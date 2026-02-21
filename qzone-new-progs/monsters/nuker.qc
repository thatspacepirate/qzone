//Decompiled code. Please respect the original copyright.
void() EggTouch;
void() SpawnFriendEgg;
void() nuker_fire;

void(string soundone, string soundtwo) nukesound =
{
	if ((random() < 0.5))
	{
		if ((random() < 0.5))
		{
			sound(self, CHAN_VOICE, soundone, ATTN_NORM, ATTN_IDLE);
		}
		else
		{
			sound(self, CHAN_VOICE, soundtwo, ATTN_NORM, ATTN_IDLE);
		}
	}
};

void() nuker_stand1 = [ 0, nuker_stand2 ]
{
	ai_stand();
	nukesound("nukehap1.wav", "nukehap2.wav");
};

void() nuker_stand2 = [ 1, nuker_stand3 ]
{
	ai_stand();
};

void() nuker_stand3 = [ 2, nuker_stand4 ]
{
	ai_stand();
};

void() nuker_stand4 = [ 3, nuker_stand5 ]
{
	ai_stand();
};

void() nuker_stand5 = [ 4, nuker_stand6 ]
{
	ai_stand();
};

void() nuker_stand6 = [ 5, nuker_stand7 ]
{
	ai_stand();
};

void() nuker_stand7 = [ 6, nuker_stand8 ]
{
	ai_stand();
};

void() nuker_stand8 = [ 7, nuker_stand9 ]
{
	ai_stand();
};

void() nuker_stand9 = [ 8, nuker_stand10 ]
{
	ai_stand();
};

void() nuker_stand10 = [ 9, nuker_stand1 ]
{
	ai_stand();
};

void() nuker_walk1 = [ 0, nuker_walk2 ]
{
	nukesound("nukehap1.wav", "nukehap2.wav");
	ai_walk(ATTN_NORM);
};

void() nuker_walk2 = [ 1, nuker_walk3 ]
{
	ai_walk(ATTN_NORM);
};

void() nuker_walk3 = [ 2, nuker_walk4 ]
{
	ai_walk(ATTN_NORM);
};

void() nuker_walk4 = [ 3, nuker_walk5 ]
{
	ai_walk(ATTN_NORM);
};

void() nuker_walk5 = [ 4, nuker_walk6 ]
{
	ai_walk(ATTN_IDLE);
};

void() nuker_walk6 = [ 5, nuker_walk7 ]
{
	ai_walk(SOLID_SLIDEBOX);
};

void() nuker_walk7 = [ 6, nuker_walk8 ]
{
	ai_walk(MOVETYPE_STEP);
};

void() nuker_walk8 = [ 7, nuker_walk9 ]
{
	ai_walk(ATTN_IDLE);
};

void() nuker_walk9 = [ 8, nuker_walk10 ]
{
	ai_walk(SOLID_SLIDEBOX);
};

void() nuker_walk10 = [ 9, nuker_walk1 ]
{
	ai_walk(MOVETYPE_STEP);
};

void() nuker_run1 = [ 10, nuker_run2 ]
{
	nukesound("nukehap1.wav", "nukehap2.wav");
	ai_run(TE_TELEPORT);
};

void() nuker_run2 = [ 11, nuker_run3 ]
{
	ai_run(15);
};

void() nuker_run3 = [ 12, nuker_run4 ]
{
	ai_run(TE_LAVASPLASH);
};

void() nuker_run4 = [ 13, nuker_run5 ]
{
	ai_run(TE_LAVASPLASH);
};

void() nuker_run5 = [ 14, nuker_run6 ]
{
	ai_run(EF_DIMLIGHT);
};

void() nuker_run6 = [ 15, nuker_run7 ]
{
	ai_run(15);
};

void() nuker_run7 = [ 16, nuker_run8 ]
{
	ai_run(TE_LAVASPLASH);
};

void() nuker_run8 = [ 17, nuker_run9 ]
{
	ai_run(EF_DIMLIGHT);
};

void() nuker_run9 = [ 18, nuker_run10 ]
{
	ai_run(15);
};

void() nuker_run10 = [ 19, nuker_run11 ]
{
	ai_run(TE_LAVASPLASH);
};

void() nuker_run11 = [ 20, nuker_run12 ]
{
	ai_run(TE_LAVASPLASH);
};

void() nuker_run12 = [ 21, nuker_run13 ]
{
	ai_run(EF_DIMLIGHT);
};

void() nuker_run13 = [ 22, nuker_run14 ]
{
	ai_run(15);
};

void() nuker_run14 = [ 23, nuker_run15 ]
{
	ai_run(TE_LAVASPLASH);
};

void() nuker_run15 = [ 24, nuker_run16 ]
{
	ai_run(EF_DIMLIGHT);
};

void() nuker_run16 = [ 25, nuker_run1 ]
{
	ai_run(EF_DIMLIGHT);
};

void() nuker_atk1 = [ 26, nuker_atk2 ]
{
	ai_face();
};

void() nuker_atk2 = [ 27, nuker_atk3 ]
{
	ai_face();
};

void() nuker_atk3 = [ 28, nuker_atk4 ]
{
	ai_face();
};

void() nuker_atk4 = [ 29, nuker_atk5 ]
{
	ai_face();
};

