//Decompiled code. Please respect the original copyright.

void() nuker2_stand1 = [ 11, nuker2_stand2 ]
{
};

void() nuker2_stand2 = [ 12, nuker2_stand3 ]
{
};

void() nuker2_stand3 = [ 13, nuker2_stand4 ]
{
};

void() nuker2_stand4 = [ 14, nuker2_stand5 ]
{
};

void() nuker2_stand5 = [ 15, nuker2_stand6 ]
{
};

void() nuker2_stand6 = [ 16, nuker2_stand7 ]
{
};

void() nuker2_stand7 = [ 16, nuker2_stand8 ]
{
};

void() nuker2_stand8 = [ 17, nuker2_stand9 ]
{
};

void() nuker2_stand9 = [ 17, nuker2_stand10 ]
{
};

void() nuker2_stand10 = [ 18, nuker2_stand11 ]
{
};

void() nuker2_stand11 = [ 18, nuker2_stand12 ]
{
};

void() nuker2_stand12 = [ 19, nuker2_stand13 ]
{
};

void() nuker2_stand13 = [ 19, nuker2_stand14 ]
{
};

void() nuker2_stand14 = [ 20, nuker2_stand15 ]
{
};

void() nuker2_stand15 = [ 21, nuker2_stand16 ]
{
};

void() nuker2_stand16 = [ 22, nuker2_stand17 ]
{
};

void() nuker2_stand17 = [ 23, nuker2_stand18 ]
{
};

void() nuker2_stand18 = [ 24, nuker2_stand19 ]
{
};

void() nuker2_stand19 = [ 25, nuker2_stand20 ]
{
};

void() nuker2_stand20 = [ 26, nuker2_stand1 ]
{
	ai_stand();
	FoundTarget();
};

void() nuker2_idlesound =
{
	if ((random() < 0.3))
	{
		sound(self, CHAN_VOICE, "nukemad1.wav", ATTN_NORM, ATTN_NORM);
	}
	else
	{
		if ((random() < 0.5))
		{
			sound(self, CHAN_VOICE, "nukemad2.wav", ATTN_NORM, ATTN_NORM);
		}
		else
		{
			sound(self, CHAN_VOICE, "nukemad3.wav", ATTN_NORM, ATTN_NORM);
		}
	}
};

