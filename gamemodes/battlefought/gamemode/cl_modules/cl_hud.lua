-- Convars that determine how far away from the edges of the screen the HUD is
-- Also another one that allows you to disable the cool little effects
CreateConVar("bfthud_xoffset", 0, FCVAR_ARCHIVE, "How far away from the vertical edges of the screen should the HUD be in pixels?", 0)
CreateConVar("bfthud_yoffset", 0, FCVAR_ARCHIVE, "How far away from the horizontal edges of the screen should the HUD be in pixels?", 0)
CreateConVar("bfthud_attention", 1, FCVAR_ARCHIVE, "Determines if special HUD effects are turned on.")
local hide = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
    ["CHudSquadStatus"] = true,
    ["CHudAmmo"] = true,
    ["CHudSecondaryAmmo"] = true,
    ["CHudSuitPower"] = true,
}
hook.Add("HUDShouldDraw", "battle_fought_hudshoulddraw", function(name)
    if hide[name] then
		return false
	end
end)

--[[
    Fonts used by the HUD
    Duplicate fonts with blursize = 2 exist for extra font shadows
]]
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

-- Most colors used by the hud
local hudbgcolor = Color(0, 0, 0, 200)
local hudhpcolor = Color(185, 185, 185)
local hudhpredcolor = Color(255, 50, 50)
local hudarcolor = Color(115, 115, 255)
local hudtxcolor = Color(195, 195, 195)
local hudtxredcolor = Color(255, 50, 50)
local hudaxcolor = Color(255, 145, 0)

-- Convenience function added to draw the extra shadow for text without having 2 lines
local function DrawTextWithShadow(text, font, x, y, color, alignone, aligntwo)
    draw.SimpleText(text, font .. "_blur", x + 2, y + 2, hudbgcolor, alignone, aligntwo)
    draw.SimpleText(text, font, x, y, color, alignone, aligntwo)
end

-- Sine wave used to make the HP bar pulse red when low on health
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
    -- Draw nothing if the weapon is not valid
    if not IsValid(LocalPlayer():GetActiveWeapon()) then return end

    local ammo1 = LocalPlayer():GetAmmoCount(LocalPlayer():GetActiveWeapon():GetPrimaryAmmoType())
    local maxclip1 = LocalPlayer():GetActiveWeapon():GetMaxClip1()
    local clip1 = LocalPlayer():GetActiveWeapon():Clip1()

    -- Show nothing if the weapon is not meant to have ammo at all
    if clip1 == -1 and ammo1 == 0 then return end

    -- The clip of the weapon is the ammo if the weapon does not use clips
    if clip1 == -1 then
        clip1 = ammo1
    end

    DrawTextWithShadow(clip1, "bfthud_ammobig", ScrW() - (ScrW() * 65/1920) - GetConVar("bfthud_xoffset"):GetInt(), ScrH() - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt(), (clip1 < maxclip1 / 3 and hudamrdcolor or hudamtxcolor), TEXT_ALIGN_RIGHT, TEXT_ALIGN_BOTTOM)
    if LocalPlayer():GetActiveWeapon():Clip1() ~= -1 then -- Don't draw the ammo counter if it's already displayed above
        DrawTextWithShadow(ammo1, "bfthud_ammosmall", ScrW() - (ScrW() * 65/1920) - GetConVar("bfthud_xoffset"):GetInt(), ScrH() - (ScrH() * 60/1080) - GetConVar("bfthud_yoffset"):GetInt(), (ammo1 == 0 and hudamrdcolor or hudamtxcolor), TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP)
    end
end

local oldar = 0
local showarmor = false
hook.Add("Think", "battle_fought_armorsound", function()
    -- Armor isn't the same as last frame? Initiate Operation Glass Break
    if LocalPlayer():Armor() ~= oldar and LocalPlayer():Armor() == 0 then
        surface.PlaySound("common/warning.wav")
        surface.PlaySound("physics/glass/glass_sheet_break" .. math.random(1, 3) .. ".wav")
        showarmor = true
    end
    oldar = LocalPlayer():Armor()
end)

local drawarmorfor = 0
local vignettearmor = Color(115, 115, 255)
local vignettegradient = Material("battlefought/vignette_white.png", "noclamp smooth")
function DrawEffects()
    if LocalPlayer():Health() < LocalPlayer():GetMaxHealth() / 3 then
        DrawMotionBlur(0.4, 0.8, 0.01)
        surface.SetDrawColor(hudbgcolor)
        surface.SetMaterial(vignettegradient)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        draw.NoTexture()
    end

    if showarmor and drawarmorfor == 0 then
        showarmor = false
        drawarmorfor = UnPredictedCurTime() + 0.350
        DrawMotionBlur(0.4, 0.8, 0.02)
    end

    if drawarmorfor ~= 0 then
        local mp = math.TimeFraction(drawarmorfor - 0.350, drawarmorfor, UnPredictedCurTime())
        surface.SetDrawColor(ColorAlpha(vignettearmor, 255 * (1 - mp)))
        surface.SetMaterial(vignettegradient)
        surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
        if mp >= 1 then
            drawarmorfor = 0
        end
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