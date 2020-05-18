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

  if (not isSpectator and ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    timer.Simple(1, function()
      CheckAffectsRoundState()  -- this is in a timer because ply:Team() is still oldTeam at this point
                                -- need to delay our check so that ply:Team() returns the right val
    end )
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

  if (#spawnPoints == 0) then
    return ents.FindByClass("info_player_start")[1]
  else
    return spawnPoints[math.random(#spawnPoints)]
  end
end

local playerMeta = FindMetaTable("Player")
function playerMeta:EmulateRespawn()
  if (self:Alive()) then
    self:KillSilent()
  end
  self:UnSpectate()
  self:Spawn()
end
