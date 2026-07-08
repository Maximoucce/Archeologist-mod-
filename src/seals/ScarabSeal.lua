-- Gold Seal
SMODS.Seal {
    key = "ScarabSeal",
    pos = {
        x = 2,
        y = 0
    },
    badge_colour = G.C.GOLD,
    unlocked = false,
    discovered = false,
    config = {
        extra = {
            money = 3
        }
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

    
    get_p_dollars = function(self, card)
        return card.ability.seal.extra.money
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.extra.money } }
    end,
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}