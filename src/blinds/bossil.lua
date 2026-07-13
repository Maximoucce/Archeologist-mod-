SMODS.Atlas {
    key = "bossilimg",
    path = "fossilEN.png",
    px = 32,
    py = 32
}

function beatInOneHand()
    return SMODS.last_hand_oneshot == true
end

local e_sr = G.FUNCS.start_run
G.FUNCS.start_run = function(e)
    e_sr(e) -- Lance la run normalement
    
    -- On trouve ton boss dans le registre des Blinds et on reset sa position
    if G.P_BLINDS and G.P_BLINDS['bl_maxarch_bossil'] then
        G.P_BLINDS['bl_maxarch_bossil'].pos.y = 0
    end
end

SMODS.Blind {
    key = "bossil",
    atlas = "bossilimg",
    mult = 2,
    pos = { x = 0, y = 0 },
    boss_colour = HEX('7E6752'),
    boss = { min = 2 },
    dollars = 5,
    discovered = false,

    defeat = function(self)
        if beatInOneHand() then
            self.pos.y = 1
            attention_text({
                text = "brokemsg",
                set = "Other",
                scale = 1,
                hold = 1.5,
                major = self,
                backdrop_colour = G.C.RED
            })
        end
    end,

    calc_dollar_bonus = function(self,card)
        if beatInOneHand() then
            play_sound("glass2", 0.5, 1)
            self.pos.y = 1
            G.GAME.blind.dollars = -10
            return G.GAME.blind.dollars, {
                key = "brokeF",
                set = "Other",
                text_colour = G.C.RED
            }
        end
    end
}