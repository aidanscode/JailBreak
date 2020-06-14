SpawnEntities = {}
SpawnEntities.Directory = 'spawn_entities'
SpawnEntities.GetCurrentMapPath = SpawnEntities.Directory .. '/' .. game.GetMap() .. '.json'

SpawnEntities.GetCurrentMapSpawns = function()
  if (not file.Exists(SpawnEntities.Directory, "DATA")) then
    file.CreateDir(SpawnEntities.Directory)
  end

  local fullPath = SpawnEntities.GetCurrentMapPath

  if (not file.Exists(fullPath, "DATA")) then
    return {} --just return an empty list, there are no spawns for the map at this point
  else
    local content = file.Read(fullPath, "DATA")
    return util.JSONToTable(content)
  end
end

SpawnEntities.UpdateCurrentMapSpawns = function(spawns)
  local content = util.TableToJSON(spawns)
  local path = SpawnEntities.GetCurrentMapPath
  file.Write(path, content)
end

SpawnEntities.SaveNewEntity = function(ent)
  local currentSpawns = SpawnEntities.GetCurrentMapSpawns()
  local name = ent:GetClass()
  if (not string.find(name, "weapon")) then
    name = ent:GetModel()
  end

  local newRecord = {
    pos = ent:GetPos(),
    ang = ent:GetAngles(),
    isWeapon = ent:IsWeapon()
  }

  if (newRecord.isWeapon) then
    newRecord.entity = ent:GetClass()
  else
    newRecord.entity = 'prop_physics'
    newRecord.model = ent:GetModel()
  end

  table.insert(currentSpawns, newRecord)
  SpawnEntities.UpdateCurrentMapSpawns(currentSpawns)
end

SpawnEntities.SpawnCurrentMapEntities = function()
  local entities = SpawnEntities.GetCurrentMapSpawns()

  for _, v in pairs(entities) do
    local ent = ents.Create(v.entity)
    ent:SetPos(v.pos)
    ent:SetAngles(v.ang)

    --Can't have ent:Spawn() outside of this if statement because
    --if the entity is not a weapon, we need to spawn it AFTER we set its model
    --and BEFORE we get its physics object. Any other order will cause errors
    --1) Entities can not be spawned without a model
    --2) An entity does not have a physics object before it is spawned
    if (v.isWeapon) then
      ent:Spawn()
    else
      ent:SetModel(v.model)
      ent:Spawn()

      local physObj = ent:GetPhysicsObject()
      if (IsValid(physObj)) then
        physObj:EnableMotion(false)
      else
      end
    end
  end
end
