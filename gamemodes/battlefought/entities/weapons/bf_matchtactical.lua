AddCSLuaFile()

SWEP.PrintName = "United States Tactical .45"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "German Handgun, police variant of the United States Match .45."

SWEP.Weight = 5
SWEP.Slot = 1

SWEP.KillIcon = "y"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "y"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "y"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel = "models/weapons/w_pist_usp.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.AimHoldType = "revolver"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 444
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 23
SWEP.Bullet.Force = 12
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.013
SWEP.Bullet.Sound = Sound("Weapon_USP.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.538975
SWEP.Recoil.SidewaysRecoil = {0.09085, -0.1195}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7485
SWEP.ADS.Speed = 18.55
SWEP.ADS.Cone = 0.0027965
SWEP.ADS.RecoilMP = 0.7984357895
SWEP.ADS.Pos = Vector(-5.92, -3.327, 2.38)
SWEP.ADS.Ang = Angle(0.414, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(-0.834, -20, -16.716)
SWEP.Movement.Ang = Angle(65.29, 0, 0)
SWEP.Movement.Pos2 = Vector(0.354, -18.445, -16.442)
SWEP.Movement.Ang2 = Angle(66.585, 0, 0)

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
SWEP.Crosshair.HideADS = true
SWEP.Crosshair.CenterDot = true