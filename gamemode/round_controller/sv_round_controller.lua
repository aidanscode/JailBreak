--game.CleanUpMap() to reset map
--At the start of the server, round state should be "Not enough players"
--We need at least one player on each team
ROUND_STATE = NOT_ENOUGH_PLAYERS

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

util.AddNetworkString("SendPlayerRoundState")
function ChangeRoundState(newRoundState)
  ROUND_STATE = newRoundState

  net.Start("SendPlayerRoundState")
    net.WriteInt(ROUND_STATE, 4)
  net.Broadcast()
end

local playerMeta = FindMetaTable("Player")
function playerMeta:SendRoundState()
  net.Start("SendPlayerRoundState")
    net.WriteInt(ROUND_STATE, 4) --4 bits, gives us a max value of 7
  net.Send(self)
end
