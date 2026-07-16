SMODS.Atlas {
    key = "ArteImage",
    path = "SoulArte3.png",
    px = 71,
    py = 95
}

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
            seal = "ScarabS"
        },
        max_highlighted = 1
    },

    loc_vars = function(self, info_queue, card)
        if G.P_SEALS["maxarch_ScarabS"] then
            info_queue[#info_queue + 1] = G.P_SEALS["maxarch_ScarabS"]
        end
        return { vars = { 
            card.ability.max_highlighted,
            colours = { HEX("0219AB") }
        }
    }
    end,

-- Modified code of Golden Seal
    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("crumple2", 2,3)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal("maxarch_ScarabS", nil, true)
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