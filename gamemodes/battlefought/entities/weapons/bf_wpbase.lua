SWEP.ViewModel = "models/weapons/cstrike/c_rif_m4a1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.ViewModelFOV = 70

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = true

SWEP.HoldType = "ar2"

SWEP.Primary.Ammo = "AR2"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

SWEP.Bullet = {}
SWEP.Bullet.HiCal = true
SWEP.Bullet.RPM = 666
SWEP.Bullet.Amount = 1
SWEP.Bullet.Pellets = 1
SWEP.Bullet.Damage = 31
SWEP.Bullet.Force = 14
SWEP.Bullet.TracerFrequency = 1
SWEP.Bullet.Cone = 0.015
SWEP.Bullet.Sound = Sound("Weapon_M4A1.Single")

SWEP.Recoil = {}
SWEP.Recoil.UpwardsRecoil = 3
SWEP.Recoil.SidewaysRecoil = 1

SWEP.ADS = {}
SWEP.ADS.FOVMP = 0.6985
SWEP.ADS.Speed = 2.25
SWEP.ADS.Cone = 0.01
SWEP.ADS.RecoilMP = 0.5
SWEP.ADS.Sound = Sound("Default.Zoom")

SWEP.Anim = {}
SWEP.Anim.Equip = ACT_VM_DEPLOY
SWEP.Anim.Shoot = ACT_VM_PRIMARYATTACK
SWEP.Anim.Reload = ACT_VM_RELOAD

function SWEP:Deploy()
    self:SendWeaponAnim(self.Anim.Equip)
end

function SWEP:SecondaryAttack()
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "AimingDownSights")
    self:NetworkVar("Bool", 1, "Reloading")
    self:NetworkVar("Float", 0, "ReloadTime")
end

function SWEP:Initialize()
    self:SetAimingDownSights(false)
    self:SetReloading(false)
    self:SetReloadTime(0)
    self:SetHoldType(self.HoldType)
end
  
function SWEP:Reload()
    if self:Clip1() ~= self:GetMaxClip1() and self:Ammo1() ~= 0 and not self:GetReloading() then
        self:GetOwner():DoReloadEvent()
        self:SendWeaponAnim(self.Anim.Reload)
        self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
        self:SetReloading(true)
    end
end
  
function SWEP:Think()
    self:SetAimingDownSights(self:GetOwner():KeyDown(IN_ATTACK2) and not self:GetReloading())
    if self:GetOwner():KeyPressed(IN_ATTACK2) and not self:GetReloading() then
        self:EmitSound(self.ADS.Sound)
    end

    if self:GetReloading() and self:GetReloadTime() <= CurTime() then
        self:SetReloading(false)
      
        local amount = math.min(self:GetMaxClip1() - self:Clip1(), self:Ammo1())
        self:SetClip1(self:Clip1() + amount)
        self:GetOwner():RemoveAmmo(amount, self:GetPrimaryAmmoType())
    end
end

function SWEP:Holster()
    self:SetAimingDownSights(false)
    self:SetReloading(false)
    return true
end

function SWEP:FireCoolBullet()
    local ply = self:GetOwner()

    local bullet = {}
    bullet.Num = 1
    bullet.Src = ply:GetShootPos()
    bullet.Dir = ply:GetAimVector() - ply:EyeAngles():Right() * ply:GetViewPunchAngles().y * 0.05 - ply:EyeAngles():Up() * ply:GetViewPunchAngles().x * 0.05
    local bulletCone = (self:GetAimingDownSights() and self.ADS.Cone or self.Bullet.Cone)
    bullet.Spread = Vector(bulletCone, bulletCone, 0)
    bullet.Tracer = self.Bullet.TracerFrequency
    bullet.Force = self.Bullet.Force
    bullet.Damage = self.Bullet.Damage
    bullet.AmmoType = self.Primary.Ammo
    bullet.Callback = function(attacker, tr, dmginfo)
    -- A callback function that is ran before damage is applied
    end
    if self.Bullet.HiCal then
        bullet.TracerName = "AR2Tracer"
    end

    self:GetOwner():FireBullets(bullet)

    self:ShootEffects()
end

function SWEP:PrimaryAttack()
    if self:GetReloading() or not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire(CurTime() + (60 / self.Bullet.RPM))

    self:SendWeaponAnim(self.Anim.Shoot)
    self:EmitSound(self.Bullet.Sound)
    self:TakePrimaryAmmo(self.Bullet.Amount)
    self:FireCoolBullet()

    local sidewaysRecoil = util.SharedRandom("sidewaysRecoil", 0 - self.Recoil.SidewaysRecoil, self.Recoil.SidewaysRecoil)
    self:GetOwner():SetViewPunchAngles(Angle(0 - (self.Recoil.UpwardsRecoil * (self:GetAimingDownSights() and self.ADS.RecoilMP or 1)), sidewaysRecoil * (self:GetAimingDownSights() and self.ADS.RecoilMP or 1)))
end

SWEP.BlurAmount = 0
function SWEP:PreDrawViewModel(vm, weapon, ply)
    self.BlurAmount = Lerp(FrameTime() * 15, self.BlurAmount, self:GetReloading() and ScrH() or 0)
    if math.Round(self.BlurAmount) ~= 0 then
        DrawToyTown(2, self.BlurAmount)
    end
end

function SWEP:DoImpactEffect(tr, nDamageType)
	if tr.HitSky or not self.Bullet.HiCal then return end
	
	local effectdata = EffectData()
	effectdata:SetOrigin(tr.HitPos + tr.HitNormal)
	effectdata:SetNormal(tr.HitNormal)
    if IsFirstTimePredicted() then
	    util.Effect("AR2Impact", effectdata)
    end
end

SWEP.FOVMP = 1
function SWEP:TranslateFOV(fov)
    self.FOVMP = Lerp(FrameTime() * self.ADS.Speed, self.FOVMP, self:GetAimingDownSights() and self.ADS.FOVMP or 1)
	return fov * self.FOVMP
end