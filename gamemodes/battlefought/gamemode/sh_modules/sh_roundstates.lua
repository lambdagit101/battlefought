GM.RoundState = 0

ROUND_OVER = 3
ROUND_STARTING = 1
ROUND_PROGRESS = 2
ROUND_WARMUP = 0

if SERVER then
    util.AddNetworkString("battle-fought-state-change")
    function GM:ChangeRoundState(state)
        GAMEMODE.RoundState = state
        net.Start("battle-fought-state-change")
        net.WriteInt(state, 7)
        net.Broadcast()
    end
end

if CLIENT then
    net.Receive("battle-fought-state-change", function(len)
        GAMEMODE.RoundState = net.ReadInt(7)
    end)
end

function GM:GetRoundState()
    return GAMEMODE.RoundState
end