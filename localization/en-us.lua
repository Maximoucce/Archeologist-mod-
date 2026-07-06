return {
    descriptions = {
        Joker = {
            j_maxarch_Archjoker = {
                name = "Archeologist",
                text = {
                    "Copies ability of {C:attention}Joker{}",
                    "in this position {C:dark_edition,E:1}last run{}",
                    "{s:0.9,C:attention}Archeologist {s:0.9}excluded"
                },
                unlock = {"Use {C:attention}1{} {C:tarot,T:c_maxarch_ExcTarot,E:1}Excavation{} card"}
            }
        },
        Other = {
            arch_incompat = {
                name = "Incompatible",
                text = {
                    "{C:mult}Archeologist can't{}",
                    "{C:mult}copy itself{}"
                }
            },
        },
        Tarot = {
            c_maxarch_ExcTarot = {
                name = "Excavation",
                text = {
                    "{C:green,s:1.1}#1# in #2#{} {C:default,s:1.1}chance to win{} {C:money,s:1.1}$#3#{}",
                    "else triggers the {X:spectral,C:edition,E:1}Pharaoh's Curse{}"
                }
            }
        },
        Mod = {
            MaxArchMod = {
                name = "Archeologist Mod",
                text = {
                    "This is my first mod, it adds a brand new joker",
                    "with an interesting and not buggy at all feature",
                    "{X:mult,C:white}!!!{} {C:mult} This joker tends to crash the game{}",
                    "{C:mult}when paired with complex modded jokers{}",
                    "Thank you {C:chips}@theAstra_{} for the youtube tutorials",
                    "on how to make Balatro mods, and the Balatro",
                    "modding community for their help and feeback {C:purple}<3{}"
                }
            }
        }
    }
}