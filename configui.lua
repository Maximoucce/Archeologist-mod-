--Code from Fusion Jokers
SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 4,
            minh = 2,
            align = "tl",
            padding = 0.2,
            colour = G.C.BLACK
        },
        nodes = {{
            n = G.UIT.C,
            config = {
                minw=1,
                minh=1,
                align = "tl",
                colour = G.C.CLEAR,
                padding = 0.15
            },
                nodes = {
                    create_toggle({
                        label = "Mewing Jokers compatibility",
                        ref_table = MaxArchMod.archconfig,
                        ref_value = "arch_alt_art",
                    })
                }
        }}
    }
end