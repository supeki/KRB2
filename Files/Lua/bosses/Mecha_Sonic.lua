-- Originally made for the Speccy Expansion Pack.
-- By Marilyn, not reusable.

freeslot(
	"SPR_MEST",
	"SPR_MEFL",
	"SPR_MECH",
	"SPR_MECB",
	"SPR_MEUC",
	"SPR_MESP",
	"SPR_MEDA",
	"SPR_MEDB",
	"SPR_MTSC",
	"SPR_MECG",
	"SPR_METR",
	"S_MECHASONIC_STAND",
	"S_MECHASONIC_DASH",
	"S_MECHASONIC_DASHBACKWARDS",
	"S_MECHASONIC_FALL",
	"S_MECHASONIC_CROUCH",
	"S_MECHASONIC_UNCROUCH",
	"S_MECHASONIC_SPIN",
	"S_MECHASONIC_ANOTHERSPIN",
	"S_MECHASONIC_PAIN",
	"S_MECHASONIC_DEAD",
	"S_MECHASONIC_CHARGE",
	"S_MECHASONIC_CHARGESTILL",
	"S_MECHASONIC_TRANSFORM",
	"MT_MECHASONIC",
	"SPR_SMDA",
	"SPR_SMEY",
	"S_SUPERMECHASONIC_DASH",
	"S_SUPERMECHASONIC_EYEATTACK",
	"S_SUPERMECHASONIC_FLOAT"
)

mobjinfo[MT_MECHASONIC] = {
        spawnstate = S_MECHASONIC_FALL,
        spawnhealth = 12,
        seestate = S_MECHASONIC_DASH,
        seesound = sfx_none,
        reactiontime = 0,
        attacksound = sfx_none,
        painstate = S_MECHASONIC_PAIN,
        painchance = MT_THOK,
        painsound = sfx_s3k6e,
        meleestate = S_NULL,
        missilestate = S_NULL,
        deathstate = S_MECHASONIC_DEAD,
        xdeathstate = S_NULL,
        deathsound = sfx_s3k6e,
        speed = 36*FRACUNIT,
        radius = 48*FRACUNIT,
        height = 96*FRACUNIT,
        dispoffset = 0,
        mass = 0,
        damage = 0,
        activesound = sfx_none,
        flags = MF_SPECIAL|MF_SHOOTABLE|MF_BOSS,
        raisestate = MT_THOK
}

states[S_MECHASONIC_STAND] = {
	sprite = SPR_MEST,
	frame = A,
	tics = 70,
	var1 = 0,
	var2 = 0,
	nextstate = S_MECHASONIC_CROUCH
}

states[S_MECHASONIC_FALL] = {
	sprite = SPR_MEFL,
	frame = A,
	tics = 1,
	var1 = 0,
	var2 = 0,
	nextstate = S_MECHASONIC_FALL
}

states[S_MECHASONIC_CROUCH] = {
	sprite = SPR_MECH,
	frame = A|FF_ANIMATE,
	tics = 12,
	var1 = 1,
	var2 = 6,
	nextstate = S_MECHASONIC_DASH
}

states[S_MECHASONIC_UNCROUCH] = {
	sprite = SPR_MEUC,
	frame = A|FF_ANIMATE,
	tics = 18,
	var1 = 1,
	var2 = 9,
	nextstate = S_MECHASONIC_STAND
}

states[S_MECHASONIC_DASH] = {
	sprite = SPR_MECH,
	frame = B,
	tics = 35,
	var1 = 3,
	var2 = 0,
	nextstate = S_MECHASONIC_UNCROUCH
}

states[S_MECHASONIC_DASHBACKWARDS] = {
	sprite = SPR_MECB,
	frame = A,
	tics = 35,
	var1 = 3,
	var2 = 0,
	nextstate = S_MECHASONIC_UNCROUCH
}

states[S_MECHASONIC_DEAD] = {
	sprite = SPR_MEDA,
	frame = A,
	tics = -1,
	var1 = 0,
	var2 = 0
}

states[S_MECHASONIC_SPIN] = {
	sprite = SPR_MESP,
	frame = A|FF_ANIMATE,
	tics = -1,
	var1 = 1,
	var2 = 5
}

states[S_MECHASONIC_ANOTHERSPIN] = {
	sprite = SPR_MESP,
	frame = A|FF_ANIMATE,
	tics = -1,
	var1 = 1,
	var2 = 5
}

