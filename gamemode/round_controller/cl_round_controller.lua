--We don't know what the round state is when we join
ROUND_STATE = ROUND_STATE or nil

net.Receive("SendPlayerRoundState", function()
  ROUND_STATE = net.ReadInt(4)
end )
