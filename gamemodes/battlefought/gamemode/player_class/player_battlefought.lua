DEFINE_BASECLASS("player_default")

local PLAYER = {} 

PLAYER.DisplayName = "battle_fought_player"
PLAYER.WalkSpeed = 200
PLAYER.SlowWalkSpeed = 150
PLAYER.RunSpeed  = 345
PLAYER.CrouchedWalkSpeed = 0.3
PLAYER.StartArmor = 33
PLAYER.MaxArmor = 99
 
function PLAYER:Loadout()
    self.Player:RemoveAllAmmo()
 	self.Player:GiveAmmo(1,	"armor_charge", true)
 	self.Player:Give("bf_armorcharger")
end

player_manager.RegisterClass("player_battlefought", PLAYER, "player_default")