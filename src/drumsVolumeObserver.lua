local workingDirectory = reaper.GetResourcePath() .. "/Scripts/ReactivePanda/src"
require(workingDirectory .. "/util")

local previousDrumsVolume = nil
function listenForChangesInDrumsVolume()

	local drumsTrack = getTrack("drums")

	local _, drumsVolume, _ = reaper.GetTrackUIVolPan(drumsTrack)

	if drumsVolume ~= previousDrumsVolume then

		local drumsOutputTrack = getTrack("drumsOutput")
		reaper.SetMediaTrackInfo_Value(drumsOutputTrack, "D_VOL", drumsVolume)
	end

	previousDrumsVolume = drumsVolume
end