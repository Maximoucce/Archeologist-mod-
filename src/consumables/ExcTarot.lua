SMODS.Consumable {
    key = "ExcTarot",
    atlas = "ExcImage",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    set = 'Tarot',
    keep_on_use = false, 
    
    config = {
        extra = {
            odds = 2,
            dollars = 50
        }
    },

    can_use = function(self, card)
        return true
    end,

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            card.ability.extra.odds, card.ability.extra.dollars
        }
    }
    end,

    use = function(self, card, area, copier)

        -- DEBLOCAGE OFFICIEL (AVEC ANIMATION)
        local joker_key = 'j_maxarch_Archjoker' -- Utilise la clé exacte de ton joker

        if G.P_CENTERS[joker_key] and not G.P_CENTERS[joker_key].unlocked then
            -- On passe l'objet complet de G.P_CENTERS à la fonction native de Balatro.
            -- C'est elle qui va gérer proprement la sauvegarde ET l'alerte visuelle au menu !
            unlock_card(G.P_CENTERS[joker_key])
         end

        if SMODS.pseudorandom_probability(card, "Excavation", 1, card.ability.extra.odds) then
            ease_dollars(card.ability.extra.dollars)
            attention_text({
                text = "Treasure !",
                scale = 1.2, 
                hold = 2,
                backdrop_col = G.C.GREEN
            })
        else
            play_sound("maxarch_PCLong", 1, 1)
            attention_text({
                text = {
                    "Pharaoh's curse !",
                    {"Curse"}
                    },
                scale = 1.2, 
                hold = 5,
                backdrop_col = G.C.RED
            })
            
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 5,
                func = function()
                    G.STATE = G.STATES.GAME_OVER
                    G.STATE_COMPLETE = false
                    return true
                end
            }))
        end
    end,

    in_pool = function(self, args)
        return true
    end
}