AddCSLuaFile()

SWEP.PrintName = "Uterusmaschinenpistole-45"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "German SMG, successor of the Maschinenpistole-7, slower, yet more damaging."

SWEP.Weight = 7
SWEP.Slot = 2

SWEP.KillIcon = "q"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "q"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "q"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_ump45.mdl"
SWEP.WorldModel = "models/weapons/w_smg_ump45.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "smg"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1.1185

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 571
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 29
SWEP.Bullet.Force = 14
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.011
SWEP.Bullet.Sound = Sound("Weapon_UMP45.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 1.575
SWEP.Recoil.SidewaysRecoil = {0.41785, -0.68795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6685
SWEP.ADS.Speed = 14.75
SWEP.ADS.Cone = 0.0067965
SWEP.ADS.RecoilMP = 0.5984357895
SWEP.ADS.Pos = Vector(-8.801, 0, 4.4)
SWEP.ADS.Ang = Angle(-1.489, -0.343, -2.054)
SWEP.ADS.VectorBoost = Vector(0, -3, -0.25)
SWEP.ADS.AngleBoost = Angle(0.25, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.014
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
SWEP.Rload.Shells = false
SWEP.Rload.ShellInserted = 1
