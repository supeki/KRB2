-- Be warned Knuckles, he's not giving up the Chaos Emeralds without a fair fight... hey Sonic why are you glo- AAAA!!-
-- (Super) Sonic Boss Fight by Marilyn. Maybe not reusable, we'll find out soon enough.

freeslot(
	"MT_SONIC",
	"S_SONIC_SPAWN", -- "What's up, Knuckles?"
	"S_SONIC_STND", -- ...
	"S_SONIC_BORED", -- "I'm waaaaaaiting!"
	"S_SONIC_BORED2", -- "I'm waaaaaaiting!"
	"S_SONIC_WALK", -- Transitions into a run state if he's going fast enough, idk... lol.
	"S_SONIC_RUN",
	"S_SONIC_DECIDE",
	"S_SONIC_JUMP", -- *boince*
	"S_SONIC_CHARGE",
	"S_SONIC_SPINDASH",
	"S_SONIC_HOMING1", -- "Better watch yourself, Knucklehead!"
	"S_SONIC_HOMING2", -- *homing sound idk*
	"S_SONIC_HOMING3", -- "Hurray!"
	"S_SONIC_FALL",
	"S_SONIC_PAIN", -- *ring loss sound*
	"S_SONIC_DEAD", -- "NO!..."
	"S_SONIC_TRANSFORM", -- *transformation sound*
	"S_SUPERSONIC_STND", -- ...
	"S_SUPERSONIC_WALK", -- ...
	"S_SUPERSONIC_DASH1", -- "I'll show you what the Chaos Emeralds can really do!"
	"S_SUPERSONIC_DASH2", -- *Nyooooommm!!*
	"S_SUPERSONIC_FALL", -- ...
	"S_SUPERSONIC_UNTRANSFORM" -- ...
)

states[S_SONIC_SPAWN] = {
	sprite = SPR_PLAY,
	frame = SPR2_STND|A,
	tics = 35,
	nextstate = S_SONIC_STND
}

states[S_SONIC_STND] = {
	sprite = SPR_PLAY,
	frame = SPR2_STND|A,
	tics = 105,
	action = A_Look,
	var1 = 2048 << 16 + 1,
	var2 = 1,
	nextstate = S_SONIC_BORED
}

states[S_SONIC_BORED] = {
	sprite = SPR_PLAY,
	frame = SPR2_WAIT|A,
	tics = 17,
	action = A_Look,
	var1 = 2048 << 16 + 1,
	var2 = 1,
	nextstate = S_SONIC_BORED2
}

states[S_SONIC_BORED2] = {
	sprite = SPR_PLAY,
	frame = SPR2_WAIT|B,
	tics = 17,
	action = A_Look,
	var1 = 2048 << 16 + 1,
	var2 = 1,
	nextstate = S_SONIC_BORED
}

states[S_SONIC_WALK] = {
	sprite = SPR_PLAY,
	frame = SPR2_WALK|FF_ANIMATE,
	tics = 105,
	var1 = 7,
	var2 = 3,
	nextstate = S_SONIC_DECIDE
}

states[S_SONIC_RUN] = {
	sprite = SPR_PLAY,
	frame = SPR2_RUN_|FF_ANIMATE,
	tics = 70,
	var1 = 3,
	var2 = 2,
	nextstate = S_SONIC_DECIDE
}

states[S_SONIC_DECIDE] = {
	sprite = SPR_PLAY,
	frame = SPR2_SKID,
	tics = -1,
	action = A_RandomState,
	var1 = S_SONIC_JUMP,
	var2 = S_SONIC_CHARGE,
	nextstate = S_SONIC_STND
}

states[S_SONIC_JUMP] = {
	sprite = SPR_PLAY,
	frame = SPR2_ROLL|FF_ANIMATE,
	tics = 18,
	var1 = 5,
	var2 = 3,
	nextstate = S_SONIC_HOMING1
}

states[S_SONIC_CHARGE] = {
	sprite = SPR_PLAY,
	frame = SPR2_SPIN|FF_ANIMATE,
	tics = 17,
	var1 = 3,
	var2 = 2,
	nextstate = S_SONIC_SPINDASH
}

