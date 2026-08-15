SMODS.Atlas {
    key = "staketest",
    path = "staketest3.png",
    px = 29,
    py = 29
}

SMODS.Atlas {
    key = "stakestickertest",
    path = "stakestickertest2.png",
    px = 71,
    py = 95
}

SMODS.Stake {
    key = "pale_green",

    order = 1,
    unlocked_stake = "maxarch_brown",
    applied_stakes = { "gold" },
    above_stake = "gold",
    --Code fragment from Buffonery
    prefix_config = {
		above_stake = { mod = false },
		applied_stakes = { mod = false }
	},

	atlas = "staketest",
    pos = {
        x = 0,
        y = 0
    },

	sticker_atlas = "stakestickertest",
    sticker_pos = {
        x = 0,
        y = 0
    },

    modifiers = function()
        G.GAME.modifiers.enable_washed_in_shop = true
    end,

    colour = HEX("a0c69e")
}


SMODS.Stake {
    key = "brown",

    order = 2,
    applied_stakes = {"maxarch_pale_green"},
    above_stake = "maxarch_pale_green",
    --Code fragment from Buffonery
    prefix_config = {
		above_stake = { mod = false },
		applied_stakes = { mod = false }
	},

	atlas = "staketest",
    pos = {
        x = 1,
        y = 0
    },

	sticker_atlas = "stakestickertest",
    sticker_pos = {
        x = 1,
        y = 0
    },


    modifiers = function()
        G.GAME.modifiers.enable_faulty_in_shop = true
    end,

    colour = HEX("a07c46")
}