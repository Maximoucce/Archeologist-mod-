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
            brokeF = {
                name = "Broken Fossil",
            },
            brokemsg = {
                name = "Broken !",
            },
            maxarch_scarabs_seal = {
                name = "Scarab Seal",
                text = {
                    "Effect varies with card's",
                    "position in played hand :",
                    "{X:dark_edition,C:white}Current#5#effect#5#:{} {C:attention}#4#{}",
                    "{C:inactive,E:1}---------------------------------{}",
                    "{C:tarot}dawn{} : {C:chips}+#3#{} Chips and {C:mult}+#1#{} Mult if {C:attention}first{}",
                    "{C:gold}zenith{} : {C:money}+#2#${} if in the {C:attention}middle{}",
                    "{C:mult}dusk{} : {X:mult,C:white}X#6#{} Mult if {C:attention}last{}"

                }
            }
        },
        Tarot = {
            c_maxarch_ExcTarot = {
                name = "Excavation",
                text = {
                    "{C:green,s:1.1}#1# in #2#{} {C:default,s:1.1}chance to win{} {C:money,s:1.1}$#3#{}",
                    "else triggers the {X:spectral,C:edition,E:1}Pharaoh's#4#Curse{}"
                }
            },
            c_maxarch_DesTarot = {
                name = "Desert",
                text = {
                    "Enhances {C:attention}#1#{}",
                    "selected cards to",
                    "{C:attention}Sandy Card{}"
                }
            }
        },
        Spectral = {
            c_maxarch_ArteSpec = {
                name = "Artefact",
                text = {
                    "Add a {V:1}Scarab Seal{}",
                    "to {C:attention}#1#{} selected",
                    "card in your hand"
                }
            }
        },
        Enhanced = {
            m_maxarch_sanddd = {
                name = "Sandy Card",
                text = {
                    "{V:1}-#1#%{} blind size"
                }
            }
        },
        Back = {
            b_maxarch_Museum = {
                name = "Museum Deck",
                text = {
                    "After beating a {C:attention}Boss Blind{}, earn :",
                    "{C:money}$#2#{} per {C:common}Common{} Joker",
                    "{C:money}$#3#{} per {C:uncommon}Uncommon{} Joker",
                    "{C:money}$#4#{} per {C:rare}Rare{} Joker",
                    "one {C:spectral,E:1}spectral card{}",
                    "per {C:legendary}Legendary{} Joker",
                    "No {C:attention}Interest{} or extra {C:blue}Hand{} bonus"
                },
                unlock = {
                    "Discover at least",
                    "{C:attention}#1#{} items from",
                    "your collection"
                }
            }
        },
        Blind = {
            bl_maxarch_bossil = {
                name = "The Fossil",
                text = {
                    "Careful, flames break it"
                }
            }
        },
        Mod = {
            MaxArchMod = {
                name = "Archeologist Mod",
                text = {
                    "This is my first mod, it adds a bit of everything",
                    "with interesting and not buggy at all features",
                    "{X:mult,C:white}!!!{} {C:mult} The joker tends to crash the game{}",
                    "{C:mult}when paired with complex modded jokers{}",
                    "Thank you {C:chips}@theAstra_{} for the youtube tutorials",
                    "on how to make Balatro mods, and the Balatro",
                    "modding community for their help and feeback {C:purple}<3{}"
                }
            }
        }
    }
}