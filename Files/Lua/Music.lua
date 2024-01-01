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