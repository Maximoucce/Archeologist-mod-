SMODS.Atlas {
    key = "bossilimg",
    path = "fossilEN.png",
    px = 32,
    py = 32
}

SMODS.Sound({
    key = "rocbrek",
    path = "rocbrek.ogg"
})

--Code du venant du Yahimod (opentolan)
function beatInOneHand()
    return SMODS.last_hand_oneshot == true
end

--Fonction pour réinitialiser le sprite
local e_sr = G.FUNCS.start_run
G.FUNCS.start_run = function(e)
    e_sr(e)
    if G.P_BLINDS and G.P_BLINDS["bl_maxarch_bossil"] then
        G.P_BLINDS["bl_maxarch_bossil"].pos.y = 0
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

    calc_dollar_bonus = function(self,card)
        if beatInOneHand() then
            attention_text({
                text = localize("k_maxarch_brok"),
                scale = 1,
                hold = 1.3,
                major = G.GAME.blind,
                backdrop_colour = G.C.RED
            })
            --play_sound("glass2", 0.5, 1)
            play_sound("maxarch_rocbrek", 1, 0.3)
            self.pos.y = 1
            G.GAME.blind.dollars = -15
            return G.GAME.blind.dollars, {
                key = "brokeF",
                set = "Other",
                text_colour = G.C.RED
            }
        end
    end
}