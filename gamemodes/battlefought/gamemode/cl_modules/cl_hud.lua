local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudSquadStatus"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
}

surface.CreateFont("bfthud_general", {
    font = "Roboto",
    size = ScrW() * (16/1920),
    weight = 750,
})

surface.CreateFont("bfthud_ammobig", {
    font = "Roboto",
    size = ScrW() * (72/1920),
    weight = 1000,
})
surface.CreateFont("bfthud_ammosmall", {
    font = "Roboto",
    size = ScrW() * (37/1920),
    weight = 750,
})

CreateConVar("bfthud_xoffset", 0, FCVAR_ARCHIVE, "How far away from the vertical edges of the screen should the HUD be in pixels?", 0)
CreateConVar("bfthud_yoffset", 0, FCVAR_ARCHIVE, "How far away from the horizontal edges of the screen should the HUD be in pixels?", 0)
CreateConVar("bfthud_attention", 1, FCVAR_ARCHIVE, "Determines if special HUD effects are turned on.")

hook.Add("HUDShouldDraw", "battle_fought_hudshoulddraw", function(name)
    if hide[name] then
		return false
	end
end)

local hudbgcolor = Color(0, 0, 0, 200)
local hudhpcolor = Color(185, 185, 185)
local hudhpredcolor = Color(205, 45, 45)
local hudarcolor = Color(115, 115, 255)
local hudtxcolor = Color(195, 195, 195)
local hudtxredcolor = Color(255, 45, 45)

local lowhpsine = math.sin(2 * math.pi * 1 * CurTime())

local displaygradient = Material("vgui/gradient-l.vtf", "noclamp smooth")
function DrawHealthDisplay()
    local boxsizex = (ScrW() * 270/1920)
    local boxsizey = (ScrW() * 75/1920)

    surface.SetDrawColor(hudbgcolor)
	surface.SetMaterial(displaygradient)
	surface.DrawTexturedRect((ScrW() * 35/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey - (ScrH() * 30/1080) - GetConVar("bfthud_yoffset"):GetInt(), boxsizex * 1.45, boxsizey)
    draw.NoTexture()

    lowhpsine = math.sin(2 * math.pi * 1 * CurTime())
    draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 30/1080) - GetConVar("bfthud_yoffset"):GetInt() + 4, boxsizex * (0.735), ScreenScale(2), hudbgcolor)
    draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 30/1080) - GetConVar("bfthud_yoffset"):GetInt() + 4, boxsizex * (0.735) * (LocalPlayer():Health() / LocalPlayer():GetMaxHealth()), ScreenScale(2), (LocalPlayer():Health() < LocalPlayer():GetMaxHealth() / 3 and ColorAlpha(hudhpredcolor, 255 * math.abs(lowhpsine)) or hudhpcolor))

    draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 40/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), boxsizex * (0.735), ScreenScale(2), hudbgcolor)
    draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 40/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), boxsizex * (0.735) * (LocalPlayer():Armor() / LocalPlayer():GetMaxArmor()), ScreenScale(2), hudarcolor)

    draw.SimpleText(LocalPlayer():Nick(), "bfthud_general", (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), hudtxcolor)
end

function DrawAmmo()
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    draw.DrawText(LocalPlayer():GetActiveWeapon():Clip1(), "bfthud_ammobig", ScrW() - (ScrW() * 65/1920) - GetConVar("bfthud_xoffset"):GetInt(), ScrH() - (ScrH() * 60/1080), hudtxcolor)
end

local vignettegradient = Material("battlefought/vignette_white.png", "noclamp smooth")
function DrawEffects()
    if LocalPlayer():Health() < LocalPlayer():GetMaxHealth() / 3 then
        DrawMotionBlur(0.4, 0.8, 0.01)
        surface.SetDrawColor(hudbgcolor)
        surface.SetMaterial(vignettegradient)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        draw.NoTexture()
    end
end

hook.Add("HUDPaint", "battle_fought_hudpaint", function()
    local shouldHaltHud = hook.Run("HUDShouldDraw", "battle_fought_hud")
    if shouldHaltHud ~= nil and shouldHaltHud == false then return end

    if not LocalPlayer():Alive() then return end
    DrawEffects()
    DrawHealthDisplay()
    DrawAmmo()
end)