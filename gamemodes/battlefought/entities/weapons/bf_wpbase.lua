SWEP.PrintName = "Maschinenpistole-7"
SWEP.Purpose = "German SMG, decent damage, great for short to medium-range combat."

SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_rif_m4a1.mdl"
SWEP.ViewModelFOV = 60

SWEP.CSMuzzleFlashes = true

SWEP.UseHands = false
SWEP.HoldType = "smg"

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 30
SWEP.Primary.DefaultClip = 30
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false

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
SWEP.Recoil.SidewaysRecoil = 1

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
SWEP.Movement.Pos = Vector(1.95, -2.049, -1.153)
SWEP.Movement.Ang = Angle(-7.336, 32.63, -8.372)

SWEP.Anim = {}
SWEP.Anim.Equip = ACT_VM_DEPLOY
SWEP.Anim.Shoot = ACT_VM_PRIMARYATTACK
SWEP.Anim.Reload = ACT_VM_RELOAD

SWEP.Rload = {}
SWEP.Rload.Sound = Sound("Weapon_SMG1.Reload")

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
        if self.Rload.Sound then
            self:EmitSound(self.Rload.Sound)
        end
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

function SWEP:CalculateCone()
    local cone = self.Bullet.Cone

    if self:GetOwner():Crouching() then
        cone = cone * self.Crouch.Cone
    end

    if self:GetAimingDownSights() then
        cone = cone * self.ADS.Cone
    end

    if not self:GetOwner():OnGround() or self:GetOwner():GetVelocity():LengthSqr() > 22500 then
        cone = cone * self.ADS.Cone
    end

    return cone
end

function SWEP:FireCoolBullet()
    local ply = self:GetOwner()

    local bullet = {}
    bullet.Num = 1
    bullet.Src = ply:GetShootPos()
    bullet.Dir = ply:GetAimVector() - ply:EyeAngles():Right() * ply:GetViewPunchAngles().y * 0.05 - ply:EyeAngles():Up() * ply:GetViewPunchAngles().x * 0.05
    local bulletCone = self:CalculateCone()
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

function SWEP:CalculateRecoilMP()
    local recoilmp = 1

    if self:GetOwner():Crouching() then
        recoilmp = recoilmp * self.Crouch.RecoilMP
    end
    
    if not self:GetOwner():OnGround() or self:GetOwner():GetVelocity():LengthSqr() > 22500 then
        recoilmp = recoilmp * self.Movement.RecoilMP
    end
    
    if self:GetAimingDownSights() then
        recoilmp = recoilmp * self.ADS.RecoilMP
    end

    return recoilmp
end

function SWEP:ViewPunch()
    local recoilmp = self:CalculateRecoilMP()
    local sidewaysRecoil = util.SharedRandom("sidewaysRecoil", 0 - self.Recoil.SidewaysRecoil, self.Recoil.SidewaysRecoil)
    self:GetOwner():SetViewPunchAngles(Angle(0 - (self.Recoil.UpwardsRecoil * recoilmp), sidewaysRecoil * recoilmp))
end

function SWEP:PrimaryAttack()
    if self:GetOwner():IsSprinting() or self:GetReloading() or not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire(CurTime() + (60 / self.Bullet.RPM))

    self:SendWeaponAnim(self.Anim.Shoot)
    self:EmitSound(self.Bullet.Sound)
    self:TakePrimaryAmmo(self.Bullet.Amount)
    self:FireCoolBullet()

    self:ViewPunch()
end

SWEP.BlurAmount = 0
function SWEP:PreDrawViewModel(vm, weapon, ply)
    self.BlurAmount = Lerp(FrameTime() * 15, self.BlurAmount, self:GetReloading() and ScrH() or 0)
    if math.Round(self.BlurAmount) ~= 0 then
        DrawToyTown(2, self.BlurAmount)
    end
end

function SWEP:DoImpactEffect(tr, nDamageType)
	if tr.HitSky then return end
    if not self.Bullet.HiCal then return end
	
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

local sprintsine = math.sin(2 * math.pi * 2 * CurTime() / 2)
function SWEP:GetOffset()
	if self:GetReloading() then return end

	if self:GetOwner():IsSprinting() then
        sprintsine = math.sin(2 * math.pi * 2 * CurTime())
		return self.Movement.Pos * (sprintsine * 0.25), self.Movement.Ang * (sprintsine * 0.25)
	end

	if self:GetAimingDownSights() then
		return self.ADS.Pos, self.ADS.Ang
    end
end

SWEP.ViewModelPos = Vector( 0, 0, 0 )
SWEP.ViewModelAngle = Angle( 0, 0, 0 )

function SWEP:OffsetThink()
	local offset_pos, offset_ang = self:GetOffset()

	if not offset_pos then offset_pos = vector_origin end
	if not offset_ang then offset_ang = angle_zero end

	self.ViewModelPos = LerpVector(FrameTime() * 10, self.ViewModelPos, offset_pos)
	self.ViewModelAngle = LerpAngle(FrameTime() * 10, self.ViewModelAngle, offset_ang)
end

function SWEP:PreDrawViewModel()
	self:OffsetThink()
end

function SWEP:GetViewModelPosition( pos, ang )
	ang:RotateAroundAxis( ang:Right(), self.ViewModelAngle.p )
	ang:RotateAroundAxis( ang:Up(), self.ViewModelAngle.y )
	ang:RotateAroundAxis( ang:Forward(), self.ViewModelAngle.r )

	pos = pos + self.ViewModelPos.x * ang:Right()
	pos = pos + self.ViewModelPos.y * ang:Forward()
	pos = pos + self.ViewModelPos.z * ang:Up()

	return pos, ang
end