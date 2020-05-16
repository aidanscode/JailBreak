function selectTeam(team)
  net.Start("TeamSelection")
    net.WriteInt(team, 3)
  net.SendToServer()
end

function showTeamSelectionMenu()
  local width = 300
  local height = 150

  local centerX = (ScrW() / 2) - (width / 2)
  local centerY = (ScrH() / 2) - (height / 2)

  local Frame = vgui.Create('DFrame')
  Frame:SetPos(centerX, centerY)
  Frame:SetSize(width, height)
  Frame:SetTitle("Team Selection")
  Frame:SetDraggable(false)
  Frame:ShowCloseButton(false)
  Frame:SetVisible(true)
  Frame:MakePopup()

  local PrisonerButton = vgui.Create("DButton", Frame)
  PrisonerButton:SetText(TEAM_PRISONERS['name'])
  PrisonerButton:SetPos((width / 3) - 30, (height / 2) - 15)
  PrisonerButton:SetSize(60, 30)
  PrisonerButton.DoClick = function()
    selectTeam(TEAM_PRISONERS['index'])
    Frame:Close()
  end

  local GuardButton = vgui.Create("DButton", Frame)
  GuardButton:SetText(TEAM_GUARDS['name'])
  GuardButton:SetPos((width * (2/3)) - 30, (height / 2) - 15)
  GuardButton:SetSize(60, 30)
  GuardButton.DoClick = function()
    selectTeam(TEAM_GUARDS['index'])
    Frame:Close()
  end
end

concommand.Add("select_team", function()
  if (LocalPlayer():IsSpectator()) then
    showTeamSelectionMenu()
  end
end )
