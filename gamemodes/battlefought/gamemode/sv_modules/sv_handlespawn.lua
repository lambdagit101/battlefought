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

util.AddNetworkString("battle-fought-loadout")
hook.Add("PlayerSpawn", "battle-fought-warmup-loadout", function(ply)
    if not GetGlobalBool("battle-fought-mip") then
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
    end
end)

hook.Add("PlayerCanPickupWeapon", "noDoublePickup", function( ply, weapon )
    if ( ply:HasWeapon( weapon:GetClass() ) ) then
		return false
	end
end)

function GM:PlayerInitialSpawn(ply)
    if GetGlobalBool("battle-fought-mip") then
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
    if not GetGlobalBool("battle-fought-mip") then
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