--https://github.com/Steamodded/smods/wiki/SMODS.Voucher
--lvl 1 : chance de ne pas utiliser les consommables (1/10) ou redonner
--lvl 2 : ?
--déblocage avec le nombre de consommables utilisés ? sur une seule run ?

-- Inspiring Movie
SMODS.Voucher {
    key = "copycons1",
    atlas = "",
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            odds = 10
        }
    },

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, self.config.extra.odds,
            "maxarch_copycons1")
        return { vars = { numerator, denominator} }
    end,

    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end
}



-- The Fool
SMODS.Consumable {
    key = 'fool',
    set = 'vremade_Tarot',
    pos = { x = 0, y = 0 },
    loc_vars = function(self, info_queue, card)
        -- This vanilla variable only checks for vanilla Tarots and Planets, you would have to keep track on your own for any custom consumables
        local fool_c = G.GAME.last_tarot_planet and G.P_CENTERS[G.GAME.last_tarot_planet] or nil
        local last_tarot_planet = fool_c and localize { type = 'name_text', key = fool_c.key, set = fool_c.set } or
            localize('k_none')
        local colour = (not fool_c or fool_c.name == 'The Fool') and G.C.RED or G.C.GREEN

        if not (not fool_c or fool_c.name == 'The Fool') then
            info_queue[#info_queue + 1] = fool_c
        end

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = ' ' .. last_tarot_planet .. ' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        }
                    }
                }
            }
        }

        return { vars = { last_tarot_planet }, main_end = main_end }
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.consumeables.config.card_limit > #G.consumeables.cards then
                    play_sound('timpani')
                    SMODS.add_card({ key = G.GAME.last_tarot_planet })
                    card:juice_up(0.3, 0.5)
                end
                return true
            end
        }))
        delay(0.6)
    end,
    can_use = function(self, card)
        return (#G.consumeables.cards < G.consumeables.config.card_limit or card.area == G.consumeables) and
            G.GAME.last_tarot_planet and
            G.GAME.last_tarot_planet ~= 'c_fool'
    end
}


-- Hook
SMODS.current_mod.calculate = function(self, context)
    if not G.GAME.maxarch_PR_tag_active then return end

    if context.repetition then
        if context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = PR_config.extra.repetitions,
                card = context.other_card
            }
        end
        if context.cardarea == G.play then
            return {
                repetitions = PR_config.extra.repetitions,
                card = context.other_card
            }
        end
    end
    if context.blind_defeated then
        G.GAME.maxarch_PR_tag_active = false
    end
end




local conskey = nil
context consummable used -->
    local conskey = key consumable used
    
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                SMODS.add_card {
                                    key = conskey
                                }
                            G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                    end















-- Grand Thesis
SMODS.Voucher {
    key = "copycons2",
    pos = { x = 1, y = 0 },
    config = { extra = { shop_size = 1 } },
    unlocked = false,
    requires = { 'v_vremade_overstock_norm' },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.shop_size } }
    end,
    redeem = function(self, card)
        G.E_MANAGER:add_event(Event({
            func = function()
                change_shop_size(card.ability.extra.shop_size)
                return true
            end
        }))
    end,
    locked_loc_vars = function(self, info_queue, card)
        return { vars = { 2500, G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_dollars_spent } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'c_shop_dollars_spent' and
            G.PROFILES[G.SETTINGS.profile].career_stats.c_shop_dollars_spent >= 2500
    end
}