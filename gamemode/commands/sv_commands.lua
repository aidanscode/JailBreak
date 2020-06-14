Commands = {}
Commands.commands = {}
Commands.FindCommand = function(name)
  local command = nil

  for _, v in pairs(Commands.commands) do
    if (v.name == name) then
      command = v
      break
    end
  end

  return command
end

Commands.AttemptToExecute = function(sender, name, args)
  local command = Commands.FindCommand(name)

  if (command != nil) then
    command.handler(sender, args)
  else
    sender:ChatPrint('Unrecognized command!')
  end
end

local wardenCommand = {}
wardenCommand.name = "warden"
wardenCommand.handler = function(sender, args)
  if (ROUND_STATE != IN_PROGRESS) then
    sender:ChatPrint('You can only become the warden while the round is in progress!')
    return
  end

  if (CURRENT_WARDEN != nil) then
    sender:ChatPrint('There is already a warden this round!')
    return
  end

  --We'll eventually also prevent a player from going warden after a certain amount of time has passed in the round (ex: first minute)

  sender:MakeWarden()
end
table.insert(Commands.commands, wardenCommand)

local spawnCommand = {}
spawnCommand.name = "spawn"
spawnCommand.handler = function(sender, args)
  if (not sender:HasWeapon("weapon_physgun")) then
    sender:Give("weapon_physgun")
  end

  local entity = args[1]
  local model = nil
  if (entity == null) then
    sender:ChatPrint('Please supply an entity to spawn')
    return
  end

  if (not string.find(entity, "weapon")) then
    model = entity
    entity = 'prop_physics'
  end

  local trace = sender:GetEyeTrace()
  if (trace.HitSky) then
    sender:ChatPrint('You\'re looking at the sky, brother')
  else
    local pos = trace.HitPos
    local ent = ents.Create(entity)

    if (not IsValid(ent)) then
      sender:ChatPrint('Invalid entity entered!')
    else
      ent:SetPos(pos)
      if (model) then
        ent:SetModel(model)
      end

      ent:Spawn()
    end
  end

end
table.insert(Commands.commands, spawnCommand)
