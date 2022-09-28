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
    if self:Ammo1() == 0 then return end
    self:SetNextPrimaryFire(CurTime() + 1)

    self:TakePrimaryAmmo(1)
    self:SendWeaponAnim(ACT_SLAM_DETONATOR_DETONATE)
    self:EmitSound("items/gift_drop.wav")
    self:GetOwner():SetArmor(math.Clamp(self:GetOwner():Armor() + 33, 0, self:GetOwner():GetMaxArmor()))
end