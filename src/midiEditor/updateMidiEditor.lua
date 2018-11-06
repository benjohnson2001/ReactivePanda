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

local repeatState = nil
local cursorPosition = nil
function updateMidiEditor()

  if activeMidiEditor() ~= nil and midiEditorIsOpen == false then
    --print("\n\nmidi editor was opened")
    midiEditorIsOpen = true

    repeatState = getRepeatState()
    cursorPosition = getCursorPosition()

    configureMidiEditor()
  end

  if activeMidiEditor() == nil and midiEditorIsOpen == true then
    -- print("\n\nmidi editor was closed")
    midiEditorIsOpen = false

    setRepeatState(repeatState)
    setCursorPosition(cursorPosition)
  end
end