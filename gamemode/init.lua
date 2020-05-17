AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

AddCSLuaFile("round_controller/cl_round_controller.lua")
include("round_controller/sv_round_controller.lua")

AddCSLuaFile("teams/teams.lua")
include("teams/teams.lua")
include("teams/sv_teams.lua")

AddCSLuaFile("ui/cl_team_selection.lua")

AddCSLuaFile("ui/cl_hud.lua")

function GM:PlayerInitialSpawn(ply)
  ply:SetTeam(TEAM_SPECTATORS)
  ply:SendRoundState()
end

function GM:PlayerSpawn(ply)
  if (ply:IsSpectator()) then
    ply:Spectate(OBS_MODE_ROAMING)
    ply:ConCommand("select_team")
  end
end
