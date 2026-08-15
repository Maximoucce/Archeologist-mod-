SMODS.Atlas {
    key = "stickerstest",
    path = "stickerstestdouble.png",
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
        y = 0 --Change to 1 if other modded stickers overlap
    },

    needs_enable_flag = true,

    config = {
        down_limit = 0.5,
        up_limit = 1.3,
        extra = {
            art = "standard"
        }
    },

    default_compat = true,
    compat_exceptions = {"j_maxarch_Archjoker"},
    should_apply = function(self, card, center, area, bypass_roll)
        local default_check = SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
        local shop_check = (area == G.shop_jokers) or (area == G.pack_cards)
        return default_check and shop_check
    end,

    apply = function(self, card, val)
        SMODS.Sticker.apply(self, card, val)
            if val then
                card.ability.washed_factor = self.config.down_limit + math.random() * (self.config.up_limit - self.config.down_limit)
                local lfactor = card.ability.washed_factor or 1
            if card.ability.extra then
                if type(card.ability.extra) == "table" then
                    for k, v in pairs(card.ability.extra) do
                        if type(v) == "number" then
                            card.ability.extra[k] = math.floor(v * lfactor)
                        end
                    end
                elseif type(card.ability.extra) == "number" then
                    card.ability.extra = math.floor(card.ability.extra * lfactor)
                end
            end
            --works ???
            if card.cost then
                card.cost = math.floor(card.cost * lfactor)
            end
            card:set_cost()
        end
    end,

    loc_vars = function(self, info_queue, card)
        local lfactor = card.ability.washed_factor or 1
        return { vars = { self.config.down_limit, self.config.up_limit, lfactor } }
    end
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
        y = 0 --Change to 1 if other modded stickers overlap
    },

    needs_enable_flag = true,

    config = {
        num = 1,
        odds = 5,
        extra = {
            art = "standard"
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.num, self.config.odds } }
    end,

    default_compat = true,
    compat_exceptions = {"j_maxarch_Archjoker"},
    should_apply = function(self, card, center, area, bypass_roll)
        local default_check = SMODS.Sticker.should_apply(self, card, center, area, bypass_roll)
        local shop_check = (area == G.shop_jokers) or (area == G.pack_cards)
        return default_check and shop_check
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            if SMODS.pseudorandom_probability(card, "Faulty", self.config.num, self.config.odds, card) then
                card:set_debuff(true)
            else
                card:set_debuff(false)
            end
        end
    end
}