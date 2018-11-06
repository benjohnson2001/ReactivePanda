local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/midiEditor/configureMidiEditor")
require(workingDirectory .. "/repeatState")
require(workingDirectory .. "/cursorPosition")

function activeMidiEditor()
  return reaper.MIDIEditor_GetActive()
end

function activeTake()
  return reaper.MIDIEditor_GetTake(activeMidiEditor())
end

local midiEditorIsOpen = false

function updateMidiEditor()

  if activeMidiEditor() ~= nil and midiEditorIsOpen == false then
    --print("\n\nmidi editor was opened")
    midiEditorIsOpen = true

    configureMidiEditor()
  end

  if activeMidiEditor() == nil and midiEditorIsOpen == true then
    -- print("\n\nmidi editor was closed")
    midiEditorIsOpen = false
  end
end