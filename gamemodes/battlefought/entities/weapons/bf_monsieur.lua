AddCSLuaFile()

SWEP.PrintName = "Monsieur 47-41-59"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Belgian assault rifle. We say that so it is not french."

SWEP.Slot = 2

SWEP.KillIcon = "t"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "t"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_famas.mdl"
SWEP.WorldModel = "models/weapons/w_rif_famas.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "AR2"
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 790
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 29
SWEP.Bullet.Force = 13
SWEP.Bullet.TracerFrequency = 0
SWEP.Bullet.Cone = 0.016875
SWEP.Bullet.Sound = Sound("Weapon_Famas.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 1.1975
SWEP.Recoil.SidewaysRecoil = {0.681785, -0.7795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6985
SWEP.ADS.Speed = 2.65
SWEP.ADS.Cone = 0.0087965
SWEP.ADS.RecoilMP = 0.6084357895
SWEP.ADS.Pos = Vector(-2.921, 0, 0.238)
SWEP.ADS.Ang = Angle(2.634, 1.385, -4)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8156945
SWEP.Crouch.Cone = 0.00941357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.528575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(0, -3.967, -0.831)
SWEP.Movement.Ang = Angle(-3.945, 20.867, -5.367)

SWEP.Anim = {}
SWEP.Anim.EquipEmpty = ACT_VM_DEPLOY
SWEP.Anim.Equip = ACT_VM_DEPLOY
SWEP.Anim.ShootEmpty = ACT_VM_PRIMARYATTACK
SWEP.Anim.Shoot = ACT_VM_PRIMARYATTACK
SWEP.Anim.ReloadEmpty = ACT_VM_RELOAD
SWEP.Anim.Reload = ACT_VM_RELOAD
SWEP.Anim.IdleEmpty = ACT_VM_IDLE
SWEP.Anim.Idle = ACT_VM_IDLE

SWEP.Anim.ShellReloadStart = ACT_SHOTGUN_RELOAD_START
SWEP.Anim.ShellReloadInsert = ACT_VM_RELOAD
SWEP.Anim.ShellReloadFinish = ACT_SHOTGUN_RELOAD_FINISH

SWEP.Rload = {}
SWEP.Rload.Shells = false
SWEP.Rload.ShellInserted = 1

SWEP.Crosshair = {}
SWEP.Crosshair.Enabled = true
SWEP.Crosshair.TShape = true
SWEP.Crosshair.HideADS = false
SWEP.Crosshair.CenterDot = true