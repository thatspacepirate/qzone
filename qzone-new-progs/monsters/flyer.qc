//Decompiled code. Please respect the original copyright.
void(float side) Flyer_Melee;

void() slime_idlesound =
{
	if ((random() < 0.2))
	{
		if ((random() < 0.5))
		{
			if ((random() < 0.33))
			{
				sound(self, CHAN_VOICE, "slimhap1.wav", ATTN_NORM, ATTN_IDLE);
			}
			else
			{
				if ((random() < 0.5))
				{
					sound(self, CHAN_VOICE, "slimhap2.wav", ATTN_NORM, ATTN_IDLE);
				}
				else
				{
					sound(self, CHAN_VOICE, "slimhap3.wav", ATTN_NORM, ATTN_IDLE);
				}
			}
		}
		else
		{
			if ((random() < 0.33))
			{
				sound(self, CHAN_VOICE, "slimhap4.wav", ATTN_NORM, ATTN_IDLE);
			}
			else
			{
				if ((random() < 0.5))
				{
					sound(self, CHAN_VOICE, "slimhap5.wav", ATTN_NORM, ATTN_IDLE);
				}
				else
				{
					sound(self, CHAN_VOICE, "slimhap6.wav", ATTN_NORM, ATTN_IDLE);
				}
			}
		}
	}
};
void() Flyer_JumpTouch;

void() flyer_stand1 = [ 5, flyer_stand2 ]
{
	ai_stand();
	self.skin = STATE_TOP;
};

void() flyer_stand2 = [ 6, flyer_stand3 ]
{
	ai_stand();
};

void() flyer_stand3 = [ 7, flyer_stand4 ]
{
	ai_stand();
};

void() flyer_stand4 = [ 8, flyer_stand5 ]
{
	ai_stand();
};

void() flyer_stand5 = [ 9, flyer_stand6 ]
{
	ai_stand();
};

void() flyer_stand6 = [ 10, flyer_stand7 ]
{
	ai_stand();
};

void() flyer_stand7 = [ 11, flyer_stand8 ]
{
	ai_stand();
};

void() flyer_stand8 = [ 12, flyer_stand1 ]
{
	ai_stand();
};

void() flyer_walk1 = [ 5, flyer_walk2 ]
{
	slime_idlesound();
	ai_walk(EF_DIMLIGHT);
};

void() flyer_walk2 = [ 6, flyer_walk3 ]
{
	ai_walk(MOVETYPE_TOSS);
	self.skin = STATE_TOP;
};

void() flyer_walk3 = [ 7, flyer_walk4 ]
{
	ai_walk(MOVETYPE_TOSS);
};

void() flyer_walk4 = [ 8, flyer_walk5 ]
{
	ai_walk(MOVETYPE_PUSH);
};

void() flyer_walk5 = [ 9, flyer_walk6 ]
{
	ai_walk(MOVETYPE_STEP);
};

void() flyer_walk6 = [ 10, flyer_walk7 ]
{
	ai_walk(MOVETYPE_TOSS);
};

void() flyer_walk7 = [ 11, flyer_walk8 ]
{
	ai_walk(TE_LAVASPLASH);
};

void() flyer_walk8 = [ 12, flyer_walk1 ]
{
	ai_walk(TE_LAVASPLASH);
};

void() flyer_run1 = [ 5, flyer_run2 ]
{
	slime_idlesound();
	ai_run(20);
};

void() flyer_run2 = [ 6, flyer_run3 ]
{
	ai_run(TE_LAVASPLASH);
	self.skin = STATE_TOP;
};

void() flyer_run3 = [ 7, flyer_run4 ]
{
	ai_run(20);
};

void() flyer_run4 = [ 8, flyer_run5 ]
{
	ai_run(14);
};

void() flyer_run5 = [ 9, flyer_run6 ]
{
	ai_run(TE_LAVASPLASH);
};

void() flyer_run6 = [ 10, flyer_run7 ]
{
	ai_run(TE_LAVASPLASH);
};

void() flyer_run7 = [ 11, flyer_run8 ]
{
	ai_run(TE_LAVASPLASH);
};

void() flyer_run8 = [ 12, flyer_run1 ]
{
	ai_run(20);
};

