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

local rgbcolor = Color(0, 0, 0)
local devcolor = Color(0, 255, 0)
function SWEP:DrawHUD()
    local rainbow = RGBRainbow(1)
    rgbcolor = Color(rainbow.r, rainbow.g, rainbow.b)
    for _, pos in ipairs(self.BoxTable) do
        local coords = pos[1]:ToScreen()
        local enddir = (pos[1] + pos[2]:Forward() * 32):ToScreen()

        draw.NoTexture()
        surface.SetDrawColor(devcolor)
        surface.DrawLine(coords.x, coords.y, enddir.x, enddir.y)
        draw.RoundedBox(8, coords.x - 9, coords.y - 9, 18, 18, devcolor)
        draw.RoundedBox(8, coords.x - 8, coords.y - 8, 16, 16, rgbcolor)
        draw.SimpleText("[" .. pos[1].x .. " " .. pos[1].y .. " " .. pos[1].z .. "]", "HudHintTextLarge", coords.x, coords.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

function SWEP:PrimaryAttack()
    if game.SinglePlayer() then self:CallOnClient("PrimaryAttack") end

    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
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