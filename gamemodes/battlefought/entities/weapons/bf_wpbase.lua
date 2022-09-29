SWEP.PrintName = "Maschinenpistole-7"
SWEP.Purpose = "German SMG, decent damage, great for short to medium-range combat."

SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 60

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
SWEP.Anim.EquipEmpty = ACT_VM_DEPLOY_EMPTY
SWEP.Anim.Equip = ACT_VM_DEPLOY
SWEP.Anim.ShootEmpty = ACT_VM_PRIMARYATTACK_EMPTY
SWEP.Anim.Shoot = ACT_VM_PRIMARYATTACK
SWEP.Anim.ReloadEmpty = ACT_VM_RELOAD_EMPTY
SWEP.Anim.Reload = ACT_VM_RELOAD
SWEP.Anim.IdleEmpty = ACT_VM_IDLE_EMPTY
SWEP.Anim.Idle = ACT_VM_IDLE

SWEP.Anim.Sprint = ACT_INVALID

SWEP.Anim.ShellReloadStart = ACT_SHOTGUN_RELOAD_START
SWEP.Anim.ShellReloadInsert = ACT_VM_RELOAD
SWEP.Anim.ShellReloadFinish = ACT_SHOTGUN_RELOAD_FINISH

SWEP.Rload = {}
SWEP.Rload.Shells = false
SWEP.Rload.ShellInserted = 1
SWEP.Rload.Sound = Sound("Weapon_SMG1.Reload")

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	self:SendWeaponAnim(self.Anim.Equip)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.Equip.SpeedMP)

	return true
end

function SWEP:IsSprinting()
    return self:GetOwner():IsSprinting() and self:GetOwner():GetVelocity():LengthSqr() >= self:GetOwner():GetSlowWalkSpeed() * self:GetOwner():GetSlowWalkSpeed() and self:GetOwner():OnGround()
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "AimingDownSights")
    self:NetworkVar("Bool", 1, "Reloading")
    self:NetworkVar("Float", 0, "ReloadTime")
	self:NetworkVar("Float", 1, "NextIdle")
end

function SWEP:Initialize()
    self:SetAimingDownSights(false)
    self:SetReloading(false)
    self:SetReloadTime(0)
	self:SetNextIdle(0)
    self:SetHoldType(self.HoldType)
    self:SetDeploySpeed(self.Equip.SpeedMP)
end
  
function SWEP:Reload()
    if self.Rload.Shells then
        if not self:GetReloading() and self:Clip1() ~= self:GetMaxClip1() then
            self:GetOwner():DoReloadEvent()
            self:SendWeaponAnim(self.Anim.ShellReloadStart)
        
            self:SetReloading(true)
            self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
        end
    else
        if self:Clip1() ~= self:GetMaxClip1() and self:Ammo1() ~= 0 and not self:GetReloading() then
            self:GetOwner():DoReloadEvent()
            self:SendWeaponAnim(self:Clip1() == 0 and self.Anim.ReloadEmpty or self.Anim.Reload)
            self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
            self:SetReloading(true)
            if self.Rload.Sound then
                self:EmitSound(self.Rload.Sound)
            end
            self:QueueIdle()
        end
    end
end

function SWEP:ReloadThink()
    if self.Rload.Shells then
        if self:GetReloadTime() <= CurTime() then
            if self:Clip1() < self:GetMaxClip1() and self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and not self:GetOwner():KeyDown(IN_ATTACK) then
                self:SetClip1(self:Clip1() + self.Rload.ShellInserted)
                self:GetOwner():RemoveAmmo(self.Rload.ShellInserted, self:GetPrimaryAmmoType())
                self:SendWeaponAnim(self.Anim.ShellReloadInsert)
                self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
            else
                self:SetReloading(false)
        
                self:SendWeaponAnim(self.Anim.ShellReloadFinish)
                self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
                self:QueueIdle()
            end
        end
    else
        if self:GetReloading() and self:GetReloadTime() <= CurTime() then
            self:SetReloading(false)
          
            local amount = math.min(self:GetMaxClip1() - self:Clip1(), self:Ammo1())
            self:SetClip1(self:Clip1() + amount)
            self:GetOwner():RemoveAmmo(amount, self:GetPrimaryAmmoType())
            self:QueueIdle()
        end
    end
end

function SWEP:IronsightsThink()
    self:SetAimingDownSights(self:GetOwner():KeyDown(IN_ATTACK2) and not self:GetReloading() and not self:IsSprinting())
    self:SetHoldType((self:GetAimingDownSights() and self.AimHoldType or self.HoldType))
    if self:GetOwner():KeyPressed(IN_ATTACK2) and not self:GetReloading() and not self:IsSprinting() and self.ADS.Sound ~= nil then
        self:EmitSound(self.ADS.Sound)
    end
