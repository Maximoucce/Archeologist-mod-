SMODS.Enhancement {
    key = "sanddd",
    atlas = "sanddd",
    pos = {
        x = 0,
        y = 0
    },
    config = {
        reduction = 2 -- Pourcentage de réduction
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.reduction, colours = { HEX("000000") } } }
    end,

    -- calculate s'exécute lors des différentes phases de jeu
    calculate = function(self, card, context)
        -- On vérifie que la carte est bien jouée dans la main et qu'on évalue les cartes individuelles
        if context.main_scoring and context.cardarea == G.play then
            -- On réduit les jetons cibles de la blinde actuelle de 2%
            G.GAME.blind.chips = G.GAME.blind.chips * ((100 - self.config.reduction) / 100)
            
            -- On met à jour la jauge de la blinde à l'écran
            G.GAME.blind:set_chips(G.GAME.blind.chips)

            -- On renvoie une petite animation visuelle sur la carte
            return {
                message = "-"..self.config.reduction.."%",
                colour = G.C.CHIPS,
                card = card
            }
        end
    end
}