-- Talisman
SMODS.Consumable {
    key = "Artefact",
    set = "Spectral",
    atlas = "ArteImage",
    pos = {
        x = 0,
        y = 0
    },
    unlocked = false,
    discovered = false,

    config = {
        extra = {
            seal = "ScarabSeal"
        },
        max_highlighted = 1
    },

    locked_loc_vars = function(self, info_queue, card)
        -- Injection sécurisée et recommandée du tooltip pour l'Excavation
        if G.P_CENTERS and G.P_CENTERS.c_maxarch_ExcTarot then
            info_queue[#info_queue + 1] = { 
                key = 'c_maxarch_ExcTarot', 
                set = 'Tarot' 
            }
        end

        -- On renvoie simplement une table vide pour les variables.
        -- Steamodded va automatiquement aller chercher la clé 'unlock' du fichier de localisation !
        return { vars = {} }
    end,

    check_for_unlock = function(self, args)
        return false
    end,

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
        return { vars = { card.ability.max_highlighted } }
    end,

    use = function(self, card, area, copier)
        local conv_card = G.hand.highlighted[1]
        G.E_MANAGER:add_event(Event({
            func = function()
                play_sound("crumple2", 1.5,1)
                card:juice_up(0.3, 0.5)
                return true
            end
        }))

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
                conv_card:set_seal(card.ability.extra.seal, nil, true)
                return true
            end
        }))

        delay(0.5)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end,

    draw = function(self, card, layer)
        -- This is for the Spectral shader. You don't need this with `set = "Spectral"`
        -- Also look into SMODS.DrawStep if you make multiple cards that need the same shader
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
        end
    end
    -- The config field already handles the functionality so it doesn't need to be implemented
    -- The following is how the implementation would be
    --[[
    can_use = function(self, card)
        return G.hand and #G.hand.highlighted <= card.ability.max_highlighted and #G.hand.highlighted > 0
    end
    ]] --
}