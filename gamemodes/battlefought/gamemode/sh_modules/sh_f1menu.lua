BF = GM:ReturnBFTable()

if SERVER then
    util.AddNetworkString("battle-fought-f1")
    function GM:ShowHelp(ply)
        net.Start("battle-fought-f1")
        net.Send(ply)
    end
    
    util.AddNetworkString("battle-fought-vote")
    net.Receive("battle-fought-vote", function(len, ply)
        if (ply.VoteCooldown or 0) > CurTime() then
            return 
        end

        ply.VoteCooldown = CurTime() + 5

        SetGlobalInt("battle-fought-votes", GetGlobalInt("battle-fought-votes") + (not ply:GetNWBool("battle-fought-voted") and 1 or -1))
        ply:SetNWBool("battle-fought-voted", not ply:GetNWBool("battle-fought-voted"))
    end)

    util.AddNetworkString("battle-fought-pmupdate")
    net.Receive("battle-fought-pmupdate", function(len, ply)
        local pmkey = net.ReadString()

        if (ply.PMCooldown or 0) > CurTime() or BF.PlayerModels[pmkey] == nil then
            return 
        end

        ply:SetNWString("battle-fought-pm", pmkey)
    end)
end

if CLIENT then
    net.Receive("battle-fought-f1", function(len)
        local fullHelpUI = vgui.Create("DFrame")
        fullHelpUI:SetSize(640, 480)
        fullHelpUI:Center()
        fullHelpUI:SetIcon("icon16/tux.png")
        fullHelpUI:SetTitle(language.GetPhrase("bftui-help-title"))
        fullHelpUI:SetDraggable(false)
        fullHelpUI:MakePopup()

        local categories = vgui.Create("DPropertySheet", fullHelpUI)
        categories:Dock(FILL)

        local vote = vgui.Create("DPanel", categories)
        vote.Paint = nil

        local voteText = vgui.Create("DLabel", vote)
        voteText:Dock(FILL)
        voteText:SetFont("Default")
        voteText:SetText(language.GetPhrase("bftui-help-votetext"))

        local voteButton = vgui.Create("DButton", vote)
        voteButton:Dock(BOTTOM)
        voteButton.Think = function(self)
            local hasVoted = LocalPlayer():GetNWBool("battle-fought-voted")
            --self:SetColor(Color((voted and 0 or 255), (voted and 255 or 0), 0))
            self:SetText(string.format(language.GetPhrase("bftui-help-votebutton"), "(" .. GetGlobalInt("battle-fought-votes") .. "/" .. math.ceil(player.GetCount() / 2) .. ")"))
        end
        voteButton.DoClick = function(self)
            net.Start("battle-fought-vote")
            net.SendToServer()
        end
        categories:AddSheet(language.GetPhrase("bftui-help-vote"), vote, "icon16/tick.png")

        local pm = vgui.Create("DScrollPanel", vote)
        pm.Paint = nil 

        local pmSelector = vgui.Create("DIconLayout", pm)
        pmSelector:Dock(FILL)
        for k, v in SortedPairs(BF.PlayerModels) do
            local pmSelector = pmSelector:Add("SpawnIcon")
            pmSelector:SetModel(v)
            pmSelector:SetTooltip(k)
	        pmSelector:SetSize(64, 64)
            pmSelector.DoClick = function(self)
                net.Start("battle-fought-pmupdate")
                net.WriteString(k)
                net.SendToServer()
            end
        end
        categories:AddSheet(language.GetPhrase("bftui-help-pm"), pm, "icon16/computer.png")

    end)
end