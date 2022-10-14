SWEP.PrintName = "battle_fought_boxer_"
SWEP.AdminOnly = true
SWEP.Spawnable = true

function SWEP:Initialize()
    util.PrecacheModel("models/Items/item_item_crate.mdl")
end

SWEP.BoxTable = {}
function SWEP:SecondaryAttack()
    if SERVER then
        file.Write("bf_" .. game.GetMap() .. ".json", util.TableToJSON(self.BoxTable, true))
        self:GetOwner():ChatPrint("Saved the file as bf_" .. game.GetMap() .. ".json to the server's data folder!")
    end
end

function RGBRainbow(frequency)
    local result = {}

    result.r = math.floor(math.sin(CurTime() * frequency + 0) * 127 + 128)
    result.g = math.floor(math.sin(CurTime() * frequency + 2) * 127 + 128)
    result.b = math.floor(math.sin(CurTime() * frequency + 4) * 127 + 128)

    return result
end

function SWEP:DrawHUD()
    for _, pos in ipairs(self.BoxTable) do
        local coords = pos[1]:ToScreen()
        local rainbow = RGBRainbow(1)

        draw.RoundedBox(8, coords.x - 8, coords.y - 8, 16, 16, Color(rainbow.r, rainbow.g, rainbow.b))
    end
end

function SWEP:PrimaryAttack()
    if game.SinglePlayer() then self:CallOnClient("PrimaryAttack") end

    if (game.SinglePlayer() and CLIENT) or (CLIENT and IsFirstTimePredicted()) then
        self.BoxTable[#self.BoxTable + 1] = {
            self:GetOwner():GetEyeTrace().HitPos,
            Angle(0, self:GetOwner():EyeAngles().y, 0)
        }
    end
    if SERVER then
        self:GetOwner():ChatPrint("Saved a box at [" .. self:GetOwner():GetEyeTrace().HitPos.x .. " " .. self:GetOwner():GetEyeTrace().HitPos.y .. " " .. self:GetOwner():GetEyeTrace().HitPos.z .. "]")
    end
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