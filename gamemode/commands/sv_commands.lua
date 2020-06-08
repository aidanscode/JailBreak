Commands = {}

Commands.AttemptToExecute = function(sender, name, args)
  sender:ChatPrint("Hey, got your request for a command")
  sender:ChatPrint(name)
  sender:ChatPrint(table.ToString(args))
  sender:ChatPrint("Not implemented yet")
  --TODO
  --Have a way of registering/defining commands and their handlers
  --This function will find and execute the desired handler if exists, otherwise simply tell the sender the command does not exist
end
