BF = GM:ReturnBFTable()

if SERVER then
    CreateConVar("bftserver_starttime", 5, FCVAR_ARCHIVE, "How much should every player wait in seconds before the round actually starts?", 0, 60)
    CreateConVar("bftserver_endtime", 10, FCVAR_ARCHIVE, "How much should every player wait in seconds before warm-up starts again?", 0, 60)

    util.AddNetworkString("battle-fought-round-start")
    function GM:StartRound()
        SetGlobalBool("battle-fought-mip", true)
        SetGlobalInt("battle-fought-votes", 0)

        game.CleanUpMap(false, {"env_fire", "entityflame", "_firesmoke"})

        local startingWeapon = BF.StartingWeapons[math.random(#BF.StartingWeapons)]

        for _, ply in ipairs(player.GetAll()) do
            ply:SetNWBool("battle-fought-voted", false)
            
            ply:Spawn()
            ply:StripWeapons()
            ply:StripAmmo()
            player_manager.RunClass(ply, "Loadout")
            ply:SetNWBool("battle-fought-freeze", true)

            ply:Give(startingWeapon, false)
            ply:GiveAmmo(ply:GetWeapon(startingWeapon):Clip1() * 2, ply:GetWeapon(startingWeapon):GetPrimaryAmmoType(), true)
            ply:Give(BF.Knife)
        end

        net.Start("battle-fought-loadout")
        net.WriteString("")
        net.WriteString(startingWeapon)
        net.Broadcast()
        
        net.Start("battle-fought-round-start")
        net.WriteFloat(GetConVar("bftserver_starttime"):GetInt())
        net.Broadcast()

        timer.Simple(GetConVar("bftserver_starttime"):GetInt(), function()
            for _, ply in ipairs(player.GetAll()) do
                ply:SetNWBool("battle-fought-freeze", false)
            end
        end)
    end

    function GM:AlivePlayers()
        local i = 0
        local alivePlayers = {}

        for _, ply in ipairs(player.GetAll()) do
            if ply:Alive() then 
                i = i + 1 
                alivePlayers[#alivePlayers + 1] = ply
            end
        end

        return i, alivePlayers
    end

    util.AddNetworkString("battle-fought-round-end")
    function GM:EndRound(winner)
        winner = winner or NULL
        
        for _, ply in ipairs(player.GetAll()) do
            ply:SetNWBool("battle-fought-freeze", true)
        end

        net.Start("battle-fought-round-end")
        net.WriteEntity(winner)
        net.WriteFloat(GetConVar("bftserver_endtime"):GetInt())
        net.Broadcast()

        timer.Simple(GetConVar("bftserver_endtime"):GetInt(), function()
            SetGlobalBool("battle-fought-mip", false)

            game.CleanUpMap(false, {"env_fire", "entityflame", "_firesmoke"})

            for _, ply in ipairs(player.GetAll()) do
                ply:SetNWBool("battle-fought-freeze", false)
                ply:KillSilent()
                ply:StripAmmo()
                ply:StripWeapons()
                ply:Spawn()
            end
        end)
    end

    hook.Add("PlayerDeath", "battle-fought-round-death", function(victim, inflictor, attacker)
        if not GetGlobalBool("battle-fought-mip") then return end

        local amount, lastplayers = GAMEMODE:AlivePlayers()

        if amount == 1 then
            GAMEMODE:EndRound(lastplayers[1])
        end
    end)
end

hook.Add("StartCommand", "battle-fought-freeze", function(ply, cmd)
    if ply:GetNWBool("battle-fought-freeze") and ply:Alive() then
        cmd:ClearMovement()
        cmd:RemoveKey(IN_ATTACK)
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_DUCK)
        cmd:RemoveKey(IN_WALK)
    end
end)