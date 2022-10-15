BF = GM:ReturnBFTable()

if SERVER then
    CreateConVar("bftserver_starttime", 5, FCVAR_ARCHIVE, "How much should every player wait in seconds before the round actually starts?", 0, 60)
    CreateConVar("bftserver_roundtime", 5, FCVAR_ARCHIVE, "How much does a round last for in minutes? 0 meaning no time limit.", 0, 60)
    CreateConVar("bftserver_endtime", 10, FCVAR_ARCHIVE, "How much should every player wait in seconds before warm-up starts again?", 0, 60)
    util.AddNetworkString("battle-fought-round-start")

    function GM:StartRound()
        hook.Run("battle-fought-rounddelay", GetConVar("bftserver_starttime"):GetInt())
        SetGlobalFloat("battle-fought-starttimer", CurTime() + GetConVar("bftserver_starttime"):GetInt())
        GAMEMODE:ChangeRoundState(1)
        SetGlobalInt("battle-fought-votes", 0)

        game.CleanUpMap(false, {"env_fire", "entityflame", "_firesmoke"})

        for _, ply in ipairs(player.GetAll()) do
            ply:SetNWBool("battle-fought-voted", false)
            ply:SetFrags(0)
            ply:SetDeaths(0)
            ply:Spawn()
            GAMEMODE:PlayerLoadout(ply)
            ply:SetNWBool("battle-fought-freeze", true)
        end

        net.Start("battle-fought-loadout")
        net.WriteString("")
        net.WriteString(BF.Knife)
        net.Broadcast()
        net.Start("battle-fought-round-start")
        net.WriteFloat(GetConVar("bftserver_starttime"):GetInt())
        net.Broadcast()

        timer.Simple(GetConVar("bftserver_starttime"):GetInt(), function()
            hook.Run("battle-fought-roundbegin")
            SetGlobalFloat("battle-fought-timer", GetConVar("bftserver_roundtime"):GetFloat() ~= 0 and CurTime() + GetConVar("bftserver_roundtime"):GetFloat() * 60 or 0)
            GAMEMODE:ChangeRoundState(2)

            for _, ply in ipairs(player.GetAll()) do
                ply:SetNWBool("battle-fought-freeze", false)
            end
        end)
    end

    function GM:AlivePlayers()
        local i = 0
        local alivePlayers = {}
        local plyTable = player.GetAll()

        for _, ply in ipairs(plyTable) do
            if ply:Alive() then
                i = i + 1
                alivePlayers[#alivePlayers + 1] = ply
            end
        end

        return i, alivePlayers
    end

    util.AddNetworkString("battle-fought-round-end")

    function GM:EndRound(winner)
        hook.Run("battle-fought-roundend", winner)

        for _, ply in ipairs(player.GetAll()) do
            ply:SetNWBool("battle-fought-freeze", true)
        end

        GAMEMODE:ChangeRoundState(3)
        net.Start("battle-fought-round-end")
        net.WriteEntity(winner)
        net.WriteFloat(GetConVar("bftserver_endtime"):GetInt())
        net.Broadcast()

        timer.Simple(GetConVar("bftserver_endtime"):GetInt(), function()
            GAMEMODE:ChangeRoundState(0)

            game.CleanUpMap(false, {"env_fire", "entityflame", "_firesmoke"})

            for _, ply in ipairs(player.GetAll()) do
                ply:SetFrags(0)
                ply:SetDeaths(0)
                ply:SetNWBool("battle-fought-freeze", false)
                ply:KillSilent()
                ply:StripAmmo()
                ply:StripWeapons()
                ply:Spawn()
            end
        end)
    end

    hook.Add("Think", "battle-fought-round-timer", function()
        if GAMEMODE:GetRoundState() ~= 2 then return end

        if GAMEMODE:GetRoundState() == 2 and GetGlobalFloat("battle-fought-timer") < CurTime() then
            GAMEMODE:EndRound(NULL)
        end
    end)

    hook.Add("PlayerDeath", "battle-fought-round-death", function(victim, inflictor, attacker)
        if GAMEMODE:GetRoundState() ~= 2 then return end
        if victim:GetNWBool("battle-fought-freeze", "stinky poopoo egg") == "stinky poopoo egg" then return end
        local amount, lastplayers = GAMEMODE:AlivePlayers()

        if amount == 1 then
            GAMEMODE:EndRound(lastplayers[1])
        elseif amount == 0 then
            GAMEMODE:EndRound(NULL)
        end
    end)

    hook.Add("PlayerDisconnected", "battle-fought-disconnect", function(ply)
        if GetGlobalInt("battle-fought-votes") >= math.ceil(((player.GetCount() - #player.GetBots()) - 1) / 2) then
            SetGlobalFloat("battle-fought-startingin", CurTime() + 5)
        else
            SetGlobalFloat("battle-fought-startingin", 0)
        end

        if GAMEMODE:GetRoundState() ~= 2 then return end
        ply:Kill()
    end)
end

hook.Add("StartCommand", "battle-fought-freeze", function(ply, cmd)
    if ply:GetNWBool("battle-fought-freeze") and ply:Alive() then
        cmd:ClearMovement()
        cmd:RemoveKey(IN_ATTACK)
        cmd:RemoveKey(IN_ATTACK2)
        cmd:RemoveKey(IN_JUMP)
        cmd:RemoveKey(IN_DUCK)
        cmd:RemoveKey(IN_WALK)
        cmd:RemoveKey(IN_USE)
    end
end)