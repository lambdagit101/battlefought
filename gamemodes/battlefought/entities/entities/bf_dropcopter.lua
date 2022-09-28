AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"

function ENT:Initialize()
    self:SetModel("models/Combine_Helicopter.mdl")
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_CUSTOM)
end

function ENT:Think()
    if not SERVER then return end
    self:SetPos(self:GetPos() + self:GetAngles():Forward() * 25)
end

