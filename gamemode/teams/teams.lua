--Set up team constants

TEAM_SPECTATORS = 1
TEAM_PRISONERS = 2
TEAM_GUARDS = 3

TEAM_PRISONERS_MODELS = {
  "models/player/Group01/male_01.mdl",
  "models/player/Group01/male_02.mdl",
  "models/player/Group01/male_03.mdl",
  "models/player/Group01/male_04.mdl",
  "models/player/Group01/male_05.mdl",
  "models/player/Group01/male_06.mdl",
  "models/player/Group01/male_07.mdl",
  "models/player/Group01/male_08.mdl",
  "models/player/Group01/male_09.mdl"
}

TEAM_GUARDS_MODELS = {
  "models/player/odessa.mdl"
}
WARDEN_MODEL = "models/player/gman_high.mdl"

TEAM_PRISONERS_LOADOUT = {
  ["weapon_knife"] = 3
}

TEAM_GUARDS_LOADOUT = {
  ["weapon_knife"] = 1,
  ["weapon_deagle"] = 1,
  ["weapon_m4a1"] = 1
}

DESIRED_GUARD_TO_PRISONER_RATIO = 0.25 -- 1/4 (One guard for every four prisoners, rounding up)

function GM:CreateTeams()
  team.SetUp(TEAM_SPECTATORS, "Spectators", Color(255, 255, 255))

  team.SetUp(TEAM_PRISONERS, "Prisoners", Color(255, 0, 0))
  team.SetSpawnPoint(TEAM_PRISONERS, "info_player_terrorist")

  team.SetUp(TEAM_GUARDS, "Guards", Color(51, 51, 255))
  team.SetSpawnPoint(TEAM_PRISONERS, "info_player_counterterrorist")
end
