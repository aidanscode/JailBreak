local function NotEnoughPlayers()
  --End round timer
  if (timer.Exists(ROUND_TIMER_IDENTIFIER)) then
    timer.Remove(ROUND_TIMER_IDENTIFIER)
    ROUND_TIME_LEFT = 0
    BroadcastRoundState()
  end

  --Respawn anyone not alive
  for _, ply in pairs(GetAllActivePlayers()) do
    ply:ForceRespawn()
  end
end

local function Starting()
  game.CleanUpMap()
  --autoBalanceTeams()

  --Set the round timer (without starting)
  ROUND_TIME_LEFT = ROUND_MAX_LENGTH

  for _, ply in pairs(GetAllActivePlayers()) do
    ply:ForceRespawn()
  end

  timer.Simple(1, function()
    --Double check just in case the round state changed to NOT_ENOUGH_PLAYERS while this timer was waiting
    if (ROUND_STATE == STARTING) then
      ChangeRoundState(IN_PROGRESS)
    end
  end )
end

local function InProgress()
  timer.Create(ROUND_TIMER_IDENTIFIER, 1, ROUND_TIME_LEFT, function()
    if (ROUND_STATE == IN_PROGRESS) then
      ROUND_TIME_LEFT = ROUND_TIME_LEFT - 1 --every second, subtract round time left by 1 second
      BroadcastRoundState() --Send users the new official time left

      if (ROUND_TIME_LEFT == 0) then
        ChangeRoundState(ENDING, false)
      end
    end
  end )
end

local function Ending(winner)
  if (winner == nil or winner == false) then
    PrintMessage(HUD_PRINTTALK, "It's a tie! Nobody wins")
  else
    PrintMessage(HUD_PRINTTALK, "The winner is: " .. team.GetName(winner))
  end

  timer.Simple(5, function()
    --Double check just in case the round state changed to NOT_ENOUGH_PLAYERS while this timer was waiting
    if (ROUND_STATE == ENDING) then
      ChangeRoundState(STARTING)
    end
  end )
end

local function Dispatcher(newRoundState, winner)
  if (newRoundState == NOT_ENOUGH_PLAYERS) then
    NotEnoughPlayers()
  elseif (newRoundState == STARTING) then
    Starting()
  elseif (newRoundState == IN_PROGRESS) then
    InProgress()
  elseif (newRoundState == ENDING) then
    Ending(winner)
  end
end

hook.Add("RoundStateChange", "RoundStateChangeHandler", Dispatcher)
