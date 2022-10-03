AddCSLuaFile()

SWEP.PrintName = "United States Match .45"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "German Handgun, deals decent damage, a great fallback."

SWEP.Weight = 4
SWEP.Slot = 1

SWEP.KillIcon = "-"
SWEP.KillIconFont = "bfthud-hl2killicons"
SWEP.SelectIcon = "-"
SWEP.SelectIconFont = "bfthud-hl2icons"
SWEP.BlurSelectIcon = "-"
SWEP.SelectIconBlurFont = "bfthud-hl2icons-blur"

SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
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
SWEP.LeEquip.SpeedMP = 1.32985

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 400
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 35
SWEP.Bullet.Force = 9
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.015
SWEP.Bullet.Sound = Sound("Weapon_Pistol.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.678975
SWEP.Recoil.SidewaysRecoil = {0.11785, -0.1795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7985
SWEP.ADS.Speed = 18.55
SWEP.ADS.Cone = 0.0037965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(-5.96, -3.327, 2.88)
SWEP.ADS.Ang = Angle(0.414, -1.277, 1.404)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(0, 0, 0)
SWEP.Movement.Ang = Angle(-5.623, 7.218, -2.52)

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
SWEP.Rload.Sound = Sound("Weapon_Pistol.Reload")

SWEP.Crosshair = {}
SWEP.Crosshair.TShape = true
SWEP.Crosshair.HideADS = true
SWEP.Crosshair.CenterDot = true