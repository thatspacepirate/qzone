//Decompiled code. Please respect the original copyright.
void() player_run;
void(vector org, vector vel, float damage) SpawnBlood;
void() SuperDamageSound;
void() W_FireSlicer;

void() W_Precache =
{
	precache_sound("weapons/r_exp3.wav");
	precache_sound("weapons/rocket1i.wav");
	precache_sound("weapons/sgun1.wav");
	precache_sound("weapons/guncock.wav");
	precache_sound("weapons/ric1.wav");
	precache_sound("weapons/ric2.wav");
	precache_sound("weapons/ric3.wav");
	precache_sound("weapons/spike2.wav");
	precache_sound("weapons/tink1.wav");
	precache_sound("weapons/grenade.wav");
	precache_sound("weapons/bounce.wav");
	precache_sound("weapons/shotgn2.wav");
	precache_sound("slicer.wav");
	precache_sound("lockload.wav");
};

float() crandom =
{
	return ((CHAN_VOICE * (random() - 0.5)));
};

void() W_FireAxe =
{
	local vector source;
//	local float org_x;
//	local float org_y;
//	local float org_z;
        local  vector org; //madfox

        makevectors (self.v_angle); // madfox       
	source = (self.origin + '0 0 16');
//	traceline(source, (source + (v_forward * IT_LIGHTNING)), FALSE, self);
	traceline (source, source + v_forward*64, FALSE, self);//madfox
//if ((trace_fraction == SOLID_TRIGGER))
	if ((trace_fraction == 1,0)) //madfox
	{
		return;
	}
//	org_x = (trace_endpos - (v_forward * WEAPON_SPIKES));
        org = trace_endpos - v_forward * 4;//madfox
	if (trace_ent.takedamage)
	{
//		trace_ent.axhitme = SOLID_TRIGGER;
                trace_ent.axhitme = 1;//madfox
//		SpawnBlood(org_x, VEC_ORIGIN, 20);
                SpawnBlood(org, '0 0 0', 20);//madfox
		T_Damage(trace_ent, self, self, 20);
	}
	else
	{
		sound(self, CHAN_WEAPON, "player/axhit2.wav", CHAN_WEAPON, ATTN_NORM);
		WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte(MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord(MSG_BROADCAST, org_x);
		WriteCoord(MSG_BROADCAST, org_y);
		WriteCoord(MSG_BROADCAST, org_z);
	}
};

vector() wall_velocity =
{
	local vector vel;

	vel = normalize(self.velocity);
	vel = normalize(((vel + (v_up * (random() - 0.5))) + (v_right * (random() - 0.5))));
	vel = (vel + (TE_GUNSHOT * trace_plane_normal));
	vel = (vel * 200);
	return (vel);
};

void(vector org, vector vel) SpawnMeatSpray =
{
	local entity missile;
	local entity mpuff;

	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_NOT;
	makevectors(self.angles);
	missile.velocity = vel;
	missile.velocity_z = ((missile.velocity_z + 250) + (50 * random()));
	missile.avelocity = '3000 1000 2000';
	missile.nextthink = (time + ATTN_NORM);
	missile.think = SUB_Remove;
	setmodel(missile, "progs/zom_gib.mdl");
	setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(missile, org);
};

void(vector org, vector vel, float damage) SpawnBlood =
{
	particle(org, (vel * 0.1), 73, (damage * TE_GUNSHOT));
};

void(float damage) spawn_touchblood =
{
	local vector vel;

	vel = (wall_velocity() * 0.2);
	SpawnBlood((self.origin + (vel * 0.01)), vel, damage);
};

void(vector org, vector vel) SpawnChunk =
{
	particle(org, (vel * 0.02), SOLID_NOT, MOVETYPE_BOUNCE);
};
entity multi_ent;
float multi_damage;

void() ClearMultiDamage =
{
	multi_ent = world;
	multi_damage = SOLID_NOT;
};

void() ApplyMultiDamage =
{
	if (!multi_ent)
	{
		return;
	}
	T_Damage(multi_ent, self, self, multi_damage);
};

void(entity hit, float damage) AddMultiDamage =
{
	if (!hit)
	{
		return;
	}
	if ((hit != multi_ent))
	{
		ApplyMultiDamage();
		multi_damage = damage;
		multi_ent = hit;
	}
	else
	{
		multi_damage = (multi_damage + damage);
	}
};

void(float damage, vector dir) TraceAttack =
{
	local vector vel, org;
//	local float org_x;
//	local float org_y;
//	local float org_z;

//	vel = normalize(((dir + (v_up * crandom())) + (v_right * crandom())));
	vel = normalize(dir + v_up *crandom() + v_right * crandom());//madfox
//	vel = (vel + (TE_GUNSHOT * trace_plane_normal));
	vel = vel + 2*trace_plane_normal;//madfox
	vel = (vel * 200);
//	org_x = (trace_endpos - (dir * WEAPON_SPIKES));
	org = trace_endpos - dir *4;//madfox

	if (trace_ent.takedamage)
	{
//		SpawnBlood(org_x, (vel * 0.2), damage);
		SpawnBlood(org, (vel * 0.2), damage);//madfox
		AddMultiDamage(trace_ent, damage);
	}
	else
	{
		WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte(MSG_BROADCAST, TE_GUNSHOT);
		WriteCoord(MSG_BROADCAST, org_x);
		WriteCoord(MSG_BROADCAST, org_y);
		WriteCoord(MSG_BROADCAST, org_z);
	}
};

void(float shotcount, vector dir, float spread_x, float spread_y, float spread_z) FireBullets =
{
	local vector direction;
	local vector src;

	makevectors(self.v_angle);
	src = (self.origin + (v_forward * MOVETYPE_BOUNCE));
	src_z = (self.absmin_z + (self.size_z * 0.7));
	ClearMultiDamage();
	while ((shotcount > MSG_BROADCAST))
	{
		direction = ((dir + ((crandom() * spread_x) * v_right)) + ((crandom() * spread_y) * v_up));
		traceline(src, (src + (direction * IT_CELLS)), FALSE, self);
		if ((trace_fraction != ATTN_NORM))
		{
			TraceAttack(WEAPON_SPIKES, direction);
		}
		shotcount = (shotcount - ATTN_NORM);
	}
	ApplyMultiDamage();
};

void() W_FireShotgun =
{
	local vector dir;

	sound(self, CHAN_WEAPON, "weapons/guncock.wav", CHAN_WEAPON, ATTN_NORM);
	self.punchangle_x = CONTENT_SOLID;
	self.ammo_shells = (self.ammo_shells - ATTN_NORM);
	self.currentammo = (self.ammo_shells - ATTN_NORM);
	dir = aim(self, 100000);
	FireBullets(MOVETYPE_TOSS, dir, 0.04);
};

void() W_FireSuperShotgun =
{
	local vector dir;

	if ((self.currentammo == ATTN_NORM))
	{
		W_FireShotgun();
		return;
	}
	sound(self, CHAN_WEAPON, "weapons/shotgn2.wav", CHAN_WEAPON, ATTN_NORM);
	self.punchangle_x = CONTENT_SLIME;
	self.ammo_shells = (self.ammo_shells - TE_GUNSHOT);
	self.currentammo = (self.ammo_shells - TE_GUNSHOT);
	dir = aim(self, 100000);
	FireBullets(14, dir, 0.14);
};

void() s_explode1 = [ 0, s_explode2 ]
{
};

void() s_explode2 = [ 1, s_explode3 ]
{
};

void() s_explode3 = [ 2, s_explode4 ]
{
};

void() s_explode4 = [ 3, s_explode5 ]
{
};

void() s_explode5 = [ 4, s_explode6 ]
{
};

void() s_explode6 = [ 5, SUB_Remove ]
{
};

void() BecomeExplosion =
{
	self.movetype = MOVETYPE_NONE;
	self.velocity = VEC_ORIGIN;
	self.touch = SUB_Null;
	setmodel(self, "progs/s_explod.spr");
	self.solid = SOLID_NOT;
	s_explode1();
};

void() T_MissileTouch =
{
	local float damg;

	if ((other == self.owner))
	{
		return;
	}
	if ((pointcontents(self.origin) == CONTENT_SKY))
	{
		remove(self);
		return;
	}
	damg = (100 + (random() * 20));
	if (other.health)
	{
		if ((other.classname == "monster_shambler"))
		{
			damg = (damg * 0.5);
		}
		T_Damage(other, self, self.owner, damg);
	}
	T_RadiusDamage(self, self.owner, 120, other);
	self.origin = (self.origin - (WEAPON_BIG * normalize(self.velocity)));
	WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte(MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord(MSG_BROADCAST, self.origin_x);
	WriteCoord(MSG_BROADCAST, self.origin_y);
	WriteCoord(MSG_BROADCAST, self.origin_z);
	BecomeExplosion();
};

void() T_StarTouch =
{
	local float damg;

	if ((other == self.owner))
	{
		other.ammo_nails = (other.ammo_nails + TE_GUNSHOT);
		remove(self);
		return;
	}
	self.movetype = MOVETYPE_BOUNCE;
	sound(self, CHAN_WEAPON, "slicer.wav", CHAN_WEAPON, ATTN_NORM);
	if ((pointcontents(self.origin) == CONTENT_SKY))
	{
		remove(self);
		return;
	}
	if ((self.frags == MSG_BROADCAST))
	{
		damg = 15;
	}
	if ((self.frags == ATTN_NORM))
	{
		damg = SVC_INTERMISSION;
	}
	if ((self.frags == TE_GUNSHOT))
	{
		damg = 35;
	}
	if ((self.frags == TE_EXPLOSION))
	{
		damg = 40;
	}
	if ((self.frags == WEAPON_SPIKES))
	{
		damg = 45;
	}
	if ((self.frags == TE_LIGHTNING1))
	{
		damg = 50;
	}
	if ((self.frags == MOVETYPE_TOSS))
	{
		damg = 15;
		self.velocity = (self.velocity * MSG_BROADCAST);
	}
	if (other.health)
	{
		T_Damage(other, self, self.owner, damg);
		self.velocity = (self.velocity * 0.5);
	}
	self.frags = (self.frags + ATTN_NORM);
};

void() W_FireRocket =
{
	local entity missile;
	local entity mpuff;

	self.ammo_rockets = (self.ammo_rockets - ATTN_NORM);
	self.currentammo = (self.ammo_rockets - ATTN_NORM);
	sound(self, CHAN_WEAPON, "weapons/sgun1.wav", CHAN_WEAPON, ATTN_NORM);
	self.punchangle_x = CONTENT_SOLID;
	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.solid = SOLID_BBOX;
	makevectors(self.v_angle);
	missile.velocity = aim(self, 1000);
	missile.velocity = (missile.velocity * 1000);
	missile.angles = vectoangles(missile.velocity);
	missile.touch = T_MissileTouch;
	missile.nextthink = (time + TE_LIGHTNING1);
	missile.think = SUB_Remove;
	setmodel(missile, "progs/missile.mdl");
	setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(missile, ((self.origin + (v_forward * WEAPON_BIG)) + '0 0 16'));
};

void() W_FireSlicer =
{
	local entity missile;
	local entity mpuff;

	self.ammo_nails = (self.ammo_nails - ATTN_NORM);
	self.currentammo = (self.ammo_nails - ATTN_NORM);
	sound(self, CHAN_WEAPON, "lockload.wav", CHAN_WEAPON, ATTN_NORM);
	self.punchangle_x = MSG_BROADCAST;
	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_FLYMISSILE;
	missile.frags = MSG_BROADCAST;
	missile.solid = SOLID_BBOX;
	makevectors(self.v_angle);
	missile.avelocity_y = (random() * 2200);
	missile.velocity = aim(self, 1000);
	missile.velocity = (missile.velocity * 1700);
	missile.angles = vectoangles(missile.velocity);
	missile.touch = T_StarTouch;
	missile.nextthink = (time + TE_LIGHTNING1);
	missile.think = SUB_Remove;
	self.attack_finished = (time + 0.64);
	setmodel(missile, "progs/star.mdl");
	setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(missile, ((self.origin + (v_forward * WEAPON_BIG)) + '0 0 16'));
};

void(vector p1, vector p2, entity from, float damage) LightningDamage =
{
	local entity e1;
	local entity e2;
	local vector f;
	local float damadd;

	f = (p2 - p1);
	normalize(f);
	f_x = (MSG_BROADCAST - f_y);
	f_y = f_x;
	f_z = MSG_BROADCAST;
	f = (f * IT_GRENADE_LAUNCHER);
	e2 = world;
	e1 = world;
	traceline(p1, p2, FALSE, self);
	if (trace_ent.takedamage)
	{
		particle(trace_endpos, '0 0 100', 225, (damage * WEAPON_SPIKES));
		T_Damage(trace_ent, from, from, damage);
		if ((self.classname == "player"))
		{
			if ((other.classname == "player"))
			{
				trace_ent.velocity_z = (trace_ent.velocity_z + 400);
			}
		}
	}
	e1 = trace_ent;
	traceline((p1 + f), (p2 + f), FALSE, self);
	if (((trace_ent != e1) && trace_ent.takedamage))
	{
		particle(trace_endpos, '0 0 100', 225, (damage * WEAPON_SPIKES));
		T_Damage(trace_ent, from, from, damage);
	}
	e2 = trace_ent;
	traceline((p1 - f), (p2 - f), FALSE, self);
	if ((((trace_ent != e1) && (trace_ent != e2)) && trace_ent.takedamage))
	{
		particle(trace_endpos, '0 0 100', 225, (damage * WEAPON_SPIKES));
		T_Damage(trace_ent, from, from, damage);
	}
};

void(vector start_pos, vector bolt_dir, float spawn_num) LightningBounce =
{
	local entity tempent;
	local vector old_endpos;

	if ((spawn_num < ATTN_NORM))
	{
		return;
	}
	tempent = spawn();
	tempent.origin = start_pos;
	setorigin(tempent, start_pos);
	setmodel(tempent, "progs/grenade.mdl");
	tempent.v_angle = bolt_dir;
	tempent.angles = vectoangles(tempent.v_angle);
	traceline(start_pos, (start_pos + (bolt_dir * 300)), FALSE, self);
	old_endpos = (trace_endpos + (bolt_dir * WEAPON_SPIKES));
	bolt_dir_x = (bolt_dir_x * (((FALSE - SOLID_BBOX) * fabs(trace_plane_normal_x)) + ATTN_NORM));
	bolt_dir_y = (bolt_dir_y * (((FALSE - SOLID_BBOX) * fabs(trace_plane_normal_y)) + ATTN_NORM));
	bolt_dir_z = (bolt_dir_z * (((FALSE - SOLID_BBOX) * fabs(trace_plane_normal_z)) + ATTN_NORM));
	WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte(MSG_BROADCAST, TE_LIGHTNING2);
	WriteEntity(MSG_BROADCAST, tempent);
	WriteCoord(MSG_BROADCAST, start_pos_x);
	WriteCoord(MSG_BROADCAST, start_pos_y);
	WriteCoord(MSG_BROADCAST, start_pos_z);
	WriteCoord(MSG_BROADCAST, trace_endpos_x);
	WriteCoord(MSG_BROADCAST, trace_endpos_y);
	WriteCoord(MSG_BROADCAST, trace_endpos_z);
	LightningDamage(start_pos, trace_endpos, self, SVC_INTERMISSION);
	bolt_dir_x = (bolt_dir_x + (0.05 * crandom()));
	bolt_dir_y = (bolt_dir_y + (0.05 * crandom()));
	bolt_dir_z = (bolt_dir_z + (0.05 * crandom()));
	LightningBounce(old_endpos, bolt_dir, (spawn_num - ATTN_NORM));
	remove(tempent);
};

void() W_FireLightning =
{
	if ((self.ammo_cells < ATTN_NORM))
	{
		self.weapon = W_BestWeapon();
		W_SetCurrentAmmo();
		return;
	}
	if ((self.waterlevel > ATTN_NORM))
	{
		T_RadiusDamage(self, self, (35 * self.ammo_cells), world);
		self.ammo_cells = MSG_BROADCAST;
		W_SetCurrentAmmo();
		return;
	}
	if ((self.t_width < time))
	{
		sound(self, CHAN_WEAPON, "weapons/lhit.wav", CHAN_WEAPON, ATTN_NORM);
		self.t_width = (time + 0.6);
	}
	self.punchangle_x = CONTENT_SOLID;
	self.ammo_cells = (self.ammo_cells - ATTN_NORM);
	self.currentammo = (self.ammo_cells - ATTN_NORM);
	makevectors(self.v_angle);
	if ((((self.ammo_cells / SOLID_BBOX) == floor((self.ammo_cells / SOLID_BBOX))) || (self.attack_finished < time)))
	{
		LightningBounce(self.origin, v_forward, TE_EXPLOSION);
	}
};

void() GrenadeExplode =
{
	T_RadiusDamage(self, self.owner, 120, world);
	WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte(MSG_BROADCAST, TE_EXPLOSION);
	WriteCoord(MSG_BROADCAST, self.origin_x);
	WriteCoord(MSG_BROADCAST, self.origin_y);
	WriteCoord(MSG_BROADCAST, self.origin_z);
	BecomeExplosion();
};

void() GrenadeTouch =
{
	if ((other == self.owner))
	{
		return;
	}
	if ((other.takedamage == DAMAGE_AIM))
	{
		GrenadeExplode();
		return;
	}
	sound(self, CHAN_WEAPON, "weapons/bounce.wav", CHAN_WEAPON, ATTN_NORM);
	if ((self.velocity == VEC_ORIGIN))
	{
		self.avelocity = VEC_ORIGIN;
	}
};

void() W_FireGrenade =
{
	local entity missile;
	local entity mpuff;

	self.ammo_rockets = (self.ammo_rockets - ATTN_NORM);
	self.currentammo = (self.ammo_rockets - ATTN_NORM);
	sound(self, CHAN_WEAPON, "weapons/grenade.wav", CHAN_WEAPON, ATTN_NORM);
	self.punchangle_x = CONTENT_SOLID;
	missile = spawn();
	missile.owner = self;
	missile.movetype = MOVETYPE_BOUNCE;
	missile.solid = SOLID_BBOX;
	missile.classname = "grenade";
	makevectors(self.v_angle);
	if (self.v_angle_x)
	{
		missile.velocity = ((((v_forward * 600) + (v_up * 200)) + ((crandom() * v_right) * MOVETYPE_BOUNCE)) + ((crandom() * v_up) * MOVETYPE_BOUNCE));
	}
	else
	{
		missile.velocity = aim(self, 10000);
		missile.velocity = (missile.velocity * 600);
		missile.velocity_z = 200;
	}
	missile.avelocity = '300 300 300';
	missile.angles = vectoangles(missile.velocity);
	missile.touch = GrenadeTouch;
	missile.nextthink = (time + 2.5);
	missile.think = GrenadeExplode;
	setmodel(missile, "progs/grenade.mdl");
	setsize(missile, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(missile, self.origin);
};
void() spike_touch;
void() superspike_touch;

void(vector org, vector dir) launch_spike =
{
	newmis = spawn();
	newmis.owner = self;
	newmis.movetype = MOVETYPE_FLYMISSILE;
	newmis.solid = SOLID_BBOX;
	newmis.angles = vectoangles(dir);
	newmis.touch = spike_touch;
	newmis.classname = "spike";
	newmis.think = SUB_Remove;
	newmis.nextthink = (time + TE_LIGHTNING2);
	setmodel(newmis, "progs/spike.mdl");
	setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
	setorigin(newmis, org);
	newmis.velocity = (dir * 1000);
};

void() W_FireSuperSpikes =
{
	local vector dir;
	local entity old;

	sound(self, CHAN_WEAPON, "weapons/spike2.wav", CHAN_WEAPON, ATTN_NORM);
	self.attack_finished = (time + 0.2);
	self.ammo_nails = (self.ammo_nails - SOLID_BBOX);
	self.currentammo = (self.ammo_nails - SOLID_BBOX);
	dir = aim(self, 1000);
	launch_spike((self.origin + '0 0 16'), dir);
	newmis.touch = superspike_touch;
	setmodel(newmis, "progs/s_spike.mdl");
	setsize(newmis, VEC_ORIGIN, VEC_ORIGIN);
	self.punchangle_x = CONTENT_SOLID;
};

void(float ox) W_FireSpikes =
{
	local vector dir;
	local entity old;

	makevectors(self.v_angle);
	if (((self.ammo_nails >= SOLID_BBOX) && (self.weapon == IT_SUPER_NAILGUN)))
	{
		W_FireSuperSpikes();
		return;
	}
	if ((self.ammo_nails < ATTN_NORM))
	{
		self.weapon = W_BestWeapon();
		W_SetCurrentAmmo();
		return;
	}
	sound(self, CHAN_WEAPON, "weapons/rocket1i.wav", CHAN_WEAPON, ATTN_NORM);
	self.attack_finished = (time + 0.2);
	self.ammo_nails = (self.ammo_nails - ATTN_NORM);
	self.currentammo = (self.ammo_nails - ATTN_NORM);
	dir = aim(self, 1000);
	launch_spike(((self.origin + '0 0 16') + (v_right * ox)), dir);
	self.punchangle_x = CONTENT_SOLID;
};
.float hit_z;

void() spike_touch =
{
	local float rand;

	if ((other == self.owner))
	{
		return;
	}
	if ((other.solid == SOLID_TRIGGER))
	{
		return;
	}
	if ((pointcontents(self.origin) == CONTENT_SKY))
	{
		remove(self);
		return;
	}
	if (other.takedamage)
	{
		spawn_touchblood(MOVETYPE_FLYMISSILE);
		T_Damage(other, self, self.owner, MOVETYPE_FLYMISSILE);
	}
	else
	{
		WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
		if ((self.classname == "wizspike"))
		{
			WriteByte(MSG_BROADCAST, TE_WIZSPIKE);
		}
		else
		{
			if ((self.classname == "knightspike"))
			{
				WriteByte(MSG_BROADCAST, TE_KNIGHTSPIKE);
			}
			else
			{
				WriteByte(MSG_BROADCAST, TE_SPIKE);
			}
		}
		WriteCoord(MSG_BROADCAST, self.origin_x);
		WriteCoord(MSG_BROADCAST, self.origin_y);
		WriteCoord(MSG_BROADCAST, self.origin_z);
	}
	remove(self);
};

void() superspike_touch =
{
	local float rand;

	if ((other == self.owner))
	{
		return;
	}
	if ((other.solid == SOLID_TRIGGER))
	{
		return;
	}
	if ((pointcontents(self.origin) == CONTENT_SKY))
	{
		remove(self);
		return;
	}
	if (other.takedamage)
	{
		spawn_touchblood(18);
		T_Damage(other, self, self.owner, 18);
	}
	else
	{
		WriteByte(MSG_BROADCAST, SVC_TEMPENTITY);
		WriteByte(MSG_BROADCAST, TE_SUPERSPIKE);
		WriteCoord(MSG_BROADCAST, self.origin_x);
		WriteCoord(MSG_BROADCAST, self.origin_y);
		WriteCoord(MSG_BROADCAST, self.origin_z);
	}
	remove(self);
};

void() W_SetCurrentAmmo =
{
	player_run();
	self.items = (self.items - (self.items & (((IT_SHELLS | IT_NAILS) | IT_ROCKETS) | IT_CELLS)));
	if ((self.weapon == IT_AXE))
	{
		self.currentammo = MSG_BROADCAST;
		self.weaponmodel = "progs/v_axe.mdl";
		self.weaponframe = MSG_BROADCAST;
	}
	else
	{
		if ((self.weapon == IT_SHOTGUN))
		{
			self.currentammo = self.ammo_shells;
			self.weaponmodel = "progs/v_shot.mdl";
			self.weaponframe = MSG_BROADCAST;
			self.items = (self.items | IT_SHELLS);
		}
		else
		{
			if ((self.weapon == IT_SUPER_SHOTGUN))
			{
				self.currentammo = self.ammo_shells;
				self.weaponmodel = "progs/v_shot2.mdl";
				self.weaponframe = MSG_BROADCAST;
				self.items = (self.items | IT_SHELLS);
			}
			else
			{
				if ((self.weapon == IT_NAILGUN))
				{
					self.currentammo = self.ammo_nails;
					self.weaponmodel = "progs/v_slicer.mdl";
					self.weaponframe = MSG_BROADCAST;
					self.items = (self.items | IT_NAILS);
				}
				else
				{
					if ((self.weapon == IT_SUPER_NAILGUN))
					{
						self.currentammo = self.ammo_nails;
						self.weaponmodel = "progs/v_nail2.mdl";
						self.weaponframe = MSG_BROADCAST;
						self.items = (self.items | IT_NAILS);
					}
					else
					{
						if ((self.weapon == IT_GRENADE_LAUNCHER))
						{
							self.currentammo = self.ammo_rockets;
							self.weaponmodel = "progs/v_rock.mdl";
							self.weaponframe = MSG_BROADCAST;
							self.items = (self.items | IT_ROCKETS);
						}
						else
						{
							if ((self.weapon == IT_ROCKET_LAUNCHER))
							{
								self.currentammo = self.ammo_rockets;
								self.weaponmodel = "progs/v_rock2.mdl";
								self.weaponframe = MSG_BROADCAST;
								self.items = (self.items | IT_ROCKETS);
							}
							else
							{
								if ((self.weapon == IT_LIGHTNING))
								{
									self.currentammo = self.ammo_cells;
									self.weaponmodel = "progs/v_light.mdl";
									self.weaponframe = MSG_BROADCAST;
									self.items = (self.items | IT_CELLS);
								}
								else
								{
									self.currentammo = MSG_BROADCAST;
									self.weaponmodel = "";
									self.weaponframe = MSG_BROADCAST;
								}
							}
						}
					}
				}
			}
		}
	}
};

float() W_BestWeapon =
{
	local float it;

	it = self.items;
	if (((self.ammo_cells >= IT_SHOTGUN) && (it & IT_LIGHTNING)))
	{
		return (IT_LIGHTNING);
	}
	else
	{
		if (((self.ammo_nails >= IT_SUPER_SHOTGUN) && (it & IT_SUPER_NAILGUN)))
		{
			return (IT_SUPER_NAILGUN);
		}
		else
		{
			if (((self.ammo_shells >= IT_SUPER_SHOTGUN) && (it & IT_SUPER_SHOTGUN)))
			{
				return (IT_SUPER_SHOTGUN);
			}
			else
			{
				if (((self.ammo_nails >= IT_SHOTGUN) && (it & IT_NAILGUN)))
				{
					return (IT_NAILGUN);
				}
				else
				{
					if (((self.ammo_shells >= IT_SHOTGUN) && (it & IT_SHOTGUN)))
					{
						return (IT_SHOTGUN);
					}
				}
			}
		}
	}
	return (IT_AXE);
};

float() W_CheckNoAmmo =
{
	if ((self.currentammo > MSG_BROADCAST))
	{
		return (TRUE);
	}
	if ((self.weapon == IT_AXE))
	{
		return (TRUE);
	}
	self.weapon = W_BestWeapon();
	W_SetCurrentAmmo();
	return (FALSE);
};
void() player_axe1;
void() player_axeb1;
void() player_axec1;
void() player_axed1;
void() player_shot1;
void() player_nail1;
void() player_slicer;
void() player_light1;
void() player_rocket1;

void() W_Attack =
{
	local float r;

	if (!W_CheckNoAmmo())
	{
		return;
	}
	makevectors(self.v_angle);
	self.show_hostile = (time + TRUE);
	if ((self.weapon == IT_AXE))
	{
		sound(self, CHAN_WEAPON, "weapons/ax1.wav", CHAN_WEAPON, ATTN_NORM);
		r = random();
		if ((r < 0.25))
		{
			player_axe1();
		}
		else
		{
			if ((r < 0.5))
			{
				player_axeb1();
			}
			else
			{
				if ((r < 0.75))
				{
					player_axec1();
				}
				else
				{
					player_axed1();
				}
			}
		}
		self.attack_finished = (time + 0.5);
	}
	else
	{
		if ((self.weapon == IT_SHOTGUN))
		{
			player_shot1();
			W_FireShotgun();
			self.attack_finished = (time + 0.5);
		}
		else
		{
			if ((self.weapon == IT_SUPER_SHOTGUN))
			{
				player_shot1();
				W_FireSuperShotgun();
				self.attack_finished = (time + 0.7);
			}
			else
			{
				if ((self.weapon == IT_NAILGUN))
				{
					player_slicer();
				}
				else
				{
					if ((self.weapon == IT_SUPER_NAILGUN))
					{
						player_nail1();
					}
					else
					{
						if ((self.weapon == IT_GRENADE_LAUNCHER))
						{
							player_rocket1();
							W_FireGrenade();
							self.attack_finished = (time + 0.6);
						}
						else
						{
							if ((self.weapon == IT_ROCKET_LAUNCHER))
							{
								player_rocket1();
								W_FireRocket();
								self.attack_finished = (time + 0.8);
							}
							else
							{
								if ((self.weapon == IT_LIGHTNING))
								{
									player_light1();
									self.attack_finished = (time + 0.1);
									sound(self, CHAN_AUTO, "weapons/lstart.wav", IT_SHOTGUN, ATTN_NORM);
								}
							}
						}
					}
				}
			}
		}
	}
};

void() W_ChangeWeapon =
{
	local float it;
	local float am;
	local float fl;

	it = self.items;
	am = CHAN_AUTO;
	if ((self.impulse == ATTN_NORM))
	{
		fl = IT_AXE;
	}
	else
	{
		if ((self.impulse == IT_SUPER_SHOTGUN))
		{
			fl = IT_SHOTGUN;
			if ((self.ammo_shells < IT_SHOTGUN))
			{
				am = IT_SHOTGUN;
			}
		}
		else
		{
			if ((self.impulse == TE_EXPLOSION))
			{
				fl = IT_SUPER_SHOTGUN;
				if ((self.ammo_shells < IT_SUPER_SHOTGUN))
				{
					am = IT_SHOTGUN;
				}
			}
			else
			{
				if ((self.impulse == IT_NAILGUN))
				{
					fl = IT_NAILGUN;
					if ((self.ammo_nails < IT_SHOTGUN))
					{
						am = IT_SHOTGUN;
					}
				}
				else
				{
					if ((self.impulse == TE_LIGHTNING1))
					{
						fl = IT_SUPER_NAILGUN;
						if ((self.ammo_nails < IT_SUPER_SHOTGUN))
						{
							am = IT_SHOTGUN;
						}
					}
					else
					{
						if ((self.impulse == TE_LIGHTNING2))
						{
							fl = IT_GRENADE_LAUNCHER;
							if ((self.ammo_rockets < IT_SHOTGUN))
							{
								am = IT_SHOTGUN;
							}
						}
						else
						{
							if ((self.impulse == TE_WIZSPIKE))
							{
								fl = IT_ROCKET_LAUNCHER;
								if ((self.ammo_rockets < IT_SHOTGUN))
								{
									am = IT_SHOTGUN;
								}
							}
							else
							{
								if ((self.impulse == IT_SUPER_NAILGUN))
								{
									fl = IT_LIGHTNING;
									if ((self.ammo_cells < IT_SHOTGUN))
									{
										am = IT_SHOTGUN;
									}
								}
							}
						}
					}
				}
			}
		}
	}
	self.impulse = CHAN_AUTO;
	if (!(self.items & fl))
	{
		sprint(self, "no weapon.\n");
		return;
	}
	if (am)
	{
		sprint(self, "not enough ammo.\n");
		return;
	}
	self.weapon = fl;
	W_SetCurrentAmmo();
};

void() CheatCommand =
{
	if ((deathmatch || coop))
	{
		return;
	}
	self.ammo_rockets = 100;
	self.ammo_nails = 250;
	self.ammo_shells = 150;
	self.items = (((((((((self.items | IT_AXE) | IT_SHOTGUN) | IT_SUPER_SHOTGUN) | IT_NAILGUN) | IT_SUPER_NAILGUN) | IT_GRENADE_LAUNCHER) | IT_ROCKET_LAUNCHER) | IT_KEY1) | IT_KEY2);
	self.ammo_cells = 250;
	self.items = (self.items | IT_LIGHTNING);
	self.weapon = IT_ROCKET_LAUNCHER;
	self.impulse = CHAN_AUTO;
	W_SetCurrentAmmo();
};

void() CycleWeaponCommand =
{
	local float it;
	local float am;

	it = self.items;
	self.impulse = CHAN_AUTO;
	while (IT_SHOTGUN)
	{
		am = CHAN_AUTO;
		if ((self.weapon == IT_LIGHTNING))
		{
			self.weapon = IT_AXE;
		}
		else
		{
			if ((self.weapon == IT_AXE))
			{
				self.weapon = IT_SHOTGUN;
				if ((self.ammo_shells < IT_SHOTGUN))
				{
					am = IT_SHOTGUN;
				}
			}
			else
			{
				if ((self.weapon == IT_SHOTGUN))
				{
					self.weapon = IT_SUPER_SHOTGUN;
					if ((self.ammo_shells < IT_SUPER_SHOTGUN))
					{
						am = IT_SHOTGUN;
					}
				}
				else
				{
					if ((self.weapon == IT_SUPER_SHOTGUN))
					{
						self.weapon = IT_NAILGUN;
						if ((self.ammo_nails < IT_SHOTGUN))
						{
							am = IT_SHOTGUN;
						}
					}
					else
					{
						if ((self.weapon == IT_NAILGUN))
						{
							self.weapon = IT_SUPER_NAILGUN;
							if ((self.ammo_nails < IT_SUPER_SHOTGUN))
							{
								am = IT_SHOTGUN;
							}
						}
						else
						{
							if ((self.weapon == IT_SUPER_NAILGUN))
							{
								self.weapon = IT_GRENADE_LAUNCHER;
								if ((self.ammo_rockets < IT_SHOTGUN))
								{
									am = IT_SHOTGUN;
								}
							}
							else
							{
								if ((self.weapon == IT_GRENADE_LAUNCHER))
								{
									self.weapon = IT_ROCKET_LAUNCHER;
									if ((self.ammo_rockets < IT_SHOTGUN))
									{
										am = IT_SHOTGUN;
									}
								}
								else
								{
									if ((self.weapon == IT_ROCKET_LAUNCHER))
									{
										self.weapon = IT_LIGHTNING;
										if ((self.ammo_cells < IT_SHOTGUN))
										{
											am = IT_SHOTGUN;
										}
									}
								}
							}
						}
					}
				}
			}
		}
		if (((self.items & self.weapon) && (am == CHAN_AUTO)))
		{
			W_SetCurrentAmmo();
			return;
		}
	}
};

void() ServerflagsCommand =
{
	serverflags = ((serverflags * IT_SUPER_SHOTGUN) + IT_SHOTGUN);
};

void() QuadCheat =
{
	if ((deathmatch || coop))
	{
		return;
	}
	self.super_time = IT_SHOTGUN;
	self.super_damage_finished = (time + SVC_INTERMISSION);
	self.items = (self.items | IT_QUAD);
	dprint("quad cheat\n");
};

void() PrintLocation =
{
	local string p;

	p = vtos(self.origin);
	sound(self, CHAN_BODY, "misc/talk.wav", IT_SHOTGUN, ATTN_NORM);
	sprint(self, "i?:");
	sprint(self, p);
	sprint(self, "\n");
	sprint(self, "®?:");
	bprint(vtos(self.angles));
	sprint(self, "\n");
	sprint(self, "\n");
};

void() ImpulseCommands =
{
	if (((self.impulse >= ATTN_NORM) && (self.impulse <= IT_SUPER_NAILGUN)))
	{
		W_ChangeWeapon();
	}
	if ((self.impulse == MOVETYPE_FLYMISSILE))
	{
		CheatCommand();
	}
	if ((self.impulse == MOVETYPE_BOUNCE))
	{
		CycleWeaponCommand();
	}
	if ((self.impulse == TE_TELEPORT))
	{
		ServerflagsCommand();
	}
	if ((self.impulse == 255))
	{
		QuadCheat();
	}
	if ((self.impulse == 200))
	{
		PrintLocation();
	}
	self.impulse = CHAN_AUTO;
};

void() W_WeaponFrame =
{
	if ((time < self.attack_finished))
	{
		return;
	}
	ImpulseCommands();
	if (self.button0)
	{
		SuperDamageSound();
		W_Attack();
	}
};

void() SuperDamageSound =
{
	if ((self.super_damage_finished > time))
	{
		if ((self.super_sound < time))
		{
			self.super_sound = (time + ATTN_NORM);
			sound(self, CHAN_BODY, "items/damage3.wav", ATTN_NORM, ATTN_NORM);
		}
	}
	return;
};