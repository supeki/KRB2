-- Be warned Knuckles, he's not giving up the Chaos Emeralds without a fair fight... hey Sonic why are you glo- AAAA!!-
-- (Super) Sonic Boss Fight by Marilyn. Maybe not reusable, we'll find out soon enough.

freeslot(
	"MT_SONIC",
	"S_SONIC_SPAWN", -- "What's up, Knuckles?"
	"S_SONIC_STND", -- ...
	"S_SONIC_BORED", -- "I'm waaaaaaiting!"
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
	"S_SONIC_DEAD2", -- "NO!..."
	"S_SONIC_TRANSFORM", -- "I'll show you what the Chaos Emeralds can really do!"
	"S_SUPERSONIC_STND", -- ...
	"S_SUPERSONIC_DASH", -- *Nyooooommm!!*
	"S_SUPERSONIC_FALL", -- ...
	"S_SUPERSONIC_UNTRANSFORM", -- ...
	"sfx_whatup",
	"sfx_illsho"
)

states[S_SONIC_SPAWN] = {
	sprite = SPR_PLAY,
	frame = SPR2_STND|A,
	tics = 35,
	action = A_PlaySound,
	var1 = sfx_whatup,
	var2 = 0,
	nextstate = S_SONIC_STND
}

states[S_SONIC_STND] = {
	sprite = SPR_PLAY,
	frame = SPR2_STND|A,
	tics = 17,
	action = A_Look,
	var1 = 2048 << 16 + 1,
	var2 = 1,
	nextstate = S_SONIC_STND
}

states[S_SONIC_WALK] = {
	sprite = SPR_PLAY,
	frame = SPR2_WALK|FF_ANIMATE,
	tics = 105,
	action = nil,
	var1 = 7,
	var2 = 3,
	nextstate = S_SONIC_DECIDE
}

states[S_SONIC_RUN] = {
	sprite = SPR_PLAY,
	frame = SPR2_RUN_|FF_ANIMATE,
	tics = 70,
	action = nil,
	var1 = 4,
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
	tics = 0,
	action = A_SetObjectFlags,
	var1 = MF_NOCLIP|MF_NOCLIPHEIGHT|MF_NOCLIPTHING,
	var2 = 2,
	nextstate = S_SONIC_DEAD2
}

states[S_SONIC_DEAD2] = {
	sprite = SPR_PLAY,
	frame = SPR2_DEAD|A,
	tics = -1,
	nextstate = S_SONIC_DEAD2
}

mobjinfo[MT_SONIC] = {
	spawnstate = S_SONIC_STND,
	spawnhealth = 12, -- Stronger than the average boss.
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
	speed = skins["sonic"].normalspeed, -- Sonic's base normalspeed value :>
	radius = skins["sonic"].radius,
	height = skins["sonic"].height,
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
		
	if sonic.state == S_SONIC_SPAWN
		or sonic.state == S_SONIC_STND
		or sonic.state == S_SONIC_BORED
		or sonic.state == S_SONIC_WALK
		or sonic.state == S_SONIC_RUN
		or sonic.state == S_SONIC_DECIDE
		or sonic.state == S_SONIC_FALL
	then
		return false
	end
	
	if (sonic.state == S_SONIC_HOMING2 or sonic.state == S_SONIC_JUMP or sonic.state == S_SONIC_CHARGE or sonic.state == S_SONIC_SPINDASH) and ((pmo.player.pflags & PF_JUMPED) or (pmo.player.pflags & PF_SPINNING)) then
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
	
	if sonic.invtimer then return false end
	P_InstaThrust(sonic, pmo.angle, 6*FRACUNIT)
	sonic.angle = pmo.angle + ANGLE_180
	P_SetObjectMomZ(sonic, 6*FRACUNIT, false)
	S_StartSound(sonic, sfx_s3kb9)
end, MT_SONIC)

