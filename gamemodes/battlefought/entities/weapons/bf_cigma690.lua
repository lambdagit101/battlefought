AddCSLuaFile()

SWEP.PrintName = "Cigma 690 AUTO"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "American Shotgun, fully automatic, perfect for your one man cheeseburger apocalypse."

SWEP.Slot = 2

SWEP.KillIcon = "B"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "B"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "B"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_shot_xm1014.mdl"
SWEP.WorldModel = "models/weapons/w_shot_xm1014.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "shotgun"
SWEP.AimHoldType = "ar2"

SWEP.Primary.Ammo = "buckshot"
SWEP.Primary.ClipSize = 7
SWEP.Primary.DefaultClip = 7
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 171
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 6
SWEP.Bullet.Damage = 18
SWEP.Bullet.Force = 4
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.09
SWEP.Bullet.Sound = Sound("Weapon_XM1014.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 2.475
SWEP.Recoil.SidewaysRecoil = {1.01785, -1.4795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6585
SWEP.ADS.Speed = 7.75
SWEP.ADS.Cone = 0.067965
SWEP.ADS.RecoilMP = 0.7084357895
SWEP.ADS.Pos = Vector(-2, -2, 2)
SWEP.ADS.Ang = Angle(0, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8156945
SWEP.Crouch.Cone = 0.0541357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.528575
SWEP.Movement.Cone = 0.225
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
SWEP.Rload.Shells = true
SWEP.Rload.ShellInserted = 1

SWEP.Crosshair = {}
SWEP.Crosshair.TShape = true
SWEP.Crosshair.HideADS = false
SWEP.Crosshair.CenterDot = true