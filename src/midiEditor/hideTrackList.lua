local commandId = 40818

local function trackListIsVisible()

	local midiEditorSectionId = 32060
	local state = reaper.GetToggleCommandStateEx(midiEditorSectionId, commandId)

	return state == 1
end

local function toggleShowHideTrackList()

	reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

function hideTrackList()

	if trackListIsVisible() then
		toggleShowHideTrackList()
	end
end