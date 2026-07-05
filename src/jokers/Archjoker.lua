-- Chargement avec cache
function EJ_load_previous_run()
    if G.EJ_previous_run_cache then 
        return G.EJ_previous_run_cache 
    end
    
    if not love.filesystem.getInfo("ej_previous_run.txt") then
        return {}
    end
    
    print((love.filesystem.read("ej_previous_run.txt")))
    
    local contents, size = love.filesystem.read("ej_previous_run.txt")
    local jokers = {}
    if contents then
        for key in string.gmatch(contents, "[^,]+") do
            table.insert(jokers, key)
        end
    end
    G.EJ_previous_run_cache = jokers
    return jokers
end

-- Sauvegarde ultra-sécurisée contre les tables invalides (nil)
function EJ_save_previous_run(joker_keys)
    -- SÉCURITÉ : Si joker_keys est nil ou n'est pas une table, on crée une liste vide
    if type(joker_keys) ~= 'table' then
        joker_keys = {}
    end

    love.filesystem.write("ej_previous_run.txt", table.concat(joker_keys, ","))
    G.EJ_previous_run_cache = nil -- Réinitialise le cache
end

local EJ_old_update = Game.update
local EJ_already_saved = false

function Game:update(dt)
    EJ_old_update(self, dt)

    if G.STATE == G.STATES.GAME_OVER then
        if not EJ_already_saved then
            -- 1. On prépare la table pour récolter les clés des jokers
            local current_jokers = {}
            
            -- 2. On vérifie si la zone des jokers existe et contient des cartes
            if G.jokers and G.jokers.cards then
                for _, card in ipairs(G.jokers.cards) do
                    if card.config.center and card.config.center.key then
                        table.insert(current_jokers, card.config.center.key)
                    end
                end
            end
            
            -- 3. On envoie la table récoltée à la fonction de sauvegarde !
            EJ_save_previous_run(current_jokers)
            print((love.filesystem.read("ej_previous_run.txt")))
            EJ_already_saved = true
        end
    else
        EJ_already_saved = false
    end
end

--info générales du joker
SMODS.Joker {
    key = 'Archjoker',
    atlas = 'ArchHDf',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = false,
    unlocked = false,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,

    --déblocage du joker (1 partie perdue)
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 1, G.PROFILES[G.SETTINGS.profile].career_stats.c_losses } }
    end,
    check_for_unlock = function(self, args) -- equivalent to `unlock_condition = {type = 'c_losses', extra = 1}`
        if args.type == 'career_stat' and args.statname == 'c_losses' then
            return G.PROFILES[G.SETTINGS.profile].career_stats[args.statname] >= 1
        end
        return false
    end,

    -- Permet d'afficher proprement le tooltip du Joker copié ou l'incompatibilité
    loc_vars = function(self, info_queue, card)
        local position = nil
        if G.jokers and G.jokers.cards then
            for i, c in ipairs(G.jokers.cards) do
                if c == card then position = i break end
            end
        end
        
        local previous_run = EJ_load_previous_run()
        local target_key = (position and previous_run) and previous_run[position] or nil
        
        -- CAS 1 : Incompatibilité (Archjoker tente de se copier lui-même)
        if target_key == self.key then
            -- On passe simplement la clé maintenant qu'elle est enregistrée !
            info_queue[#info_queue+1] = { key = 'arch_incompat', set = 'Other' }
            return { vars = { "Incompatible" } }
        end
        
        -- CAS 2 : Fonctionnement normal
        if target_key and G.P_CENTERS[target_key] then
            info_queue[#info_queue+1] = G.P_CENTERS[target_key]
            return { vars = { G.P_CENTERS[target_key].name } }
        end
        
        return { vars = { "Aucun" } }
    end,

    calculate = function(self, card, context)
        local position = nil
        for i, c in ipairs(G.jokers.cards) do
            if c == card then position = i break end
        end

        local previous_run = EJ_load_previous_run()
        local target_key = (position and previous_run) and previous_run[position] or nil

        -- On bloque strictement si la cible est un autre Archjoker pour éviter les crashs de boucle
        if target_key and target_key ~= self.key and G.P_CENTERS[target_key] then
            local target_center = G.P_CENTERS[target_key]
            
            -- Initialisation de la mémoire des compteurs
            card.ability.persisted_states = card.ability.persisted_states or {}
            
            -- 1. SAUVEGARDE de l'état d'origine
            local old_center = card.config.center
            local old_ability = card.ability
            
            -- 2. CLONAGE DE SÉCURITÉ PROFOND
            local temp_ability = copy_table(old_ability)
            temp_ability.name = target_center.name
            temp_ability.set = target_center.set or 'Joker'
            temp_ability.effect = target_center.effect
            
            -- Injection forcée de TOUTE la configuration d'origine du joker ciblé (Aide pour Misprint / To-Do List)
            if target_center.config then
                for k, v in pairs(target_center.config) do
                    if type(v) == 'table' then
                        temp_ability[k] = copy_table(v)
                    else
                        temp_ability[k] = v
                    end
                end
            end
            
            -- 3. GESTION DE LA PERSISTANCE AVANCÉE (Compteurs et Objectifs dynamiques)
            if card.ability.persisted_states[target_key] then
                temp_ability.extra = copy_table(card.ability.persisted_states[target_key])
                -- Pour To Do List, on restaure aussi les variables volantes hors de 'extra' si elles existent
                if card.ability.persisted_states[target_key .. '_to_do_target'] then
                    temp_ability.to_do_target = card.ability.persisted_states[target_key .. '_to_do_target']
                end
            else
                -- Premier chargement du Joker imité
                if target_center.config and target_center.config.extra then
                    temp_ability.extra = copy_table(target_center.config.extra)
                else
                    temp_ability.extra = {} 
                end
            end
            
            -- 4. APPLICATION DU MASQUE
            card.config.center = target_center
            card.ability = temp_ability
            
            -- On fait croire au jeu que c'est un Blueprint qui agit (comportement safe par défaut)
            local ctx = context
            ctx.blueprint = true
            ctx.blueprint_card = card
            
            -- 5. CALCUL
            local ret = card:calculate_joker(ctx)
            
            -- 6. SAUVEGARDE ET PERSISTANCE DU NOUVEL ÉTAT
            if card.ability.extra then
                old_ability.persisted_states[target_key] = copy_table(card.ability.extra)
            end
            -- Sauvegarde spécifique pour l'objectif de To Do List s'il a changé pendant le calcul
            if card.ability.to_do_target then
                old_ability.persisted_states[target_key .. '_to_do_target'] = card.ability.to_do_target
            end
            
            -- 7. RESTAURATION DE L'ARCHJOKER
            card.config.center = old_center
            card.ability = old_ability
            
            if ret then
                ret.card = card
                return ret
            end
        end
    end
}