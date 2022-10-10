if file.Exists("battle-fought-tables.lua", "LUA") then
    AddCSLuaFile("battle-fought-tables.lua")
    include("battle-fought-tables.lua")
end

function GM:GenerateDefaultBFTable()
    local meinTable = {}

    meinTable.StartingWeapons = {"bf_p337", "bf_sixeight", "bf_brock13", "bf_match45", "bf_matchtactical", "bf_goldbeagle"}

    meinTable.CommonWeapons = {"bf_sixeight", "bf_match45", "bf_matchtactical", "bf_gewehr3", "bf_blitzer770", "bf_bigmac12", "bf_mp5", "bf_marksmanc"}

    meinTable.RareWeapons = {"bf_goldbeagle", "bf_kzmrodyna", "bf_monsieur", "bf_p337", "bf_marksmanp", "bf_mp7", "bf_ump45", "bf_futaba90", "bf_ava4", "bf_cigma480", "bf_drp", "bf_brock13"}

    meinTable.EpiqueWeapons = {"bf_cigma690", "bf_bullpup", "bf_blitzer772", "bf_m789", "bf_prototypevg", "bf_pdfattacker", "bf_spasme12"}

    meinTable.Primaries = {
        ["bf_cigma690"] = true,
        ["bf_bullpup"] = true,
        ["bf_blitzer772"] = true,
        ["bf_m789"] = true,
        ["bf_prototypevg"] = true,
        ["bf_pdfattacker"] = true,
        ["bf_marksmanp"] = true,
        ["bf_mp7"] = true,
        ["bf_ump45"] = true,
        ["bf_futaba90"] = true,
        ["bf_ava4"] = true,
        ["bf_cigma480"] = true,
        ["bf_drp"] = true,
        ["bf_kzmrodyna"] = true,
        ["bf_monsieur"] = true,
        ["bf_gewehr3"] = true,
        ["bf_blitzer770"] = true,
        ["bf_bigmac12"] = true,
        ["bf_mp5"] = true,
        ["bf_marksmanc"] = true,
        ["bf_spasme12"] = true
    }

    meinTable.Secondaries = {
        ["bf_goldbeagle"] = true,
        ["bf_p337"] = true,
        ["bf_sixeight"] = true,
        ["bf_match45"] = true,
        ["bf_matchtactical"] = true,
        ["bf_brock13"] = true
    }

    meinTable.Whitelist = {
        ["aact_weapact"] = true
    }

    meinTable.Knife = "bf_knife"
    meinTable.ArmorCharger = "bf_armorcharger"

    meinTable.PlayerModels = {
        ["css_riot"] = "models/player/riot.mdl",
        ["css_gasmask"] = "models/player/gasmask.mdl",
        ["css_urban"] = "models/player/urban.mdl",
        ["css_swat"] = "models/player/swat.mdl",
        ["css_phoenix"] = "models/player/phoenix.mdl",
        ["css_leet"] = "models/player/leet.mdl",
        ["css_arctic"] = "models/player/arctic.mdl",
        ["css_guerilla"] = "models/player/guerilla.mdl",
        ["dod_american"] = "models/player/dod_american.mdl",
        ["dod_german"] = "models/player/dod_german.mdl",
        ["eli"] = "models/player/eli.mdl",
        ["male07"] = "models/player/Group01/male_07.mdl",
        ["male17"] = "models/player/Group03/male_07.mdl",
        ["medic07"] = "models/player/Group03m/male_07.mdl",
        ["medic11"] = "models/player/Group03m/female_02.mdl",
        ["female08"] = "models/player/Group03/female_02.mdl",
        ["female02"] = "models/player/Group01/female_02.mdl",
        ["combineprison"] = "models/player/combine_soldier_prisonguard.mdl",
        ["combine"] = "models/player/combine_soldier.mdl",
        ["combineelite"] = "models/player/combine_super_soldier.mdl",
        ["alyx"] = "models/player/alyx.mdl",
        ["barney"] = "models/player/barney.mdl",
        ["breen"] = "models/player/breen.mdl",
        ["police"] = "models/player/police.mdl",
        ["policefem"] = "models/player/police_fem.mdl",
        ["stripped"] = "models/player/soldier_stripped.mdl",
        ["skeleton"] = "models/player/skeleton.mdl",
        ["mossman"] = "models/player/mossman.mdl",
        ["mossmanarctic"] = "models/player/mossman_arctic.mdl",
        ["odessa"] = "models/player/odessa.mdl",
        ["chell"] = "models/player/p2_chell.mdl",
        ["gman"] = "models/player/gman_high.mdl",
        ["kleiner"] = "models/player/kleiner.mdl",
        ["hostage01"] = "models/player/hostage/hostage_01.mdl",
        ["hostage02"] = "models/player/hostage/hostage_02.mdl",
        ["hostage03"] = "models/player/hostage/hostage_03.mdl",
        ["hostage04"] = "models/player/hostage/hostage_04.mdl",
        ["magnusson"] = "models/player/magnusson.mdl"
    }

    meinTable.DefaultPM = "dod_american"

    return meinTable
end

BF = BF or {}

if table.IsEmpty(BF) then
    BF = GM:GenerateDefaultBFTable()
end

function GM:ReturnBFTable()
    return BF
end

function GM:ReturnRandomWeapon()
    local weapon = math.random(1, 3)
    local rarity = weapon

    if weapon == 1 then
        weapon = BF.CommonWeapons
    elseif weapon == 2 then
        weapon = BF.RareWeapons
    else
        weapon = BF.EpiqueWeapons
    end

    return weapon[math.random(#weapon)], rarity
end