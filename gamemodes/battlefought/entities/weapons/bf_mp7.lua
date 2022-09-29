SWEP.PrintName = "Maschinenpistole-7"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "German SMG, decent damage, great for short to medium-range combat."

SWEP.Slot = 2

SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 70

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = false
SWEP.HoldType = "smg"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.Equip = {}
SWEP.Equip.SpeedMP = 0.7985

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 700
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 26
SWEP.Bullet.Force = 14
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.015
SWEP.Bullet.Sound = Sound("Weapon_SMG1.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 1.575
SWEP.Recoil.SidewaysRecoil = {0.91785, -1.0795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6985
SWEP.ADS.Speed = 2.25
SWEP.ADS.Cone = 0.0087965
SWEP.ADS.RecoilMP = 0.6984357895
SWEP.ADS.Pos = Vector(-6.433, -2.75, 2.542)
SWEP.ADS.Ang = Angle(0, 0, 0)
SWEP.ADS.Sound = Sound("Default.Zoom")

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(0, -3.967, -0.831)
SWEP.Movement.Ang = Angle(-3.945, 20.867, -5.367)

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
SWEP.Rload.Sound = Sound("Weapon_SMG1.Reload")
