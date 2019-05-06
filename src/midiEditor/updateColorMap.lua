local function setColorMap(fileName)

	local stringArg = ""
	local isUndo = false
	local _, trackStateChunk = reaper.GetTrackStateChunk(activeTrack(), stringArg, isUndo)

	local colorMapDirectory = "/Users/panda/Library/Application Support/REAPER/Scripts/ReactivePanda/colormaps"
	local newColorMapCommand = "COLORMAP \"" .. colorMapDirectory .. "/" .. fileName .. "\""

	local newTrackStateChunk, numberOfSubstitutions = string.gsub(trackStateChunk, "COLORMAP \"(.-)\"", newColorMapCommand)
	reaper.SetTrackStateChunk(activeTrack(), newTrackStateChunk, isUndo)
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

	if trackName == "drums" or trackName == "mxr drums" or trackName == "simple drums" or trackName == "drums1" then
		setColorMap("drums.png")
	else
		local colorMapFileName = noteNames[scaleTonicNote()] .. scaleNames[scaleType()] .. ".png"
		setColorMap(colorMapFileName)
	end
end