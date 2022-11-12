AddCSLuaFile()

SWEP.PrintName = "Stoner DarkRP"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Austrian SMG, amazing for short ranges."

SWEP.Slot = 2

SWEP.KillIcon = "d"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "d"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "d"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "9mmRound"
SWEP.Primary.ClipSize = 25
SWEP.Primary.DefaultClip = 25
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 1.674525

SWEP.Bullet = {}
SWEP.Bullet.HiCal = false
SWEP.Bullet.RPM = 857
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 19
SWEP.Bullet.Force = 10
SWEP.Bullet.TracerFrequency = 0
SWEP.Bullet.Cone = 0.035
SWEP.Bullet.Sound = Sound("Weapon_TMP.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 0.848975
SWEP.Recoil.SidewaysRecoil = {0.30085, -0.30085}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7885
SWEP.ADS.Speed = 14.95
SWEP.ADS.Cone = 0.0307965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(-2, -2, 2)
SWEP.ADS.Ang = Angle(1, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.7856945
SWEP.Crouch.Cone = 0.03301357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.618575
SWEP.Movement.Cone = 0.038
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
SWEP.Crosshair.HideADS = false
SWEP.Crosshair.CenterDot = true