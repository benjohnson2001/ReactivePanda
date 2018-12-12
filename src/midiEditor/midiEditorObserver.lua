local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditor/updateNoteNames")
require(workingDirectory .. "/midiEditor/updateColorMap")
require(workingDirectory .. "/midiEditor/midiEditorFunctions")
require(workingDirectory .. "/midiEditor/hideTrackList")
require(workingDirectory .. "/midiEditor/hideMediaLane")

local function whenMidiEditorIsOpened()

  startUndoBlock()

    updateColorMap()
    updateNoteNames()

    setViewToHideUnusedAndUnnamedNoteRows()
    zoomToContent()
    moveEditCursorToStartOfMediaItem()

    --showOnlyChannelOne()
    hideTrackList()
    hideMediaLane()

  endUndoBlock("ReactivePanda: midi editor opened")
end

local function resetDrumPatternIndex()

  local activeProjectIndex = 0
  local sectionName = "com.pandabot.DrumPatterns"
  local key = "drumPatternIndex"
  reaper.SetProjExtState(activeProjectIndex, sectionName, key, 0)
end

local function whenMidiEditorIsClosed()

  resetDrumPatternIndex()
end

local midiEditorIsOpen = false
function listenForMidiEditorOpeningAndClosing()

  if activeMidiEditor() ~= nil and midiEditorIsOpen == false then
    midiEditorIsOpen = true
    whenMidiEditorIsOpened()
  end

  if activeMidiEditor() == nil and midiEditorIsOpen == true then
    midiEditorIsOpen = false
    whenMidiEditorIsClosed()
  end
end
