local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/util")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scales")
require(workingDirectory .. "/midiEditor/midiEditorObserver")
require(workingDirectory .. "/midiEditor/midiEditorFunctions")
require(workingDirectory .. "/drumsVolumeObserver")

clearConsoleWindow()

local function main()

	setViewToHideUnusedAndUnnamedNoteRows()
  zoomToContent()

	listenForMidiEditorOpeningAndClosing()
	listenForChangesInDrumsVolume()

	if not quitProgram then
		reaper.runloop(main)
	end
end

main()