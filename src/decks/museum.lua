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

    unlocked = false,

--Code de Black Deck
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 150 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == "discover_amount" and args.amount >= 150
    end,

    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra.dollars, 1, 2, 4 } }
    end,

    calc_dollar_bonus = function(self, card)
        local total_dollars = 0
        if G.GAME.blind.boss then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.rarity == 1 then
                    total_dollars = total_dollars + (1*self.config.extra.dollars)
                elseif j.config.center.rarity == 2 then
                    total_dollars = total_dollars + (2*self.config.extra.dollars)
                elseif j.config.center.rarity == 3 then
                    total_dollars = total_dollars + (4*self.config.extra.dollars)
                elseif j.config.center.rarity == 4 then
                    --Code de 6th sense
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                SMODS.add_card {
                                    set = "Spectral"
                                }
                            G.GAME.consumeable_buffer = 0
                                return true
                            end)}))
                    end
                end
            end  
        end
        return total_dollars
    end
}