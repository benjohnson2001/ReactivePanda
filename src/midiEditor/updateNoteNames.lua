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

local function setLeadArticulationNoteNames(track)

	setNoteName(track, 24, "sustain")
	setNoteName(track, 25, "mute")
	setNoteName(track, 26, "power chord sustain")
	setNoteName(track, 27, "power chord mute")
	setNoteName(track, 28, "staccato")
	setNoteName(track, 29, "staccato snap")
	setNoteName(track, 30, "choke")
	setNoteName(track, 31, "tapping")
	setNoteName(track, 32, "harmonics")
	setNoteName(track, 33, "tremelo")
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

local function setDrumNoteNameFor(track, drumName)

	for i = 0, 126 do
		local noteName = drumName .. (i+1)
		setNoteName(track, i, noteName)
  end
end

local function setDrumNoteNamesForKick(track)
	setDrumNoteNameFor(track, "kick")
end

local function setDrumNoteNamesForSnare(track)
	setDrumNoteNameFor(track, "snare")
end

local function setDrumNoteNamesForClosedHihat(track)
	setDrumNoteNameFor(track, "hihat_closed")
end

local function setDrumNoteNamesForOpenHihat(track)
	setDrumNoteNameFor(track, "hihat_open")
end

local function setDrumNoteNamesForStevenSlateDrums(track)

	setNoteName(track, 93, "china bow")
	setNoteName(track, 92, "crash R bow")
	setNoteName(track, 91, "crash L bow")
	setNoteName(track, 90, "splash bow")

	setNoteName(track, 73, "hihat footsplash")
	setNoteName(track, 72, "hihat pedal")

	setNoteName(track, 71, "hihat open tip")
	setNoteName(track, 70, "hihat 4/5 tip")
	setNoteName(track, 69, "hihat 3/5 tip")
	setNoteName(track, 68, "hihat 2/5 tip")
	setNoteName(track, 67, "hihat 1/5 tip")
	setNoteName(track, 66, "hihat closed tip")

	setNoteName(track, 65, "hihat open shank")
	setNoteName(track, 64, "hihat 4/5 shank")
	setNoteName(track, 63, "hihat 3/5 shank")
	setNoteName(track, 62, "hihat 2/5 shank")
	setNoteName(track, 61, "hihat 1/5 shank")
	setNoteName(track, 60, "hihat closed shank")

	setNoteName(track, 59, "ride edge")
	setNoteName(track, 58, "ride choke")

	setNoteName(track, 57, "crash R edge")
	setNoteName(track, 56, "crash R choke")
	setNoteName(track, 55, "crash L edge")
	setNoteName(track, 54, "crash L choke")

	setNoteName(track, 53, "ride bell")
	setNoteName(track, 52, "ride bow shank")
	setNoteName(track, 51, "ride bow tip")

	setNoteName(track, 50, "splash edge")
	setNoteName(track, 49, "splash choke")
	
	setNoteName(track, 48, "tom1")
	setNoteName(track, 47, "tom2")
	setNoteName(track, 43, "tom3")
	setNoteName(track, 41, "tom4")

	setNoteName(track, 40, "snare rimshot")
	setNoteName(track, 39, "snare rimclick")
	setNoteName(track, 38, "snare center")
	setNoteName(track, 37, "snare sidestick")

	setNoteName(track, 36, "kick")
	setNoteName(track, 35, "kick double")
	
	setNoteName(track, 34, "snare side")
	setNoteName(track, 33, "snare rimshot edge")

	setNoteName(track, 32, "china choke")
	setNoteName(track, 31, "china edge")
	
	setNoteName(track, 21, "snare rolls")
	
	--[[
	setNoteName(track, 19, "tom1 rimclick")
	setNoteName(track, 17, "tom2 rimclick")
	setNoteName(track, 14, "tom3 rimclick")
	setNoteName(track, 12, "tom4 rimclick")
	]]--
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

local function setDrumNoteNamesForRealidrums(track)

	setNoteName(track, 21, "kick")
	setNoteName(track, 22, "snare")
	setNoteName(track, 23, "snare alt")
	setNoteName(track, 24, "hihat closed")
	setNoteName(track, 25, "hihat foot")
	setNoteName(track, 26, "hihat semiopen")
	setNoteName(track, 27, "hihat open")
	setNoteName(track, 28, "ride 1")
	setNoteName(track, 29, "ride 2")
	setNoteName(track, 30, "ride 3")
	setNoteName(track, 31, "tom low")
	setNoteName(track, 32, "tom mid")
	setNoteName(track, 33, "tom high")
	setNoteName(track, 34, "crash 1")
	setNoteName(track, 35, "crash 2")
	setNoteName(track, 36, "crash 3")
	setNoteName(track, 37, "crash 4")
	setNoteName(track, 38, "percussion 1")
	setNoteName(track, 39, "percussion 2")
	setNoteName(track, 40, "percussion 3")
	setNoteName(track, 41, "sidestick")
	setNoteName(track, 42, "brush sweep")
end

