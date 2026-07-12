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
        -- S'active au début du round
        if context.type == "round_start_bonus" then
            tag:yep('+', G.C.EDITION, function()
                -- active une variable globale pour dire que le bonus est actif
                G.GAME.PR_tag_active = true
                return true
            end)
            tag.triggered = true
            return true
        end
    end,

    -- Code de Mime
   -- calculate = function(self, card, context)
      --  if context.repetition and context.cardarea == G.hand and (next(context.card_effects[1]) or #context.card_effects > 1) then
      --      return {
      --          repetitions = self.config.extra.repetitions
      --      }
      --  end
        -- Code de Dusk
      --  if context.repetition and context.cardarea == G.play then
      --      return {
      --          repetitions = card.ability.extra.repetitions
       --     }
    --    end
    --end
}

-- 2. Hook pour injecter les retriggers en main et en jeu
local card_calculate_repetition_ref = Card.calculate_repetition
function Card.calculate_repetition(self, context)
    -- On récupère d'abord les retriggers normaux (Mime, Dusk, etc.)
    local r = card_calculate_repetition_ref(self, context)
    
    -- Si notre Tag a été activé pour cette blinde
    if G.GAME.PR_tag_active then
        -- On vérifie si on est soit en main (G.hand), soit joué (G.play)
        if context.cardarea == G.hand or context.cardarea == G.play then
            -- Si 'r' existe déjà (ex: un autre joker donne un retrigger)
            if r then
                r.repetitions = (r.repetitions or 0) + 1
            else
                -- Sinon, on crée la table de retrigger
                r = {
                    repetitions = 1,
                    card = self
                }
            end
        end
    end
    
    return r
end

-- 3. Reset du bonus à la fin de la blinde
local end_round_ref = end_round
function end_round()
    -- On désactive le bonus dès que la manche se termine
    G.GAME.PR_tag_active = false
    return end_round_ref()
end

