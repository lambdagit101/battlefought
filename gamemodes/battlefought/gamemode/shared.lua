GM.Name = "battle_fought_"
GM.Author = "lambups & juinc"
GM.Email = "N/A"
GM.Website = "N/A"

if SERVER then
	AddCSLuaFile("player_class/player_battlefought.lua")
end
include("player_class/player_battlefought.lua")

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