SMODS.Atlas {
    key = "Museum",
    path = "Museetest.png",
    px = 71,
    py = 95
}

SMODS.Back {
    key = "Museum",
    atlas = "Museum",
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            dollars = 1,
            no_interest = true
        }
    },

    apply = function(self, back)
        G.GAME.modifiers.money_per_hand = 0
        G.GAME.modifiers.no_interest = true
    end,

    unlocked = true,

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.dollars, 1, 2, 4 } }
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and context.beat_boss then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.rarity == 1 then
                    return {
                        dollars = 1*self.config.extra.dollars
                    }
                elseif j.config.center.rarity == 2 then
                    return {
                        dollars = 2*self.config.extra.dollars
                    }
                elseif j.config.center.rarity == 3 then
                    return {
                        dollars = 4*self.config.extra.dollars
                    }
                elseif j.config.center.rarity == 4 then
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                SMODS.add_card {
                                    set = 'Spectral',
                                    key_append = 'vremade_sixth_sense' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                    end
                end
        end
    end
end
}