void() flyer_jump1 = [ 13, flyer_jump2 ]
{
	ai_face();
	self.skin = ATTN_NORM;
};

void() flyer_jump2 = [ 14, flyer_jump3 ]
{
	ai_face();
};

void() flyer_jump3 = [ 15, flyer_jump4 ]
{
	ai_face();
};

void() flyer_jump4 = [ 16, flyer_jump5 ]
{
	ai_face();
	self.skin = ATTN_IDLE;
	self.touch = Flyer_JumpTouch;
	makevectors(self.angles);
	slime_idlesound();
	self.origin_z = (self.origin_z + ATTN_NORM);
	self.velocity = ((v_forward * 600) + '0 0 250');
	if ((self.flags & FL_ONGROUND))
	{
		self.flags = (self.flags - FL_ONGROUND);
	}
};

void() flyer_jump5 = [ 17, flyer_jump6 ]
{
};

void() flyer_jump6 = [ 18, flyer_jump7 ]
{
	self.skin = ATTN_NORM;
	self.nextthink = (time + ATTN_NORM);
};

void() flyer_jump7 = [ 19, flyer_jump8 ]
{
};

void() flyer_jump8 = [ 20, flyer_run1 ]
{
	self.skin = STATE_TOP;
	slime_idlesound();
};

void() flyer_atta1 = [ 13, flyer_atta2 ]
{
	ai_charge(MOVETYPE_STEP);
	sound(self, CHAN_VOICE, "slimatk1.wav", ATTN_NORM, ATTN_IDLE);
};

void() flyer_atta2 = [ 14, flyer_atta3 ]
{
	ai_charge(STATE_TOP);
};

void() flyer_atta3 = [ 15, flyer_atta4 ]
{
	ai_charge(STATE_TOP);
};

void() flyer_atta4 = [ 16, flyer_atta5 ]
{
	ai_charge(ATTN_NORM);
	slime_idlesound();
};

void() flyer_atta5 = [ 17, flyer_atta6 ]
{
	ai_charge(ATTN_IDLE);
	Flyer_Melee(200);
};

void() flyer_atta6 = [ 18, flyer_atta7 ]
{
	Flyer_Melee(-200);
};

void() flyer_atta7 = [ 19, flyer_atta8 ]
{
	ai_charge(TE_LIGHTNING1);
};

void() flyer_atta8 = [ 20, flyer_run1 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() flyer_pain1 = [ 0, flyer_pain2 ]
{
	self.skin = SOLID_SLIDEBOX;
};

void() flyer_pain2 = [ 1, flyer_pain3 ]
{
};

void() flyer_pain3 = [ 2, flyer_pain4 ]
{
};

void() flyer_pain4 = [ 3, flyer_pain5 ]
{
};

void() flyer_pain5 = [ 4, flyer_run1 ]
{
	self.skin = STATE_TOP;
};

void(entity attacker, float damage) flyer_pain =
{
	if ((self.touch == Flyer_JumpTouch))
	{
		return;
	}
	if ((self.pain_finished > time))
	{
		return;
	}
	self.pain_finished = (time + ATTN_NORM);
	if ((random() < 0.5))
	{
		sound(self, CHAN_VOICE, "slimhrt1.wav", ATTN_NORM, ATTN_IDLE);
	}
	else
	{
		sound(self, CHAN_VOICE, "slimhrt2.wav", ATTN_NORM, ATTN_IDLE);
	}
	flyer_pain1();
};

void() flyer_die1 = [ 21, flyer_die2 ]
{
	sound(self, CHAN_VOICE, "slimdie.wav", ATTN_NORM, ATTN_NORM);
};

void() flyer_die2 = [ 22, flyer_die3 ]
{
};

void() flyer_die3 = [ 23, flyer_die4 ]
{
};

void() flyer_die4 = [ 24, flyer_die5 ]
{
};

void() flyer_die5 = [ 25, flyer_die6 ]
{
};

void() flyer_die6 = [ 26, flyer_die7 ]
{
	self.solid = SOLID_NOT;
};

void() flyer_die7 = [ 27, flyer_die8 ]
{
};

void() flyer_die8 = [ 28, flyer_die9 ]
{
};

void() flyer_die9 = [ 29, flyer_die9 ]
{
};

void() Flyer_die =
{
	flyer_die1();
};

void() Flyer_MeleeAttack =
{
	flyer_atta1();
};

void() monster_flyer =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}

	/* Moving to worldspawn

	precache_model ("progs/flyer.mdl");

	precache_sound ("slimatk1.wav");
	precache_sound ("slimdie.wav");
	precache_sound ("slimhap1.wav");
	precache_sound ("slimhap2.wav");
	precache_sound ("slimhap3.wav");
	precache_sound ("slimhap4.wav");
	precache_sound ("slimhap5.wav");
	precache_sound ("slimhap6.wav");
	precache_sound ("slimhap1.wav");
	precache_sound ("slimhrt1.wav");
	precache_sound ("slimhrt2.wav");
	precache_sound ("slimsee.wav");
	*/
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "progs/flyer.mdl");
	setsize(self, VEC_HULL_MIN, '16 16 60');
	self.health = 40;
	self.th_stand = flyer_stand1;
	self.th_walk = flyer_walk1;
	self.th_run = flyer_run1;
	self.th_die = Flyer_die;
	self.th_melee = Flyer_MeleeAttack;
	self.th_missile = flyer_jump1;
	self.th_pain = flyer_pain;

			//gnounc
	self.noise = "slimsee.wav";	//gnounc
	self.netname = "Flyer";
	self.killstring = " got slimed by a Flyer\n";

	walkmonster_start();
};

