local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudSquadStatus"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudSuitPower"] = true,
}

surface.CreateFont("bfthud_general", {
    font = "Roboto",
    size = ScrW() * (16/1920),
    weight = 750,
})
surface.CreateFont("bfthud_general_blur", {
    font = "Roboto",
    size = ScrW() * (16/1920),
    weight = 750,
    blursize = 2,
})

surface.CreateFont("bfthud_ammobig", {
    font = "Roboto",
    size = ScrW() * (50/1920),
    weight = 1000,
})
surface.CreateFont("bfthud_ammobig_blur", {
    font = "Roboto",
    size = ScrW() * (50/1920),
    weight = 1000,
    blursize = 2,
})

surface.CreateFont("bfthud_ammosmall", {
    font = "Roboto",
    size = ScrW() * (32/1920),
    weight = 500,
})
surface.CreateFont("bfthud_ammosmall_blur", {
    font = "Roboto",
    size = ScrW() * (32/1920),
    weight = 500,
    blursize = 2,
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
local hudhpredcolor = Color(255, 50, 50)
local hudarcolor = Color(115, 115, 255)
local hudtxcolor = Color(195, 195, 195)
local hudtxredcolor = Color(255, 50, 50)
local hudaxcolor = Color(255, 145, 0)

local function DrawTextWithShadow(text, font, x, y, color, alignone, aligntwo)
    draw.SimpleText(text, font .. "_blur", x + 2, y + 2, hudbgcolor, alignone, aligntwo)
    draw.SimpleText(text, font, x, y, color, alignone, aligntwo)
end

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
    
    draw.DrawText(LocalPlayer():GetAmmoCount("armor_charge") .. "\nArmor\n" .. (LocalPlayer():GetAmmoCount("armor_charge") == 1 and "Charge" or "Charges"), "bfthud_general_blur", (ScrW() * 130/1920) + GetConVar("bfthud_xoffset"):GetInt() + boxsizex * (0.735) + 2, ScrH() - boxsizey / 2 - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080) + 2, hudbgcolor, TEXT_ALIGN_CENTER)
    draw.DrawText(LocalPlayer():GetAmmoCount("armor_charge") .. "\nArmor\n" .. (LocalPlayer():GetAmmoCount("armor_charge") == 1 and "Charge" or "Charges"), "bfthud_general", (ScrW() * 130/1920) + GetConVar("bfthud_xoffset"):GetInt() + boxsizex * (0.735), ScrH() - boxsizey / 2 - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), hudtxcolor, TEXT_ALIGN_CENTER)

    draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 40/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), boxsizex * (0.735), ScreenScale(2), hudbgcolor)
    draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 40/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), boxsizex * (0.735) * (LocalPlayer():Armor() / LocalPlayer():GetMaxArmor()), ScreenScale(2), hudarcolor)

    if LocalPlayer():GetSuitPower() ~= 100 then
        draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 40/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 24/1080), boxsizex * (0.735), ScreenScale(2), hudbgcolor)
        draw.RoundedBox(0, (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 40/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 24/1080), boxsizex * (0.735) * (LocalPlayer():GetSuitPower() / 100), ScreenScale(2), hudaxcolor)
    end

    DrawTextWithShadow(LocalPlayer():Nick(), "bfthud_general", (ScrW() * 65/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey / 2 - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt() + (ScrH() * 4/1080), hudtxcolor)
end

local hudamtxcolor = Color(195, 195, 195)
local hudamrdcolor = Color(255, 50, 50)

function DrawAmmo()
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    local ammo1 = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
    local maxclip1 = LocalPlayer():GetActiveWeapon():GetMaxClip1()
    local clip1 = LocalPlayer():GetActiveWeapon():Clip1()

    if clip1 == -1 and ammo1 == 0 then return end

    if clip1 == -1 then
        clip1 = ammo1
    end

    DrawTextWithShadow(clip1, "bfthud_ammobig", ScrW() - (ScrW() * 65/1920) - GetConVar("bfthud_xoffset"):GetInt(), ScrH() - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt(), (clip1 < maxclip1 / 3 and hudamrdcolor or hudamtxcolor), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
    if LocalPlayer():GetActiveWeapon():Clip1() ~= -1 then
        DrawTextWithShadow(ammo1, "bfthud_ammosmall", ScrW() - (ScrW() * 65/1920) - GetConVar("bfthud_xoffset"):GetInt(), ScrH() - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt(), (ammo1 == 0 and hudamrdcolor or hudamtxcolor), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end
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