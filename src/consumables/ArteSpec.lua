-- Talisman
SMODS.Consumable {
    key = "ArteSpec",
    set = "Spectral",
    atlas = "ArteImage",
    pos = {
        x = 0,
        y = 0
    },
    soul_pos = {
        x = 1,
        y = 0
    },

    unlocked = true,
    discovered = false,

    config = {
        extra = {
            seal = "maxarch_ScarabSeal"
        },
        max_highlighted = 1
    },

    loc_vars = function(self, info_queue, card)
        if G.P_SEALS[card.ability.extra.seal] then
            info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        end
        return { vars = { 
            card.ability.max_highlighted,
            colours = { HEX("0219AB") }
        }
    }
    end,

    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("crumple2", 1.5,2)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,
}