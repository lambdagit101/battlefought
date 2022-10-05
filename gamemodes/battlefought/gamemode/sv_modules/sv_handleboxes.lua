local boxPositions = file.Read("bf_" .. game.GetMap() .. ".json", "DATA")

CreateConVar("bft_randomboxes", 1, FCVAR_ARCHIVE, "Should box spawns be random?", 0, 1)

function GM:PostCleanupMap()
    if boxPositions ~= nil and GetGlobalBool("battle-fought-mip") then
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