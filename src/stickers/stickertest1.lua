SMODS.Atlas {
    key = "stickerstest",
    path = "stickerstest1.png",
    px = 71,
    py = 95
}

SMODS.Sticker {
    key = "washed",

    --Label for the badge, else doesn't work
    loc_txt = {
        ["en-us"] = {
                label = "Washed"
        },
        ["fr"] = {
                label = "Délavé"
        }
    },

    badge_colour = HEX("a0c69e"),
    atlas = "stickerstest",
    pos = {
        x = 0,
        y = 0
    },

    needs_enable_flag = true,

    config = {
        down_limit = 0.5,
        up_limit = 1.25
    },

    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
            if val then
            local factor = math.random(self.config.down_limit, self.config.up_limit)
            if card.ability.extra then
                for k, v in pairs(card.ability.extra) do
                    if type(v) == "number" then
                        card.ability.extra[k] = math.floor(v * factor)
                    end
                end
            end

            if card.cost then
                card.cost = math.floor(card.cost * factor)
            end
            card:set_cost()
        end
    end,

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.down_limit, self.config.up_limit } }
    end,
}

--------------------------------------------------------------------------------------------

SMODS.Sticker {
    key = "faulty",

    --Label for the badge, else doesn't work
    loc_txt = {
        ["en-us"] = {
                label = "Faulty"
        },
        ["fr"] = {
                label = "Défectueux"
        }
    },

    badge_colour = HEX("a07c46"),
    atlas = "stickerstest",
    pos = {
        x = 1,
        y = 0
    },

    needs_enable_flag = true,

    config = {
        num = 1,
        odds = 5
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.num, self.config.odds } }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            if SMODS.pseudorandom_probability(card, "Faulty", self.config.num, self.config.odds) then
                func = function()
                    card:set_debuff(true)
                end
            else
                func = function()
                    card:set_debuff(false)
                end
            end
        end
    end
}