SMODS.Atlas{
    key = "PRimg",
    path = "tagtest.png",
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
        return { vars = { tag.config.extra.repetitions } }
    end,

    apply = function(self, tag, context)
        if context.type == "round_start_bonus" then
            tag:yep('+', G.C.EDITION, function()
                G.GAME.PR_tag_active = true
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

local card_calculate_repetition_ref = Card.calculate_repetition
function Card.calculate_repetition(self, context)
    local r = card_calculate_repetition_ref(self, context)
    
    if G.GAME.PR_tag_active then
        if context.cardarea == G.play or context.cardarea == G.hand then
            if r then
                r.repetitions = (r.repetitions or 0) + 1
            else
                r = {
                    repetitions = 1,
                    card = self,
                    message = localize('k_again_ex') -- Affiche "Again!" à l'écran
                }
            end
        end
    end
    
    return r
end

-- Désactivation à la fin de la manche
local end_round_ref = end_round
function end_round()
    G.GAME.PR_tag_active = false
    return end_round_ref()
end