BF = GM:ReturnBFTable()

if SERVER then
    CreateConVar("bftserver_starttime", 5, FCVAR_ARCHIVE, "How much should every player wait in seconds before the round actually starts?", 0, 60)

    function GM:StartRound()
        SetGlobalBool("battle-fought-mip", true)

        game.CleanUpMap(false, {"env_fire", "entityflame", "_firesmoke"})

        local startingWeapon = BF.StartingWeapons[math.random(#BF.StartingWeapons)]

        util.AddNetworkString("battle-fought-roundstart")
        for _, ply in ipairs(player.GetAll()) do
            ply:Spawn()
            ply:StripWeapons()
            ply:StripAmmo()
            player_manager.RunClass(ply, "Loadout")
            ply:SetNWBool("battle-fought-freeze", true)

            ply:Give(startingWeapon, false)
            ply:GiveAmmo(ply:GetWeapon(startingWeapon):Clip1() * 2, ply:GetWeapon(startingWeapon):GetPrimaryAmmoType(), true)
        end

        net.Start("battle-fought-loadout")
        net.WriteString("")
        net.WriteString(startingWeapon)
        net.Broadcast()

        timer.Simple(GetConVar("bftserver_starttime"):GetInt(), function()
            for _, ply in ipairs(player.GetAll()) do
                ply:SetNWBool("battle-fought-freeze", false)
            end
        end)
    end
end

hook.Add("StartCommand", "battle-fought-freeze", function(ply, cmd)
    if ply:GetNWBool("battle-fought-freeze") then
        cmd:ClearMovement()
        cmd:RemoveKey(IN_ATTACK)
        cmd:RemoveKey(IN_JUMP)
    end
end)