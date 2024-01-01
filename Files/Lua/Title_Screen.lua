local titletimer = 0

addHook("ThinkFrame", function()
	if gamestate ~= GS_TITLESCREEN then
		titletimer = 0
	elseif titletimer < 5*TICRATE then
		titletimer = $+1
	end
end)

hud.add(function(v)
	v.drawScaled((160-(477/4))*FRACUNIT, (100-(286/4))*FRACUNIT, FRACUNIT/2, v.cachePatch("TEMBL"))
	
	if titletimer >= TICRATE and titletimer < TICRATE+39 then
		v.drawScaled(160*FRACUNIT, 148*FRACUNIT, FRACUNIT/2, v.cachePatch("TKNUX"..tostring(((titletimer-TICRATE)/3)%13+1)))
	elseif titletimer >= TICRATE+39 then
		v.drawScaled(160*FRACUNIT, 148*FRACUNIT, FRACUNIT/2, v.cachePatch("TKNUX13"))
	end
	
	v.drawScaled((160-(477/4))*FRACUNIT, (100-(286/4))*FRACUNIT, FRACUNIT/2, v.cachePatch("TEMBL2"))
	
	v.drawScaled((160-326/4)*FRACUNIT, 118*FRACUNIT, FRACUNIT/2, v.cachePatch("TROBO"))
	v.drawScaled((160-17)*FRACUNIT, 120*FRACUNIT, FRACUNIT/2, v.cachePatch("TTWO"))
end, "title")