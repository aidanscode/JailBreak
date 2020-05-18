local function NotEnoughPlayers()
end

local function Starting()
  game.CleanUpMap()
  --autoBalanceTeams()

  for _, ply in pairs(GetAllActivePlayers()) do
    ply:EmulateRespawn()
    ply:Give("weapon_stunstick")
  end

  timer.Simple(1, function()
    ChangeRoundState(IN_PROGRESS)
  end )
end

local function InProgress()
 --do stuff
end

local function Ending()
  timer.Simple(5, function()
    ChangeRoundState(STARTING)
  end )
end

local function Dispatcher(newRoundState)
  if (newRoundState == NOT_ENOUGH_PLAYERS) then
    NotEnoughPlayers()
  elseif (newRoundState == STARTING) then
    Starting()
  elseif (newRoundState == IN_PROGRESS) then
    InProgress()
  elseif (newRoundState == ENDING) then
    Ending()
  end
end

hook.Add("RoundStateChange", "RoundStateChangeHandler", Dispatcher)
