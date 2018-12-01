local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditor/updateNoteNames")
require(workingDirectory .. "/midiEditor/updateColorMap")
require(workingDirectory .. "/midiEditor/midiEditorFunctions")

local function whenMidiEditorIsOpened()

  updateColorMap()
  updateNoteNames()

  setViewToHideUnusedAndUnnamedNoteRows()
  zoomToContent()
  moveEditCursorToStartOfMediaItem()

  --showOnlyChannelOne()
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
