AddCSLuaFile()

SWEP.PrintName = "FTB-90"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Japanese Personal Defence Weapon, firing it's own caliber, it can deal increased damage at short to medium ranges."

SWEP.Weight = 15
SWEP.Slot = 2

SWEP.KillIcon = "m"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "m"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_p90.mdl"
SWEP.WorldModel = "models/weapons/w_smg_p90.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "smg"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 0.9185

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 857
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 25
SWEP.Bullet.Force = 18
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.031
SWEP.Bullet.Sound = Sound("Weapon_P90.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 1.45
SWEP.Recoil.SidewaysRecoil = {0.71785, -0.71785}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.4685
SWEP.ADS.Speed = 13.45
SWEP.ADS.Cone = 0.021965
SWEP.ADS.RecoilMP = 0.5984357895
SWEP.ADS.Pos = Vector(3.332, -1.806, 1.652)
SWEP.ADS.Ang = Angle(1.633, 0, 0)
SWEP.ADS.Scope = true

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.0301357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.032
SWEP.Movement.Pos = Vector(0, -3.967, -0.831)
SWEP.Movement.Ang = Angle(-3.945, 20.867, -5.367)

SWEP.Anim = {}
SWEP.Anim.EquipEmpty = ACT_VM_DRAW
SWEP.Anim.Equip = ACT_VM_DRAW
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