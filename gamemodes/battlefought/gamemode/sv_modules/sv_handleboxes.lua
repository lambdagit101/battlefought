local boxPositions = file.Read("bf_" .. game.GetMap() .. ".json", "DATA")

function GM:PostCleanupMap()
    if boxPositions ~= nil then
        local boxTable = util.JSONToTable(boxPositions)
        for _, pos in ipairs(boxTable) do
            local box = ents.Create("bf_supplybox")
            box:SetPos(pos)
            box:Spawn()
        end
    end
end