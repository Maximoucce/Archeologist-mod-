SMODS.Atlas {
    key = "Brushjoker",
    path = "Brushjoker.png",
    --Brush is from the Faithful java 64x texture pack for Minecraft (https://faithfulpack.net)
    px = 71,
    py = 95
}

SMODS.Sound({
    key = "brush",
    path = "brush.ogg"
})

SMODS.Joker {
    key = "Brushjoker",
    atlas = "Brushjoker",
    pos = {
        x = 0,
        y = 0
    },

    rarity = 1,
    cost = 5,
    blueprint_compat = false,
    unlocked = true,
    discovered = false,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            uses = 4,
            art = "standard"
        }
    },

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_maxarch_sanddd
        return {
            vars = {
                card.ability.extra.uses
            }
        }
    end,

    calculate = function(self, card, context)
        if card.ability.extra.uses > 0 then
            if context.first_hand_drawn and not context.blueprint then
                local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
                juice_card_until(card, eval, true)
            end
            if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
                local target_card = context.full_hand[1]
                if target_card.config.center.key == "m_maxarch_sanddd" then  
                    local random_enhancement = SMODS.poll_enhancement({ guaranteed = true}) --, options = { "m_bonus", "m_glass", "m_gold", "m_lucky", "m_mult", "m_steel", "m_stone", "m_wild"}})
                    --poll_enhancement(key, mod, guaranteed, options)
                    local random_edition = SMODS.poll_edition({key = "j_maxarch_Brushjoker", no_negative = true, guaranteed = true})
                    --poll_edition(key, mod, no_negative, guaranteed, options)
                    local random_seal = SMODS.poll_seal({ guaranteed = true })
                    --poll_seal(key, mod, no_negative, guaranteed, options)

                    G.E_MANAGER:add_event(Event({
                        play_sound("maxarch_brush", 1, 0.5),
                        trigger = "after",
                        delay = 0.5,
                        func = function()
                            target_card:set_ability(G.P_CENTERS[random_enhancement])
                            --set_ability(center, initial(optionnal), delay_sprites)
                            target_card:set_edition(random_edition, true)
                            --set_edition(edition, immediate, silent, delay)
                            target_card:set_seal(random_seal, true)
                            --set_seal(seal, immediate, silent)
                            target_card:juice_up()
                            return true
                        end
                    }))
                    delay(0.4)

                    --Code from Perishable sticker
                    if card.ability.extra.uses > 0 then
                        if card.ability.extra.uses == 1 then
                            card.ability.extra.uses = 0
                            return {
                                message = localize('k_disabled_ex'),
                                colour = G.C.FILTER,
                                delay = 0.45,
                                func = function()
                                    card:set_debuff(true)
                                end
                            }
                        else
                            card.ability.extra.uses = card.ability.extra.uses - 1
                            return {
                                message = localize { type = 'variable', key = 'a_remaining', vars = { card.ability.extra.uses } },
                                colour = G.C.FILTER,
                                delay = 0.45
                            }
                        end
                    end
                end
            end
        else
            card:set_debuff(true)
        end
    end,

    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_maxarch_sanddd") then
                return true
            end
        end
        return false
    end,

    --Code from Fusion Jokers (Club Wizard)
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