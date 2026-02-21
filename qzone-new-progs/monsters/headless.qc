//Decompiled code. Please respect the original copyright.
void() head_fire;
void(float offset) head_fireb;
void() head_firec;

void() head_stand1 = [ 27, head_stand2 ]
{
	ai_stand();
};

void() head_stand2 = [ 28, head_stand3 ]
{
	ai_stand();
};

void() head_stand3 = [ 29, head_stand4 ]
{
	ai_stand();
};

void() head_stand4 = [ 30, head_stand5 ]
{
	ai_stand();
};

void() head_stand5 = [ 31, head_stand6 ]
{
	ai_stand();
};

void() head_stand6 = [ 32, head_stand7 ]
{
	ai_stand();
};

void() head_stand7 = [ 33, head_stand8 ]
{
	ai_stand();
};

void() head_stand8 = [ 34, head_stand9 ]
{
	ai_stand();
};

void() head_stand9 = [ 35, head_stand10 ]
{
	ai_stand();
};

void() head_stand10 = [ 36, head_stand1 ]
{
	ai_stand();
};

void() head_walk1 = [ 36, head_walk2 ]
{
	if ((random() < 0.2))
	{
		sound(self, CHAN_VOICE, "soldier/idle.wav", ATTN_NORM, ATTN_IDLE);
	}
	ai_walk(ATTN_NORM);
};

