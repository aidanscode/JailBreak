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
