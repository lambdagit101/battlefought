AddCSLuaFile()

SWEP.PrintName = "IDDQD Gold Beagle"
SWEP.Base = "bf_wpbase"
SWEP.Purpose = "Palestinian hand cannon, can quickly destroy one's armor."

SWEP.Weight = 7
SWEP.Slot = 1

SWEP.KillIcon = "f"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.SelectIcon = "f"
SWEP.SelectIconFont = "bfthud-cssicons"

SWEP.ViewModel = "models/weapons/cstrike/c_pist_deagle.mdl"
SWEP.WorldModel = "models/weapons/w_pist_deagle.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true
SWEP.HoldType = "pistol"
SWEP.AimHoldType = "revolver"

SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 6
SWEP.Primary.DefaultClip = 6
SWEP.Primary.Automatic = false

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 0.69875

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 167
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 53
SWEP.Bullet.Force = 19
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.02
SWEP.Bullet.Sound = Sound("Weapon_DEagle.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 2.878975
SWEP.Recoil.SidewaysRecoil = {0.11785, -0.1795}

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.7985
SWEP.ADS.Speed = 15.9875
SWEP.ADS.Cone = 0.0167965
SWEP.ADS.RecoilMP = 0.8984357895
SWEP.ADS.Pos = Vector(-6.43, -3.327, 1.71)
SWEP.ADS.Ang = Angle(0.825, -0.125, 0)

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.01801357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.998575
SWEP.Movement.Cone = 0.06
SWEP.Movement.Pos = Vector(0, 0, 0)
SWEP.Movement.Ang = Angle(-5.623, 7.218, -2.52)

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