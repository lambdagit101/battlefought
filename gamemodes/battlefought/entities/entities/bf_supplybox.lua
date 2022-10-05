AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:Draw()
    self:DrawModel()
end

function ENT:Initialize()
    self:SetModel("models/Items/item_item_crate.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_CUSTOM)

    self:PhysWake()
end

function ENT:Use(ply)
    self:Remove()

    ply:Give("item_healthvial")
    ply:GiveAmmo(math.random(0, 1), "armor_charge", false)
    
    local weapon, rarity = GAMEMODE:ReturnRandomWeapon()

    self:EmitSound("items/ammo_pickup.wav")
    if rarity == 1 then
        self:EmitSound("items/ammocrate_close.wav")
    elseif rarity == 2 then
        self:EmitSound("buttons/blip1.wav")
    else
        self:EmitSound("common/bugreporter_failed.wav")
    end
    ply:Give(weapon)

    ply:GiveAmmo(ply:GetWeapon(weapon):Clip1() * 2, ply:GetWeapon(weapon):GetPrimaryAmmoType(), false)
end