states[S_MECHASONIC_CHARGE] = {
	sprite = SPR_MECG,
	frame = A|FF_ANIMATE,
	tics = 20,
	var1 = 3,
	var2 = 5,
	nextstate = S_MECHASONIC_CHARGESTILL
}

states[S_MECHASONIC_CHARGESTILL] = {
	sprite = SPR_MECG,
	frame = D,
	tics = 105,
	var1 = 0,
	var2 = 0,
	nextstate = S_MECHASONIC_CROUCH
}

states[S_MECHASONIC_TRANSFORM] = {
	sprite = SPR_METR,
	frame = A|FF_ANIMATE,
	tics = 20,
	var1 = 3,
	var2 = 5,
	nextstate = S_SUPERMECHASONIC_DASH
}

states[S_SUPERMECHASONIC_DASH] = {
	sprite = SPR_SMDA,
	frame = A,
	tics = -1,
	var1 = 0,
	var2 = 0
}

states[S_SUPERMECHASONIC_EYEATTACK] = {
	sprite = SPR_SMEY,
	frame = A,
	tics = -1,
	var1 = 0,
	var2 = 0
}

states[S_SUPERMECHASONIC_FLOAT] = {
	sprite = SPR_MEFL,
	frame = A,
	tics = -1,
	var1 = 0,
	var2 = 0
}

addHook("MobjDamage", function(mecha, inf, src, dmg)
	mecha.flags2 = $|MF2_FRET
	mecha.invuln = 105
	mecha.health = $ - dmg
	S_StartSound(mecha, sfx_s3k6e)
	return true
end, MT_MECHASONIC)

