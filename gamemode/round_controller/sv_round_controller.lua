--At the start of the server, round state should be "Not enough players"
--We need at least one player on each
ROUND_STATE = NOT_ENOUGH_PLAYERS

--How long should each round be? In seconds
ROUND_MAX_LENGTH = 480 --(60 * 8), eight minutes. Following the LifePunch model for now

--How much time is left in the current round? No round has started yet so we'll set this to 0
ROUND_TIME_LEFT = 0

--game.CleanUpMap() to reset map
