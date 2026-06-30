function EJ_save_previous_run()
    if not (G.jokers and G.jokers.cards) then return end

    local keys = {}
    for i, card in ipairs(G.jokers.cards) do
        keys[i] = card.config.center.key
    end

    love.filesystem.write("echo_joker_previous_run.txt", table.concat(keys, ";"))
    print("Archeologist mod : last run jokers saved -> " .. table.concat(keys, ";"))
end

local EJ_previous_run_cache = nil

function EJ_load_previous_run()
    if EJ_previous_run_cache then return EJ_previous_run_cache end

    EJ_previous_run_cache = {}
    if love.filesystem.getInfo("echo_joker_previous_run.txt") then
        local content = love.filesystem.read("echo_joker_previous_run.txt")
        for key in string.gmatch(content, "[^;]+") do
            table.insert(EJ_previous_run_cache, key)
        end
    end
    return EJ_previous_run_cache
end

local EJ_old_update = Game.update
local EJ_already_saved = false

function Game:update(dt)
    EJ_old_update(self, dt)

    if G.STATE == G.STATES.GAME_OVER then
        if not EJ_already_saved then
            EJ_save_previous_run()
            EJ_already_saved = true
        end
    else
        EJ_already_saved = false
    end
end

SMODS.Joker {
    key = 'Archjoker',
    atlas = 'ArchK',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,

    -- Permet d'afficher proprement le tooltip du Joker copié quand on survole l'Archjoker !
    loc_vars = function(self, info_queue, card)
        local position = nil
        if G.jokers and G.jokers.cards then
            for i, c in ipairs(G.jokers.cards) do
                if c == card then position = i break
            end
        end
    end
        
        local previous_run = EJ_load_previous_run()
        local target_key = position and previous_run[position]
        
        -- Si on trouve un joker valide et que ce n'est pas un Archjoker
        if target_key and target_key ~= card.config.center.key and G.P_CENTERS[target_key] then
            -- On injecte la description du joker copié dans la file d'affichage UI
            info_queue[#info_queue+1] = G.P_CENTERS[target_key]
            return { vars = { G.P_CENTERS[target_key].name } }
        end
        return { vars = { "Aucun" } }
    end,

    -- L'effet dynamique (façon Blueprint)
    calculate = function(self, card, context)
        -- 1. Trouver la position actuelle de cet Archjoker dans la ligne
        local position = nil
        for i, c in ipairs(G.jokers.cards) do
            if c == card then position = i break end
        end

        -- 2. Récupérer la clé de la partie précédente pour cette position
        local previous_run = EJ_load_previous_run()
        local target_key = position and previous_run[position]

        -- 3. Vérification + EXCEPTION (ne pas copier un autre Archjoker)
        -- card.config.center.key contient la clé unique de TON Archjoker
        if target_key and target_key ~= card.config.center.key and G.P_CENTERS[target_key] then
            
            -- SAUVEGARDE de l'état d'origine de l'Archjoker
            local old_center = card.config.center
            local old_ability = card.ability
            
            -- MODIFICATION TEMPORAIRE (On l'habille avec le costume du vieux joker)
            card.config.center = G.P_CENTERS[target_key]
            -- copy_table est une fonction native de Balatro pour dupliquer proprement des tables Lua
            -- Cela évite les crashs si le joker copié cherche des variables spécifiques (ex: card.ability.extra)
            card.ability = copy_table(G.P_CENTERS[target_key].config) or {}
            
            -- On prépare le contexte de simulation (comme le fait Blueprint)
            local ctx = context
            ctx.blueprint = true
            ctx.blueprint_card = card
            
            -- ON LANCE LE CALCUL DU JOKER COPIÉ
            local ret = card:calculate_joker(ctx)
            
            -- RESTAURATION IMMÉDIATE (L'Archjoker redevient lui-même)
            card.config.center = old_center
            card.ability = old_ability
            
            -- On renvoie le résultat du calcul au jeu
            if ret then
                ret.card = card
                return ret
            end
        end
    end
}

--ok, cette fois le joker marche, mais il y a un problème : Il se transforme littéralement en la carte copiée, ce qui n'est pas le but (plus vers le même effet que blueprint, que l'on peut déplacer pour en changer son effet). De plus, j'aimerais ajouter une exception pour la copie de capacité : ne peut pas copier un autre archjoker, pour éviter les bugs