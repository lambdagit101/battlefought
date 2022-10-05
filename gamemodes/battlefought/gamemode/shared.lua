GM.Name = "battle_fought_"
GM.Author = "lambups & juinc"
GM.Email = "N/A"
GM.Website = "N/A"

AddCSLuaFile("player_class/player_battlefought.lua")
AddCSLuaFile("sh_modules/sh_defaulttable.lua")
AddCSLuaFile("sh_modules/sh_handleround.lua")
AddCSLuaFile("sh_modules/sh_f1menu.lua")

include("player_class/player_battlefought.lua")
include("sh_modules/sh_defaulttable.lua")
include("sh_modules/sh_handleround.lua")
include("sh_modules/sh_f1menu.lua")

function GM:Initialize()
	game.AddAmmoType({
		name = "armor_charge",
		dmgtype = DMG_GENERIC,
		tracer = TRACER_LINE,
		plydmg = 0,
		npcdmg = 0,
		force = 0,
		minsplash = 0,
		maxsplash = 0
	})
end