-- Loads with cache
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

-- Security for invalid (nil) tables
function EJ_save_previous_run(joker_keys)
    if type(joker_keys) ~= 'table' then
        joker_keys = {}
    end

    love.filesystem.write("ej_previous_run.txt", table.concat(joker_keys, ","))
    G.EJ_previous_run_cache = nil -- Reset cache
end

local EJ_old_update = Game.update
local EJ_already_saved = false

function Game:update(dt)
    EJ_old_update(self, dt)

    if G.STATE == G.STATES.GAME_OVER then
        if not EJ_already_saved then
            local current_jokers = {}
            
            if G.jokers and G.jokers.cards then
                for _, card in ipairs(G.jokers.cards) do
                    if card.config.center and card.config.center.key then
                        table.insert(current_jokers, card.config.center.key)
                    end
                end
            end
            
            EJ_save_previous_run(current_jokers)
            print((love.filesystem.read("ej_previous_run.txt")))
            EJ_already_saved = true
        end
    else
        EJ_already_saved = false
    end
end

SMODS.Atlas {
    key = "ArchHDf",
    path = "ArchHDf.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "Archjoker",
    atlas = "ArchHDf",
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

    locked_loc_vars = function(self, info_queue, card)
        if G.P_CENTERS and G.P_CENTERS.c_maxarch_ExcTarot then
            info_queue[#info_queue + 1] = { 
                key = 'c_maxarch_ExcTarot', 
                set = 'Tarot' 
            }
        end

        return { vars = {} }
    end,

    check_for_unlock = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        local position = nil
        if G.jokers and G.jokers.cards then
            for i, c in ipairs(G.jokers.cards) do
                if c == card then position = i break end
            end
        end
        
        local previous_run = EJ_load_previous_run()
        local target_key = (position and previous_run) and previous_run[position] or nil
        
        if target_key == self.key then
            info_queue[#info_queue+1] = { key = 'arch_incompat', set = 'Other' }
            return { vars = { "Incompatible" } }
        end
        
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

        if target_key and target_key ~= self.key and G.P_CENTERS[target_key] then
            local target_center = G.P_CENTERS[target_key]
            
            card.ability.persisted_states = card.ability.persisted_states or {}
            
            local old_center = card.config.center
            local old_ability = card.ability
            
            local temp_ability = copy_table(old_ability)
            temp_ability.name = target_center.name
            temp_ability.set = target_center.set or 'Joker'
            temp_ability.effect = target_center.effect
            
            if target_center.config then
                for k, v in pairs(target_center.config) do
                    if type(v) == 'table' then
                        temp_ability[k] = copy_table(v)
                    else
                        temp_ability[k] = v
                    end
                end
            end
            
            if card.ability.persisted_states[target_key] then
                temp_ability.extra = copy_table(card.ability.persisted_states[target_key])
                if card.ability.persisted_states[target_key .. '_to_do_target'] then
                    temp_ability.to_do_target = card.ability.persisted_states[target_key .. '_to_do_target']
                end
            else
                if target_center.config and target_center.config.extra then
                    temp_ability.extra = copy_table(target_center.config.extra)
                else
                    temp_ability.extra = {} 
                end
            end
            
            card.config.center = target_center
            card.ability = temp_ability
            
            local ctx = context
            ctx.blueprint = true
            ctx.blueprint_card = card
            
            local ret = card:calculate_joker(ctx)
            
            if card.ability.extra then
                old_ability.persisted_states[target_key] = copy_table(card.ability.extra)
            end
            if card.ability.to_do_target then
                old_ability.persisted_states[target_key .. '_to_do_target'] = card.ability.to_do_target
            end
            
            card.config.center = old_center
            card.ability = old_ability
            
            if ret then
                ret.card = card
                return ret
            end
        end
    end
}