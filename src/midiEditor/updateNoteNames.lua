local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/util")

local function clearAllNoteNames()

	local commandId = 40412
	reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

local function setNoteName(track, pitch, name)

	local activeProjectIndex = 0
	local allChannels = -1
	reaper.SetTrackMIDINoteNameEx(activeProjectIndex, track, pitch, allChannels, name)
end

local function setRomanNumeralNoteNames(track, minOctave, maxOctave)

	local noteNames = {"I", "II", "III", "IV", "V", "VI", "VII"}
	
	local scalePattern = getScalePattern(scaleTonicNote(), scales[scaleType()])
	shiftTable(scalePattern, scaleTonicNote()-1)

	for octave = minOctave, maxOctave do

		local noteIndex = 1 
		for i = 1, #scalePattern do

			if scalePattern[i] then

				local pitch = i-1 + (octave+1)*12 + scaleTonicNote()-1

				setNoteName(track, pitch, noteNames[noteIndex])
				noteIndex = noteIndex + 1
			end
		end
	end
end

function updateNoteNames()

	--clearAllNoteNames()

	local track = reaper.GetMediaItemTake_Track(activeTake())
	local _, trackName = reaper.GetTrackName(track, "")

	if trackName == "bass" or trackName == "tele" or trackName == "strat" or trackName == "vocals" then
		setRomanNumeralNoteNames(track, 2, 5)
	end	

	if trackName == "drums" then
		--setRomanNumeralNoteNamesForDrums(track)
	end
end