void() head_walk2 = [ 27, head_walk3 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk3 = [ 28, head_walk4 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk4 = [ 29, head_walk5 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk5 = [ 30, head_walk6 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk6 = [ 31, head_walk7 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk7 = [ 32, head_walk8 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk8 = [ 33, head_walk9 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk9 = [ 34, head_walk10 ]
{
	ai_walk(ATTN_NORM);
};

void() head_walk10 = [ 35, head_walk1 ]
{
	ai_walk(ATTN_NORM);
};

void() head_run1 = [ 27, head_run2 ]
{
	if ((random() < 0.2))
	{
		sound(self, CHAN_VOICE, "soldier/idle.wav", ATTN_NORM, ATTN_IDLE);
	}
	ai_run(TE_TELEPORT);
};

void() head_run2 = [ 28, head_run3 ]
{
	ai_run(15);
};

void() head_run3 = [ 29, head_run4 ]
{
	ai_run(MOVETYPE_BOUNCE);
};

void() head_run4 = [ 30, head_run5 ]
{
	ai_run(MOVETYPE_BOUNCE);
};

void() head_run5 = [ 31, head_run6 ]
{
	ai_run(EF_DIMLIGHT);
};

void() head_run6 = [ 32, head_run7 ]
{
	ai_run(15);
};

void() head_run7 = [ 33, head_run8 ]
{
	ai_run(MOVETYPE_BOUNCE);
};

void() head_run8 = [ 34, head_run9 ]
{
	ai_run(EF_DIMLIGHT);
};

void() head_run9 = [ 35, head_run10 ]
{
	ai_run(MOVETYPE_BOUNCE);
};

void() head_run10 = [ 36, head_run1 ]
{
	ai_run(EF_DIMLIGHT);
};

void() head_atk1 = [ 37, head_atk2 ]
{
	ai_face();
};

void() head_atk2 = [ 38, head_atk3 ]
{
	ai_face();
};

void() head_atk3 = [ 39, head_atk4 ]
{
	ai_face();
	head_fire();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void() head_atk4 = [ 40, head_atk5 ]
{
	ai_face();
	SUB_CheckRefire(head_atk1);
};

void() head_atk5 = [ 41, head_atk6 ]
{
	ai_face();
};

void() head_atk6 = [ 42, head_atk7 ]
{
	ai_face();
};

void() head_atk7 = [ 40, head_run1 ]
{
	ai_face();
};

void() head_atk1b = [ 0, head_atk2b ]
{
	ai_face();
};

void() head_atk2b = [ 1, head_atk3b ]
{
	ai_face();
};

void() head_atk3b = [ 2, head_atk4b ]
{
	ai_face();
};

void() head_atk4b = [ 3, head_atk5b ]
{
	ai_face();
};

void() head_atk5b = [ 4, head_atk6b ]
{
	ai_face();
	head_fireb(ATTN_NORM);
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void() head_atk6b = [ 5, head_atk7b ]
{
	ai_face();
	head_fireb(SOLID_NOT);
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void() head_atk7b = [ 6, head_atk8b ]
{
	ai_face();
	head_fireb(CONTENT_EMPTY);
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void() head_atk8b = [ 7, head_atk9b ]
{
	ai_face();
	SUB_CheckRefire(head_atk1b);
};

void() head_atk9b = [ 1, head_run1 ]
{
	ai_face();
	SUB_CheckRefire(head_atk1b);
};

void() head_atk1c = [ 8, head_atk2c ]
{
	ai_face();
};

void() head_atk2c = [ 9, head_atk3c ]
{
	ai_face();
};

void() head_atk3c = [ 9, head_atk4c ]
{
	ai_face();
};

void() head_atk4c = [ 10, head_atk5c ]
{
	ai_face();
};

void() head_atk5c = [ 10, head_atk6c ]
{
	ai_face();
};

void() head_atk6c = [ 10, head_atk7c ]
{
	ai_face();
};

void() head_atk7c = [ 11, head_atk8c ]
{
	ai_face();
};

void() head_atk8c = [ 11, head_atk9c ]
{
	ai_face();
	SUB_CheckRefire(head_atk1c);
};

void() head_atk9c = [ 11, head_atk10c ]
{
	ai_face();
};

void() head_atk10c = [ 11, head_atk11c ]
{
	ai_face();
};

void() head_atk11c = [ 12, head_atk12c ]
{
	ai_face();
	head_firec();
	self.effects = (self.effects | EF_MUZZLEFLASH);
};

void() head_atk12c = [ 13, head_atk13c ]
{
	ai_face();
};

void() head_atk13c = [ 14, head_atk14c ]
{
	ai_face();
};

void() head_atk14c = [ 15, head_atk15c ]
{
	ai_face();
};

void() head_atk15c = [ 16, head_atk16c ]
{
	ai_face();
};

void() head_atk16c = [ 17, head_atk17c ]
{
	ai_face();
};

void() head_atk17c = [ 18, head_atk18c ]
{
	ai_face();
};

void() head_atk18c = [ 19, head_atk19c ]
{
	ai_face();
};

void() head_atk19c = [ 20, head_atk20c ]
{
	ai_face();
};

void() head_atk20c = [ 21, head_atk21c ]
{
	ai_face();
};

void() head_atk21c = [ 22, head_atk22c ]
{
	ai_face();
};

void() head_atk22c = [ 23, head_atk23c ]
{
	ai_face();
};

void() head_atk23c = [ 24, head_run1 ]
{
	ai_face();
};

void() head_pain1 = [ 25, head_pain2 ]
{
};

void() head_pain2 = [ 26, head_run1 ]
{
	ai_pain(ATTN_NORM);
};

void() head_attack =
{
	local float r;

	r = random();
	if ((r < 0.4))
	{
		if ((((self.skin == ATTN_NORM) || (self.skin == EF_MUZZLEFLASH)) || (self.skin == SOLID_NOT)))
		{
			head_atk1();
		}
	}
	else
	{
		if ((r < 0.8))
		{
			if (((self.skin == ATTN_NORM) || (self.skin == EF_MUZZLEFLASH)))
			{
				head_atk1b();
			}
		}
		else
		{
			if ((self.skin == EF_MUZZLEFLASH))
			{
				head_atk1c();
			}
		}
	}
};

void(entity attacker, float damage) head_pain =
{
	local float r;

	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + 0.6);
	head_pain1();
	sound(self, CHAN_VOICE, "soldier/pain1.wav", ATTN_NORM, ATTN_NORM);
};

void() head_fire =
{
	local vector dir;
	local entity en;

	ai_face();
	sound(self, CHAN_WEAPON, "soldier/sattck1.wav", CHAN_WEAPON, ATTN_NORM);
	en = self.enemy;
	dir = (en.origin - (en.velocity * 0.2));
	dir = normalize((dir - self.origin));
	FireBullets(MOVETYPE_STEP, dir, 0.1);
};

void(float offset) head_fireb =
{
	local vector offang;
	local vector org;
	local vector vec;

	offang = vectoangles((self.enemy.origin - self.origin));
	offang_y = (offang_y + (offset * MOVETYPE_TOSS));
	makevectors(offang);
	org = (((self.origin + self.mins) + (self.size * 0.5)) + (v_forward * 20));
	vec = normalize(v_forward);
	vec_z = ((SOLID_NOT - vec_z) + ((random() - 0.5) * 0.1));
	launch_spike(org, vec);
	newmis.classname = "bluesphere";
	setmodel(newmis, "progs/sphere2.mdl");
	setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.velocity = (vec * 700);
	sound(self, CHAN_WEAPON, "soldier/sattck1.wav", CHAN_WEAPON, ATTN_NORM);
};

void() head_firec =
{
	local vector vec;
	local vector dst;

	makevectors(self.enemy.angles);
	dst = (self.enemy.origin - (13 * self.movedir));
	vec = normalize((dst - self.origin));
	launch_spike(self.origin, vec);
	newmis.classname = "redsphere";
	setmodel(newmis, "progs/sphere.mdl");
	setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
	newmis.velocity = (vec * 600);
	sound(self, CHAN_WEAPON, "soldier/sattck1.wav", CHAN_WEAPON, ATTN_NORM);
};

void() head_die1 = [ 43, head_die2 ]
{
};

void() head_die2 = [ 44, head_die3 ]
{
};

void() head_die3 = [ 45, head_die4 ]
{
};

void() head_die4 = [ 47, head_die5 ]
{
	self.solid = SOLID_NOT;
	self.ammo_shells = MOVETYPE_BOUNCE;
	DropBackpack();
};

void() head_die5 = [ 49, head_die6 ]
{
};

void() head_die6 = [ 51, head_die7 ]
{
};

void() head_die7 = [ 52, head_die8 ]
{
};

void() head_die8 = [ 53, head_die9 ]
{
};

void() head_die9 = [ 54, head_die10 ]
{
};

void() head_die10 = [ 55, head_die10 ]
{
};

void() head_die =
{
	if ((self.health < -35))
	{
		sound(self, CHAN_VOICE, "player/udeath.wav", ATTN_NORM, ATTN_NORM);
		ThrowHead("progs/arm2.mdl", self.health);
		ThrowGib("progs/gib1.mdl", self.health);
		ThrowGib("progs/gib2.mdl", self.health);
		ThrowGib("progs/gib3.mdl", self.health);
		return;
	}
	sound(self, CHAN_VOICE, "soldier/death1.wav", ATTN_NORM, ATTN_NORM);
	head_die1();
};

void() monster_headless =
{
	local float r;

	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model("progs/sphere.mdl");
	precache_model("progs/sphere2.mdl");
	precache_model("progs/headless.mdl");
	precache_model("progs/arm2.mdl");
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
	setmodel(self, "progs/headless.mdl");
	setsize(self, VEC_HULL_MIN, '16 16 60');
	r = random();
	if ((r < 0.5))
	{
		self.skin = SOLID_NOT;
		self.health = SVC_INTERMISSION;
	}
	else
	{
		if ((r < 0.8))
		{
			self.skin = ATTN_NORM;
			self.health = 50;
		}
		else
		{
			self.skin = CHAN_VOICE;
			self.health = 60;
		}
	}
	self.th_stand = head_stand1;
	self.th_walk = head_walk1;
	self.th_run = head_run1;
	self.th_missile = head_attack;
	self.th_pain = head_pain;
	self.th_die = head_die;

			//gnounc
	self.noise = "soldier/sight1.wav";	//gnounc
	self.netname = "Headless";
	self.killstring = " loses their head to a Headless\n";

	walkmonster_start();
};