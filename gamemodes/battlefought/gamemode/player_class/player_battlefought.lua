DEFINE_BASECLASS("player_default")

local PLAYER = {} 

PLAYER.DisplayName = "battle_fought_player"
PLAYER.WalkSpeed = 200
PLAYER.RunSpeed  = 400
PLAYER.CrouchedWalkSpeed = 0.3
 
function PLAYER:Loadout()
    self.Player:RemoveAllAmmo()
 	self.Player:GiveAmmo(1,	"armor_charge", true)
 	self.Player:Give("bf_armorcharger")
end

player_manager.RegisterClass("player_battlefought", PLAYER, "player_default")