addHook("MobjThinker", function(sonic)
	if not (sonic and sonic.valid) then return end
	sonic.skin = "sonic"
	sonic.color = skins["sonic"].prefcolor
	
	if sonic.z+sonic.height < sonic.subsector.sector.floorheight then P_RemoveMobj(sonic) return end
	if sonic.z > sonic.subsector.sector.ceilingheight then P_RemoveMobj(sonic) return end
	
	if sonic.state == S_SONIC_DEAD then
		P_SetObjectMomZ(sonic, 12*FRACUNIT, false)
		sonic.state = S_SONIC_DEAD2
	end 
	
	if not sonic.health then return end
	
	sonic.flags2 = $ & ~MF2_FRET
	
	if sonic.state == S_SONIC_PAIN then
		sonic.flags = $ & ~MF_SPECIAL
		sonic.flags = $ & ~MF_SHOOTABLE
		
		if P_IsObjectOnGround(sonic) then
			sonic.state = S_SONIC_STND
			sonic.invtimer = 105
		end
		
		return
	elseif sonic.invtimer then
		sonic.flags = $ & ~MF_SPECIAL
		sonic.flags = $ & ~MF_SHOOTABLE
		sonic.invtimer = $ - 1
		
		if not sonic.invtimer then
			sonic.flags = $|MF_SPECIAL
			sonic.flags = $|MF_SHOOTABLE
		end
	end
	
	if not sonic.target then return end
	
	if S_MusicName() ~= "VSSONC" then
		S_ChangeMusic("VSSONC", true)
	end
	
	if sonic.state == S_SONIC_WALK or sonic.state == S_SONIC_RUN then
		if FixedHypot(sonic.momx, sonic.momy) < sonic.info.speed then
			P_Thrust(sonic, sonic.angle, skins["sonic"].acceleration*FRACUNIT/17)
		end
		
		if sonic.angle ~= R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y) and (R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64) > 0 then
			sonic.angle = $ - ($ - R_PointToAngle2(sonic.x, sonic.y, sonic.target.x, sonic.target.y))/(R_PointToDist2(sonic.x, sonic.y, sonic.target.x, sonic.target.y)/FRACUNIT/64)
		end
	end
	
	if sonic.state == S_SONIC_DECIDE then
		if (not ((player.pflags & PF_JUMPED) or (player.pflags & PF_SPINNING))) and not P_IsObjectOnGround(sonic.target) then
			sonic.state = S_SONIC_JUMP
		elseif P_IsObjectOnGround(sonic.target) and not (player.pflags & PF_SPINNING) then
			sonic.state = S_SONIC_CHARGE
		else
			sonic.state = S_SONIC_DECIDE
		end
	end
	
	if sonic.state == S_SONIC_JUMP then
		sonic.flags = $|MF_PAIN
		if sonic.tics == 18 then 
			P_SetObjectMomZ(sonic, 12*skins["sonic"].jumpfactor, true)
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
			sonic.state = S_SONIC_STND
		end
	end
	
	if sonic.state == S_SONIC_HOMING1 then
		sonic.frame = (sonic.tics % 6)
	end
	
	if sonic.state == S_SONIC_HOMING2 then
		if sonic.tics == 70 then S_StartSound(sonic, sfx_thok) end
		P_HomingAttack(sonic, sonic.target)
		local thok = P_SpawnMobjFromMobj(sonic, 0, 0, 0, MT_THOK)
		thok.color = sonic.color
	end
	
	if sonic.state == S_SONIC_FALL then
		sonic.flags = $ & ~MF_PAIN
		if P_IsObjectOnGround(sonic) then
			sonic.state = S_SONIC_STND
		end
	end
	
	if FixedHypot(sonic.momx, sonic.momy) >= skins["sonic"].runspeed*FRACUNIT and sonic.state == S_SONIC_WALK then
		P_SetMobjStateNF(sonic, S_SONIC_RUN)
	elseif FixedHypot(sonic.momx, sonic.momy) < skins["sonic"].runspeed*FRACUNIT and sonic.state == S_SONIC_RUN then
		P_SetMobjStateNF(sonic, S_SONIC_WALK)
	end
end, MT_SONIC)