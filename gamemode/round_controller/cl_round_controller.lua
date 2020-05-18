--We don't know what the round state is when we join
ROUND_STATE = ROUND_STATE or nil
ROUND_TIME_LEFT = ROUND_TIME_LEFT or 0

net.Receive("SendPlayerRoundState", function()
  ROUND_STATE = net.ReadInt(4)
  ROUND_TIME_LEFT = net.ReadInt(32)
end )
