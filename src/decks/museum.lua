-- Green Deck
SMODS.Back {
    key = "green",
    pos = { x = 2, y = 2 },
    config = { extra_hand_bonus = 0, extra_discard_bonus = 0, no_interest = true },
    unlocked = true,
    loc_vars = function(self, info_queue, back)
        return { vars = { self.config.extra_hand_bonus, self.config.extra_discard_bonus } }
    end,
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    apply = function(self, back)
        G.GAME.modifiers.money_per_hand = self.config.extra_hand_bonus
        G.GAME.modifiers.money_per_discard = self.config.extra_discard_bonus
        G.GAME.modifiers.no_interest = true
    end,
    ]]
    locked_loc_vars = function(self, info_queue, back)
        return { vars = { 75 } }
    end,
    check_for_unlock = function(self, args)
        return args.type == 'discover_amount' and args.amount >= 75
    end
}
-- Baseball Card
SMODS.Joker {
    config = { extra = { xmult = 1.5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.other_joker and context.other_joker:is_rarity("Uncommon") then
            return {
                xmult = card.ability.extra.xmult
            }
        end
    end,
}