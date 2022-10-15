AddCSLuaFile()

SWEP.PrintName = "MASHINA-789"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Russian Machine Gun, works best while standing still."

SWEP.Weight = 7
SWEP.Slot = 2

SWEP.KillIcon = "z"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "z"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "z"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_mach_m249para.mdl"
SWEP.WorldModel = "models/weapons/w_mach_m249para.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "ar2"
SWEP.Primary.ClipSize = 100
SWEP.Primary.DefaultClip = 100
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1.1185

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 750
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 35
SWEP.Bullet.Force = 19
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.03
SWEP.Bullet.Sound = Sound("Weapon_M249.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 2.275
SWEP.Recoil.SidewaysRecoil = {0.51785, -0.38795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6685
SWEP.ADS.Speed = 9.55
SWEP.ADS.Cone = 0.0247965
SWEP.ADS.RecoilMP = 0.7984357895
SWEP.ADS.Pos = Vector(-5.9275, 0, 2)
SWEP.ADS.Ang = Angle(0.6575, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.02501357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.07
SWEP.Movement.Pos = Vector(2.523, 1.057, -3.757)
SWEP.Movement.Ang = Angle(-3.116, 29.691, -17.487)
SWEP.Movement.Pos2 = Vector(1.74, -0.105, -5.007)
SWEP.Movement.Ang2 = Angle(-3.116, 32.015, -17.487)

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
