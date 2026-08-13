return {
    descriptions = {
        Joker = {
            j_maxarch_Archjoker = {
                name = 'Archéologue',
                text = {
                    "Copie l'effet du {C:attention}Joker{} à cette",
                    "position pendant la {C:dark_edition,E:1}dernière partie{}",
                    "{s:0.9,C:attention}Archéologue {s:0.9}exclu"
                },
                unlock = {"Utiliser {C:attention}1{} carte {C:tarot,E:1}Excavation{}"}
            },
            j_maxarch_Sandjoker = {
                name = "Joker de sable",
                text = {
                    "Réduit la taille de blinde de {B:1,C:white}X#1#{}",
                    "pour chaque {C:attention}Carte Sableuse",
                    "dans votre {C:attention}jeu complet",
                    "{C:inactive}(Actuellement : {B:1,C:white}X#2#{C:inactive})",
                },
            },
            j_maxarch_Brushjoker = {
                name = "Pinceau",
                text = {
                    "Si la {C:attention}première main{} de la manche",
                    "est une seule {C:attention}Carte Sableuse{},",
                    "enlève le sable et la transforme en",
                    "{C:dark_edition,E:1}nouvelle carte améliorée{}",
                    "{C:inactive}({C:attention}#1#{C:inactive} restantes)"
                }
            }
        },
        Other = {
            arch_incompat = {
                name = "Incompatible",
                text = {
                    "{C:mult}#1#{}"
                }
            },
            brokeF = {
                name = "Fossile Brisé",
            },
            maxarch_scarabs_seal = {
                name = "Sceau Scarabée",
                text = {
                    "Effet varie avec la position de",
                    "la carte dans la main jouée :",
                    "{X:dark_edition,C:white}Effet#5#actuel#5#:{} {C:attention,s:1.1}#4#{}",
                    "{C:inactive,E:1}---------------------------------{}",
                    "{C:tarot}aube{} : {C:chips}+#3#{} Jetons et {C:mult}+#1#{} Mult si {C:attention}dernière{}",
                    "{C:gold}zénith{} : {C:money}+#2#${} si au {C:attention}milieu{}",
                    "{C:mult}crépuscule{} : {X:mult,C:white}X#6#{} Mult si {C:attention}dernière{}"

                }
            }
        },
        Tarot = {
            c_maxarch_ExcTarot = {
                name = "Excavation",
                text = {
                    "{C:green,s:1.1}#1# chance(s) sur #2#{} {C:default,s:1.1}de gagner{} {C:money,s:1.1}$#3#{}",
                    "sinon déclenche la {X:spectral,C:edition,E:1}Malédiction#4#du#4#Pharaon{}"
                }
            },
            c_maxarch_DesTarot = {
                name = "Désert",
                text = {
                    "Améliore {C:attention}#1#{}",
                    "cartes sélectionnées en",
                    "{C:attention}Carte Sableuse{}"
                }
            }
        },
        Spectral = {
            c_maxarch_ArteSpec = {
                name = "Artéfact",
                text = {
                    "Ajoute un {V:1}Sceau Scarabée{}",
                    "à {C:attention}#1#{} carte sélectionnée",
                    "dans votre main"
                }
            }
        },
        Enhanced = {
            m_maxarch_sanddd = {
                name = "Carte Sableuse",
                text = {
                    "{B:1,C:white}X#1#{} taille de blinde"
                }
            }
        },
        Back = {
            b_maxarch_Museum = {
                name = "Jeu du Musée",
                text = {
                    "{s:0.8}Après avoir battu une{} {s:0.8,C:attention}Blinde Boss{}{s:0.8} :{}",
                    "{s:0.8,C:money}$#2#{} {s:0.8}par{} {s:0.8,C:common}Commun{}",
                    "{s:0.8,C:money}$#3#{} {s:0.8}par{} {s:0.8,C:uncommon}Peu commun{}{}",
                    "{s:0.8,C:money}$#4#{} {s:0.8}par{} {s:0.8,C:rare}Rare{}{}",
                    "{s:0.8,C:spectral,E:1}1 carte spectrale{} {s:0.8}par{} {s:0.8,C:legendary}Légendaire{}{}",
                    "Vous ne percevez pas d'{C:attention}intérêts{}"
                },
                unlock = {
                    "Découvrez au moins",
                    "{C:attention}#1#{} objets de",
                    "votre collection"
                }
            }
        },
        Blind = {
            bl_maxarch_bossil = {
                name = "Le Fossile",
                text = {
                    "Attention, les flammes le brisent"
                }
            }
        },
        Tag = {
            tag_maxarch_PR = {
                name = "Badge de Révision",
                text = {
                "Déclenche à nouveau toutes les",
                "cartes {C:attention}marquantes{} et",
                "toutes les capacités des",
                "{C:attention}cartes en main{}"
                }
            }
        },
        Voucher = {
            v_maxarch_shovelvoucher = {
                name = "Pelle",
                text = {
                    "Octroie {C:money}$1{} par carte jouée",
                    "si {C:attention}1/3{} du jeu a été pioché",
                    "{C:inactive}(#6#/#1# requis){}"
                }
            },
            v_maxarch_excavatorvoucher = {
                name = "Pelleteuse",
                text = {
                    "Octroie de manière",
                    "permanente {C:red}+#5#{} défausse",
                    "Octroie {C:money}$1{} par carte jouée",
                    "si {C:attention}2/3{} du jeu a été pioché",
                    "{C:inactive}(#6#/#1# requis){}"
                },
                unlock = {
                    "Utilisez la {C:voucher}Pelle{}",
                    "{C:attention}#1#{} fois au total",
                    "{C:inactive}(#2#)",
                },
            }
        },
        Mod = {
            MaxArchMod = {
                name = "Mod Archéologue",
                text = {
                    "C'est mon premier mod, il ajoute un peu de tout",
                    "avec des mécaniques intéressantes et fonctionnelles(?)",
                    "{X:mult,C:white}!!!{} {C:mult} Le joker à tendance à faire crash le jeu{}",
                    "{C:mult}si associé à des jokers moddés complexes{}",
                    "Merci {C:chips}@theAstra_{} pour les tutoriels youtube",
                    "pour faire des mods Balatro, et la communauté de",
                    "modding et de pixel art Balatro pour leur aide et leurs retours",
                    "{C:legendary}<3{}"
                }
            }
        }
    },
    misc = {
        dictionary = {
            k_maxarch_exco = "Trésor !",
            k_maxarch_excx = "Malédiction du Pharaon !",
            k_maxarch_brok = "Brisé !",

            k_maxarch_none = "aucun",
            k_maxarch_dawn = "aube",
            k_maxarch_zenith = "zénith",
            k_maxarch_dusk = "crépuscule"
        }
    }
}