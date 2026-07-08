SMODS.Seal {
    key = "ScarabSeal",
    atlas = "ScarImg",
    pos = {
        x = 0,
        y = 0
    },
    badge_colour = HEX("0219AB"),
    loc_txt = {
        ["en-us"] = {
            label = "Scarab Seal",
            name = "Scarab Seal",
            text = {
                "example text {C:mult}yesyes{}"
            }
        },
        ["fr"] = {
            label = "Sceau Scarabée",
            name = "Sceau Scarabée",
            text = {
                "texte d'exemple {C:mult}ouioui{}"
            }
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
            money = 3,
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
    local current_effect = 3 -- Par défaut, effet du milieu

    if #highlighted > 0 then
        if card == highlighted[1] then
            current_effect = 1 -- Première position sélectionnée
        elseif card == highlighted[#highlighted] then
            current_effect = 2 -- Dernière position sélectionnée
        end
    end

    -- Renvoie les variables au fichier .json de traduction (localization)
    -- pour changer le texte du tooltip dynamiquement selon la position
    return {
        vars = {
            current_effect
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
                message = "dusk",
                mult = card.ability.seal.extra.mult
            }
            
        -- EFFET 2 : La carte est la DERNIÈRE à marquer des points
        elseif #scoring_hand > 0 and card == scoring_hand[#scoring_hand] then
            return {
                message = "dawn",
                p_dollars = card.ability.seal.extra.money
            }
            
        -- EFFET 3 : La carte est au MILIEU
        else   --if #scoring_hand > 0 and card ~= scoring_hand[1] and card ~= scoring_hand[#scoring_hand] then
            return {
                message = "zenith",
                chips = card.ability.seal.extra.chips
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