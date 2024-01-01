-- Uppercut! for Knuckles Robo Blast 2.
-- By Marilyn, 100% reusable.

freeslot("S_PLAY_UPPERCUT")

states[S_PLAY_UPPERCUT] = {
	sprite = SPR_PLAY,
	frame = SPR2_GASP,
	tics = 16,
	nextstate = S_PLAY_FALL
}

rawset(_G, "playingAsKnuckles", function(p)
	return (
		p.mo 
		and p.mo.valid 
		and p.mo.health
		and (p.mo.skin == "knuckles" or p.skin == #skins["knuckles"])
	)
end)

rawset(_G, "knucklesIsImmobile", function(p)
	return (
		(p.pflags & PF_STASIS)
		or (p.pflags & PF_FULLSTASIS)
		or (p.pflags & PF_SLIDING)
		or p.powers[pw_nocontrol]
		or P_PlayerInPain(p)
		or p.powers[pw_carry]
	)
end)

addHook("PlayerThink", function(p)
	if not playingAsKnuckles(p) then return end
	if knucklesIsImmobile(p) then return end
	if P_SuperReady(p) or (p.mo.state >= S_PLAY_SUPER_TRANS1 and p.mo.state <= S_PLAY_SUPER_TRANS6) then return end
	
	if not (p.cmd.buttons & BT_USE) and not (p.mo.state == S_PLAY_CLING or p.mo.state == S_PLAY_CLIMB) then
		p.uppercutready = true
		p.uppercuttap = false
	elseif p.uppercutready then
		p.uppercuttap = true
		p.uppercutready = false
	else
		p.uppercuttap = false
	end
	
	if (p.pflags & PF_JUMPED) and p.uppercuttap and not (p.pflags & PF_THOKKED) then
		p.mo.state = S_PLAY_UPPERCUT
		p.pflags = $ & ~PF_JUMPED
		p.pflags = $|PF_THOKKED
		p.pflags = $ & ~PF_SPINNING
		P_InstaThrust(p.mo, R_PointToAngle2(0, 0, p.rmomx, p.rmomy), p.speed/2)
		
		if (p.mo.eflags & MFE_UNDERWATER) then
			P_SetObjectMomZ(p.mo, 8*FRACUNIT, false)
		else
			P_SetObjectMomZ(p.mo, 16*FRACUNIT, false)
		end
		p.uppercutted = true
	end
	
	if p.mo.state == S_PLAY_UPPERCUT then
		P_SpawnGhostMobj(p.mo)
		p.powers[pw_strong] = STR_ANIM|STR_CEILING
		p.uppercutangle = $+FixedAngle(45*FRACUNIT)
		p.drawangle = p.uppercutangle
	else
		p.uppercutangle = p.drawangle
	end
end)

addHook("PlayerCanDamage", function(p)
	if p.mo.state == S_PLAY_UPPERCUT then
		return true
	end
end)