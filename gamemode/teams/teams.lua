--We need three teams
--1) Spectators
--2) Prisoners
--3) Guards
--Players should not be able to manually join the spectators team.
--They are placed in the spectators team when they join and moved out of it when they select a team

--Set up team constants
TEAM_SPECTATORS = 1
TEAM_PRISONERS = 2
TEAM_GUARDS = 3

function GM:CreateTeams()
  team.SetUp(TEAM_SPECTATORS, "Spectators", Color(255, 255, 255))

  team.SetUp(TEAM_PRISONERS, "Prisoners", Color(255, 0, 0))
  team.SetSpawnPoint(TEAM_PRISONERS, "info_player_terrorist")

  team.SetUp(TEAM_GUARDS, "Guards", Color(51, 51, 255))
  team.SetSpawnPoint(TEAM_PRISONERS, "info_player_counterterrorist")
end
