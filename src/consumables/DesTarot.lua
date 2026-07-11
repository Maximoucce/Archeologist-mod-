SMODS.Consumable {
    key = "DesTarot",
    atlas = "DesImage",
    pos = {
        x = 0,
        y = 0
    },
    discovered = false,
    set = "Tarot",
    keep_on_use = false,

    config = {
        max_highlighted = 2,
        mod_conv = "m_maxarch_sanddd"
    },

loc_vars = function(self, info_queue, card)
        if G.P_CENTERS[card.ability.mod_conv] then
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
        end
        return { vars = { card.ability.max_highlighted } }
    end
}