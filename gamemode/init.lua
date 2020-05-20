AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

AddCSLuaFile("rounds/round_states.lua")
AddCSLuaFile("rounds/cl_round_state_keeper.lua")
include("rounds/round_states.lua")
include("rounds/sv_round_state_keeper.lua")
include("rounds/sv_round_state_change_handler.lua")

AddCSLuaFile("teams/teams.lua")
include("teams/teams.lua")
include("teams/sv_teams.lua")

AddCSLuaFile("utility/player_helpers.lua")
include("utility/player_helpers.lua")
include("utility/sv_round_helpers.lua")

include("event_hooks/sv_gamemode_hooks.lua")

AddCSLuaFile("ui/cl_hud.lua")
AddCSLuaFile('ui/cl_team_selection.lua')

--This allows me to easily add a bot to the game that I can test with
--Only here for dev purposes, will be removed eventually
local bot = nil
hook.Add("PlayerSay", "erfg", function(ply, text)
  if (bot == nil) then
    bot = player.CreateNextBot(text)
    bot:SetTeam(TEAM_PRISONERS)
  else
    bot:Kick(text)
  end
end )
