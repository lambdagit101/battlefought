CreateConVar("bft_randomboxes", 1, FCVAR_ARCHIVE, "Should box spawns be random?", 0, 1)

function GM:PostCleanupMap()
    local boxPositions = file.Read("bf_" .. game.GetMap() .. ".json", "DATA")

    if boxPositions == nil then
        print("A:> echo \"There are no supply box locations available! Please create some by going into Sandbox and using the battle_fought_boxer_ weapon in the Other category. Left click saves a box, right click saves the file for the map it's being used in.\"")
    end
    if boxPositions ~= nil and GAMEMODE:GetRoundState() ~= 0 then
        local boxTable = util.JSONToTable(boxPositions)
        local boxesRandom = GetConVar("bft_randomboxes"):GetBool()
        for _, coords in ipairs(boxTable) do
            if boxesRandom then
                local chance = math.random(1, 3)
                if chance == 1 then continue end
            end
            local box = ents.Create("bf_supplybox")
            box:SetPos(coords[1])
            box:SetAngles(coords[2])
            box:Spawn()
        end
    end
end