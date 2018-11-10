function getTrack(trackNameArg)

  local activeProjectIndex = 0
  local numberOfTracks = reaper.CountTracks(activeProjectIndex)

  for i = 0, numberOfTracks - 1 do

    local track = reaper.GetTrack(activeProjectIndex, i)
    local _, trackName = reaper.GetTrackName(track, "")

    if trackName == trackNameArg then
    	return track
    end
  end

  return nil
end

local function clearAllNoteNames()

	local commandId = 40412
	reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

local function setRomanNumeralNoteNames(track, minOctave, maxOctave)

	local activeProjectIndex = 0
	local allChannels = -1
	local noteNames = {"I", "II", "III", "IV", "V", "VI", "VII"}
	
	local scalePattern = getScalePattern(scaleTonicNote(), scales[scaleType()])
	shiftTable(scalePattern, scaleTonicNote()-1)

	for octave = minOctave, maxOctave do

		local noteIndex = 1 
		for i = 1, #scalePattern do

			if scalePattern[i] then

				local pitch = i-1 + (octave+1)*12 + scaleTonicNote()-1
				reaper.SetTrackMIDINoteNameEx(activeProjectIndex, track, pitch, allChannels, noteNames[noteIndex])
				noteIndex = noteIndex + 1
			end
		end
	end
end

local function setNoteName(track, pitch, name)

	local activeProjectIndex = 0
	local allChannels = -1

	reaper.SetTrackMIDINoteNameEx(activeProjectIndex, track, pitch, allChannels, name)
end

local function setRomanNumeralNoteNamesForDrums(track)

	setNoteName(60, "kick")
	setNoteName(60, "snare")
	setNoteName(60, "snare_flam")
	setNoteName(60, "hihat")
	setNoteName(60, "hihat_semiopen")
	setNoteName(60, "hihat_pedal")
	setNoteName(60, "hihat_open")
	setNoteName(60, "hihat_closed")
	setNoteName(60, "crash")
	setNoteName(60, "china")
	setNoteName(60, "ride")
	setNoteName(60, "ride_edge")
	setNoteName(60, "ride_cup")
	setNoteName(60, "tom1")
	setNoteName(60, "tom2")
	setNoteName(60, "tom3")
	setNoteName(60, "tom4")
end

function updateNoteNames()

	clearAllNoteNames()

	local track = reaper.GetMediaItemTake_Track(activeTake())
	local _, trackName = reaper.GetTrackName(track, "")

	if trackName == "bass" or trackName == "tele" or trackName == "strat" or trackName == "vocals" then
		setRomanNumeralNoteNames(track, 2, 5)
	end	

	if trackName == "drums" then
		--setRomanNumeralNoteNamesForDrums(track)
	end
end