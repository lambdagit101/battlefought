hook.Add("PlayerSpawn", "battle_fought_main_spawn", function(ply)
    player_manager.SetPlayerClass(ply, "player_battlefought")
end)

function GM:SpawnHeli()
    GAMEMODE.heli = ents.Create("bf_dropcopter")
    GAMEMODE.heli:SetPos(Vector(-2034.973755, 5310.209473, 2576.591064))
    GAMEMODE.heli:SetAngles(Angle(-0.725239, -90.927902, 0.000000))
    GAMEMODE.heli:Spawn()

    for k, v in ipairs(player.GetAll()) do
        v:Spectate(OBS_MODE_CHASE)
        v:SpectateEntity(GAMEMODE.heli)
        v:SetNWBool("battle_fought_in_heli", true)
    end
end

concommand.Add("spawnheli", function(ply, cmd, args)
    GAMEMODE:SpawnHeli()
end)

function GM:PlayerSetModel(ply)
    ply:SetModel("models/player/odessa.mdl")

    ply:SetupHands()
end

hook.Add("PlayerDeath", "battle_fought_deathcam", function(victim, inflictor, attacker)
    victim:Spectate(OBS_MODE_DEATHCAM)
end)