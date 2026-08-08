SMODS.Atlas {
    key = "voucherstest",
    path = "voucherstest3soul+wsale1.png",
    px = 71,
    py = 95
}

-- lvl 1 : Shovel
SMODS.Voucher {
    key = "shovelvoucher",
    atlas = "voucherstest",
    pos = {
        x = 0,
        y = 0
    },
    discovered = "false",
    unlocked = "true",
    cost = 10,

    loc_vars = function(self, info_queue, card)
        local totcards = (G.playing_cards and #G.playing_cards or 52)
        local remcards = ((G.deck and G.deck.cards) and #G.deck.cards or 52)
        local halfdeck = math.floor(totcards*0.5)
        local quartdeck = math.floor(totcards*0.25)
        return {
            vars = {
                totcards,
                remcards,
                halfdeck,
                quartdeck
            }
        }
    end,

    calculate = function(self, card, context)
        local totcards = (G.playing_cards and #G.playing_cards or 52)
        local remcards = ((G.deck and G.deck.cards) and #G.deck.cards or 52)
        --Code from the Tooth
        if context.press_play then
            if remcards <= math.floor(totcards*0.5) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.play.cards[i]:juice_up()
                                    return true
                                end,
                            }))
                            ease_dollars(1)
                            delay(0.23)
                        end
                        return true
                    end
                }))
                delay(0.4)
            end
        end
    end
}

---------------------------------------------------------------------------------------

-- lvl 2 : Excavator
SMODS.Voucher {
    key = "excavatorvoucher",
    atlas = "voucherstest",
    pos = {
        x = 1,
        y = 0
    },
    soul_pos = {
        x = 2,
        y = 0
    },
    requires = {"v_maxarch_shovelvoucher"},
    discovered = "false",
    unlocked = "true",
    cost = 10,

    config = {
        extra = {
            discards = 1
        }
    },

    loc_vars = function(self, info_queue, card)
        local totcards = (G.playing_cards and #G.playing_cards or 52)
        local remcards = ((G.deck and G.deck.cards) and #G.deck.cards or 52)
        local halfdeck = math.floor(totcards*0.5)
        local quartdeck = math.floor(totcards*0.25)
        return {
            vars = {
                totcards,
                remcards,
                halfdeck,
                quartdeck,
                card.ability.extra.discards
            }
        }
    end,

    redeem = function(self, card)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.discards
        ease_discard(card.ability.extra.discards)
    end,

    calculate = function(self, card, context)
        local totcards = (G.playing_cards and #G.playing_cards or 52)
        local remcards = ((G.deck and G.deck.cards) and #G.deck.cards or 52)
        --Code from the Tooth
        if context.press_play then
            if remcards <= math.floor(totcards*0.25) then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        for i = 1, #G.play.cards do
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.play.cards[i]:juice_up()
                                    return true
                                end,
                            }))
                            ease_dollars(1)
                            delay(0.23)
                        end
                        return true
                    end
                }))
                delay(0.4)
            end
            --Secret
            if remcards == 0 and not G.GAME.excavator_easter_egg_triggered then
                G.GAME.excavator_easter_egg_triggered = true
                G.E_MANAGER:add_event(Event({
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        SMODS.add_card {
                            set = "Spectral",
                            key = "c_soul",
                            edition = "e_negative"
                        }
                        return true
                    end
                }))
                delay(0.4)
            end
        end
    end
}