local function GetGuardToPrisonerRatio()
  local prisonerCount = team.NumPlayers(TEAM_PRISONERS)
  local guardCount = team.NumPlayers(TEAM_GUARDS)

  --Protect against divide by 0 errors
  if (prisonerCount == 0) then
    return 0
  end

  local actualRatio = guardCount / prisonerCount

  return actualRatio, guardCount, prisonerCount
end

local function SwapRandomPlayer(FROM_TEAM, TO_TEAM)
  local teamPlayers = team.GetPlayers(FROM_TEAM)
  local ply = teamPlayers[math.random(#teamPlayers)]

  ply:SetTeam(TO_TEAM)
end

--[[
  Explanation of the team balancing logic:
  We want to have as few guards as possible
  While still having the ACTUAL guard/prisoner ratio
  >= the DESIRED guard/prisoner ratio
  (as defined in teams/teams.lua)
]]--
function AutoBalanceTeams()
  local desiredRatio = DESIRED_GUARD_TO_PRISONER_RATIO
  local actualRatio, guardCount, prisonerCount = GetGuardToPrisonerRatio()

  if (actualRatio < desiredRatio) then --We need more guards! Swap a prisoner over
    SwapRandomPlayer(TEAM_PRISONERS, TEAM_GUARDS)

    --Check if we have enough now
    AutoBalanceTeams()
  else
    --At this point we know we have >= the desired ratio
    --So let's check the math. Can we move a guard over to prisoners and still meet our desired ratio (>=)?
    if (((guardCount - 1) / (prisonerCount + 1)) >= desiredRatio) then
      --We have more than enough guards! Swap a random guard over
      SwapRandomPlayer(TEAM_GUARDS, TEAM_PRISONERS)

      --Check if we still have too many guards
      AutoBalanceTeams()
    end
  end
end
