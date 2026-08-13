SMODS.Atlas {
    key = "museumsleeve",
    path = "museumsleeve.png",
    px = 73,
    py = 95
}

CardSleeves.Sleeve {         --WIP
    key = "museumsleeve",
    name = "Museum Sleeve",
    atlas = "museumsleeve",
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

    apply = function(self)
        G.GAME.modifiers.money_per_hand = 1
        G.GAME.modifiers.no_interest = true
    end,

    unlocked = true, --change
    unlock_condition = { deck = "b_maxarch_Museum", stake = "stake_blue" },

    loc_vars = function(self)
        local key, vars
        if self.get_current_deck_key() == "b_maxarch_Museum" then
            key = self.key .. "_alt"
            vars = {}
        else
            key = self.key
            vars = { self.config.extra.dollars, 1, 3, 5 }
        end
        return { key = key, vars = vars }
    end,

    --Alt
    get_weight = function(self, weight, key)
        if self.get_current_deck_key() == "b_maxarch_Museum" then
            if key == "Rare" or key == "c_soul" then
                return weight * 100
            end
        end
        return weight
    end,

    --Normal
    calculate = function(self, back, context)
        if self.get_current_deck_key() == "b_maxarch_Museum" then
            return 0
        end
        local total_dollars = 0
        if context.blind_defeated then
            for _, j in ipairs(G.jokers.cards) do
                if j.config.center.rarity == 1 then
                    total_dollars = total_dollars + (1*self.config.extra.dollars)
                elseif j.config.center.rarity == 2 then
                    total_dollars = total_dollars + (3*self.config.extra.dollars)
                elseif j.config.center.rarity == 3 then
                    total_dollars = total_dollars + (5*self.config.extra.dollars)
                elseif j.config.center.rarity == 4 then
                    --Code from 6th sense
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({
                            func = (function()
                                SMODS.add_card {set = "Spectral"}
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
