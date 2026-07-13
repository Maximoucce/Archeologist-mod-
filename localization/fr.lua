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
                unlock = {"Utiliser {C:attention}1{} carte {C:tarot,T:c_maxarch_ExcTarot,E:1}Excavation{}"}
            }
        },
        Other = {
            arch_incompat = {
                name = "Incompatible",
                text = {
                    "{C:mult}L'Archéologue ne peut pas{}",
                    "{C:mult}se copier lui-même{}"
                }
            },
            brokeF = {
                name = "Fossile Brisé",
            },
            brokemsg = {
                name = "Brisé !",
            },
            maxarch_scarabs_seal = {
                name = "Sceau Scarabée",
                text = {
                    "Effet varie avec la position de",
                    "la carte dans la main jouée :",
                    "{X:dark_edition,C:white}Effet#5#actuel#5#:{} {C:attention}#4#{}",
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
                    "{V:1}-#1#%{} taille de blinde"
                }
            }
        },
        Back = {
            b_maxarch_Museum = {
                name = "Jeu du Musée",
                text = {
                    "Après avoir battu une {C:attention}Blinde Boss{}, recevez :",
                    "{C:money}$#2#{} par Joker {C:common}Commun{}",
                    "{C:money}$#3#{} par Joker {C:uncommon}Peu Commun{}",
                    "{C:money}$#4#{} par Joker {C:rare}Rare{}",
                    "une {C:spectral,E:1}carte spectrale{}",
                    "par Joker {C:legendary}Légendaire{}",
                    "Pas d'{C:attention}intérêts{} ni de bonus de {C:blue}main restante{}"
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
                    "modding pour leur aide et leurs retours {C:purple}<3{}"
                }
            }
        }
    }
}