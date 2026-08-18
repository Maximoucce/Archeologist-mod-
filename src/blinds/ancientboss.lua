SMODS.Atlas {
    key = "ancientbossimg",
    path = "ancienttboss.png",
    atlas_table = "ANIMATION_ATLAS",
    frames = 21,
    px = 34,
    py = 34
}

SMODS.Font{
    key = "Behistun",
    path = "Behistun-J8dE.ttf",
    render_scale = 170,
    TEXT_HEIGHT_SCALE = 0.83,
    TEXT_OFFSET = {x=0,y=0},
    FONTSCALE = 0.1,
    squish = 0.9,
    DESCSCALE = 1
}

local function restore_original_font()
    if G.original_font then
        G.LANG.font = G.original_font
        G.original_font = nil
        if G.HUD then
            G.HUD:recalculate()
        end
    end
end

local main_menu_ref = Game.main_menu
function Game:main_menu(change_context)
    restore_original_font()
    return main_menu_ref(self, change_context)
end

local start_run_ref = Game.start_run
function Game:start_run(args)
    restore_original_font()
    return start_run_ref(self, args)
end

SMODS.Blind {
    key = "ancientboss",
    atlas = "ancientbossimg",
    dollars = 8,
    mult = 3,
    pos = { x = 0, y = 0 },
    boss_colour = HEX('7E6752'),
    boss = { showdown = true },
    discovered = false,
    set_blind = function(self, reset)
        if not G.original_font then
            G.original_font = G.LANG.font
        end
        if G.LANG.font and SMODS.Fonts.maxarch_Behistun then
            G.LANG.font = SMODS.Fonts.maxarch_Behistun
            if G.HUD then
                G.HUD:recalculate()
            end
        end
    end,
    disable = function(self)
        restore_original_font()
    end,
    defeat = function(self)
        restore_original_font()
    end
}