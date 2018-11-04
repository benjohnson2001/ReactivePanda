
scales = {
  { name = "Major",           pattern = "101011010101" },
  { name = "Natural Minor",   pattern = "101101011010" },
  { name = "Harmonic Minor",  pattern = "101101011001" },
  { name = "Melodic Minor",   pattern = "101101010101" },
  { name = "Pentatonic",      pattern = "101010010100" },
  { name = "Ionian",          pattern = "101011010101" },
  { name = "Aeolian",         pattern = "101101011010" },
  { name = "Dorian",          pattern = "101101010110" },
  { name = "Mixolydian",      pattern = "101011010110" },
  { name = "Phrygian",        pattern = "110101011010" },
  { name = "Lydian",          pattern = "101010110101" },
  { name = "Locrian",         pattern = "110101101010" }
}

function getScalePattern(scaleTonicNote, scale)

  local scalePatternString = scale['pattern']
  local scalePattern = {false,false,false,false,false,false,false,false,false,false,false}

  for i = 0, #scalePatternString do
    local note = getNotesIndex(scaleTonicNote+i)
    if scalePatternString:sub(i+1, i+1) == '1' then
      scalePattern[note] = true
    end
  end
  return scalePattern
end


function getNotesIndex(note) 
   return ((note - 1) % 12) + 1
end