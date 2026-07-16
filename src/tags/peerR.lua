SMODS.Atlas{
    key = "PRimg",
    path = "tagline.png",
    px = 32,
    py = 32,
}

SMODS.Tag {
    key = "PR",
    atlas = "PRimg",
    pos = {
        x = 0,
        y = 0
    },

    config = {
        extra = {
            repetitions = 1
        }
    },

    loc_vars = function(self, info_queue, tag)
        return { vars = { self.config.extra.repetitions } }
    end,

    apply = function(self, tag, context)
        if context.type == "round_start_bonus" then
            tag:yep('+', G.C.FILTER, function()
                G.GAME.maxarch_PR_tag_active = true
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

local PR_config = { extra = { repetitions = 1 } }

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