end

function SWEP:QueueIdle()
	self:SetNextIdle(CurTime() + self.Owner:GetViewModel():SequenceDuration() + 0.1)
end

function SWEP:IdleThink()
	if self:GetNextIdle() == 0 then return end

	if CurTime() > self:GetNextIdle() then
		self:SetNextIdle(0)
		self:SendWeaponAnim(self:Clip1() > 0 and self.Anim.Idle or self.Anim.IdleEmpty)
	end
end
  
function SWEP:Think()
    self:ReloadThink()
    self:IronsightsThink()

    self.BobScale = (self:GetAimingDownSights() and 0.1 or 1)
    self.SwayScale = (self:GetAimingDownSights() and 0.1 or 1)
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

    if not self:GetOwner():OnGround() or self:GetOwner():IsSprinting() then
        cone = cone * self.ADS.Cone
    end

    return cone
end

function SWEP:FireCoolBullet()
    local ply = self:GetOwner()

    local bullet = {}
    bullet.Num = self.Bullet.Pellets
    bullet.Src = ply:GetShootPos()
    bullet.Dir = ply:GetAimVector() - ply:EyeAngles():Right() * ply:GetViewPunchAngles().y * 0.02 - ply:EyeAngles():Up() * ply:GetViewPunchAngles().x * 0.02
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
end

function SWEP:CalculateRecoilMP()
    local recoilmp = 1

    if self:GetOwner():Crouching() then
        recoilmp = recoilmp * self.Crouch.RecoilMP
    end
    
    if not self:GetOwner():OnGround() or self:GetOwner():IsSprinting() then
        recoilmp = recoilmp * self.Movement.RecoilMP
    end
    
    if self:GetAimingDownSights() then
        recoilmp = recoilmp * self.ADS.RecoilMP
    end

    return recoilmp
end

function SWEP:ViewPunch()
    local recoilmp = self:CalculateRecoilMP()
    local sidewaysRecoil = util.SharedRandom("sidewaysRecoil", self.Recoil.SidewaysRecoil[1], self.Recoil.SidewaysRecoil[2])
    self:GetOwner():ViewPunch(Angle(0 - (self.Recoil.UpwardsRecoil * recoilmp), sidewaysRecoil * recoilmp, sidewaysRecoil * recoilmp * -1))
end

function SWEP:PrimaryAttack()
    if self:IsSprinting() or self:GetReloading() or not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire(CurTime() + (60 / self.Bullet.RPM))

    self:SendWeaponAnim(self:Clip1() - self.Bullet.Amount <= 0 and self.Anim.ShootEmpty or self.Anim.Shoot)
    self:QueueIdle()
	self:GetOwner():MuzzleFlash()
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
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

function SWEP:AdjustMouseSensitivity()
	return self.FOVMP
end

function SWEP:SetDeploySpeed(speed)
	self.m_WeaponDeploySpeed = tonumber(speed)
end

function SWEP:DoDrawCrosshair(x, y)
    local offsetFromTsentr = 0

    return false
end

local sprintsine
function SWEP:GetOffset()
	if self:GetReloading() then return end

    local velocity = self:GetOwner():GetVelocity():Length()
    local baseVector = Vector(0 + (velocity / 1000), 0 - (6 * (velocity / 1000)), 0 - (velocity / 1000))
    local baseAngle = Angle(0, 0, 0)
    local airSpread = 0.1675 * (velocity / 500)

    if not self:GetOwner():OnGround() and self:GetOwner():WaterLevel() ~= 3 then
        baseVector:Add(Vector(math.Rand(-airSpread, airSpread), math.Rand(-airSpread, airSpread) / 1.15, math.Rand(-airSpread, airSpread)))
        baseAngle:Add(Angle(math.Rand(-airSpread, airSpread), math.Rand(-airSpread, airSpread), math.Rand(-airSpread, airSpread)))
    end

    local tr = util.QuickTrace(self:GetOwner():EyePos(), self:GetOwner():EyeAngles():Forward() * 32, self:GetOwner())

    if tr.Hit and not tr.HitNonWorld and not tr.HitSky and not tr.AllSolid then
        baseVector:Add(Vector(0, -19.725 * (1 - tr.Fraction), 0))
    end

	if self:IsSprinting() then
        return self.Movement.Pos, self.Movement.Ang
	end

	if self:GetAimingDownSights() then
		return self.ADS.Pos, self.ADS.Ang
    end

    if self.ViewModelFlip then
        baseVector.x = baseVector.x - baseVector.x * 2
        baseAngle.y = baseAngle.y - baseAngle.y * 2
        baseAngle.r = baseAngle.r - baseAngle.r * 2
    end

    return baseVector, baseAngle
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