GM.Intermission = true
GM.Time = 0
GM.IntermissionTime = 30
GM.WaveTime = 240

function Intermissionn()
    GM.Intermission = true
    util.AddNetworkString("Intermission")
    print("Intermissioning - server")
    hook.Add("Think","Intermission",function()
        if GAMEMODE.Intermission == true then
            GAMEMODE.Time = GAMEMODE.Time + 0.1
            print(GAMEMODE.Time)
            if GAMEMODE.Time >= GAMEMODE.IntermissionTime then
                GAMEMODE.Time = 0
                GAMEMODE.Intermission = false
                print(GAMEMODE.Intermission)
                hook.Remove("Think","Intermission")
                print("Intermission over - server")
                StartWave()
            end
        end
    end)
end

Intermissionn()

function StartWave()
    if GAMEMODE.Intermission == true then return end
    if #player.GetHumans() == 0 then return end

    util.AddNetworkString("StartWave")

    hook.Add("Think","Wave",function()
        GAMEMODE.Time = GAMEMODE.Time + 0.001
        if GAMEMODE.Time >= GAMEMODE.WaveTime then
            GAMEMODE.Time = 0
            hook.Remove("Think","Wave")
            print("Wave over - server")
            Intermissionn()
        end
    end)

    
end