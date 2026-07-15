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
            tag:yep('+', G.C.EDITION, function()
                G.GAME.maxarch_PR_tag.active = true
                return true
            end)
            tag.triggered = true
            return true
        end
    end
}

 --           G.hand:change_size(tag.config.h_size)
   --         G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + tag.config.h_size
     --       tag.triggered = true
       --     return true

--        if context.repetition and context.cardarea == G.play then
--            if context.other_card.seal == "yahimod_whatsapp_seal" then 
--                    return {
--                        message = localize("k_again_ex"),
--                        repetitions = 2,
--                        card = card,


local card_calculate_repetition_ref = Card.calculate_repetition
function Card.calculate_repetition(self, context)
    local r = card_calculate_repetition_ref(self, context)
    
    if G.GAME.maxarch_PR_tag.active then
        print(testtesteststtet)
        if context.cardarea == G.play or context.cardarea == G.hand then
            if r then
                r.repetitions = (r.repetitions or 0) + 1
            else
                r = {
                    repetitions = 1,
                    card = self,
                    message = localize('k_again_ex')
                }
            end
        end
    end
    
    return r
end

-- Désactivation (optionnel ?)
local end_round_ref = end_round
function end_round()
    G.GAME.PR_tag_active = false
    return end_round_ref()
end