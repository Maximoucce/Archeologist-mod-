SMODS.Consumable {
    key = "ExcTarot",
    atlas = "ExcImage",
    pos = { x = 0, y = 0 },
    discovered = false,
    set = 'Tarot',
    weight = 1000,
    -- FORCE LA CARTE À ÊTRE UTILISABLE DEPUIS LA MAIN
    keep_on_use = false, 
    
    config = {
        extra = {
            odds = 2,
            dollars = 50
        }
    },

    -- AJOUT D'UNE CONDITION D'UTILISATION VALIDE
    can_use = function(self, card)
        return true
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.odds, card.ability.extra.dollars } }
    end,

    use = function(self, card, area, copier)
        unlock_card(G.P_CENTERS.j_maxarch_Archjoker) 

        if SMODS.pseudorandom_probability(card, "Excavation", 1, card.ability.extra.odds) then
            ease_dollars(card.ability.extra.dollars)
            attention_text({
                text = "Treasure !",
                scale = 1.2, 
                hold = 2,
                backdrop_col = G.C.GREEN
            })
        else
            play_sound("maxarch_PharaoCurse", 1, 1)
            attention_text({
                text = "Pharaoh's curse !",
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