states[S_SONIC_SPINDASH] = {
	sprite = SPR_PLAY,
	frame = SPR2_ROLL|FF_ANIMATE,
	tics = 105,
	var1 = 5,
	var2 = 3,
	nextstate = S_SONIC_STND
}

states[S_SONIC_HOMING1] = {
	sprite = SPR_PLAY,
	frame = SPR2_ROLL|A,
	tics = 10,
	action = A_PlaySound,
	var1 = sfx_spndsh,
	var2 = 0,
	nextstate = S_SONIC_HOMING2
}

states[S_SONIC_HOMING2] = {
	sprite = SPR_PLAY,
	frame = SPR2_ROLL|FF_ANIMATE,
	tics = 70,
	var1 = 5,
	var2 = 3,
	nextstate = S_SONIC_FALL
}

states[S_SONIC_FALL] = {
	sprite = SPR_PLAY,
	frame = SPR2_FALL|A,
	tics = -1,
	nextstate = S_SONIC_FALL
}

states[S_SONIC_PAIN] = {
	sprite = SPR_PLAY,
	frame = SPR2_PAIN|A,
	tics = -1,
	action = A_ZThrust,
	var1 = 8,
	var2 = FRACUNIT,
	nextstate = S_SONIC_PAIN
}

states[S_SONIC_DEAD] = {
	sprite = SPR_PLAY,
	frame = SPR2_DEAD|A,
	tics = -1,
	nextstate = S_SONIC_DEAD
}

states[S_SONIC_TRANSFORM] = {
	sprite = SPR_PLAY,
	frame = SPR2_TRNS|FF_ANIMATE,
	tics = 14,
	var1 = 6,
	var2 = 2,
	nextstate = S_SUPERSONIC_FALL
}

states[S_SUPERSONIC_STND] = {
	sprite = SPR_PLAY,
	frame = SPR2_STND|A|FF_SPR2SUPER,
	tics = 17,
	action = A_Look,
	var1 = 2048 << 16 + 1,
	var2 = 1,
	nextstate = S_SUPERSONIC_STND
}

states[S_SUPERSONIC_WALK] = {
	sprite = SPR_PLAY,
	frame = SPR2_WALK|FF_ANIMATE|FF_SPR2SUPER,
	tics = 105,
	var1 = 7,
	var2 = 3,
	nextstate = S_SONIC_JUMP
}

states[S_SUPERSONIC_FALL] = {
	sprite = SPR_PLAY,
	frame = SPR2_FALL|A|FF_SPR2SUPER,
	tics = -1,
	nextstate = S_SUPERSONIC_FALL
}

states[S_SUPERSONIC_DASH1] = {
	sprite = SPR_PLAY,
	frame = SPR2_SPNG|A|FF_SPR2SUPER,
	tics = 10,
	action = A_PlaySound,
	var1 = sfx_spndsh,
	var2 = 0,
	nextstate = S_SUPERSONIC_DASH2
}

states[S_SUPERSONIC_DASH2] = {
	sprite = SPR_PLAY,
	frame = SPR2_RUN_|FF_ANIMATE|FF_SPR2SUPER,
	tics = 105,
	var1 = 1,
	var2 = 1,
	nextstate = S_SUPERSONIC_FALL
}

states[S_SUPERSONIC_UNTRANSFORM] = {
	sprite = SPR_PLAY,
	frame = SPR2_TRNS|FF_ANIMATE,
	tics = 7,
	var1 = 6,
	var2 = 1,
	nextstate = S_SONIC_FALL
}

mobjinfo[MT_SONIC] = {
	--$Name Sonic
	--$Sprite WAITA1
	--$Category KRB2
	mapthingnum = 2222,
	spawnstate = S_SONIC_STND,
	spawnhealth = 8,
	seestate = S_SONIC_WALK,
	seesound = sfx_none,
	reactiontime = 0,
	attacksound = sfx_none,
	painstate = S_SONIC_PAIN,
	painchance = MT_THOK,
	painsound = sfx_s3kb9,
	meleestate = S_NULL,
	missilestate = S_NULL,
	deathstate = S_SONIC_DEAD,
	xdeathstate = S_NULL,
	deathsound = sfx_s3k35,
	speed = 36*FRACUNIT, -- Sonic's base normalspeed value :>
	radius = 16*FRACUNIT,
	height = 48*FRACUNIT,
	dispoffset = 0,
	mass = 0,
	damage = 0,
	activesound = sfx_none,
	flags = MF_SPECIAL|MF_SHOOTABLE|MF_BOSS,
	raisestate = MT_THOK
}