addHook("MobjThinker", function(mecha)
	if not (mecha and mecha.valid) then return end
	mecha.spritexscale = FRACUNIT/2*3
	mecha.spriteyscale = FRACUNIT/2*3
	if mecha.phase < 1 then
		if mecha.state == S_MECHASONIC_FALL and P_IsObjectOnGround(mecha) then
			P_StartQuake(8*FRACUNIT, 5)
			S_StartSound(mecha, sfx_s3k5f)
			if mecha.health > 4 then
				if (P_RandomRange(1, 2) == 2) or leveltime < 10*TICRATE then
					mecha.state = S_MECHASONIC_UNCROUCH
				else
					mecha.state = S_MECHASONIC_DASHBACKWARDS
				end
			else
				if (P_RandomRange(1, 4) == 2) then
					mecha.state = S_MECHASONIC_UNCROUCH
				else
					mecha.state = S_MECHASONIC_DASHBACKWARDS
				end
			end
		end
		
		if leveltime < 3*TICRATE then
			mecha.flags = $ & ~(MF_SPECIAL|MF_SHOOTABLE)
			if leveltime >= 1*TICRATE+8+TICRATE/4 then
				if leveltime == 1*TICRATE+8+TICRATE/4 then
					S_StartSoundAtVolume(mecha, sfx_s3k4e, 1000)
					local explosion = P_SpawnMobj(mecha.x, mecha.y, mecha.z-128*FRACUNIT, MT_BOSSEXPLODE)
					explosion.scale = 4*FRACUNIT
					for i=0,7 do
						local scrap = P_SpawnMobj(mecha.x+P_RandomRange(-16, 16)*FRACUNIT, mecha.y+P_RandomRange(-16, 16)*FRACUNIT, mecha.z-128*FRACUNIT, MT_BOSSJUNK)
						scrap.angle = i*ANGLE_45
						scrap.sprite = SPR_MTSC
						scrap.frame = i
						scrap.color = SKINCOLOR_COBALT
						P_SetObjectMomZ(scrap, 8*FRACUNIT, false)
						P_InstaThrust(scrap, scrap.angle, 6*FRACUNIT)
					end
				end
				mecha.tracer.z = mecha.z + 2048*FRACUNIT
				mecha.tracer.spriteyscale = FRACUNIT/10
				mecha.tracer.flags2 = $|MF2_DONTDRAW
				local explosions = P_SpawnMobj(mecha.x+P_RandomRange(-16, 16)*FRACUNIT, mecha.y+P_RandomRange(-16, 16)*FRACUNIT, mecha.z+P_RandomRange(-16, 16)*FRACUNIT, MT_SONIC3KBOSSEXPLODE)
				explosions.scale = 2*FRACUNIT
				if leveltime % 5 == 0 then
					S_StartSoundAtVolume(mecha, sfx_s3k6e, 400)
				end
			end
			return
		elseif leveltime == 3*TICRATE then
			mecha.flags = $|(MF_SPECIAL|MF_SHOOTABLE)
			S_ChangeMusic("VSMECH", true)
		end
		
		if mecha.health < 1 then 
			if mecha.state ~= S_MECHASONIC_DEAD then
				mecha.state = S_MECHASONIC_DEAD
			end
			mecha.flags2 = $ & ~MF2_FRET
			if leveltime % P_RandomRange(25,29) == 0 then
				S_StartSound(mecha, sfx_s3k5c)
			end
			mecha.phase = 2
			return 
		end
		
		if mecha.invuln then
			mecha.invuln = $ - 1
			mecha.flags = $ & ~(MF_SPECIAL|MF_SHOOTABLE)
		else
			mecha.flags2 = $ & ~MF2_FRET
			mecha.flags = $|(MF_SPECIAL|MF_SHOOTABLE)
		end
		
		if mecha.state == S_MECHASONIC_STAND then
			P_LookForPlayers(mecha, 4096*FRACUNIT, true, false)
			if mecha.target then
				if mecha.angle ~= R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
					if R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) < ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
						mecha.angle = $ + (R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) - $)/8
					else
						mecha.angle = $ - (ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) + $)/8
					end
				end
			end
		end
		
		if mecha.state ~= S_MECHASONIC_STAND and mecha.laststate == S_MECHASONIC_STAND then
			if mecha.lastattack == "dash" or mecha.lastattack == "dash2" then
				mecha.state = S_MECHASONIC_SPIN
				mecha.z = $+8*FRACUNIT
				if mecha.health > 4 then
					P_InstaThrust(mecha, mecha.angle, 12*FRACUNIT)
					P_SetObjectMomZ(mecha, 16*FRACUNIT, false)
				else
					P_InstaThrust(mecha, mecha.angle, 24*FRACUNIT)
					P_SetObjectMomZ(mecha, 8*FRACUNIT, false)
				end
				mecha.lastattack = "bounce"
			end
		end
		
		if mecha.state == S_MECHASONIC_SPIN then
			mecha.flags = $|MF_PAIN
			if P_IsObjectOnGround(mecha) then
				if mecha.lastattack == "bounce" then
					P_StartQuake(32*FRACUNIT, 5)
					S_StartSound(mecha, sfx_s3k5f)
					if P_RandomRange(1, 3) ~= 1 then
						if mecha.health > 4 then
							P_InstaThrust(mecha, mecha.angle, 12*FRACUNIT)
							P_SetObjectMomZ(mecha, 16*FRACUNIT, false)
						else
							P_InstaThrust(mecha, mecha.angle, 24*FRACUNIT)
							P_SetObjectMomZ(mecha, 4*FRACUNIT, false)
						end
						mecha.z = $+8*FRACUNIT
						mecha.lastattack = "bounce2"
					else
						S_StartSoundAtVolume(mecha, sfx_spin, 1500)
						P_InstaThrust(mecha, mecha.angle, 48*FRACUNIT)
						mecha.lastattack = "spin"
					end
				elseif mecha.lastattack == "spin" then
					if mecha.health > 4 then
						P_Thrust(mecha, mecha.angle, -FRACUNIT/(TICRATE/4))
					else
						if mecha.angle ~= R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
							if R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) < ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
								mecha.angle = $ + (R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) - $)/4
							else
								mecha.angle = $ - (ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) + $)/4
							end
						end
						P_Thrust(mecha, mecha.angle, -FRACUNIT/(TICRATE/8))
					end
					if abs(mecha.momx) + abs(mecha.momy) < FRACUNIT then
						mecha.state = S_MECHASONIC_UNCROUCH
					end
				else
					if mecha.health > 4 then
						mecha.state = S_MECHASONIC_DASHBACKWARDS
						mecha.lastattack = "dash"
					else
						if P_RandomRange(1, 3) == 1 then
							mecha.state = S_MECHASONIC_DASHBACKWARDS
							mecha.lastattack = "dash"
						else
							mecha.flags = $ & ~MF_PAIN
							mecha.state = S_MECHASONIC_UNCROUCH
						end
					end	
				end
			end
		end
		
		if mecha.state == S_MECHASONIC_SPIN and mecha.lastattack == "bounce2" and mecha.momz == 0 then
			mecha.state = S_MECHASONIC_FALL
			mecha.flags = $ & ~MF_PAIN
			P_SetObjectMomZ(mecha, -4*FRACUNIT, true)
			P_InstaThrust(mecha, mecha.angle, 0)
			if mecha.target then
				if mecha.angle ~= R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
					if R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) < ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
						mecha.angle = $ + (R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) - $)/8
					else
						mecha.angle = $ - (ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) + $)/8
					end
				end
			end
		end
		
		if mecha.state == S_MECHASONIC_SPIN then
			local ghost = P_SpawnGhostMobj(mecha)
			ghost.spritexscale = FRACUNIT/2*3
			ghost.spriteyscale = FRACUNIT/2*3
			ghost.blendmode = AST_ADD
		end
		
		if mecha.state == S_MECHASONIC_CROUCH or mecha.state == S_MECHASONIC_UNCROUCH then
			P_LookForPlayers(mecha, 4096*FRACUNIT, true, false)
			if mecha.target then
				if mecha.angle ~= R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
					if R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) < ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) then
						mecha.angle = $ + (R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) - $)/8
					else
						mecha.angle = $ - (ANGLE_MAX-R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y) + $)/8
					end
				end
			end
			
			if mecha.state == S_MECHASONIC_CROUCH then
				if mecha.dodgetimer == 18 then
					S_StartSoundAtVolume(mecha, sfx_spndsh, 1750)
					mecha.dodgetimer = $+1
				else
					mecha.dodgetimer = $+1
				end
			end
		end
		
		if mecha.state == S_MECHASONIC_DASH or mecha.state == S_MECHASONIC_DASHBACKWARDS then
			mecha.dodgetimer = 0
			mecha.flags = $|MF_PAIN
			local ghost = P_SpawnGhostMobj(mecha)
			ghost.spritexscale = FRACUNIT/2*3
			ghost.spriteyscale = FRACUNIT/2*3
			ghost.blendmode = AST_ADD
			if mecha.lastattack ~= "dash2" then
				mecha.lastattack = "dash"
			end
			if mecha.laststate ~= S_MECHASONIC_DASH and mecha.laststate ~= S_MECHASONIC_DASHBACKWARDS then
				if mecha.state == S_MECHASONIC_DASHBACKWARDS then
					mecha.angle = $ + ANGLE_180
				end
				S_StartSoundAtVolume(mecha, sfx_s3kb6, 1500)
			end
			if mecha.health > 4 then
				P_InstaThrust(mecha, mecha.angle, 48*FRACUNIT)
			else
				P_InstaThrust(mecha, mecha.angle, 72*FRACUNIT) -- requested by a friend-
			end
		end
		
		if mecha.state == S_MECHASONIC_UNCROUCH then
			if mecha.health > 4 then
				mecha.flags = $ & ~MF_PAIN
				if mecha.laststate == S_MECHASONIC_DASHBACKWARDS then
					mecha.angle = $ + ANGLE_180
				end
			else
				if mecha.lastattack == "dash" then
					mecha.lastattack = "dash2"
					mecha.angle = R_PointToAngle2(mecha.x, mecha.y, mecha.target.x, mecha.target.y)
					if mecha.laststate == S_MECHASONIC_DASHBACKWARDS then
						mecha.state = S_MECHASONIC_DASH
						S_StartSoundAtVolume(mecha, sfx_s3kb6, 1500)
					else
						mecha.state = S_MECHASONIC_DASHBACKWARDS
						S_StartSoundAtVolume(mecha, sfx_s3kb6, 1500)
					end
				else
					mecha.flags = $ & ~MF_PAIN
					if mecha.laststate == S_MECHASONIC_DASHBACKWARDS then
						mecha.angle = $ + ANGLE_180
					end
				end
			end
		end
		
		mecha.laststate = mecha.state
		
	else
	
		-- I scraped Super Mecha.
		
		if mecha.tracer.health then
			mecha.tracer.flags = $ & ~MF_NOTHINK
			P_KillMobj(mecha.tracer, mecha, mecha)
			S_ChangeMusic("BCZ2", true)
		end
	
	end
end, MT_MECHASONIC)

addHook("MobjThinker", function(metal)
	if leveltime > TICRATE then return end
	local mecha = P_SpawnMobj(metal.x, metal.y, metal.z + 768*FRACUNIT, MT_MECHASONIC)
	mecha.angle = metal.angle
	mecha.tracer = metal
	mecha.phase = 0
	mecha.downtimer = 0
	mecha.dodgetimer = 0
	mecha.charge = 0
	mecha.spawncoords = {x = mecha.x, y = mecha.y, z = mecha.z}
	mecha.spawnangle = metal.angle
	metal.flags = $|MF_NOTHINK
	metal.flags = $ & ~(MF_SHOOTABLE|MF_SPECIAL|MF_ENEMY)
	metal.shadowscale = 0
end, MT_METALSONIC_BATTLE)