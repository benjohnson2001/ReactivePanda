local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/util")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scales")
require(workingDirectory .. "/midiEditor/updateMidiEditor")
require(workingDirectory .. "/midiEditor/configureMidiEditor")

clearConsoleWindow()

local function main()

	setViewToHideUnusedAndUnnamedNoteRows()
  zoomToContent()

	updateMidiEditor()

	if not quitProgram then
		reaper.runloop(main)
	end
end

main()