local Intermission = true
local Time = 0
local IntermissionTime = 30
local WaveTime = 240

Intermission()

function Intermission()
    Intermission = true
    util.AddNetworkString("Intermission")
    hook.Add("Think","Intermission",function()
        if Intermission == true then
            Time = Time + 0.001
            if Time >= IntermissionTime then
                Time = 0
                Intermission = false
                hook.Remove("Think","Intermission")
                StartWave()
            end
        end
    end)
end

function StartWave()
    if Intermission == true then return end
    if player.GetHumans() == 0 then return end

    util.AddNetworkString("StartWave")

    hook.Add("Think","Wave",function()
        Time = Time + 0.001
        if Time >= WaveTime then
            Time = 0
            hook.Remove("Think","Wave")
            Intermission()
        end
    end)

    
end