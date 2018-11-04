local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/util")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scales")
require(workingDirectory .. "/midiEditorConfig")

clearConsoleWindow()

local function main()

	updateNoteNamesForTracks()
	updateMidiEditor()

	if not quitProgram then
		reaper.runloop(main)
	end
end

main()