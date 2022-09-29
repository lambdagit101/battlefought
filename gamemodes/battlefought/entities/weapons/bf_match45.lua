SWEP.PrintName = "United States Postal .45"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "German Handgun, deals decent damage, a great fallback."

SWEP.Slot = 1

SWEP.ViewModel = "models/weapons/v_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.ViewModelFOV = 70

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = false
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

SWEP.Equip = {}
SWEP.Equip.SpeedMP = 1.32985

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 400
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 22
SWEP.Bullet.Force = 9
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.015
SWEP.Bullet.Sound = Sound("Weapon_Pistol.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.678975
SWEP.Recoil.SidewaysRecoil = {0.11785, -0.1795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7985
SWEP.ADS.Speed = 5.25
SWEP.ADS.Cone = 0.0037965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(-5.96, -3.327, 3.88)
SWEP.ADS.Ang = Angle(0.414, -1.277, 1.404)
SWEP.ADS.Sound = nil

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(0, 0, 0)
SWEP.Movement.Ang = Angle(-5.623, 7.218, -2.52)

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
SWEP.Rload.Sound = Sound("Weapon_Pistol.Reload")
