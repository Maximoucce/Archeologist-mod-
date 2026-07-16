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
        reduction = 5 -- Pourcentage de réduction
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.reduction, colours = { HEX("000000") } } }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.main_scoring then
            return {
                xblindsize = (100 - self.config.reduction) / 100,
            }
        end
    end
}