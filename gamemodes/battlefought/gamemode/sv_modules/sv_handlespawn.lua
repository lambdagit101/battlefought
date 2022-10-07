hook.Add("PlayerSpawn", "battle-fought-main-pawn", function(ply)
    player_manager.SetPlayerClass(ply, "player_battlefought")
end)

BF = GM:ReturnBFTable()

function GM:PlayerSetModel(ply)
    ply:SetModel(BF.PlayerModels[ply:GetNWString("battle-fought-pm", BF.DefaultPM)])
    ply:SetupHands()
end

function GM:PlayerDeathSound(ply)
    return true
end

hook.Add("PlayerCanHearPlayersVoice", "battle-fought-voice-chat", function(listener, talker)
    if not talker:Alive() then
		return false
	end
end)

hook.Add("PlayerSelectSpawn", "battle-fought-better-spawns", function(ply)
	local spawns = {}
    table.Add(spawns, ents.FindByClass("info_player_start"))
    table.Add(spawns, ents.FindByClass("info_player_deathmatch"))
    table.Add(spawns, ents.FindByClass("info_deathmatch_spawn"))
	local random_entry = math.random(#spawns)

	return spawns[random_entry]
end)

util.AddNetworkString("battle-fought-loadout")
function GM:PlayerLoadout(ply)
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
    end

	return true
end
hook.Add("PlayerSpawn", "battle-fought-loadout", function(ply)
end)

function GM:PlayerInitialSpawn(ply)
    if GAMEMODE:GetRoundState() == 2 or GAMEMODE:GetRoundState() == 3 then
        ply:KillSilent()
    end
end

hook.Add("PlayerDeath", "battle-fought-deathcam", function(victim, inflictor, attacker)
    victim:Spectate(OBS_MODE_DEATHCAM)
    victim:SpectateEntity(victim)
    victim.SpectatedPlayer = 1
    victim.SpectateMode = false
    victim.DeathSpectating = false
end)

function GM:PlayerDeathThink(ply)
    if GAMEMODE:GetRoundState() == 0 then
        if ply.NextSpawnTime and ply.NextSpawnTime > CurTime() then return end
        ply:Spawn()
    else
        if ply:KeyPressed(IN_ATTACK) or ply:KeyPressed(IN_ATTACK2) or ply:KeyPressed(IN_JUMP) then
            ply.SpectatedPlayer = 1
            ply.SpectateMode = false
            ply.DeathSpectating = true
        end
    end
end

hook.Add("KeyPress", "battle-fought-death-spectate", function(ply, key)
    if ply:Alive() or not ply.DeathSpectating then return end

    if key == IN_ATTACK then
        ply.SpectatedPlayer = ply.SpectatedPlayer + 1
        if ply.SpectatedPlayer > player.GetCount() then
            ply.SpectatedPlayer = 1
        end
        ply:SpectateEntity(player.GetAll()[ply.SpectatedPlayer])
    end
    
    if key == IN_ATTACK2 then
        ply.SpectatedPlayer = ply.SpectatedPlayer - 1
        if ply.SpectatedPlayer == 0 then
            ply.SpectatedPlayer = player.GetCount()
        end
        ply:SpectateEntity(player.GetAll()[ply.SpectatedPlayer])
    end

    if key == IN_JUMP then
        ply.SpectateMode = false
        ply:Spectate(ply.SpectateMode and OBS_MODE_IN_EYE or OBS_MODE_CHASE)
    end
end)