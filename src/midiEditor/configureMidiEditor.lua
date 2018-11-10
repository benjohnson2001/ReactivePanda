local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditor/updateNoteNames")
require(workingDirectory .. "/midiEditor/updateColorMap")

function setViewToHideUnusedAndUnnamedNoteRows()

  local midiEditorSectionId = 32060
  local commandId = 40454
  
  local viewIsNotSet = reaper.GetToggleCommandStateEx(midiEditorSectionId, commandId) ~= 1

  if viewIsNotSet then
    reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
  else
    reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
    reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
  end
end

function zoomToContent()

  local commandId = 40466
  reaper.MIDIEditor_OnCommand(activeMidiEditor(), commandId)
end

function configureMidiEditor()

  updateColorMap()
  updateNoteNames()

  setViewToHideUnusedAndUnnamedNoteRows()
  zoomToContent()
end