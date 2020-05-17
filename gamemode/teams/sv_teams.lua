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

--I set the teams' acceptable spawn classes in teams.lua but that doesn't seem to work
--Even though I set GM.TeamBased to true like the gmod wiki says to
--So we're doing this manually for now
function GM:PlayerSelectSpawn(ply)
  local spawnPoints = nil
  if (ply:IsPrisoner()) then
    spawnPoints = ents.FindByClass("info_player_terrorist")
  else
    spawnPoints = ents.FindByClass("info_player_counterterrorist")
  end

  return spawnPoints[math.random(#spawnPoints)]
end
