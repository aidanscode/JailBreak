--At the start of the server, round state should be "Not enough players"
--We need at least one player on each team
ROUND_STATE = ROUND_STATE or NOT_ENOUGH_PLAYERS

--How long should each round be? In seconds
--ROUND_MAX_LENGTH = 600 --ten minutes
ROUND_MAX_LENGTH = 45 --45 seconds for development purposes

--Identifier for timer managing time left in the round
ROUND_TIMER_IDENTIFIER = "RoundTimer"

--How much time is left in this round? In seconds
ROUND_TIME_LEFT = ROUND_TIME_LEFT or 0


function AttemptToStartRound()
  local countNonSpectators = team.NumPlayers(TEAM_PRISONERS) + team.NumPlayers(TEAM_GUARDS)
  if ROUND_STATE == NOT_ENOUGH_PLAYERS and countNonSpectators > 1 then --We're good to go!
    ChangeRoundState(STARTING)
  end
end

function ShouldRoundEnd()
  if ROUND_STATE ~= IN_PROGRESS then return end
  local alivePrisoners = #GetAlivePlayersOnTeam(TEAM_PRISONERS)
  local aliveGuards = #GetAlivePlayersOnTeam(TEAM_GUARDS)

  if (aliveGuards == 0 or alivePrisoners == 0) then
    --The round is over, move timer to 0 and end
    timer.Remove(ROUND_TIMER_IDENTIFIER)
    ROUND_TIME_LEFT = 0

    --Figure out who won (if anyone)
    local winner = false
    if (aliveGuards > alivePrisoners) then
      winner = TEAM_GUARDS
    elseif (alivePrisoners > aliveGuards) then
      winner = TEAM_PRISONERS
    end
    ChangeRoundState(ENDING, winner)
  end
end

function CheckEnoughPlayers()
  local activePlayers = #GetAllActivePlayers()
  if (activePlayers < 2 and ROUND_STATE == NOT_ENOUGH_PLAYERS) then return false end --False but we're already in the right place so this ends here
  if (activePlayers > 1) then return true end

  --We don't have enough players
  ChangeRoundState(NOT_ENOUGH_PLAYERS)
  return false
end

util.AddNetworkString("SendPlayerRoundState")
function ChangeRoundState(newRoundState, winner)
  ROUND_STATE = newRoundState

  BroadcastRoundState()

  if (ROUND_STATE == ENDING) then
    hook.Call("RoundStateChange", nil, ROUND_STATE, winner)
  else
    hook.Call("RoundStateChange", nil, ROUND_STATE)
  end
end

function BroadcastRoundState()
  net.Start("SendPlayerRoundState")
    net.WriteInt(ROUND_STATE, 4)
    net.WriteInt(ROUND_TIME_LEFT, 32)
  net.Broadcast()
end

local playerMeta = FindMetaTable("Player")
function playerMeta:SendRoundState()
  net.Start("SendPlayerRoundState")
    net.WriteInt(ROUND_STATE, 4)
    net.WriteInt(ROUND_TIME_LEFT, 32)
  net.Send(self)
end

function CheckAffectsRoundState()
  if (not CheckEnoughPlayers()) then return end

  if (ROUND_STATE == IN_PROGRESS) then
    ShouldRoundEnd()
  elseif (ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    AttemptToStartRound()
  end
end

function GM:PlayerDisconnected(ply)
  timer.Simple(1/2, function()
    CheckAffectsRoundState()  --Need to delay this logic
                              --because the player is still on the server when this function is called
  end )
end

function GM:PostPlayerDeath(ply)
  if (ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    ply:Spawn()
  elseif (ROUND_STATE ~= STARTING) then
    ply:Spectate(OBS_MODE_ROAMING)
    CheckAffectsRoundState()
  end
end

function GM:PlayerDeathThink(ply)
  if (ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    return true
  else
    return false
  end
end
