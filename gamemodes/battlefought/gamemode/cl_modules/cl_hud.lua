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
hook.Add("HUDShouldDraw", "battle-fought-hudshoulddraw", function(name)
    if hide[name] then
		return false
	end
end)

--[[
    Fonts used by the HUD
    Duplicate fonts with blursize = 2 exist for extra font shadows
]]
surface.CreateFont("bfthud_general", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (16/1920),
    weight = 500,
})
surface.CreateFont("bfthud_general_blur", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (16/1920),
    weight = 500,
    blursize = 2,
})

surface.CreateFont("bfthud_loadout", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (24/1920),
    weight = 500,
})
surface.CreateFont("bfthud_loadout_blur", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (24/1920),
    weight = 500,
    blursize = 2,
})

surface.CreateFont("bfthud_ammobig", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (50/1920),
    weight = 1000,
})
surface.CreateFont("bfthud_ammobig_blur", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (50/1920),
    weight = 1000,
    blursize = 2,
})

surface.CreateFont("bfthud_ammosmall", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (32/1920),
    weight = 500,
})
surface.CreateFont("bfthud_ammosmall_blur", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (32/1920),
    weight = 500,
    blursize = 2,
})

surface.CreateFont("bfthud_name", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (18/1920),
    weight = 500,
})
surface.CreateFont("bfthud_name_blur", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (18/1920),
    weight = 500,
    blursize = 2,
})

