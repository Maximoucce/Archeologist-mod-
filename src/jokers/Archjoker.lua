--Loads with cache
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

--Security for nil
function EJ_save_previous_run(joker_keys)
    if type(joker_keys) ~= 'table' then
        joker_keys = {}
    end

    love.filesystem.write("ej_previous_run.txt", table.concat(joker_keys, ","))
    G.EJ_previous_run_cache = nil --Reset cache
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
    key = "ArchHDfC",
    path = "ArchHDfC.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "Archjoker",
    atlas = "ArchHDfC",
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
    config = {
        extra = {
            art = "standard"
        }
    },

    check_for_unlock = function(self, args)
        if args.type == "use_consumeable" and args.card and args.card.key == "c_maxarch_ExcTarot" then
            return true
        end
        local profile = G.PROFILES[G.SETTINGS.profile]
        if profile and profile.consumeable_usage and profile.consumeable_usage["c_maxarch_ExcTarot"] then
            return profile.consumeable_usage["c_maxarch_ExcTarot"].count >= 1
        end
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
        local target_center = target_key and G.P_CENTERS[target_key]
        local EXCLUDED_JOKERS = { --If too complex to handle
            ['j_blueprint'] = true,
            ['j_brainstorm'] = true,
        }

        if not target_center then
            return { vars = {} }
        end

        local card_name = target_center.name or "No Name?"

        if target_key == self.key or target_center.blueprint_compat == false or EXCLUDED_JOKERS[target_key] then
            info_queue[#info_queue+1] = { key = "arch_incompat", set = "Other", vars = {card_name} }
            return { vars = { card_name } }
        end

        local saved_state = (card.ability and card.ability.persisted_states) and card.ability.persisted_states[target_key]

        if saved_state then
            --Set temporary config
            local temp_config = copy_table(target_center.config or {})
            for k, v in pairs(saved_state) do
                if type(v) == 'table' then
                    temp_config[k] = copy_table(v)
                else
                    temp_config[k] = v
                end
            end

            --Restore modified config
            local custom_center = setmetatable({}, { __index = target_center })
            for k, v in pairs(target_center) do
                custom_center[k] = v
            end
            custom_center.config = temp_config

            --If modified
            info_queue[#info_queue+1] = custom_center
        else
            --Standard
            info_queue[#info_queue+1] = target_center
        end

        return { vars = { card_name } }
    end,

    calculate = function(self, card, context)
        local position = nil
        for i, c in ipairs(G.jokers.cards) do
            if c == card then position = i break end
        end

        local previous_run = EJ_load_previous_run()
        local target_key = (position and previous_run) and previous_run[position] or nil
        local target_center = target_key and G.P_CENTERS[target_key]
        local EXCLUDED_JOKERS = { --If too complex to handle
            ['j_blueprint'] = true,
            ['j_brainstorm'] = true,
        }

        if not target_center or target_key == self.key or target_center.blueprint_compat == false or EXCLUDED_JOKERS[target_key] then
            return
        end

        card.ability.persisted_states = card.ability.persisted_states or {}

        local old_center = card.config.center
        local old_ability = card.ability

        --Set temporary default ability
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

        --Restore saved persisted_states
        local saved_state = card.ability.persisted_states[target_key]
        if saved_state then
            for k, v in pairs(saved_state) do
                if type(v) == 'table' then
                    temp_ability[k] = copy_table(v)
                else
                    temp_ability[k] = v
                end
            end
        end

        card.config.center = target_center
        card.ability = temp_ability

        --Fetch context
        local ctx = context
        
        local is_state_changing_context =
            context.end_of_round
            or context.eval
            or context.skipping_booster
            or context.first_hand_drawn
            or context.before
            or context.after
            or context.setting_blind
            or context.skip_blind
            or context.buying_card
            or context.selling_card
            or context.open_booster
            or context.reroll_shop
            or context.using_consumeable
            or context.remove_playing_card
            or context.cards_destroyed
            or context.discard
            or (context.cardarea == G.jokers and not context.before and not context.after)

        if is_state_changing_context then
            ctx.blueprint = nil
        else
            ctx.blueprint = true
            ctx.blueprint_card = card
        end

        --Calculation
        local ret = card:calculate_joker(ctx)

        --Prevent self-destruct (not working)
        if ret and (ret.remove or ret.self_destruct) then
            ret.remove = nil
            ret.self_destruct = nil
        end

        --Save new persisted_states
        local new_saved_state = {}
        for k, v in pairs(card.ability) do
            if k ~= 'persisted_states' and k ~= 'arch_incompat' then
                if type(v) == 'table' then
                    new_saved_state[k] = copy_table(v)
                else
                    new_saved_state[k] = v
                end
            end
        end
        
        old_ability.persisted_states[target_key] = new_saved_state

        --Revert back to Archeologist
        card.config.center = old_center
        card.ability = old_ability

        if ret then
            ret.card = card
            return ret
        end
    end,

    --Code from Fusion Jokers (Club Wizard) to change sprite with config
	update = function(self, card, dt)
        if not self.discovered and not card.bypass_discovery_center then return end
        if MaxArchMod.archconfig.arch_alt_art and card.ability.extra.art ~= "alt" then
            card.children.center:set_sprite_pos({ x = 1, y = 0})
            card.ability.extra.art = "alt"
        elseif not MaxArchMod.archconfig.arch_alt_art and card.ability.extra.art ~= "standard" then
            card.children.center:set_sprite_pos({ x = 0, y = 0})
            card.ability.extra.art = "standard"
        end
    end
}