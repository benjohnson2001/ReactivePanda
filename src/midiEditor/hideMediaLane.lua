local commandId = 40819

local function mediaLaneIsVisible()

	local midiEditorSectionId = 32060
	local state = reaper.GetToggleCommandStateEx(midiEditorSectionId, commandId)

	return state == 1
end

local function toggleShowHideMediaLane()

	reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

function hideMediaLane()

	if mediaLaneIsVisible() then
		toggleShowHideMediaLane()
	end
end