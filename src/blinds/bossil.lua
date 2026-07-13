SMODS.Atlas {
    key = "bossilimg",
    path = "fossilEN.png",
    px = 32,
    py = 32
}

function beatInOneHand()
    return SMODS.last_hand_oneshot == true
end

SMODS.Blind {
    key = "bossil",
    atlas = "bossilimg",
    mult = 2,
    pos = { x = 0, y = 0 },
    boss_colour = HEX('7E6752'),
    boss = { min = 2 },
    dollars = 10,

    defeat = function(self)
        if beatInOneHand() then
            play_sound("glass2", 0.5, 1)
            
            -- Safely change the sprite position on this specific blind instance
            self.pos.x = 0
            self.posy.y = 1
            
            -- If you want to change its UI sprite immediately before it disappears:
            if G.GAME.blind and G.GAME.blind.children.animated_sprite then
                G.GAME.blind.children.animated_sprite:set_sprite_pos({x = 0, y = 1})
            end
        end
    end,
    modify_dollars = function(self)
        if beatInOneHand() then
            G.GAME.blind.dollars = 0
            return G.GAME.blind.dollars -- Force la récompense affichée et donnée à 0$
        end
        return G.GAME.blind.dollars -- Donne les 10$ par défaut si battu en plusieurs mains
    end
}