AddCSLuaFile()

SWEP.PrintName = "Maschinenpistole-5"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "German SMG, older variant of the Maschinenpistole-5, more accurate and rewarding but less damaging."

SWEP.Weight = 15
SWEP.Slot = 2

SWEP.KillIcon = "x"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "x"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mp5.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mp5.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "smg"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1.3185

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 777
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 25
SWEP.Bullet.Force = 14
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.011
SWEP.Bullet.Sound = Sound("Weapon_MP5Navy.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.875
SWEP.Recoil.SidewaysRecoil = {0.71785, -0.98795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6685
SWEP.ADS.Speed = 18.75
SWEP.ADS.Cone = 0.0067965
SWEP.ADS.RecoilMP = 0.5984357895
SWEP.ADS.Pos = Vector(-5.332, -1.806, 1.652)
SWEP.ADS.Ang = Angle(1.633, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.012
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
