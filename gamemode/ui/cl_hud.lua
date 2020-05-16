function GM:HUDPaint()
  surface.SetDrawColor( 0, 0, 0, 150 )
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

end
