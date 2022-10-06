SWEP.PrintName = "battle_fought_boxer_"
SWEP.AdminOnly = true
SWEP.Spawnable = true 

function SWEP:Initialize()
    util.PrecacheModel("models/Items/item_item_crate.mdl")
end

SWEP.BoxTable = {}
function SWEP:SecondaryAttack()
    if SERVER then
        file.Write("bf_" .. game.GetMap() .. ".json", util.TableToJSON(self.BoxTable))
        self:GetOwner():ChatPrint("Saved the file as bf_" .. game.GetMap() .. ".json to the server's data folder!")
    end
end

function SWEP:PrimaryAttack()
    self.BoxTable[#self.BoxTable + 1] = {
        self:GetOwner():GetEyeTrace().HitPos,
        Angle(0, self:GetOwner():EyeAngles().y, 0)
    }
end

function SWEP:Think()
    if not CLIENT then return end
    if self.BoxEnt == nil then
        self.BoxEnt = ClientsideModel("models/Items/item_item_crate.mdl")
        self.BoxEnt:Spawn()
    end

    self.BoxEnt:SetPos(self:GetOwner():GetEyeTrace().HitPos)
    self.BoxEnt:SetAngles(Angle(0, self:GetOwner():EyeAngles().y, 0))
end