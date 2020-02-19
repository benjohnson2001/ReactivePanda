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

    local trackName = getTrackName()
    if trackName == "vocals" then
      setViewToShowAllNoteRows()
    else
      setViewToHideUnusedAndUnnamedNoteRows()
    end

    moveEditCursorToStartOfMediaItem()

    --showOnlyChannelOne()
    
--    if trackName ~= "kick" and trackName ~= "snare" then
      zoomToContent()
--    end

    hideTrackList()
    hideMediaLane()

  endUndoBlock("ReactivePanda: midi editor opened")
end

local function whenMidiEditorIsClosed()

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
