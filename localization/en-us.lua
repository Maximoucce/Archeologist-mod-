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
                unlock = {"Use {C:attention}1{} {C:tarot,E:1}Excavation{} card"}
            },
            j_maxarch_Sandjoker = {
                name = "Sand Joker",
                text = {
                    "Reduce blind size by {B:1,C:white}X#1#{}",
                    "for each {C:attention}Sandy Card",
                    "in your {C:attention}full deck",
                    "{C:inactive}(Currently {B:1,C:white}X#2#{C:inactive})",
                },
            },
            j_maxarch_Brushjoker = {
                name = "Brush",
                text = {
                    "If {C:attention}first hand{} of round is",
                    "a single {C:attention}Sandy Card{}, remove",
                    "the sand and turn it into a",
                    "{C:dark_edition,E:1}new enhanced card{}",
                    "{C:inactive}({C:attention}#1#{C:inactive} remaining)",
                }
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
            maxarch_scarabs_seal = {
                name = "Scarab Seal",
                text = {
                    "Effect varies with card's",
                    "position in played hand :",
                    "{X:dark_edition,C:white}Current#5#effect#5#:{} {C:attention,s:1.1}#4#{}",
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
                    "{B:1,C:white}X#1#{} blind size"
                }
            }
        },
        Back = {
            b_maxarch_Museum = {
                name = "Museum Deck",
                text = {
                    "{s:0.8}After beating a{} {s:0.8,C:attention}Boss Blind{}{s:0.8}, earn :{}",
                    "{s:0.8,C:money}$#2#{} {s:0.8}per{} {s:0.8,C:common}Common{}",
                    "{s:0.8,C:money}$#3#{} {s:0.8}per{} {s:0.8,C:uncommon}Uncommon{}{}",
                    "{s:0.8,C:money}$#4#{} {s:0.8}per{} {s:0.8,C:rare}Rare{}{}",
                    "{s:0.8,C:spectral,E:1}1 spectral card{} {s:0.8}per{} {s:0.8,C:legendary}Legendary{}{}",
                    "{s:0.8}Earn no{} {s:0.8,C:attention}Interest{}"
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
        Tag = {
            tag_maxarch_PR = {
                name = "Review Tag",
                text = {
                "Retrigger all",
                "{C:attention}played{} cards and",
                "all card {C:attention}held in",
                "{C:attention}hand{} abilities"
                }
            }
        },
        Voucher = {
            v_maxarch_shovelvoucher = {
                name = "Shovel",
                text = {
                    "Grants {C:money}$1{} per card played",
                    "if {C:attention}1/3{} of the deck",
                    "has been drawn",
                    "{C:inactive}(#6#/#1# required){}"
                }
            },
            v_maxarch_excavatorvoucher = {
                name = "Excavator",
                text = {
                    "Permanently gain {C:red}+#5#{} discard",
                    "Grants {C:money}$1{} per card played",
                    "if {C:attention}2/3{} of the deck",
                    "has been drawn",
                    "{C:inactive}(#6#/#1# required){}"
                },
                unlock = {
                    "Redeem {C:voucher}Shovel{}",
                    "{C:attention}#1#{} total times",
                    "{C:inactive}(#2#)",
                },
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
                    "modding and pixel art communities for their help and feeback",
                    "{C:purple}<3{}"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_maxarch_exco = "Treasure !",
            k_maxarch_excx = "Pharaoh's curse !",
            k_maxarch_brok = "Broken !",

            k_maxarch_none = "none",
            k_maxarch_dawn = "dawn",
            k_maxarch_zenith = "zenith",
            k_maxarch_dusk = "dusk"

        }
    }
}