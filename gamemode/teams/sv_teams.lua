util.AddNetworkString("TeamSelection")
net.Receive("TeamSelection", function(len, ply)
  local selectedTeam = net.ReadInt(3) --3 bits, this gives us a possible range of [-4, 3]
                                      --Which is fine because the defined teams are indexed: 1, 2, 3

  --Make sure the selected team is a valid option before continuing
  if (selectedTeam != TEAM_PRISONERS && selectedTeam != TEAM_GUARDS) then
    return end

  --Ignore team selection request if the user is not a spectator
  if (ply:IsSpectator()) then
    ply:SetTeam(selectedTeam)
  end
end )

function GM:PlayerChangedTeam(ply, oldTeam, newTeam)
  local isSpectator = newTeam == TEAM_SPECTATORS

  if (ROUND_STATE == NOT_ENOUGH_PLAYERS and (not isSpectator)) then
    AttemptToStartRound()
  end
end
