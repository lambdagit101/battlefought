BF = GM:ReturnBFTable()

function GM:HasPrimary(ply)
    for _, v in ipairs(ply:GetWeapons()) do
        if BF.Primaries[v:GetClass()] then
            return true, v:GetClass()
        end
    end

    return false
end

function GM:HasSecondary(ply)
    for _, v in ipairs(ply:GetWeapons()) do
        if BF.Secondaries[v:GetClass()] then
            return true, v:GetClass()
        end
    end

    return false
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
    local hasPrimary, primary = GAMEMODE:HasPrimary(ply)
    local hasSecondary, secondary = GAMEMODE:HasSecondary(ply)
    local tr = util.TraceHull({
		start = ply:EyePos(),
		endpos = ply:EyePos() + ply:GetAimVector() * 82,
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