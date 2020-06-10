--We don't know anything about the current state of the round when we join, set to nil/0
ROUND_STATE = ROUND_STATE or nil
ROUND_TIME_LEFT = ROUND_TIME_LEFT or 0
CURRENT_WARDEN = nil

net.Receive("SendPlayerRoundState", function()
  ROUND_STATE = net.ReadInt(4)
  ROUND_TIME_LEFT = net.ReadInt(32)
end )

net.Receive("SendPlayerCurrentWarden", function()
  local entity = net.ReadEntity()
  if (IsValid(entity)) then
    CURRENT_WARDEN = entity
  else
    CURRENT_WARDEN = nil
  end
end )
