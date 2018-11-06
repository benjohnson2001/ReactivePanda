
local activeProjectIndex = 0

function getRepeatState()
	return reaper.GetSetRepeatEx(activeProjectIndex, -1)
end

function setRepeatState(arg)
	reaper.GetSetRepeatEx(activeProjectIndex, arg)
end