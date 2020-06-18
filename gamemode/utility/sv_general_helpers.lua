Helpers = {}
Helpers.GetAllGamemodeMaps = function()
  local prefixes = {'ba_jail_', 'jb_'}
  local availableMaps = {}

  for _, prefix in pairs(prefixes) do
    local found = file.Find('maps/' .. prefix .. '*.bsp', 'MOD')
    table.Add(availableMaps, found)
  end

  return availableMaps
end

--Same as Helpers.GetAllGamemodeMaps except the current map is removed from the result
Helpers.GetAvailableNextMaps = function()
  local allMaps = Helpers.GetAllGamemodeMaps()

  table.RemoveByValue(allMaps, game.GetMap() .. '.bsp')

  return allMaps
end

Helpers.StripFileExtension = function(fileNameWithExtension)
  return string.Split(fileNameWithExtension, ".")[1]
end
