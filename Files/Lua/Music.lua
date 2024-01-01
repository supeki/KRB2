local mus = {
	["_title"] = "UNKNWN",
	["_chsel"] = "USHORT",
	["_creds"] = "UNKNWN"
}

addHook("MusicChange", function(old, new)
	if mus[new] ~= nil then
		return mus[new]
	else
		return new
	end
end)