AddCSLuaFile()

SWEP.PrintName = "Blitzer-770"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Austrian Battle Rifle, deals high damage with high recoil."

SWEP.Slot = 2

SWEP.KillIcon = "o"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "o"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "o"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_snip_sg550.mdl"
SWEP.WorldModel = "models/weapons/w_snip_sg550.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "ar2"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "SniperRound"
SWEP.Primary.ClipSize = 20
SWEP.Primary.DefaultClip = 20
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 0.874525

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 240
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 59
SWEP.Bullet.Force = 18
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.012
SWEP.Bullet.Sound = Sound("Weapon_SG550.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 2.68975
SWEP.Recoil.SidewaysRecoil = {0.20085, -0.4195}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.1885
SWEP.ADS.Speed = 10.9875
SWEP.ADS.Cone = 0.00907965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(4, 0, 0)
SWEP.ADS.Ang = Angle(0, 0, 0)
SWEP.ADS.Scope = true
SWEP.ADS.Sound = Sound("Default.Zoom")

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.7856945
SWEP.Crouch.Cone = 0.01201357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.518575
SWEP.Movement.Cone = 0.015
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
SWEP.Crosshair.TShape = false
SWEP.Crosshair.HideADS = true
SWEP.Crosshair.CenterDot = false