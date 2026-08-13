if JokerDisplay then
    local jd_def = JokerDisplay.Definitions

    jd_def["j_maxarch_Sandjoker"] = {
        text = {
            {
                border_nodes = {
                    {
                        text = "X",
                        colour = G.C.WHITE,
                    },
                    {
                        ref_table = "card.joker_display_values",
                        ref_value = "sandval"
                    }
                },
                border_colour = G.C.DYN_UI.DARK
            }
        },
        calc_function = function(card)
            local sandy_tally = 0
            local xblind = (card.ability and card.ability.extra and card.ability.extra.xblindsize) or 0

            if G.playing_cards then
                for _, playing_card in ipairs(G.playing_cards) do
                    if SMODS.has_enhancement(playing_card, "m_maxarch_sanddd") then sandy_tally = sandy_tally + 1 end
                end
            end
            card.joker_display_values.sandval = 1 - (xblind * (sandy_tally or 0))
        end
    }

    jd_def["j_maxarch_Brushjoker"] = {
        extra = {
            {
            {text = "(", colour = G.C.UI.TEXT_INACTIVE, scale = 0.35},
            {
                ref_table = "card.joker_display_values",
                ref_value = "usesleft",
                colour = G.C.UI.TEXT_INACTIVE,
                scale = 0.35
            },
            {text = "/", colour = G.C.UI.TEXT_INACTIVE, scale = 0.35},
            {text = "4", colour = G.C.UI.TEXT_INACTIVE, scale = 0.35}, --if max uses changes
            {text = ")", colour = G.C.UI.TEXT_INACTIVE, scale = 0.35},
            },

            {
            {text = "(", colour = G.C.UI.TEXT_INACTIVE, scale = 0.30},
            {
                text = "Sandy Card",
                scale = 0.30,
                colour = G.C.SECONDARY_SET.Enhanced
            },
            {text = ")", colour = G.C.UI.TEXT_INACTIVE, scale = 0.30},
            },
        },

        reminder_text = {
            {text = "("},
            {
                ref_table = "card.joker_display_values",
                ref_value = "active_text"
            },
            {text = ")"},
        },

        calc_function = function(card)
            card.joker_display_values.is_active = G.GAME.current_round.hands_played == 0
            card.joker_display_values.active_text = localize("jdis_" ..
                (card.joker_display_values.is_active and "active" or "inactive"))

            card.joker_display_values.usesleft = card.ability.extra.uses
        end,
        style_function = function(card, text, reminder_text, extra)
            if reminder_text and reminder_text.children and reminder_text.children[2] then
                reminder_text.children[2].config.colour = card.joker_display_values.is_active and G.C.GREEN or
                    G.C.UI.TEXT_INACTIVE
            end
        end
    }

    --[[jd_def["j_maxarch_Archjoker"] = {      --WIP
        calc_function = function(card)
            JokerDisplay.copy_display(card, card.ability.target_key)
        end
    }]]

end