local Utils = assert(SMODS.load_file("src/utils.lua"))()
SMODS.Joker {
    key = 'Archjoker',
    atlas = 'ArchHD',
    pos = {
        x = 0,
        y = 0
    },
    config = {
        extra = {
            chips = 100
        }
    },
    rarity = 3,
    cost = 10,
    blueprint_compat = true,
    discovered = true,
    eternal_compat = true,
    perishable_compat = true,
    
    calculate = function(self, card, context)

    if context.joker_main then
        local pos = Utils.get_joker_position(card)
        print("Ma position : "..tostring(pos))
    end

end
}