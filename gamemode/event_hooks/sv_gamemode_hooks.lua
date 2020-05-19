function GM:PlayerInitialSpawn(ply)
  ply:SetTeam(TEAM_SPECTATORS)
  ply:SendRoundState()
end

function GM:PlayerSpawn(ply)
  if (ply:IsSpectator()) then
    ply:Spectate(OBS_MODE_ROAMING)
    ply:ConCommand("select_team")
  end
end

--[[
  I set the teams' acceptable spawn classes in teams.lua but that doesn't seem to work
  Even though I set GM.TeamBased to true like the gmod wiki says to (Gmod bug?)
  So we're doing this manually for now
]]--
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

function GM:PlayerChangedTeam(ply, oldTeam, newTeam)
  local isSpectator = newTeam == TEAM_SPECTATORS

  if (not isSpectator and ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    timer.Simple(1, function()
      CheckAffectsRoundState()  -- this is in a timer because ply:Team() is still oldTeam at this point
                                -- need to delay our check so that ply:Team() returns the right val
    end )
  end
end

function GM:PostPlayerDeath(ply)
  if (ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    ply:Spawn()
  elseif (ROUND_STATE ~= STARTING) then
    ply:Spectate(OBS_MODE_ROAMING)
    CheckAffectsRoundState()
  end
end

--[[
  This function decides whether a player will respawn by hitting space/clicking when they're dead
  Returns true allows it, return false denies it
  We only want to allow this if the round state is NOT_ENOUGH_PLAYERS
]]--
function GM:PlayerDeathThink(ply)
  return ROUND_STATE == NOT_ENOUGH_PLAYERS
end

function GM:PlayerDisconnected(ply)
  timer.Simple(1/2, function()
    CheckAffectsRoundState()  --Need to delay this function call
                              --because the player is still on the server when GM:PlayerDisconnected is called
  end )
end
