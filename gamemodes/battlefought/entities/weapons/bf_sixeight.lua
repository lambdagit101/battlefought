AddCSLuaFile()

SWEP.PrintName = "Herr Six-EighT"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Swiss handgun, medium caliber, great ammo capacity and damage."

SWEP.Weight = 3
SWEP.Slot = 1

SWEP.KillIcon = "u"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "u"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_fiveseven.mdl"
SWEP.WorldModel = "models/weapons/w_pist_fiveseven.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.AimHoldType = "revolver"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 0.874525

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 444
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 28
SWEP.Bullet.Force = 14
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.017
SWEP.Bullet.Sound = Sound("Weapon_Fiveseven.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.638975
SWEP.Recoil.SidewaysRecoil = {0.29085, -0.6195}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7985
SWEP.ADS.Speed = 18.35
SWEP.ADS.Cone = 0.0047965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(-5.96, -3.327, 2.58)
SWEP.ADS.Ang = Angle(0.414, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.7856945
SWEP.Crouch.Cone = 0.01001357835

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