AddCSLuaFile()

SWEP.PrintName = "Knife"
SWEP.Purpose = "Bowie Knife, pulled straight out of the Amazon."
SWEP.Author = "lambups"
SWEP.Instructions = "Attack button to swing\nSecondary Attack for slash"

SWEP.Slot = 0

SWEP.ViewModel = "models/weapons/cstrike/c_knife_t.mdl"
SWEP.WorldModel = "models/weapons/w_knife_t.mdl"
SWEP.ViewModelFOV = 60
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Ammo = ""
SWEP.Primary.Automatic = true

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = ""
SWEP.Secondary.Automatic = true

SWEP.DeploySound = Sound("Weapon_Knife.Deploy")
SWEP.MissSound = Sound("Weapon_Knife.Slash")
SWEP.HitSound = Sound("Weapon_Knife.Hit")
SWEP.StabSound = Sound("Weapon_Knife.Stab")
SWEP.WorldSound = Sound("Weapon_Knife.HitWall")

function SWEP:Initialize()
    self:SetHoldType("knife")

    self:SetDeploySpeed(1)
end

function SWEP:Deploy()
    self:EmitSound(self.DeploySound)

    return true
end

function SWEP:PrimaryAttack(stab)
    self:GetOwner():LagCompensation(true)

    local tr = util.TraceHull({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 48,
        filter = self:GetOwner(),
        mask = MASK_SHOT_HULL,
        mins = Vector(1, 1, 1) * -10,
        maxs = Vector(1, 1, 1) * 10
    })

    if not IsValid(tr.Entity) then
        tr = util.TraceLine({
            start = self:GetOwner():GetShootPos(),
            endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 48,
            filter = self:GetOwner(),
            mask = MASK_SHOT_HULL,
        })
    end

    local ent = tr.Entity

    if stab then
        self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
    else
        self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    end
    self:GetOwner():SetAnimation(PLAYER_ATTACK1)

    if stab then
        self:SetNextPrimaryFire(CurTime() + 0.8)
        self:SetNextSecondaryFire(CurTime() + 1)
    else
        self:SetNextPrimaryFire(CurTime() + 0.4)
        self:SetNextSecondaryFire(CurTime() + 0.4)
    end

    if IsValid(ent) and (ent:IsPlayer() or ent:IsNPC()) then
        if stab then
            self:EmitSound(self.StabSound)
        else
            self:EmitSound(self.HitSound)
        end

        if IsValid(ent) and ent:IsPlayer() and ent:Alive() and SERVER then
            ent:TakeDamage(stab and 75 or 35, self:GetOwner(), self)
        end
    elseif tr.Hit and not IsValid(ent) or (IsValid(ent) and not (ent:IsPlayer() or ent:IsNPC())) then
        self:EmitSound(self.WorldSound)

        if IsValid(ent) and not ent:IsPlayer() and not ent:IsNPC() and SERVER then
            ent:TakeDamage(stab and 75 or 35, self:GetOwner(), self)
        end
    elseif not IsValid(ent) then
        self:EmitSound(self.MissSound)
    end

    self:GetOwner():LagCompensation(false)
end

function SWEP:SecondaryAttack()
    self:PrimaryAttack(true)
end

if CLIENT then
    killicon.AddFont("bf_knife", "bfthud-csskillicons", "j", Color(255, 80, 0, 200))
end

function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
	y = y + 10
	x = x + 10
	wide = wide - 20
	
    draw.SimpleText("j", "bfthud-cssicons-blur", x + wide * 0.5, y + tall * 0.5, Color(200, 200, 0, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	draw.SimpleText("j", "bfthud-cssicons", x + wide * 0.5, y + tall * 0.5, Color(200, 200, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

    self:PrintWeaponInfo( x + wide + 20, y + tall * 0.95, alpha )
end