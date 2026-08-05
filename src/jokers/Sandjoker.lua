SMODS.Atlas {
    key = "SandjokerXf",
    path = "SandjokerXf.png",
    px = 71,
    py = 95
}

SMODS.Joker {
    key = "Sandjoker",
    atlas = "SandjokerXf",
    pos = {
        x = 0,
        y = 0
    },

    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            xblindsize = 0.02
        }
    },
    
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_maxarch_sanddd
        local sandy_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, "m_maxarch_sanddd") then sandy_tally = sandy_tally + 1 end
            end
        end
        return { vars = {
            card.ability.extra.xblindsize,
            1 - card.ability.extra.xblindsize * sandy_tally,
            colours = {HEX("000000")}
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            local sandy_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(playing_card, "m_maxarch_sanddd") then sandy_tally = sandy_tally + 1 end
            end
            return {
                xblindsize = 1 - card.ability.extra.xblindsize * sandy_tally,
            }
        end
    end,

    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, "m_maxarch_sanddd") then
                return true
            end
        end
        return false
    end,

    --Code from Fusion Jokers (Club Wizard)
	update = function(self, card, dt)
        if not self.discovered and not card.bypass_discovery_center then return end
        if MaxArchMod.archconfig.arch_alt_art and card.ability.extra.art ~= "alt" then
            card.children.center:set_sprite_pos({ x = 1, y = 0})
            card.ability.extra.art = "alt"
        elseif not MaxArchMod.archconfig.arch_alt_art and card.ability.extra.art ~= "standard" then
            card.children.center:set_sprite_pos({ x = 0, y = 0})
            card.ability.extra.art = "standard"
        end
    end
}