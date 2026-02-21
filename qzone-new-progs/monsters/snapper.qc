//Decompiled code. Please respect the original copyright.

void() Snap_Touch =
{
	local vector org;

	if (other == self.owner)
		return;		// don't explode on owner

	if (pointcontents(self.origin) == CONTENT_SKY)
	{
		remove(self);
		return;
	}

//MED 01/16/97 added silent command
//   if (!(self.spawnflags & SPAWNFLAG_SILENT))
      sound (self, CHAN_WEAPON, "enforcer/enfstop.wav", 1, ATTN_STATIC);
	org = self.origin - 8*normalize(self.velocity);

	if (other.health)
	{
		SpawnBlood (org, self.velocity*0.2, 15);
		T_Damage (other, self, self.owner, 15);
	}
	else
	{
		WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte (MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord (MSG_BROADCAST, org_x);
		WriteCoord (MSG_BROADCAST, org_y);
		WriteCoord (MSG_BROADCAST, org_z);
	}

	remove(self);

};

void(vector org, vector vec) SnapAttack =
{
	if ((random() > 0.5))
	{
		sound(self, CHAN_WEAPON, "snapslp1.wav", CHAN_WEAPON, ATTN_NORM);
	}
	else
	{
		sound(self, CHAN_WEAPON, "snapslp2.wav", CHAN_WEAPON, ATTN_NORM);
	}
	vec = normalize(vec);
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLY;
	newmis.solid = SOLID_BBOX;
	newmis.effects = EF_DIMLIGHT;
	setmodel(newmis, "progs/snapshot.mdl");
	setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(newmis, org);
	newmis.velocity = (vec * 550);
	newmis.angles = vectoangles(newmis.velocity);
	newmis.nextthink = (time + MOVETYPE_FLY);
	newmis.think = SUB_Remove;
	newmis.touch = Snap_Touch;
};

void() snapper_fire =
{
	local vector org;

	self.effects = (self.effects | EF_MUZZLEFLASH);
	makevectors(self.angles);
	org = (((self.origin + (v_forward * SVC_INTERMISSION)) + (v_right * 8.5)) + '0 0 16');
	SnapAttack(org, (self.enemy.origin - self.origin));
};
void() snap_atk1;
void() snap_walk1;

void() snap_prepare =
{
	if ((other.classname == "player"))
	{
		snap_atk1();
	}
};

void() snap_hurt =
{
	T_Damage(other, self, self.owner, 20);
};

void() snap_stand =
{
	local float rnum;

	if ((self.health < 100))
	{
		snap_walk1();
	}
	rnum = random();
	if ((random() < 0.005))
	{
		if ((random() < 0.005))
		{
			if ((rnum < 0.2))
			{
				sound(self, CHAN_WEAPON, "snapslp1.wav", CHAN_WEAPON, ATTN_NORM);
			}
			else
			{
				if ((rnum < 0.4))
				{
					sound(self, CHAN_WEAPON, "snapslp2.wav", CHAN_WEAPON, ATTN_NORM);
				}
				else
				{
					if ((rnum < 0.6))
					{
						sound(self, CHAN_WEAPON, "snapslp3.wav", CHAN_WEAPON, ATTN_NORM);
					}
					else
					{
						if ((rnum < 0.8))
						{
							sound(self, CHAN_WEAPON, "snapslp4.wav", CHAN_WEAPON, ATTN_NORM);
						}
						else
						{
							sound(self, CHAN_WEAPON, "snapslp5.wav", CHAN_WEAPON, ATTN_NORM);
						}
					}
				}
			}
		}
	}
	self.touch = snap_prepare;
	self.frags = MSG_BROADCAST;
	if (FindTarget())
	{
		return;
	}
	if ((time > self.pausetime))
	{
		self.th_walk();
		return;
	}
};

void() snap_grr =
{
	local vector spot1;
	local vector spot2;
	local float r;

	spot1 = (self.origin + self.view_ofs);
	spot2 = (self.enemy.origin + self.enemy.view_ofs);
	r = vlen((spot1 - spot2));
	if ((random() > 0.005))
	{
		if ((random() > 0.005))
		{
			if ((random() > 0.5))
			{
				sound(self, CHAN_WEAPON, "snapmad1.wav", CHAN_WEAPON, ATTN_NORM);
			}
			else
			{
				sound(self, CHAN_WEAPON, "snapmad2.wav", CHAN_WEAPON, ATTN_NORM);
			}
		}
	}
	if ((r < 350))
	{
		if ((self.health < 40))
		{
			snap_atk1();
		}
		else
		{
			if ((r < 120))
			{
				snap_atk1();
			}
		}
	}
};

void() snap_stand1 = [ 0, snap_stand1 ]
{
	snap_stand();
};

void() snap_walk1 = [ 4, snap_walk2 ]
{
	if ((self.health > 40))
	{
		ai_walk(15);
	}
	else
	{
		ai_walk(SVC_INTERMISSION);
	}
	snap_grr();
};

void() snap_walk2 = [ 5, snap_walk3 ]
{
	if ((self.health > 40))
	{
		ai_walk(15);
	}
	else
	{
		ai_walk(SVC_INTERMISSION);
	}
	snap_grr();
};

void() snap_walk3 = [ 6, snap_stand1 ]
{
	if ((self.health > SVC_INTERMISSION))
	{
		ai_walk(15);
	}
	else
	{
		ai_walk(40);
	}
	snap_grr();
};

void() snap_atk1 = [ 0, snap_atk2 ]
{
	ai_face();
	self.frags = ATTN_NORM;
};

void() snap_atk2 = [ 1, snap_atk3 ]
{
	snapper_fire();
};

void() snap_atk3 = [ 2, snap_atk4 ]
{
	ai_face();
};

void() snap_atk4 = [ 3, snap_stand1 ]
{
	ai_face();
};

void() snap_pain =
{
	if ((random() > 0.5))
	{
		sound(self, CHAN_WEAPON, "snaphrt1.wav", CHAN_WEAPON, ATTN_NORM);
	}
	else
	{
		sound(self, CHAN_WEAPON, "snaphrt2.wav", CHAN_WEAPON, ATTN_NORM);
	}
	snap_stand1();
};

void() snapper_die =
{
	sound(self, CHAN_VOICE, "player/udeath.wav", ATTN_NORM, ATTN_NORM);
	ThrowHead("progs/snaphead.mdl", -50);
	ThrowGib("progs/snapbody.mdl", -60);
	ThrowGib("progs/snapfeet.mdl", -65);
	ThrowGib("progs/snapfeet.mdl", -55);
	ThrowGib("progs/snapfeet.mdl", -65);
	return;
	remove(self);
};

void() monster_snapper =
{
	if (deathmatch)
	{
		remove(self);
		return;
	}
	precache_model2("progs/snapper.mdl");
	precache_model2("progs/snapbody.mdl");
	precache_model2("progs/snaphead.mdl");
	precache_model2("progs/snapfeet.mdl");
	precache_model2("progs/snapshot.mdl");
	precache_sound("snaphrt1.wav");
	precache_sound("snaphrt2.wav");
	precache_sound("snapslp1.wav");
	precache_sound("snapslp2.wav");
	precache_sound("snapslp3.wav");
	precache_sound("snapslp4.wav");
	precache_sound("snapslp5.wav");
	precache_sound("snapmad1.wav");
	precache_sound("snapmad2.wav");
	precache_sound("snapatk1.wav");
	precache_sound("snapatk2.wav");
	self.solid = SOLID_SLIDEBOX;
	self.movetype = MOVETYPE_STEP;
	setmodel(self, "progs/snapper.mdl");
	setsize(self, VEC_HULL_MIN, '16 16 40');
	self.health = 180;
	self.th_stand = snap_stand1;
	self.th_walk = snap_stand1;
	self.th_run = snap_stand1;
	self.th_pain = snap_pain;
	self.th_die = snapper_die;
	self.th_missile = snap_atk1;
	self.th_melee = snap_atk1;
	walkmonster_start();
};