float() CheckFlyerMelee =
{
	if ((enemy_range == RANGE_MELEE))
	{
		self.attack_state = AS_MELEE;
		return (TRUE);
	}
	return (FALSE);
};

float() CheckFlyerJump =
{
	local vector dist;
	local float d;

	if (((self.origin_z + self.mins_z) > ((self.enemy.origin_z + self.enemy.mins_z) + (0.75 * self.enemy.size_z))))
	{
		return (FALSE);
	}
	if (((self.origin_z + self.maxs_z) < ((self.enemy.origin_z + self.enemy.mins_z) + (0.25 * self.enemy.size_z))))
	{
		return (FALSE);
	}
	dist = (self.enemy.origin - self.origin);
	dist_z = FALSE;
	d = vlen(dist);
	if ((d < 100))
	{
		return (FALSE);
	}
	if ((d > 200))
	{
		if ((random() < 0.9))
		{
			return (FALSE);
		}
	}
	return (TRUE);
};

float() FlyerCheckAttack =
{
	local float vec_x;
	local float vec_y;
	local float vec_z;

	if (CheckFlyerMelee())
	{
		self.attack_state = AS_MELEE;
		return (TRUE);
	}
	if (CheckFlyerJump())
	{
		self.attack_state = AS_MISSILE;
		slime_idlesound();
		return (TRUE);
	}
	return (FALSE);
};

void(float side) Flyer_Melee =
{
	local float ldmg;
	local vector delta;

	ai_face();
	walkmove(self.ideal_yaw, 12);
	delta = (self.enemy.origin - self.origin);
	if ((vlen(delta) > 100))
	{
		return;
	}
	if (!CanDamage(self.enemy, self))
	{
		return;
	}
	sound(self, CHAN_WEAPON, "slimatk1.wav", CHAN_WEAPON, ATTN_NORM);
	ldmg = (TE_LIGHTNING1 + (TE_LIGHTNING1 * random()));
	T_Damage(self.enemy, self, self, ldmg);
	makevectors(self.angles);
	SpawnMeatSpray((self.origin + (v_forward * SECRET_YES_SHOOT)), (side * v_right));
};

void() Flyer_JumpTouch =
{
	local float ldmg;

	if ((self.health <= FALSE))
	{
		return;
	}
	if (other.takedamage)
	{
		if ((vlen(self.velocity) > 400))
		{
			ldmg = (20 + (TE_LAVASPLASH * random()));
			T_Damage(other, self, self, ldmg);
		}
	}
	if (!checkbottom(self))
	{
		if ((self.flags & FL_ONGROUND))
		{
			self.touch = SUB_Null;
			self.think = flyer_jump1;
			self.nextthink = (time + 0.1);
		}
		return;
	}
	self.touch = SUB_Null;
	self.think = flyer_jump1;
	self.nextthink = (time + 0.1);
};
