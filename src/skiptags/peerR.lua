-- Juggle Tag
SMODS.Tag {
    key = "juggle",
    pos = { x = 5, y = 1 },
    config = { h_size = 3 },
    loc_vars = function(self, info_queue, tag)
        return { vars = { tag.config.h_size } }
    end,
    apply = function(self, tag, context)
        if context.type == 'round_start_bonus' then
            tag:yep('+', G.C.BLUE, function()
                return true
            end)
            G.hand:change_size(tag.config.h_size)
            G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + tag.config.h_size
            tag.triggered = true
            return true
        end
    end
}
-- Mime
SMODS.Joker {
    key = "mime",
    blueprint_compat = true,
    rarity = 2,
    cost = 5,
    pos = { x = 4, y = 1 },
    config = { extra = { repetitions = 1 } },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}
-- Hanging Chad
SMODS.Joker {
    key = "hanging_chad",
    unlocked = false,
    blueprint_compat = true,
    rarity = 1,
    cost = 4,
    pos = { x = 9, y = 6 },
    config = { extra = { repetitions = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}