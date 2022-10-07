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

        if GetGlobalInt("battle-fought-votes") >= math.ceil(player.GetCount() / 2) then
            SetGlobalFloat("battle-fought-startingin", CurTime() + 5)
        else
            SetGlobalFloat("battle-fought-startingin", 0)
        end
    end)

    util.AddNetworkString("battle-fought-pmupdate")
    net.Receive("battle-fought-pmupdate", function(len, ply)
        local pmkey = net.ReadString()

        if (ply.PMCooldown or 0) > CurTime() or BF.PlayerModels[pmkey] == nil then
            return 
        end

        ply:SetNWString("battle-fought-pm", pmkey)
    end)

    hook.Add("Think", "battle-fought-voters", function()
        if GetGlobalFloat("battle-fought-startingin") ~= 0 and GetGlobalFloat("battle-fought-startingin") < CurTime() then
            SetGlobalFloat("battle-fought-startingin", 0)
            GAMEMODE:StartRound()
        end
    end)
end

if CLIENT then
    surface.CreateFont("bfthud_console", {
        font = "Perfect DOS VGA 437",
        size = 17,
        weight = 500,
    })

    net.Receive("battle-fought-f1", function(len)
        local shouldOpenMenu = hook.Run("battle-fought-f1open")

        if shouldOpenMenu ~= nil and shouldOpenMenu == false then return end

        local fullHelpUI = vgui.Create("DFrame")
        fullHelpUI:SetSize(640, 480)
        fullHelpUI:Center()
        fullHelpUI:SetIcon("icon16/tux.png")
        fullHelpUI:SetTitle(language.GetPhrase("bftui-help-title"))
        fullHelpUI:SetDraggable(false)
        fullHelpUI:MakePopup()

        local categories = vgui.Create("DPropertySheet", fullHelpUI)
        categories:Dock(FILL)

        if GAMEMODE:GetRoundState() == 0 then

            local vote = vgui.Create("DPanel", categories)
            vote.Paint = nil

            local voteText = vgui.Create("DLabel", vote)
            voteText:Dock(FILL)
            voteText:SetFont("Default")
            voteText:SetText(language.GetPhrase("bftui-help-votetext"))

            local voteButton = vgui.Create("DButton", vote)
            voteButton:Dock(BOTTOM)
            voteButton:SetColor(Color(255, 255, 255))
            voteButton.Think = function(self)
                local hasVoted = LocalPlayer():GetNWBool("battle-fought-voted")
                --self:SetColor(Color((voted and 0 or 255), (voted and 255 or 0), 0))
                self:SetText(string.format(language.GetPhrase("bftui-help-votebutton"), "(" .. GetGlobalInt("battle-fought-votes") .. "/" .. math.ceil(player.GetCount() / 2) .. ")"))
            end
            voteButton.Paint = function(self, w, h)
                local hasVoted = LocalPlayer():GetNWBool("battle-fought-voted")
                local tempColor = Color((hasVoted and 0 or 200) + (self:IsHovered() and 25 or 0), (hasVoted and 200 or 0) + (self:IsHovered() and 25 or 0), self:IsHovered() and 25 or 0)
                draw.RoundedBox(8, 0, 0, w, h, tempColor)
            end
            voteButton.DoClick = function(self)
                if GAMEMODE:GetRoundState() ~= 0 then return end
                surface.PlaySound("buttons/blip1.wav")
                net.Start("battle-fought-vote")
                net.SendToServer()
            end
            categories:AddSheet(language.GetPhrase("bftui-help-vote"), vote, "icon16/tick.png")

        end

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

        local about = vgui.Create("DPanel", vote)
        about.Paint = function(self, w, h)
            draw.RoundedBox(8, 0, 0, w, h, Color(0, 0, 0))
        end

        local aboutText = vgui.Create("RichText", about)
        aboutText:Dock(FILL)
        aboutText.PerformLayout = function(self)
            self:SetFontInternal("bfthud_console")
            self:SetFGColor(color_white)
        end
        aboutText:InsertColorChange(255, 255, 255, 255)
        aboutText:AppendText(language.GetPhrase("bftui-about-localization-fullcredits"))
        categories:AddSheet(language.GetPhrase("bftui-help-about"), about, "icon16/user.png")
    end)
end