addHook("ShouldDamage", function(pmo, probablysonic, sonic)
	if not (pmo and pmo.valid) then return end
	if not pmo.health then return end
	if not (sonic and sonic.valid) then return end
	if not sonic.health then return end
	if sonic.type ~= MT_SONIC then return end
	
	if pmo.player.powers[pw_flashing] or pmo.player.powers[pw_invulnerability] then return end
		
	if sonic.state == S_SONIC_SPAWN
		or sonic.state == S_SONIC_STND
		or sonic.state == S_SONIC_BORED
		or sonic.state == S_SONIC_WALK
		or sonic.state == S_SONIC_RUN
		or sonic.state == S_SONIC_DECIDE
		or sonic.state == S_SONIC_FALL
		or sonic.state == S_SONIC_TRANSFORM
		or sonic.state == S_SUPERSONIC_UNTRANSFORM
	then
		return false
	end
	
	if sonic.super then
		return true
	end
	
	if (sonic.state == S_SONIC_JUMP or sonic.state == S_SONIC_CHARGE) and ((pmo.player.pflags & PF_JUMPED) or (pmo.player.pflags & PF_SPINNING)) then
		P_InstaThrust(sonic, sonic.angle, -FixedHypot(sonic.momx, sonic.momy)/4)
		P_SetObjectMomZ(sonic, 6*FRACUNIT, false)
		
		P_InstaThrust(pmo, sonic.angle, FixedHypot(sonic.momx, sonic.momy)/4)
		P_SetObjectMomZ(pmo, 6*FRACUNIT, false)
		
		sonic.state = S_SONIC_FALL
		pmo.state = S_SONIC_FALL
		pmo.player.pflags = $ & ~PF_JUMPED
		pmo.player.pflags = $ & ~PF_SPINNING
		sonic.invtimer = 8
		return false
	end
end, MT_PLAYER)

addHook("ShouldDamage", function(sonic, probablypmo, pmo)
	if not (sonic and sonic.valid) then return end
	if not sonic.health then return end
	
	if sonic.super then
		return false
	end
	
	if sonic.state == S_SONIC_TRANSFORM then return false end
	if sonic.invtimer then return false end
	
	P_InstaThrust(sonic, pmo.angle, 6*FRACUNIT)
	sonic.angle = pmo.angle + ANGLE_180
	P_SetObjectMomZ(sonic, 6*FRACUNIT, false)
	S_StartSound(sonic, sfx_s3kb9)
end, MT_SONIC)

addHook("MobjSpawn", function(sonic)
	sonic.skin = "sonic"
	sonic.color = SKINCOLOR_CORNFLOWER
end, MT_SONIC)

addHook("MobjDeath", function(sonic, probablypmo, pmo)
	if not sonic.cansuper then
		P_SetObjectMomZ(sonic, 12*FRACUNIT, false)
		S_ChangeMusic("VSSSON", true)
		sonic.state = S_SONIC_TRANSFORM
		sonic.cansuper = true
		sonic.health = 4
		sonic.flags = $ & ~(MF_NOGRAVITY|MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOCLIPTHING)
		sonic.flags = $|MF_SPECIAL|MF_SHOOTABLE
		return true
	else
		P_SetObjectMomZ(sonic, 12*FRACUNIT, false)
		sonic.flags = $ & ~MF_NOGRAVITY
		sonic.flags = $|MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOCLIPTHING
	end
end, MT_SONIC)

