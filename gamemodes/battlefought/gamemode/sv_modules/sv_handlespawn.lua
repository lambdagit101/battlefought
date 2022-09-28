hook.Add("PlayerSpawn", "battle_fought_main_spawn", function(ply)
    player_manager.SetPlayerClass(ply, "player_battlefought")
end)