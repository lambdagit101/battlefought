AddCSLuaFile()

SWEP.PrintName = "337 Slick"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Dutch Handgun, fires a high caliber, making it an excellent fallback."

SWEP.Weight = 5
SWEP.Slot = 1

SWEP.KillIcon = "a"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "a"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_p228.mdl"
SWEP.WorldModel = "models/weapons/w_pist_p228.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.AimHoldType = "revolver"

SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 13
SWEP.Primary.DefaultClip = 13
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 400
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 31
SWEP.Bullet.Force = 17
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.016
SWEP.Bullet.Sound = Sound("Weapon_P228.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.838975
SWEP.Recoil.SidewaysRecoil = {0.29085, -0.29085}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7985
SWEP.ADS.Speed = 18.35
SWEP.ADS.Cone = 0.0137965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(-5.96, -3.327, 2.48)
SWEP.ADS.Ang = Angle(0.414, 0, 0.7985)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.7856945
SWEP.Crouch.Cone = 0.01471357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.518575
SWEP.Movement.Cone = 0.06
SWEP.Movement.Pos = Vector(0, 0, 0)
SWEP.Movement.Ang = Angle(-5.523, 7.218, -2.52)

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