surface.CreateFont("bfthud_center", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (36/1920),
    weight = 500,
})
surface.CreateFont("bfthud_center_blur", {
    font = "Perfect DOS VGA 437",
    size = ScrW() * (36/1920),
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

    if GAMEMODE:GetRoundState() == 2 then
        DrawTextWithShadow(string.ToMinutesSeconds(GetGlobalFloat("battle-fought-timer") - (GetGlobalFloat("battle-fought-timer") ~= 0 and CurTime() or 0)), "bfthud_general", (ScrW() * 35/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey - (ScrH() * 30/1080) - GetConVar("bfthud_yoffset"):GetInt(), hudtxcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    elseif GAMEMODE:GetRoundState() == 1 then
        DrawTextWithShadow(string.ToMinutesSeconds(GetGlobalFloat("battle-fought-starttimer") - CurTime()), "bfthud_general", (ScrW() * 35/1920) + GetConVar("bfthud_xoffset"):GetInt(), ScrH() - boxsizey - (ScrH() * 30/1080) - GetConVar("bfthud_yoffset"):GetInt(), hudtxcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
    end

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
        draw.SimpleText(language.GetPhrase("bftui-hud-hurt"), "bfthud_center_blur", ScrW() / 2, (ScrW() * 240/1920) + GetConVar("bfthud_yoffset"):GetInt() + 2, hudbgcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        draw.SimpleText(language.GetPhrase("bftui-hud-hurt"), "bfthud_center", ScrW() / 2, (ScrW() * 240/1920) + GetConVar("bfthud_yoffset"):GetInt(), hudtxcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

local deleteafter = 0
local killalpha = 0
local primary = "weapon_base"
local secondary = "weapon_base"
local hudldcolor = Color(185, 85, 0)
local primaryboxx = 0
function DrawLoadout()
    killalpha = Lerp(FrameTime() * 15, killalpha, (deleteafter > CurTime() and 255 or 0))

    local originx, originy = (ScrW() * 35/1920) + GetConVar("bfthud_xoffset"):GetInt(), (ScrH() * 30/1080) + GetConVar("bfthud_yoffset"):GetInt()

    surface.SetFont("bfthud_loadout")
    local textx, texty = surface.GetTextSize(" " .. language.GetPhrase("bftui-hud-loadout") .. " ")
    draw.RoundedBox(0, originx, originy, textx * (killalpha / 255), texty, ColorAlpha(hudldcolor, killalpha))
    draw.SimpleText(" " .. language.GetPhrase("bftui-hud-loadout") .. " ", "bfthud_loadout", originx - (1 - killalpha / 255) * textx, originy, ColorAlpha(hudtxcolor, killalpha))

    if primary == "" then 
        primary = secondary
        secondary = nil
    end

    local primaryx, primaryy = originx, originy + texty
    surface.SetFont("bfthud_general")
    local pwpname = " " .. weapons.Get(primary).PrintName .. " "
    local pwpnamesizex, pwpnamesizey = surface.GetTextSize(pwpname)
    local pwpkillsizex, pwpkillsizey = killicon.GetSize(primary)
    draw.RoundedBox(0, primaryx, primaryy, math.max(pwpnamesizex, pwpkillsizex) * (killalpha / 255), pwpnamesizey + pwpkillsizey, ColorAlpha(hudbgcolor, killalpha * (200 / 255)))
    killicon.Draw(primaryx + math.max(pwpnamesizex, pwpkillsizex) / 2 - (1 - killalpha / 255) * pwpkillsizex, primaryy + pwpkillsizey / 2, primary, killalpha)
    draw.SimpleText(pwpname, "bfthud_general", primaryx - (1 - killalpha / 255) * pwpnamesizex, primaryy + pwpkillsizey, ColorAlpha(hudtxcolor, killalpha))

    if secondary == nil then
        surface.SetDrawColor(200, 200, 200, killalpha)
        surface.DrawLine(originx, primaryy + pwpnamesizey + pwpkillsizey, originx + math.max(pwpnamesizex, pwpkillsizex) * (killalpha / 255), primaryy + pwpnamesizey + pwpkillsizey)
        return 
    end

    local secondaryx, secondaryy = originx, primaryy + pwpkillsizey + pwpnamesizey
    surface.SetFont("bfthud_general")
    local swpname = " " .. weapons.Get(secondary).PrintName .. " "
    local swpnamesizex, swpnamesizey = surface.GetTextSize(swpname)
    local swpkillsizex, swpkillsizey = killicon.GetSize(secondary)
    draw.RoundedBox(0, secondaryx, secondaryy, math.max(swpnamesizex, swpkillsizex) * (killalpha / 255), swpnamesizey + swpkillsizey, ColorAlpha(hudbgcolor, killalpha * (200 / 255)))
    killicon.Draw(secondaryx + math.max(swpnamesizex, swpkillsizex) / 2 - (1 - killalpha / 255) * swpkillsizex, secondaryy + swpkillsizey / 2, secondary, killalpha)
    draw.SimpleText(swpname, "bfthud_general", secondaryx - (1 - killalpha / 255) * swpnamesizex, secondaryy + swpkillsizey, ColorAlpha(hudtxcolor, killalpha))

    surface.SetDrawColor(200, 200, 200, killalpha)
    surface.DrawLine(originx, secondaryy, originx + math.max(math.max(pwpnamesizex, pwpkillsizex), math.max(swpnamesizex, swpkillsizex)) * (killalpha / 255), secondaryy)

end

net.Receive("battle-fought-loadout", function(len)
    primary = net.ReadString()
    secondary = net.ReadString()

    deleteafter = CurTime() + 4
end)

local displaygradient = Material("vgui/gradient_down.vtf", "noclamp smooth")
local warmupmp = 0
function DrawWarmup()
    warmupmp = Lerp(FrameTime() * 4, warmupmp, (GAMEMODE:GetRoundState() ~= 0 and 0 or 1))
    surface.SetFont("bfthud_center")
    local phrase = " " .. language.GetPhrase("bftui-hud-warmup") .. " "
    local textx, texty = surface.GetTextSize(phrase)
    surface.SetMaterial(displaygradient)
    surface.SetDrawColor(0, 0, 0, 200 * warmupmp)
    surface.DrawTexturedRect(ScrW() / 2 - textx, 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt(), textx * 2, texty * 1.5)
    draw.SimpleText(phrase, "bfthud_center_blur", ScrW() / 2, 2 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt(), ColorAlpha(hudbgcolor, 200 * warmupmp), TEXT_ALIGN_CENTER)
    draw.SimpleText(phrase, "bfthud_center", ScrW() / 2, 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt(), ColorAlpha(hudtxcolor, 255 * warmupmp), TEXT_ALIGN_CENTER)
    draw.NoTexture()
    
    local voterPhrase = ""
    if GetGlobalFloat("battle-fought-startingin") ~= 0 then
        voterPhrase = string.format(language.GetPhrase("bftui-hud-start"), GetGlobalFloat("battle-fought-startingin") - CurTime())
    else
        voterPhrase = string.format(language.GetPhrase("bftui-hud-votes"), GetGlobalInt("battle-fought-votes"), math.ceil(player.GetCount() / 2))
    end

    draw.SimpleText(voterPhrase , "bfthud_name_blur", ScrW() / 2, 2 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt() + texty, ColorAlpha(hudbgcolor, 200 * warmupmp), TEXT_ALIGN_CENTER)
    local _, secondy = draw.SimpleText(voterPhrase, "bfthud_name", ScrW() / 2, 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt() + texty, ColorAlpha(hudtxcolor, 255 * warmupmp), TEXT_ALIGN_CENTER)

    draw.SimpleText(string.format(language.GetPhrase("bftui-hud-voter"), input.LookupBinding("gm_showhelp") or "UNBOUND"), "bfthud_name_blur", ScrW() / 2,  secondy + 2 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt() + texty, ColorAlpha(hudbgcolor, 200 * warmupmp), TEXT_ALIGN_CENTER)
    draw.SimpleText(string.format(language.GetPhrase("bftui-hud-voter"), input.LookupBinding("gm_showhelp") or "UNBOUND"), "bfthud_name", ScrW() / 2, secondy + 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt() + texty, ColorAlpha(hudtxcolor, 255 * warmupmp), TEXT_ALIGN_CENTER)
end

function DrawSpectatorHUD()
    warmupmp = 0

    draw.RoundedBox(0, 0, 0, ScrW(), ScreenScale(50), hudbgcolor)
    draw.RoundedBox(0, 0, ScrH() - ScreenScale(50), ScrW(), ScreenScale(50), hudbgcolor)

    local spectatingTarget = IsValid(LocalPlayer():GetObserverTarget()) and LocalPlayer():GetObserverTarget() or LocalPlayer()
    DrawTextWithShadow(spectatingTarget:Nick() .. " (" .. spectatingTarget:Health() .. ")", "bfthud_name", ScrW() / 2, ScrH() - ScreenScale(50) / 2, hudtxcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    if GAMEMODE:GetRoundState() == 2 then
        DrawTextWithShadow(language.GetPhrase("bftui-hud-progress"), "bfthud_name", ScrW() / 2, ScreenScale(50) / 2, hudtxcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
end

hook.Add("HUDDrawTargetID", "battle-fought-targetid", function()
    local tr = util.TraceHull(util.GetPlayerTrace(LocalPlayer()))

    if not tr.Hit then return false end
    if not tr.HitNonWorld then return false end

    local ent = NULL
    local coords = {x = 0, y = 0, visible = false}

    if tr.Entity:IsPlayer() then
		ent = tr.Entity
	else
		return false
	end

    coords = ent:GetShootPos():ToScreen()
    coords.y = coords.y + 5
    draw.SimpleText(ent:Nick(), "bfthud_general", coords.x, coords.y + 2, hudbgcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    draw.SimpleText(ent:Nick(), "bfthud_general", coords.x, coords.y, hudtxcolor, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	return false
end)

local closeWinnerAfter = 0
local closeDelay = 0
local winner = LocalPlayer()
local winnerNick = ""
local winnerMP = 0
function DrawEndScreen()
    winnerMP = Lerp(FrameTime() * 4, winnerMP, (closeWinnerAfter > CurTime() and 1 or 0))
    surface.SetFont("bfthud_center")
    local phrase = " " .. string.format((IsValid(winnerNick) and language.GetPhrase("bftui-hud-winner") or language.GetPhrase("bftui-hud-contest")), winnerNick) .. " "
    local phraseX, phraseY = surface.GetTextSize(phrase)
    surface.SetMaterial(displaygradient)
    surface.SetDrawColor(0, 0, 0, 200 * winnerMP)
    surface.DrawTexturedRect(ScrW() / 2 - phraseX / 2, 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt(), phraseX, phraseY * 2)
    draw.SimpleText(phrase, "bfthud_center_blur", ScrW() / 2, 2 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt(), ColorAlpha(hudbgcolor, 200 * winnerMP), TEXT_ALIGN_CENTER)
    draw.SimpleText(phrase, "bfthud_center", ScrW() / 2, 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt(), ColorAlpha(hudtxcolor, 255 * winnerMP), TEXT_ALIGN_CENTER)

    draw.RoundedBox(0, ScrW() / 2 - (phraseX / 2) * math.TimeFraction(closeWinnerAfter - closeDelay, closeWinnerAfter, CurTime()), 0 + (ScrW() * 30/1920) + GetConVar("bfthud_yoffset"):GetInt() + phraseY, phraseX * math.TimeFraction(closeWinnerAfter - closeDelay, closeWinnerAfter, CurTime()), 3, ColorAlpha(hudhpcolor, 255 * winnerMP))
    draw.NoTexture()
end
net.Receive("battle-fought-round-end", function(len)
    winner = net.ReadEntity()
    closeDelay = net.ReadFloat()
    closeWinnerAfter = CurTime() + closeDelay
    if not IsValid(winner) then
        winnerNick = NULL
        return
    end
    winnerNick = winner:Nick()
end)

hook.Add("HUDPaint", "battle-fought-hudpaint", function()
    if not IsValid(LocalPlayer()) then return end
    local shouldHaltHud = hook.Run("HUDShouldDraw", "battle_fought_hud")
    if shouldHaltHud ~= nil and shouldHaltHud == false then return end

    if not LocalPlayer():Alive() then 
        DrawSpectatorHUD()
        return 
    end

    if GAMEMODE:GetRoundState() == 3 then
        DrawEndScreen()
    end
    if GetConVar("bfthud_attention"):GetBool() then
        DrawEffects()
    end
    if GAMEMODE:GetRoundState() == 0 then
        DrawWarmup()
    end
    DrawLoadout()
    DrawHealthDisplay()
    DrawAmmo()
end)