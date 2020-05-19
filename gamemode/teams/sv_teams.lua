util.AddNetworkString("TeamSelection")
net.Receive("TeamSelection", function(len, ply)
  local selectedTeam = net.ReadInt(3)

  --Make sure the selected team is a valid option before continuing
  if (selectedTeam != TEAM_PRISONERS && selectedTeam != TEAM_GUARDS) then return end

  --Ignore team selection request if the user is not a spectator
  if (ply:IsSpectator()) then
    ply:SetTeam(selectedTeam)
  end
end )
