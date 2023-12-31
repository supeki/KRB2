-- Drill Dive! for Knuckles Robo Blast 2.
-- By Marilyn, 100% reusable.

freeslot("S_PLAY_DRILLDIVE")

states[S_PLAY_DRILLDIVE] = {
	sprite = SPR_PLAY,
	frame = SPR2_NDRL|FF_ANIMATE,
	tics = -1,
	var1 = 3,
	var2 = 2,
	nextstate = S_PLAY_FALL
}

addHook("PlayerThink", function(p)
	if not playingAsKnuckles(p) then return end
	if knucklesIsImmobile(p) then return end
	if P_SuperReady(p) or (p.mo.state >= S_PLAY_SUPER_TRANS1 and p.mo.state <= S_PLAY_SUPER_TRANS6) then return end

	if (p.cmd.buttons & BT_CUSTOM1) and (((p.pflags & PF_JUMPED) and not (p.pflags & PF_THOKKED)) or (p.pflags & PF_GLIDING)) then
		p.mo.state = S_PLAY_DRILLDIVE
		p.pflags = $ & ~PF_JUMPED
		p.pflags = $|PF_THOKKED
		p.pflags = $ & ~PF_SPINNING
		P_InstaThrust(p.mo, R_PointToAngle2(0, 0, p.rmomx, p.rmomy), p.speed/4)
		
		if (p.mo.eflags & MFE_UNDERWATER) then
			P_SetObjectMomZ(p.mo, -4*FRACUNIT, false)
		else
			P_SetObjectMomZ(p.mo, -8*FRACUNIT, false)
		end
	end

	if p.mo.state == S_PLAY_DRILLDIVE then
		P_SpawnGhostMobj(p.mo)
		p.powers[pw_strong] = STR_ANIM|STR_FLOOR
		
		if not (p.cmd.buttons & BT_CUSTOM1) then
			p.mo.state = S_PLAY_FALL
		end
	else
		p.drilldiveangle = p.drawangle
	end
end)

addHook("PlayerCanDamage", function(p)
	if p.mo.state == S_PLAY_DRILLDIVE then
		return true
	end
end)