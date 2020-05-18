--At the start of the server, round state should be "Not enough players"
--We need at least one player on each team
ROUND_STATE = ROUND_STATE or NOT_ENOUGH_PLAYERS

--How long should each round be? In seconds
--ROUND_MAX_LENGTH = 600 --ten minutes
ROUND_MAX_LENGTH = 45 --45 seconds for development purposes

--How much time is left in the current round? No round has started yet so we'll set this to 0
ROUND_TIME_LEFT = 0

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

  --We'll also check the round timer here but I haven't implemented that yet
  --Now that I think about it, maybe this shouldn't check the round timer since that will end whenever it ends and automatically change the round state?
  --TBD
  if (aliveGuards == 0 or alivePrisoners == 0) then
    ChangeRoundState(ENDING)
  end
end

util.AddNetworkString("SendPlayerRoundState")
function ChangeRoundState(newRoundState)
  ROUND_STATE = newRoundState

  net.Start("SendPlayerRoundState")
    net.WriteInt(ROUND_STATE, 4)
  net.Broadcast()

  hook.Call("RoundStateChange", nil, ROUND_STATE)
end

local playerMeta = FindMetaTable("Player")
function playerMeta:SendRoundState()
  net.Start("SendPlayerRoundState")
    net.WriteInt(ROUND_STATE, 4) --4 bits, gives us a max value of 7
  net.Send(self)
end

function CheckAffectsRoundState()
  if (ROUND_STATE == IN_PROGRESS) then
    ShouldRoundEnd()
  elseif (ROUND_STATE == NOT_ENOUGH_PLAYERS) then
    AttemptToStartRound()
  end
end

function GM:PlayerDisconnected(ply)
  CheckAffectsRoundState()
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
