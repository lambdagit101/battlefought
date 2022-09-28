hook.Add("PlayerSpawn", "battle_fought_main_spawn", function(ply)
    player_manager.SetPlayerClass(ply, "player_battlefought")
end)

function GM:PlayerSetModel(ply)
    ply:SetModel("models/player/odessa.mdl")

    ply:SetupHands()
end

hook.Add("PlayerDeath", "battle_fought_deathcam", function(victim, inflictor, attacker)
    victim:Spectate(OBS_MODE_DEATHCAM)
end)