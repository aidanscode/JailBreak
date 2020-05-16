--We need three teams
--1) Spectators
--2) Prisoners
--3) Guards
--Players should not be able to manually join the spectators team.
--They are placed in the spectators team when they join and moved out of it when they select a team

--Set up team constants
TEAM_SPECTATORS = {
  index = 1,
  name = "Spectators",
  color = Color(255, 255, 255)
}

TEAM_PRISONERS = {
  index = 2,
  name = "Prisoners",
  color = Color(255, 0, 0)
}

TEAM_GUARDS = {
  index = 3,
  name = "Guards",
  color = Color(0, 0, 255)
}

team.SetUp(TEAM_SPECTATORS['index'], TEAM_SPECTATORS['name'], TEAM_SPECTATORS['color'])
team.SetUp(TEAM_PRISONERS['index'], TEAM_PRISONERS['name'], TEAM_PRISONERS['color'])
team.SetUp(TEAM_GUARDS['index'], TEAM_GUARDS['name'], TEAM_GUARDS['color'])

--Define some friendy helper functions
local playerMeta = FindMetaTable("Player")

function playerMeta:IsSpectator()
  return self:Team() == TEAM_SPECTATORS['index']
end

function playerMeta:IsPrisoner()
  return self:Team() == TEAM_PRISONERS['index']
end

function playerMeta:IsGuard()
  return self:Team() == TEAM_GUARDS['index']
end
