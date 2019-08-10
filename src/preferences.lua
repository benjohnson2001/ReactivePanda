local activeProjectIndex = 0
local sectionName = "com.pandabot.ChordGun"

local scaleTonicNoteKey = "scaleTonicNote"
local scaleTypeKey = "scaleType"

--
local function getValue(key)

  local valueExists, value = reaper.GetProjExtState(activeProjectIndex, sectionName, key)
  return value
end

--[[ ]]--

function scaleTonicNote()

	local scaleTonicNoteValue = tonumber(getValue(scaleTonicNoteKey))

	if scaleTonicNoteValue == nil then
		return 1
	end

  return scaleTonicNoteValue
end

--

function scaleType()

	local scaleTypeValue = tonumber(getValue(scaleTypeKey))

	if scaleTypeValue == nil then
		return 1
	end

  return scaleTypeValue
end