addHook("MobjThinker", function(sonic)
	if not (sonic and sonic.valid) then return end
	
	if sonic.z+sonic.height < sonic.subsector.sector.floorheight then P_RemoveMobj(sonic) return end
	if sonic.z > sonic.subsector.sector.ceilingheight then P_RemoveMobj(sonic) return end
	
	sonic.flags2 = $ & ~MF2_FRET
	
	if not sonic.health then return end
	
	if sonic.state == S_SONIC_TRANSFORM then
		if sonic.tics < 2 then
			sonic.color = SKINCOLOR_SUPERGOLD1
			sonic.super = 15*TICRATE
		end
	end
	
	if sonic.state == S_SONIC_TRANSFORM or sonic.state == S_SUPERSONIC_UNTRANSFORM then
		P_InstaThrust(sonic, sonic.angle, 0)
	end
	
	if sonic.state == S_SONIC_PAIN then
		sonic.flags = $ & ~MF_SPECIAL
		sonic.flags = $ & ~MF_SHOOTABLE
		
		if P_IsObjectOnGround(sonic) then
			if sonic.cansuper and sonic.super == 0 then
				sonic.state = S_SONIC_TRANSFORM
				sonic.invtimer = 0
			else
				sonic.state = S_SONIC_STND
				sonic.invtimer = 105
			end
		end
		
		return
	elseif sonic.invtimer then
		sonic.flags = $ & ~MF_SPECIAL
		sonic.flags = $ & ~MF_SHOOTABLE
		sonic.invtimer = $ - 1
		
		if sonic.invtimer % 2 == 0 then
			sonic.flags2 = $|MF2_DONTDRAW
		else
			sonic.flags2 = $ & ~MF2_DONTDRAW
		end
		
		if not sonic.invtimer then
			sonic.flags = $|MF_SPECIAL
			sonic.flags = $|MF_SHOOTABLE
			sonic.flags2 = $ & ~MF2_DONTDRAW
		end
	end
	
	if not sonic.target then 
		if sonic.waittimer == nil then
			sonic.waittimer = 1
		else
			sonic.waittimer = $+1
		end
		
		if sonic.waittimer >= 3*TICRATE and sonic.state ~= S_SONIC_BORED then
			sonic.state = S_SONIC_BORED
		end
		
		return 
	else
		sonic.waittimer = 0
	end
	
	if sonic.state == S_SONIC_WALK or sonic.state == S_SONIC_RUN then
		if FixedHypot(sonic.momx, sonic.momy) < sonic.info.speed then
			P_Thrust(sonic, sonic.angle, skins["sonic"].acceleration*FRACUNIT/17)
		end
		
		if sonic.angle ~= R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y) and (R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64) > 0 then
			sonic.angle = $ - ($ - R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y))/(R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64)
		end
		
		if sonic.cansuper and sonic.transtimer == 4*TICRATE then
			sonic.state = S_SONIC_JUMP
		end
		
		if sonic.super then
			sonic.state = S_SUPERSONIC_WALK
		end
	end
	
	if sonic.state == S_SUPERSONIC_WALK then
		if FixedHypot(sonic.momx, sonic.momy) < sonic.info.speed/2*3 then
			P_Thrust(sonic, sonic.angle, skins["sonic"].acceleration*FRACUNIT/12)
		end
		
		if sonic.angle ~= R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y) and (R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/128) > 0 then
			sonic.angle = $ - ($ - R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y))/(R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/128)
		end
	end
	
	if sonic.state == S_SONIC_DECIDE then
		if sonic.cansuper and sonic.super == 0 then
			sonic.state = S_SONIC_WALK
		end
	
		if (not ((player.pflags & PF_JUMPED) or (player.pflags & PF_SPINNING))) and not P_IsObjectOnGround(sonic.target) then
			sonic.state = S_SONIC_JUMP
		elseif P_IsObjectOnGround(sonic.target) and not (player.pflags & PF_SPINNING) then
			sonic.state = S_SONIC_CHARGE
		end
	end
	
	if sonic.state == S_SONIC_JUMP then
		sonic.flags = $|MF_PAIN
		
		if sonic.tics == 18 then 
			if sonic.super then
				P_SetObjectMomZ(sonic, 14*skins["sonic"].jumpfactor, true)
			else
				P_SetObjectMomZ(sonic, 10*skins["sonic"].jumpfactor, true)
			end
			
			S_StartSound(sonic, sfx_jump)
		end
	end
	
	if sonic.state == S_SONIC_CHARGE then
		sonic.flags = $|MF_PAIN
		if sonic.tics == 17 then S_StartSound(sonic, sfx_spndsh) end
		P_InstaThrust(sonic, sonic.angle, 0)
		
		if sonic.angle ~= R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y) and (R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64) > 0 then
			sonic.angle = $ - ($ - R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y))/(R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64)
		end
	end
	
	if sonic.state == S_SONIC_SPINDASH then
		if sonic.tics == 105 then
			P_Thrust(sonic, sonic.angle, 128*FRACUNIT)
			S_StartSound(sonic, sfx_zoom)
		end
		
		local thok = P_SpawnMobjFromMobj(sonic, 0, 0, 0, MT_THOK)
		thok.color = sonic.color
		
		if FixedHypot(sonic.momx, sonic.momy) < FRACUNIT then
			sonic.flags = $ & ~MF_PAIN
			sonic.state = S_SONIC_STND
		end
	end
	
	if sonic.state == S_SONIC_HOMING1 then
		if not sonic.cansuper then
			sonic.frame = (sonic.tics % 6)
		end
	end
	
	if sonic.state == S_SONIC_HOMING2 then
		if not sonic.cansuper then
			if sonic.tics == 70 then S_StartSound(sonic, sfx_thok) end
			
			P_HomingAttack(sonic, sonic.target)
			local thok = P_SpawnMobjFromMobj(sonic, 0, 0, 0, MT_THOK)
			thok.color = sonic.color
		end
	end
	
	if sonic.state == S_SUPERSONIC_DASH1 then
		if sonic.angle ~= R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y) and (R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64) > 0 then
			sonic.angle = $ - ($ - R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y))/(R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64)
		end
	end
	
	if sonic.state == S_SUPERSONIC_DASH2 then
		P_HomingAttack(sonic, sonic.target)
	
		if FixedHypot(sonic.momx, sonic.momy) < sonic.info.speed/2*3 then
			P_Thrust(sonic, sonic.angle, R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/105)
		end
	end
	
	if sonic.state == S_SONIC_FALL then
		sonic.flags = $ & ~MF_PAIN
		
		if P_IsObjectOnGround(sonic) then
			sonic.state = S_SONIC_STND
		end
	elseif sonic.state == S_SUPERSONIC_FALL then
		if P_IsObjectOnGround(sonic) then
			sonic.state = S_SUPERSONIC_STND
		end
	end
	
	local oldtics = sonic.tics
	
	if FixedHypot(sonic.momx, sonic.momy) >= 18*FRACUNIT and sonic.state == S_SONIC_WALK then
		P_SetMobjStateNF(sonic, S_SONIC_RUN)
	elseif FixedHypot(sonic.momx, sonic.momy) < 18*FRACUNIT and sonic.state == S_SONIC_RUN then
		P_SetMobjStateNF(sonic, S_SONIC_WALK)
	end
	
	sonic.tics = oldtics
	
	if sonic.super then
		sonic.flags = $|MF_PAIN
		
		sonic.color = SKINCOLOR_SUPERGOLD1 + abs(((leveltime >> 1)%9)-4)
		
		if sonic.state == S_SONIC_JUMP and sonic.tics < 2 then
			sonic.state = S_SUPERSONIC_DASH1
		end
		
		sonic.super = $ - 1
		
		if (not sonic.super) then
			sonic.color = SKINCOLOR_CORNFLOWER
			sonic.state = S_SUPERSONIC_UNTRANSFORM
		end
	elseif sonic.cansuper then
		if sonic.transtimer == nil then
			sonic.transtimer = 1
		else
			sonic.transtimer = $+1
		end
		
		if sonic.transtimer >= 5*TICRATE and sonic.state ~= S_SONIC_TRANSFORM then
			sonic.state = S_SONIC_TRANSFORM
			sonic.transtimer = 0
		end
	end
end, MT_SONIC)