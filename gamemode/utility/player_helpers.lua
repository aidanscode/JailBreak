playerMeta = FindMetaTable("Player")

function playerMeta:IsSpectator()
  return self:Team() == TEAM_SPECTATORS
end

function playerMeta:IsPrisoner()
  return self:Team() == TEAM_PRISONERS
end

function playerMeta:IsGuard()
  return self:Team() == TEAM_GUARDS
end

function GetAllActivePlayers()
  local prisoners = team.GetPlayers(TEAM_PRISONERS)
  local guards = team.GetPlayers(TEAM_GUARDS)

  return table.Add(prisoners, guards)
end

function GetAlivePlayersOnTeam(TEAM_CODE)
  local list = {}
  for _, ply in pairs(team.GetPlayers(TEAM_CODE)) do
    if (ply:Alive()) then
      table.insert(list, ply)
    end
  end

  return list
end

if (SERVER) then
  util.AddNetworkString("SendPlayerRoundState")
  function playerMeta:SendRoundState()
    net.Start("SendPlayerRoundState")
      net.WriteInt(ROUND_STATE, 4)
      net.WriteInt(ROUND_TIME_LEFT, 32)
    net.Send(self)
  end

  function BroadcastRoundState()
    net.Start("SendPlayerRoundState")
      net.WriteInt(ROUND_STATE, 4)
      net.WriteInt(ROUND_TIME_LEFT, 32)
    net.Broadcast()
  end

  --[[
    This function "respawns" a player
    If the given player is already alive, they're silently killed then spawned
    If the player is not alive, they are simply respawned
    In either case, UnSpectate() is called because the gamemode may put the player into spectate mode on death depending on the round state
  ]]--
  function playerMeta:ForceRespawn()
    if (self:Alive()) then
      self:KillSilent()
    end
    self:UnSpectate()
    self:Spawn()
  end

end
