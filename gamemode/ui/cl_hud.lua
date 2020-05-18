function GM:HUDPaint()
  surface.SetDrawColor( 0, 0, 0, 225 )
  surface.DrawRect( 25, 25, 200, 65 )

  local myTeam = LocalPlayer():Team()
  surface.SetTextColor(team.GetColor(myTeam))
  surface.SetTextPos(35, 30)
  surface.SetFont("Trebuchet24")
  surface.DrawText(team.GetName(myTeam))

  if (ROUND_STATE != nil) then
    local roundStateString = ROUND_STATE_STRINGS[ROUND_STATE]

    surface.SetTextColor(Color(255, 255, 0))
    surface.SetTextPos(35, 55)
    surface.DrawText(roundStateString)
  end

  local width = 125
  local height = 32
  surface.DrawRect((ScrW() / 2) - (width / 2), 25, width, height)

  local formattedTime = FormatTime(ROUND_TIME_LEFT)
  local xOffset = surface.GetTextSize(formattedTime) / 2
  surface.SetTextColor(Color(255, 255, 0))
  surface.SetTextPos((ScrW() / 2) - xOffset, 30)
  surface.DrawText(formattedTime)

end

function FormatTime(timeInSeconds)
  if (timeInSeconds < 3600) then
    return string.FormattedTime(timeInSeconds, "%02i:%02i")
  else
    return string.FormattedTime(timeInSeconds, "%02i:%02i:%02i")
  end
end
