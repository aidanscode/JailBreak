CommandUtils = {}

CommandUtils.IsCommand = function(str)
  if (#str == 0) then
    return false
  end

  local firstChar = string.sub(str, 1, 1)
  return firstChar == '!' or firstChar == '/'
end

CommandUtils.IsEmptyString = function(str)
  return string.Trim(str) == ""
end

CommandUtils.GetCommandBreakdown = function(str)
  local split = string.Split(str, " ")

  local name = string.lower(string.sub(split[1], 2))
  if (CommandUtils.IsEmptyString(name)) then
    return false, false
  end

  local args = {}
  for k, v in pairs(split) do
    if (k > 1 and not CommandUtils.IsEmptyString(v)) then
      table.insert(args, v)
    end
  end

  return name, args
end
