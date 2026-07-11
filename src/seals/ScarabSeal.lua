--infos générales
SMODS.Atlas {
    key = "ScarImg",
    path = "SCARR11.png",
    px = 71,
    py = 95
}

SMODS.Seal {
    key = "ScarabS",
    atlas = "ScarImg",
    pos = {
        x = 0,
        y = 0
    },
    badge_colour = HEX("0219AB"),

--Label pour le badge, sinon ça marche pas
    loc_txt = {
        ["en-us"] = {
                label = "Scarab Seal"
        },
        ["fr"] = {
                label = "Sceau Scarabée"
        }
    },

-- Fonction pour ajouter les badges sous la carte (marche pas?)
    set_badges = function(self, card, badges)
        badges[#badges + 1] = create_badge("Archeologist Mod", HEX("a07c46"), HEX("c8f8c6"), 1)
    end,

--Autres infos et config
    unlocked = true,
    discovered = false,
    config = {
        extra = {
            dollars = 2,
            mult = 3,
            chips = 20,
            xmult = 1.3
        }
    },

-- PARTIE TOOLTIP
loc_vars = function(self, info_queue, card)
    -- On regarde les cartes actuellement sélectionnées dans la main
    local highlighted = G.hand and G.hand.highlighted or {}
    local current_effect = "none" -- Par défaut
    if #highlighted == 0 then
        current_effect = "none" -- Pas ou plus sélectionnée
    end
    if #highlighted > 0 then
        if card == highlighted[1] then
            current_effect = "dawn" -- Première position sélectionnée
        elseif card == highlighted[#highlighted] then
            current_effect = "dusk" -- Dernière position sélectionnée
        else
            current_effect = "zenith" -- Milieu sélectionnée
        end
    end

    return {
        vars = {
            self.config.extra.mult, self.config.extra.dollars, self.config.extra.chips, current_effect, " ", self.config.extra.xmult
        }
    }
end,

-- PARTIE SCORING
--Khépri = renaissance --> +30 chips et +4 mult
--Rê = pleine puissance --> +2$
--Atoum = achèvement --> x1,3 mult
calculate = function(self, card, context)
    -- On s'assure qu'on calcule les points d'une carte jouée qui marque des points
    if context.cardarea == G.play and context.main_scoring then
        
        -- On utilise la main finale enregistrée par le jeu (scoring_hand)
        local scoring_hand = context.scoring_hand or {}
        
        -- dawn : La carte est la PREMIÈRE à marquer des points
        if #scoring_hand > 0 and card == scoring_hand[1] then
            return {
                chips = self.config.extra.chips,
                mult = self.config.extra.mult
            }
            
        -- dusk : La carte est la DERNIÈRE à marquer des points
        elseif #scoring_hand > 0 and card == scoring_hand[#scoring_hand] then
            return {
                x_mult = self.config.extra.xmult
            }
            
        -- zenith : La carte est au MILIEU
        else   --if #scoring_hand > 0 and card ~= scoring_hand[1] and card ~= scoring_hand[#scoring_hand] then
            return {
                p_dollars = self.config.extra.dollars
            }
        end
    end
end,

--Vestige du code du sceau doré pour les reflets
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}