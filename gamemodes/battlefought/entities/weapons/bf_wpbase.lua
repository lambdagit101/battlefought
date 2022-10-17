AddCSLuaFile()

SWEP.PrintName = "Maschinenpistole-7"
SWEP.Purpose = "German SMG, decent damage, great for short to medium-range combat."
SWEP.Author = "lambups"
SWEP.Instructions = "Attack button to shoot\nHold secondary Attack button to ADS"

SWEP.ViewModel = "models/weapons/v_smg1.mdl"
SWEP.WorldModel = "models/weapons/w_smg1.mdl"
SWEP.ViewModelFOV = 60

SWEP.AccurateCrosshair = true

SWEP.BobScale = 0.1
SWEP.SwayScale = 0.1

SWEP.KillIcon = "x"
SWEP.KillIconFont = "bfthud-csskillicons"
SWEP.KillIconColor = Color(255, 80, 0, 200)
SWEP.SelectIcon = "x"
SWEP.SelectIconFont = "bfthud-cssicons"
SWEP.SelectIconColor = Color(200, 200, 0)
SWEP.SelectIconBlur = true 
SWEP.BlurSelectIcon = "x"
SWEP.SelectIconBlurFont = "bfthud-cssicons-blur"
SWEP.SelectIconBlurColor = Color(200, 200, 0, 150)

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

SWEP.LeEquip = {}
SWEP.LeEquip.SpeedMP = 0.7985

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
SWEP.Bullet.Pump = false

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
SWEP.ADS.Scope = false
SWEP.ADS.VectorBoost = Vector(0, -3, 0)
SWEP.ADS.AngleBoost = Angle(0, 0, 0)
SWEP.ADS.Anim = false

SWEP.Crouch = {}
SWEP.Crouch.RecoilMP = 0.8756945
SWEP.Crouch.Cone = 0.00901357835

SWEP.Movement = {}
SWEP.Movement.RecoilMP = 1.498575
SWEP.Movement.Cone = 0.05
SWEP.Movement.Pos = Vector(0, -3.967, -0.831)
SWEP.Movement.Ang = Angle(-3.945, 20.867, -5.367)

SWEP.Anim = {}
SWEP.Anim.EquipEmpty = ACT_VM_DRAW_EMPTY
SWEP.Anim.Equip = ACT_VM_DRAW
SWEP.Anim.ShootEmpty = ACT_VM_PRIMARYATTACK_EMPTY
SWEP.Anim.Shoot = ACT_VM_PRIMARYATTACK
SWEP.Anim.ReloadEmpty = ACT_VM_RELOAD_EMPTY
SWEP.Anim.Reload = ACT_VM_RELOAD
SWEP.Anim.IdleEmpty = ACT_VM_IDLE_EMPTY
SWEP.Anim.Idle = ACT_VM_IDLE
SWEP.Anim.Pump = ACT_SHOTGUN_PUMP

SWEP.Pump = {}
SWEP.Pump.Sound = Sound("Weapon_Shotgun.Special1")

SWEP.Anim.ShellReloadStart = ACT_SHOTGUN_RELOAD_START
SWEP.Anim.ShellReloadInsert = ACT_VM_RELOAD
SWEP.Anim.ShellReloadFinish = ACT_SHOTGUN_RELOAD_FINISH

SWEP.Crosshair = {}
SWEP.Crosshair.Enabled = true
SWEP.Crosshair.TShape = false
SWEP.Crosshair.HideADS = true
SWEP.Crosshair.CenterDot = true

SWEP.Rload = {}
SWEP.Rload.Shells = false
SWEP.Rload.ShellInserted = 1
SWEP.Rload.Garand = false

SWEP.ViewBob = {}
SWEP.ViewBob.Attachment = 1
SWEP.ViewBob.Intensity = -0.1

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	self:SendWeaponAnim(self.Anim.Equip)
	self:GetOwner():GetViewModel():SetPlaybackRate(self.LeEquip.SpeedMP)

	return true
end

function SWEP:IsMoving()
    return self:GetOwner():GetVelocity():LengthSqr() >= (self:GetOwner():GetSlowWalkSpeed() * 0.85) * (self:GetOwner():GetSlowWalkSpeed() * 0.85) and self:GetOwner():OnGround()
end

