AddCSLuaFile()

SWEP.PrintName = "Bullpup"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Moldavian Assault Rifle, blatant copy of the Blitzer-772."

SWEP.Slot = 2

SWEP.KillIcon = "e"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "e"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "e"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel = "models/weapons/w_rif_aug.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "smg"
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
SWEP.Bullet.RPM = 666
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 28
SWEP.Bullet.Force = 16
SWEP.Bullet.TracerFrequency = 0
SWEP.Bullet.Cone = 0.023875
SWEP.Bullet.Sound = Sound("Weapon_AUG.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.775
SWEP.Recoil.SidewaysRecoil = {0.38923, -0.38923}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.3585
SWEP.ADS.Speed = 9.25
SWEP.ADS.Cone = 0.0077965
SWEP.ADS.RecoilMP = 0.9084357895
SWEP.ADS.Pos = Vector(-4.921, 0, 0.238)
SWEP.ADS.Ang = Angle(2.634, -1.385, -4)
SWEP.ADS.Scope = true

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8156945
SWEP.Crouch.Cone = 0.01841357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.528575
SWEP.Movement.Cone = 0.05
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

SWEP.Crosshair = {}
SWEP.Crosshair.Enabled = true
SWEP.Crosshair.TShape = true
SWEP.Crosshair.HideADS = false
SWEP.Crosshair.CenterDot = true