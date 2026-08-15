SMODS.Atlas {
    key = "modicon",
    path = "Icon2x.png",
    px = 34,
    py = 34
}

MaxArchMod = SMODS.current_mod
MaxArchMod.archconfig = SMODS.current_mod.config
SMODS.load_file("configui.lua")()

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

local tags_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/tags")
for _, file in ipairs(tags_src) do
    assert(SMODS.load_file("src/tags/" .. file))()
end

local blinds_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/blinds")
for _, file in ipairs(blinds_src) do
    assert(SMODS.load_file("src/blinds/" .. file))()
end

local vouchers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/vouchers")
for _, file in ipairs(vouchers_src) do
    assert(SMODS.load_file("src/vouchers/" .. file))()
end

local stakes_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/stakes")
for _, file in ipairs(stakes_src) do
    assert(SMODS.load_file("src/stakes/" .. file))()
end

local stickers_src = SMODS.NFS.getDirectoryItems(SMODS.current_mod.path .. "src/stickers")
for _, file in ipairs(stickers_src) do
    assert(SMODS.load_file("src/stickers/" .. file))()
end

SMODS.load_file("src/joker_display.lua")()