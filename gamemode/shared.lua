GM.Name = "JailBreak"
GM.Author = "Zee"
GM.Website = "aidanmurphey.com"

function GM:Initialize()

end

--Round status constants
NOT_ENOUGH_PLAYERS = 1
STARTING = 2
IN_PROGRESS = 3
ENDING = 4

--Round status names
ROUND_STATE_STRINGS = {
  [NOT_ENOUGH_PLAYERS] = "Not Enough Players",
  [STARTING] = "Starting",
  [IN_PROGRESS] = "In Progress",
  [ENDING] = "Ending"
}
