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
            }
        },
        Tarot = {
            c_maxarch_ExcTarot = {
                name = "Excavation",
                text = {
                    "{C:green,s:1.1}#1# sur #2#{} {C:default,s:1.1}de gagner{} {C:money,s:1.1}$#50#{}",
                    "sinon déclenche la {X:spectral,C:edition,E:1}Malédiction_du_Pharaon{}"
                }
            }
        },
        Mod = {
            MaxArchMod = {
                name = "Mod Archéologue",
                text = {
                    "Mon premier mod, il ajoute un tout nouveau joker",
                    "avec une mécanique intéressante et fonctionnelle(?)",
                    "{X:mult,C:white}!!!{} {C:mult} Ce joker à tendance à faire crash le jeu{}",
                    "{C:mult}si associé à des jokers moddés complexes{}",
                    "Merci {C:chips}@theAstra_{} pour les tutoriels youtube",
                    "pour faire des mods Balatro, et la communauté de",
                    "modding pour leur aide et leurs retours {C:purple}<3{}"
                }
            }
        }
    }
}