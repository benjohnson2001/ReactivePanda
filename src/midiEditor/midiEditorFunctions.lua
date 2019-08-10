local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditor/updateNoteNames")
require(workingDirectory .. "/midiEditor/updateColorMap")

function activeMidiEditor()
  return reaper.MIDIEditor_GetActive()
end

function activeTake()
  return reaper.MIDIEditor_GetTake(activeMidiEditor())
end

function activeTrack()
  return reaper.GetMediaItemTake_Track(activeTake())
end

function activeMediaItem()
  return reaper.GetMediaItemTake_Item(activeTake())
end

function activeMediaItemStartPosition()
  return reaper.GetMediaItemInfo_Value(activeMediaItem(), "D_POSITION")
end

function getTrackName()
  local _, trackName = reaper.GetTrackName(activeTrack(), "")
  return trackName
end

function setEditCursorPosition(arg)

  local activeProjectIndex = 0
  local moveView = false
  local seekPlay = false
  reaper.SetEditCurPos2(activeProjectIndex, arg, moveView, seekPlay)
end

function setViewToHideUnusedAndUnnamedNoteRows()

  local midiEditorSectionId = 32060
  local commandId = 40454
  
  local viewIsNotSet = reaper.GetToggleCommandStateEx(midiEditorSectionId, commandId) ~= 1

  if viewIsNotSet then
    reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
  end
end

function zoomToContent()

  local commandId = 40466
  reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

function moveEditCursorToStartOfMediaItem()
  setEditCursorPosition(activeMediaItemStartPosition())
end

function showOnlyChannelOne()
  
  local commandId = 40218
  reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end