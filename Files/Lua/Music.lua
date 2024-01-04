freeslot("sfx_knockk", "sfx_unlike")

local mus = {
	["_title"] = "UNKNWN",
	["_chsel"] = "USHORT",
	["_creds"] = "USHORT",
	["_shoes"] = "KXSPED"
}

addHook("MusicChange", function(old, new)
	new = string.lower(new)
	
	if mus[new] ~= nil then
		return mus[new]
	else
		return new
	end
end)

addHook("PlayerThink", function(p)
	if not playingAsKnuckles(p) then p.knuxjingle = false return end
	
	if p.exiting and (not p.knuxjingle) then
		if P_RandomChance(FRACUNIT/2) then
			S_StartSound(p.mo, sfx_knockk)
		else
			S_StartSound(p.mo, sfx_unlike)
		end
		
		p.knuxjingle = true
	elseif not p.exiting then
		p.knuxjingle = false
	end
end)