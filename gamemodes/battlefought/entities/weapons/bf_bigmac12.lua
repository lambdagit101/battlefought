AddCSLuaFile()

SWEP.PrintName = "BM-12"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "American Burger, it can quickly disperse the entire mag where you are aiming."

SWEP.Weight = 15
SWEP.Slot = 2

SWEP.KillIcon = "l"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "l"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.BlurSelectIcon = "l"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"

SWEP.ViewModel = "models/weapons/cstrike/c_smg_mac10.mdl"
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.AimHoldType = "rpg"

SWEP.Primary.Ammo = "9mmRound"
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
SWEP.Bullet.RPM = 857
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 28
SWEP.Bullet.Force = 14
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.031
SWEP.Bullet.Sound = Sound("Weapon_Mac10.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 1.25
SWEP.Recoil.SidewaysRecoil = {0.71785, -0.98795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6685
SWEP.ADS.Speed = 17.9875
SWEP.ADS.Cone = 0.0067965
SWEP.ADS.RecoilMP = 0.5984357895
SWEP.ADS.Pos = Vector(-5.332, -1.806, 1.652)
SWEP.ADS.Ang = Angle(1.633, 0, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(2.523, 1.057, -3.757)
SWEP.Movement.Ang = Angle(-3.116, 29.691, -17.487)
SWEP.Movement.Pos2 = Vector(1.74, -0.105, -5.007)
SWEP.Movement.Ang2 = Angle(-3.116, 32.015, -17.487)

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