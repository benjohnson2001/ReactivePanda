local function setColorMap(fileName)

	local stringArg = ""
	local isUndo = false
	local _, trackStateChunk = reaper.GetTrackStateChunk(activeTrack(), stringArg, isUndo)

	local colorMapDirectory = "/Users/panda/Library/Application Support/REAPER/Scripts/ReactivePanda/colormaps"

	if string.match(trackStateChunk, "MIDICOLORMAPFN") then

		local newColorMapCommand = "MIDICOLORMAPFN \"" .. colorMapDirectory .. "/" .. fileName .. "\""
		local newTrackStateChunk, numberOfSubstitutions = string.gsub(trackStateChunk, "MIDICOLORMAPFN \"(.-)\"", newColorMapCommand, 1)
		reaper.SetTrackStateChunk(activeTrack(), newTrackStateChunk, isUndo)
	else

		local newColorMapCommand = "MIDICOLORMAPFN \"" .. colorMapDirectory .. "/" .. fileName .. "\"\nFX"
		local newTrackStateChunk, numberOfSubstitutions = string.gsub(trackStateChunk, "FX", newColorMapCommand, 1)
		reaper.SetTrackStateChunk(activeTrack(), newTrackStateChunk, isUndo)
	end
end

noteNames = { 'c', 'cSharp', 'd', 'dSharp', 'e', 'f', 'fSharp', 'g', 'gSharp', 'a', 'aSharp', 'b' };

scaleNames = {	'Major', 
								'NaturalMinor', 
								'HarmonicMinor',
								'MelodicMinor', 
								'Pentatonic',    
								'Ionian',        
								'Aeolian',       
								'Dorian',        
								'Mixolydian',    
								'Phrygian',      
								'Lydian',        
								'Locrian'
							}

function updateColorMap()

	local _, trackName = reaper.GetTrackName(activeTrack(), "")

	if string.match(trackName, "drums")
	or string.match(trackName, "ssd5") then
		setColorMap("drums.png")
	else
		local colorMapFileName = noteNames[scaleTonicNote()] .. scaleNames[scaleType()] .. ".png"
		setColorMap(colorMapFileName)
	end
end