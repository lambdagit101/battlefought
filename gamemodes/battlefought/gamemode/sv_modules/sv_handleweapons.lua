BF = GM:ReturnBFTable()

function GM:HasPrimary(ply)
    for _, v in ipairs(ply:GetWeapons()) do
        if BF.Primaries[v:GetClass()] then return true, v:GetClass() end
    end

    return false
end

function GM:HasSecondary(ply)
    for _, v in ipairs(ply:GetWeapons()) do
        if BF.Secondaries[v:GetClass()] then return true, v:GetClass() end
    end

    return false
end

util.AddNetworkString("battle-fought-loadout")

function GM:PlayerLoadout(ply)
    hook.Run("battle-fought-loadout", ply)

    player_manager.RunClass(ply, "Loadout")

    if GAMEMODE:GetRoundState() == 0 then
        local _, primaryWeapon = table.Random(BF.Primaries)
        local _, secondaryWeapon = table.Random(BF.Secondaries)
        ply:Give(primaryWeapon, false)
        ply:GiveAmmo(ply:GetWeapon(primaryWeapon):Clip1() * 2, ply:GetWeapon(primaryWeapon):GetPrimaryAmmoType(), true)
        ply:Give(secondaryWeapon, false)
        ply:GiveAmmo(ply:GetWeapon(secondaryWeapon):Clip1() * 2, ply:GetWeapon(secondaryWeapon):GetPrimaryAmmoType(), true)
        net.Start("battle-fought-loadout")
        net.WriteString(primaryWeapon)
        net.WriteString(secondaryWeapon)
        net.Send(ply)
    else
        ply:Give(GetGlobalString("battle-fought-starterup"), false)
        ply:GiveAmmo(ply:GetWeapon(GetGlobalString("battle-fought-starterup")):Clip1(), ply:GetWeapon(GetGlobalString("battle-fought-starterup")):GetPrimaryAmmoType(), true)
    end

    return true
end

hook.Add("PlayerCanPickupWeapon", "battle-fought-weapons", function(ply, weapon)
    if BF.Whitelist[weapon:GetClass()] then return true end
    if GAMEMODE:GetRoundState() == 0 then return true end
    local shouldAllowWeapon = hook.Run("battle-fought-pickupallow", ply, weapon)
    if shouldAllowWeapon ~= nil then return shouldAllowWeapon end
    if ply:HasWeapon(weapon:GetClass()) then return true end
    if weapon:GetClass() == BF.Knife or weapon:GetClass() == BF.ArmorCharger then return true end
    if BF.Primaries[weapon:GetClass()] and not GAMEMODE:HasPrimary(ply) or BF.Secondaries[weapon:GetClass()] and not GAMEMODE:HasSecondary(ply) then return true end
    if not ply:KeyPressed(IN_USE) then return false end
    local _, primary = GAMEMODE:HasPrimary(ply)
    local _, secondary = GAMEMODE:HasSecondary(ply)

    local tr = util.TraceHull({
        start = ply:EyePos(),
        endpos = ply:EyePos() + ply:GetAimVector() * 142,
        filter = ply,
        mask = MASK_SHOT_HULL,
        mins = Vector(1, 1, 1) * -10,
        maxs = Vector(1, 1, 1) * 10
    })

    if tr.Hit and tr.HitNonWorld and IsValid(tr.Entity) and tr.Entity == weapon then
        if BF.Secondaries[weapon:GetClass()] then
            ply:DropWeapon(ply:GetWeapon(secondary))

            return true
        end

        if BF.Primaries[weapon:GetClass()] then
            ply:DropWeapon(ply:GetWeapon(primary))

            return true
        end
    end

    return false
end)