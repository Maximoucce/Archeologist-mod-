SMODS.Atlas {
    key = "ArchHDf",
    path = "ArchHDf.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ExcImage",
    path = "ExcHDred.png",
    px = 71,
    py = 95
}

SMODS.Sound({
    key = "PC",
    path = "PC.ogg"
})

SMODS.Atlas {
    key = "DesImage",
    path = "DSRT.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "sanddd",
    path = "sandtest.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "modicon",
    path = "ArchTagHDf.png",
    px = 34,
    py = 34
}

SMODS.Atlas {
    key = "ArteImage",
    path = "SoulArte3.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ScarImg",
    path = "SCARR11.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "Museum",
    path = "Museetest.png",
    px = 71,
    py = 95
}

SMODS.Font{
    key = "egy-hier",
    path = "ancient-egyptian-hieroglyphs.ttf",
    render_scale = 500,
    TEXT_HEIGHT_SCALE = 0.83,
    TEXT_OFFSET = {x=0,y=0},
    FONTSCALE = 0.1,
    DESCSCALE = 1
}

local consumables_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/consumables")
for _, file in ipairs(consumables_src) do
    assert(SMODS.load_file("src/consumables/" .. file))()
end

local jokers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/jokers")
for _, file in ipairs(jokers_src) do
    assert(SMODS.load_file("src/jokers/" .. file))()
end

local seals_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/seals")
for _, file in ipairs(seals_src) do
    assert(SMODS.load_file("src/seals/" .. file))()
end

local enhancements_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/enhancements")
for _, file in ipairs(enhancements_src) do
    assert(SMODS.load_file("src/enhancements/" .. file))()
end

local decks_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/decks")
for _, file in ipairs(decks_src) do
    assert(SMODS.load_file("src/decks/" .. file))()
end