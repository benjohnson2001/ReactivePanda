quitProgram = false

function clearConsoleWindow()
  reaper.ShowConsoleMsg("")
end

function print(arg)
  reaper.ShowConsoleMsg(tostring(arg) .. "\n")
end

function shiftTable(arg, numberOfPlaces)

  local outputTable = {}

  for i = numberOfPlaces, 12 do
    table.insert(outputTable, arg[i])
  end

  for i = 1, numberOfPlaces-1 do
    table.insert(outputTable, arg[i])
  end

	return outputTable
end

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

function startUndoBlock()
  reaper.Undo_BeginBlock()
end

function endUndoBlock(actionDescription)
  reaper.Undo_OnStateChange(actionDescription)
  reaper.Undo_EndBlock(actionDescription, -1)
end

function emptyFunctionToPreventAutomaticCreationOfUndoPoint()
end