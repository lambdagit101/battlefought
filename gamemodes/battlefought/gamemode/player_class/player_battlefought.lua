BF = GM:ReturnBFTable()

DEFINE_BASECLASS("player_default")

local PLAYER = {} 

PLAYER.DisplayName = "battle_fought_player"
PLAYER.WalkSpeed = 200
PLAYER.SlowWalkSpeed = 100
PLAYER.RunSpeed  = 345
PLAYER.CrouchedWalkSpeed = 0.3
PLAYER.StartArmor = 33
PLAYER.MaxArmor = 99
PLAYER.TauntCam = TauntCamera()

function PLAYER:Loadout()
    self.Player:RemoveAllAmmo()
 	self.Player:GiveAmmo(1,	"armor_charge", true)
 	self.Player:Give(BF.ArmorCharger)
 	self.Player:Give(BF.Knife)
end

function PLAYER:ShouldDrawLocal()
	if self.TauntCam:ShouldDrawLocalPlayer(self.Player, self.Player:IsPlayingTaunt()) then return true end
end

function PLAYER:CreateMove(cmd)
	if self.TauntCam:CreateMove(cmd, self.Player, self.Player:IsPlayingTaunt()) then return true end
end

function PLAYER:CalcView(view)
	if self.TauntCam:CalcView(view, self.Player, self.Player:IsPlayingTaunt()) then return true end
end

player_manager.RegisterClass("player_battlefought", PLAYER, "player_default")