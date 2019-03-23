local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
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

	local unshiftedScalePattern = getScalePattern(scaleTonicNote(), scales[scaleType()])
	local scalePattern = shiftTable(unshiftedScalePattern, scaleTonicNote())

	local myOutputString = ""
	for i = 1, 12 do

		if scalePattern[i] then
			myOutputString = myOutputString .. "1"
		else
			myOutputString = myOutputString .. "0"
		end
	end

	for octave = minOctave, maxOctave do

		local noteIndex = 1 
		for i = 1, #scalePattern do

			if scalePattern[i] then

				if noteIndex == 8 then
				end

				local pitch = i-1 + (octave+1)*12 + scaleTonicNote()-1
				setNoteName(track, pitch, noteNames[noteIndex])
				noteIndex = noteIndex + 1
			end
		end
	end
end

local function setDrumNoteNamesForGeneralMidi(track)

	setNoteName(track, 35, "acoustic bass drum")
	setNoteName(track, 36, "bass drum 1")
	setNoteName(track, 37, "side stick")
	setNoteName(track, 38, "acoustic snare")
	setNoteName(track, 39, "hand clap")
	setNoteName(track, 40, "electric snare")
	setNoteName(track, 41, "low floor")
	setNoteName(track, 42, "closed hihat")
	setNoteName(track, 43, "high floor")
	setNoteName(track, 44, "pedal hihat")
	setNoteName(track, 45, "low")
	setNoteName(track, 46, "open hihat")
	setNoteName(track, 47, "low-mid")
	setNoteName(track, 48, "hi-mid")
	setNoteName(track, 49, "crash cymbal 1")
	setNoteName(track, 50, "high")
	setNoteName(track, 51, "ride cymbal 1")
	setNoteName(track, 52, "chinese cymbal")
	setNoteName(track, 53, "ride bell")
	setNoteName(track, 54, "tambourine")
	setNoteName(track, 55, "splash cymbal")
	setNoteName(track, 56, "cowbell")
	setNoteName(track, 57, "crash cymbal 2")
	setNoteName(track, 58, "vibraslap")
	setNoteName(track, 59, "ride cymbal 2")
	setNoteName(track, 60, "hi bongo")
	setNoteName(track, 61, "low bongo")
	setNoteName(track, 62, "mute hi conga")
	setNoteName(track, 63, "open hi conga")
	setNoteName(track, 64, "low conga")
	setNoteName(track, 65, "high timbale")
	setNoteName(track, 66, "low timbale")
	setNoteName(track, 67, "high agogo")
	setNoteName(track, 68, "low agogo")
	setNoteName(track, 69, "cabasa")
	setNoteName(track, 70, "maracas")
	setNoteName(track, 71, "short whistle")
	setNoteName(track, 72, "long whistle")
	setNoteName(track, 73, "short guiro")
	setNoteName(track, 74, "long guiro")
	setNoteName(track, 75, "claves")
	setNoteName(track, 76, "hi wood block")
	setNoteName(track, 77, "low wood block")
	setNoteName(track, 78, "mute cuica")
	setNoteName(track, 79, "open cuica")
	setNoteName(track, 80, "mute triangle")
	setNoteName(track, 81, "open triangle")
end

local function setDrumNoteNamesForSimpleDrums(track)

	setNoteName(track, 0, "kick")
	setNoteName(track, 1, "snare")
	setNoteName(track, 2, "snareflam")
	setNoteName(track, 3, "hihat")
	setNoteName(track, 4, "hihat_semiopen")
	setNoteName(track, 5, "hihat_pedal")
	setNoteName(track, 6, "hihat_open")
	setNoteName(track, 7, "hihat_closed")
	setNoteName(track, 8, "crash")
	setNoteName(track, 9, "china")
	setNoteName(track, 10, "ride")
	setNoteName(track, 11, "ride_edge")
	setNoteName(track, 12, "ride_cup")
	setNoteName(track, 13, "tom1")
	setNoteName(track, 14, "tom2")
	setNoteName(track, 15, "tom3")
	setNoteName(track, 16, "tom4")
end

local function setDrumNoteNamesForMXRDrumComputer(track)

	setNoteName(track, 0, "kick")
	setNoteName(track, 1, "snare")
	setNoteName(track, 2, "rimshot")
	setNoteName(track, 3, "clap")
	setNoteName(track, 4, "hihat_closed")
	setNoteName(track, 5, "hihat_open")
	setNoteName(track, 6, "crash")
	setNoteName(track, 7, "tom1")
	setNoteName(track, 8, "tom2")
	setNoteName(track, 9, "tom3")
	setNoteName(track, 10, "woodblock")
	setNoteName(track, 11, "cowbell")
end

function updateNoteNames()

	clearAllNoteNames()

	local track = reaper.GetMediaItemTake_Track(activeTake())
	local _, trackName = reaper.GetTrackName(track, "")

	if trackName == "drumsGM" then
		setDrumNoteNamesForGeneralMidi(track)
	elseif trackName == "drums" then
--		setDrumNoteNamesForSimpleDrums(track)
		setDrumNoteNamesForMXRDrumComputer(track)
	elseif trackName == "bass" then
		setRomanNumeralNoteNames(track, 0, 4)
	elseif trackName ~= "drums" then
		setRomanNumeralNoteNames(track, 1, 5)
	end
end