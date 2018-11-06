local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/util")
require(workingDirectory .. "/preferences")
require(workingDirectory .. "/scales")
require(workingDirectory .. "/midiEditor/updateMidiEditor")

clearConsoleWindow()

local function main()

	updateMidiEditor()

	if not quitProgram then
		reaper.runloop(main)
	end
end

main()