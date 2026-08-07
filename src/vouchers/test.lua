--https://github.com/Steamodded/smods/wiki/SMODS.Voucher
--lvl 1 : chance de ne pas utiliser les consommables (1/10) ou redonner
--lvl 2 : ?
--déblocage avec le nombre de consommables utilisés ? sur une seule run ?

SMODS.Atlas {
    key = "voucherstest1",
    path = "voucherstest1.png",
    px = 71,
    py = 95
}

-- Inspiring Movie
SMODS.Voucher {
    key = "copycons1",
    atlas = "voucherstest1",
    pos = {
        x = 0,
        y = 0
    },
    discovered = "false",
    unlocked = "true",
    cost = 10,

    config = {}
}

-- Grand Thesis
SMODS.Voucher {
    key = "copycons2",
    atlas = "voucherstest1",
    pos = {
        x = 1,
        y = 0
    },
    requires = {"v_maxarch_copycons1"},
    discovered = "false",
    unlocked = "true",
    cost = 10,

    config = {}
}