function SWEP:IsSprinting()
    return self:GetOwner():IsSprinting() and self:IsMoving()
end

function SWEP:SetupDataTables()
    self:NetworkVar("Bool", 0, "AimingDownSights")
    self:NetworkVar("Bool", 1, "Reloading")
    self:NetworkVar("Float", 0, "ReloadTime")
	self:NetworkVar("Float", 1, "NextIdle")
    self:NetworkVar("Float", 2, "LastPrimaryFire")
    self:NetworkVar("Float", 3, "NextPump")
end

function SWEP:Initialize()
    self:SetAimingDownSights(false)
    self:SetReloading(false)
    self:SetReloadTime(0)
	self:SetNextIdle(0)
    self:SetHoldType(self.HoldType)
    self:SetDeploySpeed(self.LeEquip.SpeedMP)
    self:SetLastPrimaryFire(0)

    if CLIENT then
        killicon.AddFont(self:GetClass(), self.KillIconFont, self.KillIcon, self.KillIconColor)
    end
end

if CLIENT then
    surface.CreateFont("bfthud-csskillicons", {
        font = "csd",
        size = ScreenScale(24),
        extended = true,
        weight = 500
    })

    surface.CreateFont("bfthud-cssicons", {
        font = "csd",
        size = ScreenScale(48),
        extended = true,
        weight = 500
    })
    surface.CreateFont("bfthud-cssicons-blur", {
        font = "csd",
        size = ScreenScale(48),
        extended = true,
        weight = 500,
        blursize = 12,
        scanlines = 5
    })
    
    surface.CreateFont("bfthud-hl2killicons", {
        font = "HL2MP",
        size = ScreenScale(24),
        extended = true,
        weight = 500
    })

    surface.CreateFont("bfthud-hl2icons", {
        font = "HL2MP",
        size = ScreenScale(48),
        extended = true,
        weight = 500
    })
    surface.CreateFont("bfthud-hl2icons-blur", {
        font = "HL2MP",
        size = ScreenScale(48),
        extended = true,
        weight = 500,
        blursize = 12,
        additive = true,
        scanlines = 5
    })
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	y = y + 10
	x = x + 10
	wide = wide - 20
	
    if self.SelectIconBlur then
        draw.SimpleText(self.BlurSelectIcon, self.SelectIconBlurFont, x + wide * 0.5, y + tall * 0.5, self.SelectIconBlurColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
	draw.SimpleText(self.SelectIcon, self.SelectIconFont, x + wide * 0.5, y + tall * 0.5, self.SelectIconColor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end
  
function SWEP:Reload()
    if self:Ammo1() == 0 or (self.Rload.Garand and self:Clip1() ~= 0) then return end
    if self.Rload.Shells then
        if not self:GetReloading() and self:Clip1() ~= self:GetMaxClip1() then
            self:GetOwner():DoReloadEvent()
            self:SendWeaponAnim(self.Anim.ShellReloadStart)
            self:QueueIdle()
        
            self:SetReloading(true)
            self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
        end
    else
        if self:Clip1() ~= self:GetMaxClip1() and self:Ammo1() ~= 0 and not self:GetReloading() then
            self:GetOwner():DoReloadEvent()
            self:SendWeaponAnim(self:Clip1() == 0 and self.Anim.ReloadEmpty or self.Anim.Reload)
            self:QueueIdle()
            self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
            self:SetReloading(true)
            if self.Rload.Sound then
                self:EmitSound(self.Rload.Sound)
            end
        end
    end
end

function SWEP:ReloadThink()
    if self.Rload.Shells then
        if self:GetReloading() and self:GetReloadTime() <= CurTime() then
            if self:Clip1() < self:GetMaxClip1() and self:GetOwner():GetAmmoCount(self:GetPrimaryAmmoType()) > 0 and not self:GetOwner():KeyDown(IN_ATTACK) then
                self:SetClip1(self:Clip1() + self.Rload.ShellInserted)
                self:GetOwner():RemoveAmmo(self.Rload.ShellInserted, self:GetPrimaryAmmoType())
                self:SendWeaponAnim(self.Anim.ShellReloadInsert)
                self:QueueIdle()
                self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
                if self.Rload.Sound then
                    self:EmitSound(self.Rload.Sound)
                end
            else
                self:SetReloading(false)
        
                self:SendWeaponAnim(self.Anim.ShellReloadFinish)
                self:SetReloadTime(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
                if self.Bullet.Pump then
                    self:SetNextPump(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
                else
                    self:QueueIdle()
                end
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
    if self:GetOwner():KeyPressed(IN_ATTACK2) and not self:GetReloading() and not self:IsSprinting() and self.ADS.Sound then
        self:EmitSound(self.ADS.Sound)
    end
end

function SWEP:QueueIdle()
	self:SetNextIdle(CurTime() + self:GetOwner():GetViewModel():SequenceDuration() + 0.1)
end

function SWEP:IdleThink()
	if self:GetNextIdle() == 0 then return end

	if CurTime() > self:GetNextIdle() then
		self:SetNextIdle(0)
		self:SendWeaponAnim(self:Clip1() > 0 and self.Anim.Idle or self.Anim.IdleEmpty)
	end
end

function SWEP:PumpThink()
    if self:GetNextPump() ~= 0 and self:GetNextPump() < CurTime() then
        self:SetNextPump(0)
        self:SendWeaponAnim(self.Anim.Pump)
        if self.Pump.Sound then
            self:EmitSound(self.Pump.Sound)
        end
        self:QueueIdle()
    end
end
  
function SWEP:Think()
    self:ReloadThink()
    self:IronsightsThink()
    self:IdleThink()
    self:PumpThink()
end

function SWEP:Holster()
    self:SetAimingDownSights(false)
    self:SetReloading(false)
    self:SetNextIdle(0)
    self:SetReloadTime(0)
    self:SetReloading(false)

    return true
end

function SWEP:CalculateCone()
    local cone = self.Bullet.Cone

    if self:GetOwner():Crouching() then
        cone = self.Crouch.Cone
    end

    if self:GetAimingDownSights() then
        cone = self.ADS.Cone
    end

    if self:IsMoving() or not self:GetOwner():OnGround() then
        cone = self.Movement.Cone
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
    
    if not self:GetOwner():OnGround() or self:IsMoving() then
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
    if self:GetOwner():WaterLevel() == 3 or self:IsSprinting() or self:GetReloading() or not self:CanPrimaryAttack() then return end
    self:SetNextPrimaryFire(CurTime() + (60 / self.Bullet.RPM))
    if IsFirstTimePredicted() then
        self:SetLastPrimaryFire(CurTime())
    end

    if (not self:GetAimingDownSights() or not self.Crosshair.HideADS) or self.ADS.Scope or self.ADS.Anim then
        self:SendWeaponAnim(self:Clip1() - self.Bullet.Amount <= 0 and self.Anim.ShootEmpty or self.Anim.Shoot)
        self:QueueIdle()
    end
	self:GetOwner():MuzzleFlash()
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
    if self.Bullet.Pump then
        self:SetNextPump(CurTime() + self:GetOwner():GetViewModel():SequenceDuration())
    end
    self:EmitSound(self.Bullet.Sound)
    self:TakePrimaryAmmo(self.Bullet.Amount)
    self:FireCoolBullet()

    self:ViewPunch()
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
SWEP.LastFOVUpdate = 0
function SWEP:TranslateFOV(fov)
    if self.LastFOVUpdate < CurTime() then
        self.FOVMP = Lerp(FrameTime() * self.ADS.Speed, self.FOVMP, self:GetAimingDownSights() and self.ADS.FOVMP or 1)
        self.LastFOVUpdate = CurTime()
    end

	return fov * self.FOVMP
end

function SWEP:AdjustMouseSensitivity()
	return self.FOVMP
end

function SWEP:SetDeploySpeed(speed)
	self.m_WeaponDeploySpeed = tonumber(speed)
end

function SWEP:GetOffset()
	local velocity = self:GetOwner():GetVelocity():Length()
    local baseVector = Vector(0 + (velocity / 1000), 0 - (6 * (velocity / 1000)), 0 - (velocity / 1000))
    local baseAngle = Angle(0, 0, 0)
    local airSpread = 0.1675 * (velocity / 500)

    baseAngle = (baseAngle:Forward() + LocalPlayer():EyeAngles():Right() * LocalPlayer():GetViewPunchAngles().y * -0.015 + LocalPlayer():EyeAngles():Up() * LocalPlayer():GetViewPunchAngles().x * 0.015):Angle()

    if not self:GetOwner():OnGround() and self:GetOwner():WaterLevel() ~= 3 then
        baseVector:Add(Vector(math.Rand(-airSpread, airSpread), math.Rand(-airSpread, airSpread) / 1.15, math.Rand(-airSpread, airSpread)))
        baseAngle:Add(Angle(math.Rand(-airSpread, airSpread), math.Rand(-airSpread, airSpread), math.Rand(-airSpread, airSpread)))
    end

    local tr = util.QuickTrace(self:GetOwner():EyePos(), self:GetOwner():EyeAngles():Forward() * 32, self:GetOwner())

    if tr.Hit and not tr.HitNonWorld and not tr.HitSky and not tr.AllSolid then
        baseVector:Add(Vector(0, -15.725 * (1 - tr.Fraction), 0))
    end

	if self:IsSprinting() then
        if self.Movement.Pos2 and self.Movement.Ang2 then
            local sine = 0.5 * (1 + math.sin(2 * math.pi * (self:GetOwner():GetRunSpeed() / 200) * CurTime()))
            return LerpVector(sine, self.Movement.Pos, self.Movement.Pos2), LerpAngle(sine, self.Movement.Ang, self.Movement.Ang2)
        else
            return self.Movement.Pos, self.Movement.Ang
        end
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

SWEP.LastPrimaryFire = 0
function SWEP:AddOffset()
    local basevector = Vector(0, 0, 0)
    local baseangle = Angle(0, 0, 0)

    if self:GetLastPrimaryFire() ~= self.LastPrimaryFire and self.Crosshair.HideADS and self:GetAimingDownSights() and not self.ADS.Scope then
        basevector = basevector + self.ADS.VectorBoost
        baseangle = baseangle + self.ADS.AngleBoost
    end
    self.LastPrimaryFire = self:GetLastPrimaryFire()

    return basevector, baseangle
end

SWEP.ViewModelPos = Vector( 0, 0, 0 )
SWEP.ViewModelAngle = Angle( 0, 0, 0 )

function SWEP:OffsetThink()
	local offset_pos, offset_ang = self:GetOffset()
    local add_pos, add_ang = self:AddOffset()

	if not offset_pos then offset_pos = vector_origin end
	if not offset_ang then offset_ang = angle_zero end
	if not add_pos then add_pos = vector_origin end
	if not add_ang then add_ang = angle_zero end

	self.ViewModelPos = LerpVector(FrameTime() * 10, self.ViewModelPos, offset_pos) + add_pos
	self.ViewModelAngle = LerpAngle(FrameTime() * 10, self.ViewModelAngle, offset_ang) + add_ang
end

SWEP.Scope = Material("gmod/scope")
SWEP.ScopeRefract = Material("gmod/scope-refract")

function SWEP:DrawScope()
    local h = ScrH()
    local w = h * 1.25
    local x, y = ScrW() / 2 - w / 2, ScrH() / 2 - h / 2
    render.UpdateRefractTexture()
    surface.SetDrawColor(color_black)
    surface.DrawRect(0, 0, x, ScrH())
    surface.DrawRect(x + w, 0, ScrW() - (x + w), ScrH())
    surface.SetMaterial(self.ScopeRefract)
    surface.DrawTexturedRect(x, y, w, h)
    surface.SetMaterial(self.Scope)
    surface.DrawTexturedRect(x, y, w, h)
    surface.DrawLine(0, ScrH() / 2, ScrW(), ScrH() / 2)
    surface.DrawLine(ScrW() / 2, 0, ScrW() / 2, ScrH())
end

function SWEP:DrawHUDBackground()
    if self:GetAimingDownSights() and self.ADS.Scope then
        self:DrawScope()
    end
end

SWEP.BlurAmount = 0
function SWEP:PreDrawViewModel(vm, weapon, ply)
    self.BlurAmount = Lerp(FrameTime() * 15, self.BlurAmount, self:GetReloading() and ScrH() or 0)
    if math.Round(self.BlurAmount) ~= 0 then
        DrawToyTown(2, self.BlurAmount)
    end
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

SWEP.CrosshairAlpha = 1
SWEP.CrosshairSpread = 0

function SWEP:ShouldDrawCrosshair()
    return not self:GetReloading() and not self:IsSprinting() and self:GetOwner():WaterLevel() ~= 3 and self:HasAmmo() and not self:GetAimingDownSights()
end

SWEP.FiredAShot = 0
function SWEP:AddCrosshairSpread()
    local bread = 0

    if self.FiredAShot ~= self:GetLastPrimaryFire() then
        bread = bread + 25
    end
    self.FiredAShot = self:GetLastPrimaryFire()

    return bread
end

function SWEP:DoDrawCrosshair(x, y)
    if not self.Crosshair.Enabled then return true end

    self.CrosshairAlpha = Lerp(FrameTime() * 10, self.CrosshairAlpha, self:ShouldDrawCrosshair() and 1 or 0)
    --self.CrosshairAlpha = 255
    self.CrosshairSpread = Lerp(FrameTime() * 10, self.CrosshairSpread, self:CalculateCone() * 500)

    self.CrosshairSpread = self.CrosshairSpread + self:AddCrosshairSpread()
    surface.SetDrawColor(0, 0, 0, self.CrosshairAlpha * 255)
    surface.DrawRect(x - 14 - self.CrosshairSpread - 1, y - 2, 12, 4)
    surface.SetDrawColor(255, 255, 255, self.CrosshairAlpha * 255)
    surface.DrawRect(x - 14 - self.CrosshairSpread, y - 1, 11, 2)
    surface.SetDrawColor(0, 0, 0, self.CrosshairAlpha * 255)
    surface.DrawRect(x + 4 + self.CrosshairSpread - 1, y - 2, 12, 4)
    surface.SetDrawColor(255, 255, 255, self.CrosshairAlpha * 255)
    surface.DrawRect(x + 3 + self.CrosshairSpread, y - 1, 11, 2)
    surface.SetDrawColor(0, 0, 0, self.CrosshairAlpha * 255)
    surface.DrawRect(x - 2, y + 4 + self.CrosshairSpread - 1, 4, 12)
    surface.SetDrawColor(255, 255, 255, self.CrosshairAlpha * 255)
    surface.DrawRect(x - 1, y + 3 + self.CrosshairSpread, 2, 11)

    --Top line
    if not self.Crosshair.TShape then
        surface.SetDrawColor(0, 0, 0, self.CrosshairAlpha * 255)
        surface.DrawRect(x - 2, y - 14 - self.CrosshairSpread - 1, 4, 12)
        surface.SetDrawColor(255, 255, 255, self.CrosshairAlpha * 255)
        surface.DrawRect(x - 1, y - 14 - self.CrosshairSpread, 2, 11)
    end

    --Center dot
    if self.Crosshair.CenterDot or (self:GetAimingDownSights() and not self.Crosshair.HideADS) then
        local alpha = 255 * self.CrosshairAlpha

        if self:GetAimingDownSights() and not self.Crosshair.HideADS then
            alpha = 255
        end

        if self.ADS.Scope and self:GetAimingDownSights() then
            alpha = 0
        end

        surface.SetDrawColor(0, 0, 0, alpha)
        surface.DrawRect(x - 2, y - 2, 4, 4)
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.DrawRect(x - 1, y - 1, 2, 2)
    end

    return true
end

--[[
local vmang = Angle(0, 0, 0)
function SWEP:CalcView(ply, pos, ang, fov)
	if LocalPlayer():ShouldDrawLocalPlayer() or not self.ViewBob.Attachment then return end

    local angle = ang
    local position = pos
    local fieldofview = fov

    if self:GetReloading() then
        local att = self:GetOwner():GetViewModel():GetAttachment(self.ViewBob.Attachment or 1)

        vmang = LerpAngle(FrameTime() * 12.5, vmang, (Angle(att.Ang.p, att.Ang.y, att.Ang.r * 0) * self.ViewBob.Intensity))
    else
        vmang = LerpAngle(FrameTime() * 12.5, vmang, Angle(0, 0, 0))
    end
    angle:RotateAroundAxis(angle:Right(), vmang.p)
    angle:RotateAroundAxis(angle:Up(), vmang.r)
    angle:RotateAroundAxis(angle:Forward(), vmang.p + vmang.r)

    return position, angle, fov
end
]]