//Decompiled code. Please respect the original copyright.

void() pnap_stand1 = [ 0, pnap_stand2 ]
{
};

void() pnap_stand2 = [ 1, pnap_stand3 ]
{
};

void() pnap_stand3 = [ 2, pnap_stand4 ]
{
};

void() pnap_stand4 = [ 3, pnap_stand5 ]
{
};

void() pnap_stand5 = [ 2, pnap_stand6 ]
{
};

void() pnap_stand6 = [ 0, pnap_stand1 ]
{
};

void() pnap_pain1 = [ 4, pnap_pain2 ]
{
};

void() pnap_pain2 = [ 5, pnap_pain3 ]
{
};

void() pnap_pain3 = [ 4, pnap_stand1 ]
{
};

void() pnap_die1 = [ 6, pnap_die2 ]
{
};

void() pnap_die2 = [ 7, pnap_die3 ]
{
};

void() pnap_die3 = [ 8, pnap_die3 ]
{
};

void() plane_pain =
{
	if ((random() > 0.5))
	{
		sound(self, CHAN_VOICE, "nukehrt1.wav", ATTN_NORM, ATTN_NORM);
	}
	else
	{
		sound(self, CHAN_VOICE, "nukehrt2.wav", ATTN_NORM, ATTN_NORM);
	}
	pnap_pain1();
};

void() plane_die =
{
	sound(self, CHAN_VOICE, "nukedie1.wav", ATTN_NORM, ATTN_NORM);
	pnap_die1();
};

void() monster_plane =
{
	precache_model2("progs/plane.mdl");
	precache_sound("nukehrt1.wav");
	precache_sound("nukehrt2.wav");
	precache_sound("nukedie1.wav");
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "progs/plane.mdl");
	setsize(self, '-8 -8 -24', '8 8 40');
	self.health = 100;
	self.th_stand = pnap_stand1;
	self.th_walk = pnap_stand1;
	self.th_run = pnap_stand1;
	self.th_pain = plane_pain;
	self.th_die = plane_die;
	self.th_missile = pnap_stand1;
	self.th_melee = pnap_stand1;
	walkmonster_start();
};