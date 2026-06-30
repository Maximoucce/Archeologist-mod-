local Utils = {}

function Utils.get_joker_position(card)
    if not G.jokers then
        return nil
    end

    for i, joker in ipairs(G.jokers.cards) do
        if joker == card then
            return i
        end
    end

    return nil
end

function Utils.get_joker_at_position(pos)
    if not G.jokers then
        return nil
    end

    return G.jokers.cards[pos]
end

return Utils