void() nuker_atk5 = [ 30, nuker_atk6 ]
{
	ai_face();
	nuker_fire();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void() nuker_atk6 = [ 31, nuker_atk7 ]
{
	ai_face();
};

void() nuker_atk7 = [ 32, nuker_atk8 ]
{
	ai_face();
	SUB_CheckRefire(nuker_atk1);
};

void() nuker_atk8 = [ 33, nuker_atk9 ]
{
	ai_face();
};

void() nuker_atk9 = [ 34, nuker_atk10 ]
{
	ai_face();
};

void() nuker_atk10 = [ 35, nuker_atk11 ]
{
	ai_face();
};

void() nuker_atk11 = [ 36, nuker_atk12 ]
{
	ai_face();
};

void() nuker_atk12 = [ 37, nuker_atk13 ]
{
	ai_face();
};

void() nuker_atk13 = [ 38, nuker_atk14 ]
{
	ai_face();
};

void() nuker_atk14 = [ 39, nuker_run1 ]
{
	ai_face();
};

void() nuker_pain1 = [ 40, nuker_pain2 ]
{
};

void() nuker_pain2 = [ 41, nuker_pain3 ]
{
};

void() nuker_pain3 = [ 42, nuker_pain4 ]
{
};

void() nuker_pain4 = [ 43, nuker_pain5 ]
{
};

void() nuker_pain5 = [ 42, nuker_run1 ]
{
	ai_pain(ATTN_NORM);
};

void(entity attacker, float damage) nuker_pain =
{
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 0.6);
	nuker_pain1();
	if ((random() < 0.3))
	{
		sound(self, CHAN_VOICE, "nukehrt1.wav", ATTN_NORM, ATTN_NORM);
	}
	else
	{
		if ((random() < 0.5))
		{
			sound(self, CHAN_VOICE, "nukehrt2.wav", ATTN_NORM, ATTN_NORM);
		}
		else
		{
			sound(self, CHAN_VOICE, "nukehrt3.wav", ATTN_NORM, ATTN_NORM);
		}
	}
};

void() nuker_fire =
{
	local vector dir;
	local entity en;

	ai_face();
	sound(self, CHAN_WEAPON, "soldier/sattck1.wav", CHAN_WEAPON, ATTN_NORM);
	en = self.enemy;
	dir = (en.origin - (en.velocity * 0.2));
	dir = normalize((dir - self.origin));
	SpawnFriendEgg();
};

void() EggTouch =
{
	local entity oldself;

	self.angles = self.owner.angles;
	self.owner = world;
	self.classname = "monster_flyer";
	self.origin = (self.origin + '0 0 64');
	monster_flyer();
	walkmonster_start_go();
	FoundTarget();
};

void() SpawnFriendEgg =
{
	local entity missile;
	local entity mpuff;

	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.classname = "grenade";
	missile.touch = EggTouch;
	missile.nextthink = (time + ATTN_NORM);
	missile.think = EggTouch;
	makevectors(self.v_angle);
	missile.velocity = ((v_forward * 300) + (v_up * 50));
	missile.angles = vectoangles(missile.velocity);
	setmodel(missile, "progs/flyer.mdl");
	setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(missile, self.origin);
};

void(string gunname) Throw_Gun =
{
	local entity missile;
	local entity mpuff;

	self.punchangle_x = CONTENT_SOLID;
	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_NOT;
	makevectors(self.v_angle);
	missile.velocity = ((((v_forward * 100) + (v_up * 300)) + ((crandom() * v_right) * 100)) + ((crandom() * v_up) * 100));
	missile.avelocity = '100 100 100';
	missile.angles = vectoangles(missile.velocity);
	missile.nextthink = (time + 2.5);
	missile.think = SUB_Remove;
	setmodel(missile, gunname);
	setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(missile, self.origin);
};

void() nuker_die =
{
	local entity missile;
	local entity mpuff;

	if ((self.health < -35))
	{
		sound(self, CHAN_VOICE, "player/udeath.wav", ATTN_NORM, ATTN_NORM);
		ThrowHead("progs/nukebase.mdl", self.health);
		ThrowGib("progs/nukegun.mdl", self.health);
		ThrowGib("progs/gib1.mdl", self.health);
		ThrowGib("progs/gib3.mdl", self.health);
		return;
	}
	Throw_Gun("progs/nukebase.mdl");
	Throw_Gun("progs/nukegun.mdl");
	self.angles = self.owner.angles;
	self.owner = world;
	self.punchangle_x = CONTENT_SOLID;
	missile = spawn();
	missile.owner = self;
	self.classname = "monster_nukermad";
	self.frags = CHAN_VOICE;
	self.origin = (self.origin + '0 0 41');
//	self.flags = (self.flags | FL_NUKER);
	monster_nukermad(); //spawn nuker? ERROR
	FoundTarget();
	walkmonster_start_go();
};

void() monster_nuker =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model("progs/nuker.mdl");
	precache_model("progs/nukebase.mdl");
	precache_model("progs/nukegun.mdl");
	precache_model("progs/h_guard.mdl");
	precache_model("progs/gib1.mdl");
	precache_model("progs/gib2.mdl");
	precache_model("progs/gib3.mdl");
	precache_sound("soldier/death1.wav");
	precache_sound("soldier/idle.wav");
	precache_sound("soldier/pain1.wav");
	precache_sound("soldier/pain2.wav");
	precache_sound("soldier/sattck1.wav");
	precache_sound("soldier/sight1.wav");
	precache_sound("player/udeath.wav");
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "progs/nuker.mdl");
	setsize(self, VEC_HULL_MIN, '16 16 40');
	self.health = 80;
	self.th_stand = nuker_stand1;
	self.th_walk = nuker_walk1;
	self.th_run = nuker_run1;
	self.th_missile = nuker_atk1;
	self.th_melee = nuker_atk1;
	self.th_pain = nuker_pain;
	self.th_die = nuker_die;

			//gnounc
	self.noise = "nukesee.wav";	//gnounc
	self.netname = "Nuker";
	self.killstring = " got torn apart by a Nuker\n";
	walkmonster_start();
};