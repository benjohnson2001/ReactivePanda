local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditor/updateNoteNames")

local function setViewToHideUnusedAndUnnamedNoteRows()

  local midiEditorSectionId = 32060
  local commandId = 40454
  
  local viewIsNotSet = reaper.GetToggleCommandStateEx(midiEditorSectionId, commandId) ~= 1

  if viewIsNotSet then
    reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
  end
end

local function zoomToContent()

  local commandId = 40466
  reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

local function turnRepeatOn()
  setRepeatState(1)
end

local function setLoopRangeToBeMediaItemRange()

  local mediaItem = reaper.GetMediaItemTake_Item(activeTake())
  local position = reaper.GetMediaItemInfo_Value(mediaItem, "D_POSITION")
  local length = reaper.GetMediaItemInfo_Value(mediaItem, "D_LENGTH")

  local activeProjectIndex = 0
  local isSet = true
  local isLoop = true
  local autoSeek = false
  reaper.GetSet_LoopTimeRange2(activeProjectIndex, isSet, isLoop, position, position+length, autoSeek)
end


local function setCursorToBeAtStartOfMediaItem()

  local mediaItem = reaper.GetMediaItemTake_Item(activeTake())
  local position = reaper.GetMediaItemInfo_Value(mediaItem, "D_POSITION")
  setCursorPosition(position)
end

local function turnOnLooping()
  setLoopRangeToBeMediaItemRange()
  turnRepeatOn()
  setCursorToBeAtStartOfMediaItem()
end

function configureMidiEditor()

  updateNoteNames()
  setViewToHideUnusedAndUnnamedNoteRows()
  zoomToContent()
  turnOnLooping()
end