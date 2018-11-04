-- @noindex

local activeProjectIndex = 0
local sectionName = "com.pandabot.ChordGun"

local scaleTonicNoteKey = "scaleTonicNote"
local scaleTypeKey = "scaleType"

--
local function getValue(key, defaultValue)

  local valueExists, value = reaper.GetProjExtState(activeProjectIndex, sectionName, key)
  return value
end

--

--[[ ]]--

function scaleTonicNote()
  return tonumber(getValue(scaleTonicNoteKey, defaultScaleTonicNoteValue))
end

--

function scaleType()
  return tonumber(getValue(scaleTypeKey, defaultScaleTypeValue))
end
