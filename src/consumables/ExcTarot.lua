SMODS.Atlas {
    key = "ExcImage",
    path = "ExcHDred3.png",
    px = 71,
    py = 95
}

SMODS.Sound({
    key = "PC",
    path = "PC.ogg"
})

SMODS.Consumable {    --rework needed
    key = "ExcTarot",
    atlas = "ExcImage",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    set = "Tarot",
    keep_on_use = false,
    
    config = {
        extra = {
            num = 3,
            odds = 6,
            dollars = 50
        }
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.num, card.ability.extra.odds,
            "maxarch_ExcTarot")
        return { vars = { numerator, denominator, card.ability.extra.dollars, " " } }
    end,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)

-- Unlock Archeologist
        local joker_key = "j_maxarch_Archjoker"

        if G.P_CENTERS[joker_key] and not G.P_CENTERS[joker_key].unlocked then
            unlock_card(G.P_CENTERS[joker_key])
         end

        if SMODS.pseudorandom_probability(card, "Excavation", 2, card.ability.extra.odds) then
            ease_dollars(card.ability.extra.dollars)
            play_sound("polychrome1", 1, 0.5)
            attention_text({
                text = localize("k_maxarch_exco"),
                scale = 1.3,
                hold = 1.5,
                major = card,
                backdrop_colour = G.C.GOLD,
                card:juice_up(0.3, 0.5)
            })
        else
            play_sound("maxarch_PC", 1, 0.5)
            attention_text({
                text = localize("k_maxarch_excx"),
                scale = 1.2,
                hold = 1.5,
                major = card,
                backdrop_colour = G.C.MULT,
                card:juice_up(0.3, 0.5)
            })
            
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 5,
                func = function()
                    G.STATE = G.STATES.GAME_OVER
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end,

    in_pool = function(self, args)
        return true
    end,

    --Interactions with vouchers
	update = function(self, card, dt)
        if not self.discovered and not card.bypass_discovery_center then return end
        if card.children and card.children.center then
            if G.GAME.used_vouchers["v_maxarch_excavatorvoucher"] then
                card.children.center:set_sprite_pos({ x = 2, y = 0})
                card.ability.extra.num = 5
            elseif G.GAME.used_vouchers["v_maxarch_shovelvoucher"] then
                card.children.center:set_sprite_pos({ x = 1, y = 0})
                card.ability.extra.num = 4
            else
                card.children.center:set_sprite_pos({ x = 0, y = 0})
                card.ability.extra.num = 3
            end
        end
    end
}