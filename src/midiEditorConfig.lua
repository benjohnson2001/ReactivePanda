local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditorZoomSettings")
require(workingDirectory .. "/midiEditorNoteNames")



function activeMidiEditor()
  return reaper.MIDIEditor_GetActive()
end

local function setViewToHideUnusedAndUnnamedNoteRows()

  local midiEditorSectionId = 32060
  local commandId = 40454
  
  local viewIsNotSet = reaper.GetToggleCommandStateEx(midiEditorSectionId, commandId) == 0

  if viewIsNotSet then
    reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
  end
end

local function zoomToContent()

  local commandId = 40466
  reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end


local midiEditorIsOpen = false
function updateMidiEditor()

  if activeMidiEditor() ~= nil and midiEditorIsOpen == false then

    -- print("\n\nmidi editor was opened")
    midiEditorIsOpen = true

    setViewToHideUnusedAndUnnamedNoteRows()
    zoomToContent()
  end

  if activeMidiEditor() == nil and midiEditorIsOpen == true then

    -- print("\n\nmidi editor was closed")
    midiEditorIsOpen = false
  end
end