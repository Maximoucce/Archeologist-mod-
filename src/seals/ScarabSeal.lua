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
    local current_effect = "none"
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
            self.config.extra.mult, self.config.extra.dollars, self.config.extra.chips, current_effect, " ", self.config.extra.xmult
        }
    }
end,

-- PARTIE SCORING
calculate = function(self, card, context)
    if context.cardarea == G.play and context.main_scoring then
        local scoring_hand = context.scoring_hand or {}
        -- dawn
        if #scoring_hand > 0 and card == scoring_hand[1] then
            return {
                chips = self.config.extra.chips,
                mult = self.config.extra.mult
            }
            
        -- dusk
        elseif #scoring_hand > 0 and card == scoring_hand[#scoring_hand] then
            return {
                x_mult = self.config.extra.xmult
            }
            
        -- zenith
        else   -- optionnel : if #scoring_hand > 0 and card ~= scoring_hand[1] and card ~= scoring_hand[#scoring_hand] then
            return {
                p_dollars = self.config.extra.dollars
            }
        end
    end
end,

--Code du sceau doré pour les reflets
    draw = function(self, card, layer)
        if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
            G.shared_seals[card.seal].role.draw_major = card
            G.shared_seals[card.seal]:draw_shader('dissolve', nil, nil, nil, card.children.center)
            G.shared_seals[card.seal]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
        end
    end
}