void() nuker2_walk1 = [ 0, nuker2_walk2 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk2 = [ 1, nuker2_walk3 ]
{
	ai_walk(CHAN_VOICE);
};

void() nuker2_walk3 = [ 2, nuker2_walk4 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk4 = [ 3, nuker2_walk5 ]
{
	ai_walk(AS_MISSILE);
};

void() nuker2_walk5 = [ 4, nuker2_walk6 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk6 = [ 5, nuker2_walk7 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk7 = [ 6, nuker2_walk8 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk8 = [ 7, nuker2_walk9 ]
{
	ai_walk(AS_MISSILE);
};

void() nuker2_walk9 = [ 8, nuker2_walk10 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk10 = [ 9, nuker2_walk11 ]
{
	ai_walk(AS_MELEE);
	nuker2_idlesound();
};

void() nuker2_walk11 = [ 10, nuker2_walk12 ]
{
	ai_walk(CHAN_VOICE);
};

void() nuker2_walk12 = [ 9, nuker2_walk13 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk13 = [ 8, nuker2_walk14 ]
{
	ai_walk(AS_MISSILE);
};

void() nuker2_walk14 = [ 7, nuker2_walk15 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk15 = [ 6, nuker2_walk16 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk16 = [ 5, nuker2_walk17 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk17 = [ 4, nuker2_walk18 ]
{
	ai_walk(AS_MISSILE);
};

void() nuker2_walk18 = [ 3, nuker2_walk19 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk19 = [ 2, nuker2_walk20 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_walk20 = [ 1, nuker2_walk1 ]
{
	ai_walk(AS_MELEE);
};

void() nuker2_temp = [ 35, nuker2_run9 ]
{
};
void() nuker2_run9;

void() nuker2_run1 = [ 27, nuker2_run2 ]
{
	ai_run(SECRET_YES_SHOOT);
};

void() nuker2_run2 = [ 28, nuker2_run3 ]
{
	ai_run(20);
};

void() nuker2_run3 = [ 29, nuker2_run4 ]
{
	ai_run(13);
};

void() nuker2_run4 = [ 30, nuker2_run5 ]
{
	ai_run(MOVETYPE_PUSH);
};

void() nuker2_run5 = [ 31, nuker2_run6 ]
{
	ai_run(SECRET_YES_SHOOT);
};

void() nuker2_run6 = [ 32, nuker2_run7 ]
{
	ai_run(20);
};

void() nuker2_run7 = [ 33, nuker2_run8 ]
{
	ai_run(14);
	nuker2_idlesound();
};

void() nuker2_run8 = [ 34, nuker2_run9 ]
{
	ai_run(MOVETYPE_TOSS);
};

void() nuker2_run9 = [ 35, nuker2_run10 ]
{
	ai_run(20);
};

void() nuker2_run10 = [ 36, nuker2_run11 ]
{
	ai_run(14);
};

void() nuker2_run11 = [ 37, nuker2_run1 ]
{
	ai_run(MOVETYPE_TOSS);
};

void() nuker2_mad1 = [ 11, nuker2_mad2 ]
{
	sound(self, CHAN_VOICE, "nukegun.wav", ATTN_NORM, ATTN_IDLE);
};

void() nuker2_mad2 = [ 12, nuker2_mad3 ]
{
};

void() nuker2_mad3 = [ 13, nuker2_mad4 ]
{
};

void() nuker2_mad4 = [ 14, nuker2_mad5 ]
{
};

void() nuker2_mad5 = [ 15, nuker2_mad6 ]
{
};

void() nuker2_mad6 = [ 16, nuker2_mad7 ]
{
};

void() nuker2_mad7 = [ 17, nuker2_mad8 ]
{
};

void() nuker2_mad8 = [ 18, nuker2_mad9 ]
{
};

void() nuker2_mad9 = [ 19, nuker2_mad10 ]
{
};

void() nuker2_mad10 = [ 20, nuker2_mad11 ]
{
};

void() nuker2_mad11 = [ 21, nuker2_mad12 ]
{
};

void() nuker2_mad12 = [ 22, nuker2_mad13 ]
{
};

void() nuker2_mad13 = [ 23, nuker2_mad14 ]
{
};

void() nuker2_mad14 = [ 24, nuker2_mad15 ]
{
};

void() nuker2_mad15 = [ 25, nuker2_mad16 ]
{
};

void() nuker2_mad16 = [ 26, nuker2_run1 ]
{
};

void() nuker2_runatk1 = [ 38, nuker2_runatk2 ]
{
	sound(self, CHAN_WEAPON, "demon/dhit2.wav", CHAN_WEAPON, ATTN_NORM);
	ai_charge(20);
};

void() nuker2_runatk2 = [ 39, nuker2_runatk3 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk3 = [ 40, nuker2_runatk4 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk4 = [ 41, nuker2_runatk5 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk5 = [ 42, nuker2_runatk6 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk6 = [ 43, nuker2_runatk7 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk7 = [ 44, nuker2_runatk8 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk8 = [ 45, nuker2_runatk9 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk9 = [ 46, nuker2_runatk10 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk10 = [ 47, nuker2_runatk11 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee_side();
};

void() nuker2_runatk11 = [ 48, nuker2_run1 ]
{
	ai_charge(TE_LAVASPLASH);
};

void() nuker2_atk1 = [ 38, nuker2_atk2 ]
{
	sound(self, CHAN_WEAPON, "demon/dhit2.wav", CHAN_WEAPON, ATTN_NORM);
	ai_charge(FALSE);
};

void() nuker2_atk2 = [ 39, nuker2_atk3 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() nuker2_atk3 = [ 40, nuker2_atk4 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() nuker2_atk4 = [ 41, nuker2_atk5 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() nuker2_atk5 = [ 42, nuker2_atk6 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() nuker2_atk6 = [ 43, nuker2_atk7 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee();
};

void() nuker2_atk7 = [ 44, nuker2_atk8 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee();
};

void() nuker2_atk8 = [ 45, nuker2_atk9 ]
{
	ai_charge(EF_DIMLIGHT);
	ai_melee();
};

void() nuker2_atk9 = [ 46, nuker2_atk10 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() nuker2_atk10 = [ 47, nuker2_run1 ]
{
	ai_charge(EF_DIMLIGHT);
};

void() nuker2_pain1 = [ 11, nuker2_pain2 ]
{
};

void() nuker2_pain2 = [ 12, nuker2_pain3 ]
{
};

void() nuker2_pain3 = [ 13, nuker2_run1 ]
{
};

void(entity attacker, float damage) nuker3_pain =
{
	local float r;

	if ((self.pain_finished > time))
	{
		return;
	}
	r = random();
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
	nuker2_pain1();
	self.pain_finished = (time + ATTN_NORM);
};

void() nuker2_bow1 = [ 0, nuker2_bow2 ]
{
	ai_turn();
};

void() nuker2_bow2 = [ 1, nuker2_bow3 ]
{
	ai_turn();
};

void() nuker2_bow3 = [ 2, nuker2_bow4 ]
{
	ai_turn();
};

void() nuker2_bow4 = [ 3, nuker2_bow5 ]
{
	ai_turn();
};

void() nuker2_bow5 = [ 4, nuker2_bow5 ]
{
	ai_turn();
};

void() nuker2_bow6 = [ 3, nuker2_bow7 ]
{
	ai_turn();
};

void() nuker2_bow7 = [ 2, nuker2_bow8 ]
{
	ai_turn();
};

void() nuker2_bow8 = [ 1, nuker2_bow9 ]
{
	ai_turn();
};

void() nuker2_bow9 = [ 0, nuker2_bow10 ]
{
	ai_turn();
};

void() nuker2_bow10 = [ 0, nuker2_walk1 ]
{
	ai_turn();
};

void() nuker2_die1 = [ 50, nuker2_die2 ]
{
};

void() nuker2_die2 = [ 51, nuker2_die3 ]
{
};

void() nuker2_die3 = [ 52, nuker2_die4 ]
{
	self.solid = SOLID_NOT;
};

void() nuker2_die4 = [ 53, nuker2_die5 ]
{
};

void() nuker2_die5 = [ 54, nuker2_die6 ]
{
};

void() nuker2_die6 = [ 55, nuker2_die7 ]
{
};

void() nuker2_die7 = [ 56, nuker2_die8 ]
{
};

void() nuker2_die8 = [ 57, nuker2_die9 ]
{
};

void() nuker2_die9 = [ 58, nuker2_die10 ]
{
};

void() nuker2_die10 = [ 59, nuker2_die10 ]
{
};

void() nuker3_die =
{
	sound(self, CHAN_VOICE, "nukedie1.wav", ATTN_NORM, ATTN_NORM);
	nuker2_die1();
};

void() monster_nukermad =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "progs/nuker2.mdl");
	setsize(self, VEC_HULL_MIN, '16 16 40');
	self.health = 75;
	self.th_stand = nuker2_stand1;
	self.th_walk = nuker2_walk1;
	self.th_run = nuker2_run1;
	self.th_missile = nuker2_temp;
	self.th_melee = nuker2_atk1;
	self.th_pain = nuker3_pain;
	self.th_die = nuker3_die;
	if ((self.frags == CHAN_VOICE))
	{
		nuker2_mad1();
	}
//	if ((self.flags == (self.flags && FL_NUKER)))
//	{
//		nuker2_mad1();
//	}
				//gnounc
	self.noise = "nukesee.wav";	//gnounc
	self.netname = "Nuker";
	self.killstring = " got torn apart by a Nuker\n";
	walkmonster_start();
};
