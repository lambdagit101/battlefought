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

    if ply:Health() < ply:GetMaxHealth() then
        ply:Give("item_healthvial")
        ply:GiveAmmo(math.random(0, 1), "armor_charge", false)
    end

    local bueno, primary = GAMEMODE:HasPrimary(ply)
    local buenodos, secondary = GAMEMODE:HasSecondary(ply)

    if bueno then
        ply:GiveAmmo(ply:GetWeapon(primary):GetMaxClip1(), ply:GetWeapon(primary):GetPrimaryAmmoType(), false)
    end

    if buenodos then
        ply:GiveAmmo(ply:GetWeapon(secondary):GetMaxClip1(), ply:GetWeapon(secondary):GetPrimaryAmmoType(), false)
    end

    local weapon, rarity = GAMEMODE:ReturnRandomWeapon()
    self:EmitSound("items/ammo_pickup.wav")

    if rarity == 1 then
        self:EmitSound("items/ammocrate_close.wav")
    elseif rarity == 2 then
        self:EmitSound("buttons/blip1.wav")
    else
        self:EmitSound("common/bugreporter_failed.wav")
    end

    local droppedWeapon = ents.Create(weapon)
    droppedWeapon:SetPos(self:GetPos() + Vector(0, 0, 5))
    droppedWeapon:Spawn()
end