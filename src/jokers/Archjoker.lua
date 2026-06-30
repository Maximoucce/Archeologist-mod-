SMODS.Joker {
    key = 'Archjoker',
    atlas = 'ArchHD',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            chips = 100
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}