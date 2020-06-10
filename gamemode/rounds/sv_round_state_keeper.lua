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

--Who is the warden?
CURRENT_WARDEN = CURRENT_WARDEN or nil
