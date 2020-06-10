function GM:HUDPaint()
  surface.SetDrawColor( 0, 0, 0, 225 )
  surface.DrawRect( 25, 25, 200, 65 )
  surface.SetFont("Trebuchet24")

  local wardenText = 'No Warden'
  if (CURRENT_WARDEN != nil) then
    wardenText = 'Warden: ' .. CURRENT_WARDEN:GetName()
  end
  surface.SetTextColor(255, 255, 0)
  surface.SetTextPos(35, 30)
  surface.DrawText(wardenText)


  if (ROUND_STATE != nil) then
    local roundStateString = ROUND_STATE_STRINGS[ROUND_STATE]
    surface.SetTextColor(Color(255, 255, 0))
    surface.SetTextPos(35, 55)
    surface.DrawText(roundStateString)
  end

  local centerWidth = 125
  local centerHeight = 65
  surface.DrawRect((ScrW() / 2) - (centerWidth / 2), 25, centerWidth, centerHeight)

  local formattedTime = FormatTime(ROUND_TIME_LEFT)
  local timeXOffset = surface.GetTextSize(formattedTime) / 2
  surface.SetTextColor(Color(255, 255, 0))
  surface.SetTextPos((ScrW() / 2) - timeXOffset, 30)
  surface.DrawText(formattedTime)

  local myTeam = LocalPlayer():Team()
  local teamName = team.GetName(myTeam)
  local teamXOffset = surface.GetTextSize(teamName) / 2
  surface.SetTextColor(team.GetColor(myTeam))
  surface.SetTextPos((ScrW() / 2) - teamXOffset, 55)
  surface.DrawText(teamName)

end

function FormatTime(timeInSeconds)
  return string.FormattedTime(timeInSeconds, "%02i:%02i")
end
