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

function configureMidiEditor()

  updateNoteNames()
  setViewToHideUnusedAndUnnamedNoteRows()
  zoomToContent()
end