SMODS.Atlas {
    key = "sanddd",
    path = "sandfinal.png",
    px = 71,
    py = 95
}

SMODS.Enhancement {
    key = "sanddd",
    atlas = "sanddd",
    pos = {
        x = 0,
        y = 0
    },

    config = {
        reduction = 0.95 -- Reduction percentage
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.reduction, colours = {G.C.DYN_UI.DARK} } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                xblindsize = card.ability.reduction,
            }
        end
    end
}