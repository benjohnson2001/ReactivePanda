quitProgram = false

function clearConsoleWindow()
  reaper.ShowConsoleMsg("")
end

function print(arg)
  reaper.ShowConsoleMsg(tostring(arg) .. "\n")
end

function shiftTable(arg, numberOfPlaces)

	for i = 1, numberOfPlaces do
		table.insert(arg, arg[1])
		table.remove(arg, 1)
	end
end


