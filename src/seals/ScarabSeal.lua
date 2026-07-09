SMODS.Seal {
    key = "ScarabS",
    atlas = "ScarImg",
    pos = {
        x = 0,
        y = 0
    },
    badge_colour = HEX("0219AB"),

    loc_txt = {
        ["en-us"] = {
                label = "Scarab Seal"
        },
        ["fr"] = {
                label = "Sceau Scarabée"
        }
    },

    -- Fonction pour ajouter les badges sous la carte
    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge("Archeologist Mod", HEX("a07c46"), HEX("c8f8c6"), 1)
    end,

    unlocked = true,
    discovered = false,
    config = {
        extra = {
            dollars = 3,
            mult = 15,
            chips = 50
        }
    },

-- ==========================================
-- 1. AFFICHAGE DYNAMIQUE DU TOOLTIP (TEXTE)
-- ==========================================
loc_vars = function(self, info_queue, card)
    -- On regarde les cartes actuellement sélectionnées dans la main
    local highlighted = G.hand and G.hand.highlighted or {}
    local current_effect = "none" -- Par défaut
    if #highlighted == 0 then
        current_effect = "none"
    end
    if #highlighted > 0 then
        if card == highlighted[1] then
            current_effect = "dawn" -- Première position sélectionnée
        elseif card == highlighted[#highlighted] then
            current_effect = "dusk" -- Dernière position sélectionnée
        else
            current_effect = "zenith" -- Milieu sélectionné
        end
    end

    return {
        vars = {
            self.config.extra.mult, self.config.extra.dollars, self.config.extra.chips, current_effect, " "
        }
    }
end,

-- ==========================================
-- 2. APPLICATION DE L'EFFET EN JEU (SCORING)
-- ==========================================
calculate = function(self, card, context)
    -- On s'assure qu'on calcule les points d'une carte jouée qui marque des points
    if context.cardarea == G.play and context.main_scoring then
        
        -- On utilise la main finale enregistrée par le jeu (scoring_hand)
        local scoring_hand = context.scoring_hand or {}
        
        -- EFFET 1 : La carte est la PREMIÈRE à marquer des points
        if #scoring_hand > 0 and card == scoring_hand[1] then
            return {
                message = "dawn",
                mult = self.config.extra.mult
            }
            
        -- EFFET 2 : La carte est la DERNIÈRE à marquer des points
        elseif #scoring_hand > 0 and card == scoring_hand[#scoring_hand] then
            return {
                message = "dusk",
                chips = self.config.extra.chips
            }
            
        -- EFFET 3 : La carte est au MILIEU
        else   --if #scoring_hand > 0 and card ~= scoring_hand[1] and card ~= scoring_hand[#scoring_hand] then
            return {
                message = "zenith",
                p_dollars = self.config.extra.dollars
            }
        end
    end
end,

    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}