local function setDrumNoteNamesForRealidrumsFull(track)

	setNoteName(track, 21, "kick")
	setNoteName(track, 22, "snare")
	setNoteName(track, 23, "snare alt")
	setNoteName(track, 24, "hihat closed")
	setNoteName(track, 25, "hihat foot")
	setNoteName(track, 26, "hihat semiopen")
	setNoteName(track, 27, "hihat open")
	setNoteName(track, 28, "ride 1")
	setNoteName(track, 29, "ride 2")
	setNoteName(track, 30, "ride 3")
	setNoteName(track, 31, "tom low")
	setNoteName(track, 32, "tom mid")
	setNoteName(track, 33, "tom high")
	setNoteName(track, 34, "crash 1")
	setNoteName(track, 35, "crash 2")
	setNoteName(track, 36, "crash 3")
	setNoteName(track, 37, "crash 4")
	setNoteName(track, 38, "percussion 1")
	setNoteName(track, 39, "percussion 2")
	setNoteName(track, 40, "percussion 3")
	setNoteName(track, 41, "sidestick")
	setNoteName(track, 42, "brush sweep")

	setNoteName(track, 43, "fill 1")
	setNoteName(track, 44, "fill 2")
	setNoteName(track, 45, "fill 3")
	setNoteName(track, 46, "fill 4")
	setNoteName(track, 47, "fill 5")
	setNoteName(track, 48, "fill 6")
	setNoteName(track, 49, "fill 7")
	setNoteName(track, 50, "fill 8")
	setNoteName(track, 51, "fill 9")
	setNoteName(track, 52, "fill 10")
	setNoteName(track, 53, "fill 11")
	setNoteName(track, 54, "fill 12")
	setNoteName(track, 55, "fill 13")
	setNoteName(track, 56, "fill 14")
	setNoteName(track, 57, "fill 15")
	setNoteName(track, 58, "fill 16")
	setNoteName(track, 59, "fill 17")
	setNoteName(track, 60, "fill 18")
	setNoteName(track, 61, "fill 19")
	setNoteName(track, 62, "fill 20")
	setNoteName(track, 63, "fill 21")
	setNoteName(track, 64, "fill 22")
	setNoteName(track, 65, "fill 23")
	setNoteName(track, 66, "fill 24")
	setNoteName(track, 67, "fill 25")
	setNoteName(track, 68, "fill 26")
	setNoteName(track, 69, "fill 27")
	setNoteName(track, 70, "fill 28")
	setNoteName(track, 71, "fill 29")
	setNoteName(track, 72, "fill 30")
	setNoteName(track, 73, "fill 31")
	setNoteName(track, 74, "fill 32")
	setNoteName(track, 75, "fill 33")
	setNoteName(track, 76, "fill 34")
	setNoteName(track, 77, "fill 35")
	setNoteName(track, 78, "fill 36")
	setNoteName(track, 79, "fill 37")
	setNoteName(track, 80, "fill 38")
	setNoteName(track, 81, "fill 39")
	setNoteName(track, 82, "fill 40")
	setNoteName(track, 83, "fill 41")
	setNoteName(track, 84, "fill 42")
	setNoteName(track, 85, "fill 43")
	setNoteName(track, 86, "fill 44")
	setNoteName(track, 87, "fill 45")
	setNoteName(track, 88, "fill 46")
	setNoteName(track, 89, "fill 47")

	setNoteName(track, 90, "fill swing 1")
	setNoteName(track, 91, "fill swing 2")
	setNoteName(track, 92, "fill swing 3")
	setNoteName(track, 93, "fill swing 4")
	setNoteName(track, 94, "fill swing 5")
	setNoteName(track, 95, "fill swing 6")
	setNoteName(track, 96, "fill swing 7")
	setNoteName(track, 97, "fill swing 8")
	setNoteName(track, 98, "fill swing 9")
	setNoteName(track, 99, "fill swing 10")
	setNoteName(track, 100, "fill swing 11")
	setNoteName(track, 101, "fill swing 12")
	setNoteName(track, 102, "fill swing 13")
	setNoteName(track, 103, "fill swing 14")
	setNoteName(track, 104, "fill swing 15")

	setNoteName(track, 105, "drum -")
	setNoteName(track, 106, "drum +")

	setNoteName(track, 107, "groove -")
	setNoteName(track, 108, "groove +")

end

function updateNoteNames()

	clearAllNoteNames()

	local track = reaper.GetMediaItemTake_Track(activeTake())
	local _, trackName = reaper.GetTrackName(track, "")

	if trackName == "drumsGM" then
		setDrumNoteNamesForGeneralMidi(track)
	elseif trackName == "drums" or trackName == "simple drums" then
		setDrumNoteNamesForSimpleDrums(track)
	elseif trackName == "snare" then
		setDrumNoteNamesForSimpleDrums(track)
	elseif trackName == "hihat" then
		setDrumNoteNamesForSimpleDrums(track)
	elseif trackName == "mxrdrums" then
		setDrumNoteNamesForMXRDrumComputer(track)
	elseif trackName == "realidrums" then
		setDrumNoteNamesForRealidrums(track)
	elseif trackName == "ssd5" then
		setDrumNoteNamesForStevenSlateDrums(track)
	elseif trackName == "bass" then
		setRomanNumeralNoteNames(track, 1, 5)
	elseif trackName == "lead" then
		setRomanNumeralNoteNames(track, 1, 5)
		setLeadArticulationNoteNames(track)
	elseif trackName ~= "drums" then
		setRomanNumeralNoteNames(track, 1, 5)
	end
end