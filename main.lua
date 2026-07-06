SMODS.Atlas {
    key = "ArchHDf",
    path = "ArchHDf.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = "ExcImage",
    path = "ExcHD.png",
    px = 71,
    py = 95
}

SMODS.Sound({
    key = "PCLong",
    path = "PCLong.ogg"
})

SMODS.Atlas {
    key = "modicon",
    path = "ArchTagHDf.png",
    px = 34,
    py = 34
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