AddCSLuaFile()

SWEP.PrintName = "PROTOTYPE: Vanguard"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Futuristic Rifle, functionally similar to WW2 relic KZ-M Rodyna, based on sledgehammers."

SWEP.Weight = 999
SWEP.Slot = 2

SWEP.KillIcon = "2"
SWEP.KillIconFont = "bfthud-hl2killicons"
SWEP.SelectIcon = "2"
SWEP.SelectIconFont = "bfthud-hl2icons"
SWEP.BlurSelectIcon = "2"
SWEP.SelectIconBlurFont = "bfthud-hl2icons-blur"

SWEP.ViewModel = "models/weapons/c_irifle.mdl"
SWEP.WorldModel = "models/weapons/w_irifle.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "AR2"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 600
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 30
SWEP.Bullet.Force = 19
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.0156
SWEP.Bullet.Sound = Sound("Weapon_AR2.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 1.275
SWEP.Recoil.SidewaysRecoil = {1.01785, -1.4795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6585
SWEP.ADS.Speed = 6.05
SWEP.ADS.Cone = 0.0127965
SWEP.ADS.RecoilMP = 0.7084357895
SWEP.ADS.Pos = Vector(-2, -2, 2)
SWEP.ADS.Ang = Angle(0, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8156945
SWEP.Crouch.Cone = 0.01341357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.528575
SWEP.Movement.Cone = 0.05
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

SWEP.Crosshair = {}
SWEP.Crosshair.Enabled = true
SWEP.Crosshair.TShape = true
SWEP.Crosshair.HideADS = false
SWEP.Crosshair.CenterDot = false