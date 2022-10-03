AddCSLuaFile()

SWEP.PrintName = "BROCK-13"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Austrian rocket propelled grenade launcher, fully automatic with decent damage."

SWEP.Weight = 6
SWEP.Slot = 1

SWEP.KillIcon = "c"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "c"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel = "models/weapons/w_pist_glock18.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.AimHoldType = "revolver"

SWEP.Primary.Ammo = "9mmRound"
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 0.974525

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 666
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 24
SWEP.Bullet.Force = 10
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.017
SWEP.Bullet.Sound = Sound("Weapon_Glock.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.538975
SWEP.Recoil.SidewaysRecoil = {0.19085, -0.5195}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7885
SWEP.ADS.Speed = 17.95
SWEP.ADS.Cone = 0.0037965
SWEP.ADS.RecoilMP = 0.7984357895
SWEP.ADS.Pos = Vector(-5.79, -3.327, 2.58)
SWEP.ADS.Ang = Angle(0.914, 0, 0)

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