SWEP.PrintName = "Armor Charger"
SWEP.Spawnable = false

SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/weapons/w_slam.mdl"
SWEP.ViewModelFOV = 54
SWEP.UseHands = true

SWEP.Slot = 5

SWEP.Primary.Ammo = "armor_charge"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true

SWEP.Secondary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false 
function SWEP:SecondaryAttack()
end

function SWEP:Initialize()
    self:SetHoldType("slam")
end

function SWEP:Equip()
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DRAW)
end

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 1)
    if self:GetOwner():Armor() >= self:GetOwner():GetMaxArmor() then 
        self:GetOwner():PrintMessage(HUD_PRINTCENTER, "Armor is fully charged!")
        self:EmitSound("common/warning.wav")
        return 
    elseif self:Ammo1() == 0 then
        self:GetOwner():PrintMessage(HUD_PRINTCENTER, "No armor charges left!")
        self:EmitSound("common/warning.wav")
        return 
    end

    self:TakePrimaryAmmo(1)
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)
    self:EmitSound("items/gift_drop.wav")
    self:GetOwner():SetArmor(math.Clamp(self:GetOwner():Armor() + 33, 0, self:GetOwner():GetMaxArmor()))
end