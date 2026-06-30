function EJ_save_previous_run()
    if not (G.jokers and G.jokers.cards) then return end

    local keys = {}
    for i, card in ipairs(G.jokers.cards) do
        keys[i] = card.config.center.key
    end

    love.filesystem.write("echo_joker_previous_run.txt", table.concat(keys, ";"))
    print("ARCHJOKER: run précédente sauvegardée -> " .. table.concat(keys, ";"))
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
    atlas = 'ArchHD',
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

    add_to_deck = function(self, card, from_debuff)
        local previous_run = EJ_load_previous_run()

        local position = nil
        for i, c in ipairs(G.jokers.cards) do
            if c == card then position = i break end
        end

        local target_key = position and previous_run[position]
        if target_key and G.P_CENTERS[target_key] then
            card:set_ability(G.P_CENTERS[target_key])
        end
    end,

    calculate = function(self, card, context)
    end
}