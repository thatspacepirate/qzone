//Decompiled code. Please respect the original copyright.
void() T_MissileTouch;
void() info_player_start;
void(entity targ, entity attacker) ClientObituary;
void() monster_death_use;

float(entity targ, entity inflictor) CanDamage =
{
	if ((targ.movetype == MOVETYPE_PUSH))
	{
		traceline(inflictor.origin, (0.5 * (targ.absmin + targ.absmax)), TRUE, self);
		if ((trace_fraction == TRUE))
		{
			return (TRUE);
		}
		if ((trace_ent == targ))
		{
			return (TRUE);
		}
		return (FALSE);
	}
	traceline(inflictor.origin, targ.origin, TRUE, self);
	if ((trace_fraction == TRUE))
	{
		return (TRUE);
	}
	traceline(inflictor.origin, (targ.origin + '15 15 0'), TRUE, self);
	if ((trace_fraction == TRUE))
	{
		return (TRUE);
	}
	traceline(inflictor.origin, (targ.origin + '-15 -15 0'), TRUE, self);
	if ((trace_fraction == TRUE))
	{
		return (TRUE);
	}
	traceline(inflictor.origin, (targ.origin + '-15 15 0'), TRUE, self);
	if ((trace_fraction == TRUE))
	{
		return (TRUE);
	}
	traceline(inflictor.origin, (targ.origin + '15 -15 0'), TRUE, self);
	if ((trace_fraction == TRUE))
	{
		return (TRUE);
	}
	return (FALSE);
};

void(entity targ, entity attacker) Killed =
{
	local entity oself;

	oself = self;
	self = targ;
	if ((self.health < -99))
	{
		self.health = -99;
	}
	if (((self.movetype == MOVETYPE_PUSH) || (self.movetype == MOVETYPE_NONE)))
	{
		self.th_die();
		self = oself;
		return;
	}
	self.enemy = attacker;
	if ((self.flags & FL_MONSTER))
	{
		killed_monsters = (killed_monsters + TRUE);
		WriteByte(MSG_ALL, SVC_KILLEDMONSTER);
	}
	ClientObituary(self, attacker);
	self.takedamage = DAMAGE_NO;
	self.touch = SUB_Null;
	monster_death_use();
	self.th_die();
	self = oself;
};

void(entity targ, entity inflictor, entity attacker, float damage) T_Damage =
{
	local vector dir;
	local entity oldself;
	local float save;
	local float take;
	local float rnum;

	rnum = random();
	if (!targ.takedamage)
	{
		return;
	}
	damage_attacker = attacker;
	if ((attacker.super_damage_finished > time))
	{
		damage = (damage * AS_MISSILE);
	}
	save = ceil((targ.armortype * damage));
	if ((save >= targ.armorvalue))
	{
		save = targ.armorvalue;
		targ.armortype = DAMAGE_NO;
		targ.items = (targ.items - (targ.items & ((IT_ARMOR1 | IT_ARMOR2) | IT_ARMOR3)));
	}
	targ.armorvalue = (targ.armorvalue - save);
	take = ceil((damage - save));
	if ((targ.flags & FL_CLIENT))
	{
		targ.dmg_take = (targ.dmg_take + take);
		targ.dmg_save = (targ.dmg_save + save);
		targ.dmg_inflictor = inflictor;
	}
	if (((inflictor != world) && (targ.movetype == MOVETYPE_WALK)))
	{
		dir = (targ.origin - ((inflictor.absmin + inflictor.absmax) * 0.5));
		dir = normalize(dir);
		targ.velocity = (targ.velocity + ((dir * damage) * FL_CLIENT));
	}
	if ((targ.flags & FL_GODMODE))
	{
		return;
	}
	if ((targ.invincible_finished >= time))
	{
		if ((self.invincible_sound < time))
		{
			sound(targ, CHAN_ITEM, "items/protect3.wav", TRUE, ATTN_NORM);
			self.invincible_sound = (time + MSG_ALL);
		}
		return;
	}
	if ((((teamplay == ATTN_NORM) && (targ.team > DAMAGE_NO)) && (targ.team == attacker.team)))
	{
		return;
	}
	if ((targ.classname == "monster_snapper"))
	{
		if ((targ.frags == DAMAGE_NO))
		{
			take = DAMAGE_NO;
		}
	}
	targ.health = (targ.health - take);
	if (deathmatch)
	{
		if (((attacker.movetype == MOVETYPE_WALK) && (attacker != targ)))
		{
			if ((random() < DAMAGE_NO))
			{
				if ((rnum < 0.05))
				{
					stuffcmd(targ, "Damn, that hurts!\n");
				}
				else
				{
					if ((rnum < 0.1))
					{
						stuffcmd(targ, "say Look, LAY OFF!\n");
					}
					else
					{
						if ((rnum < 0.15))
						{
							stuffcmd(targ, "say I think its time for ME to molest YOU\n");
						}
						else
						{
							if ((rnum < 0.2))
							{
								stuffcmd(targ, "say No more pr0n for you porky!\n");
							}
							else
							{
								if ((rnum < 0.25))
								{
									stuffcmd(targ, "say Ya wouldn't hit me but for my connect..\n");
								}
								else
								{
									if ((rnum < 0.3))
									{
										stuffcmd(targ, "say Hey quit I'm tryin to learn the map\n");
									}
									else
									{
										if ((rnum < 0.35))
										{
											stuffcmd(targ, "say Man wait'll I get a gun\n");
										}
										else
										{
											if ((rnum < 0.4))
											{
												stuffcmd(targ, "say Fine, have your way with me.\n");
											}
											else
											{
												if ((rnum < 0.45))
												{
													stuffcmd(targ, "say STOP boning me.\n");
												}
												else
												{
													if ((rnum < 0.5))
													{
														stuffcmd(targ, "say Hey that felt good.\n");
													}
													else
													{
														if ((rnum < 0.55))
														{
															stuffcmd(targ, "say Man I was lagged for a sec.\n");
														}
														else
														{
															if ((rnum < 0.6))
															{
																stuffcmd(targ, "say STOP!\n");
															}
															else
															{
																if ((rnum < 0.65))
																{
																	stuffcmd(targ, "say Lucky snot\n");
																}
																else
																{
																	if ((rnum < 0.75))
																	{
																		stuffcmd(targ, "say MAN I WAS TYPING!\n");
																	}
																	else
																	{
																		if ((rnum < 0.8))
																		{
																			stuffcmd(targ, "say Goddamn campers popping out..\n");
																		}
																		else
																		{
																			if ((rnum < 0.85))
																			{
																				stuffcmd(targ, "say CAMPER!\n");
																			}
																			else
																			{
																				if ((rnum < 0.9))
																				{
																					stuffcmd(targ, "say Man I quit, see you on irc.\n");
																				}
																			}
																		}
																	}
																}
															}
														}
													}
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
	}
	if ((targ.health <= DAMAGE_NO))
	{
		Killed(targ, attacker);
		return;
	}
	oldself = self;
	self = targ;
	if (((self.flags & FL_MONSTER) && (attacker != world)))
	{
		if (((self != attacker) && (attacker != self.enemy)))
		{
			if (((self.classname != attacker.classname) || (self.classname == "monster_army")))
			{
				if ((self.enemy.classname == "player"))
				{
					self.oldenemy = self.enemy;
				}
				self.enemy = attacker;
				FoundTarget();
			}
		}
	}
	if (self.th_pain)
	{
		self.th_pain(attacker, take);
		if ((skill == MOVETYPE_WALK))
		{
			self.pain_finished = (time + TE_LIGHTNING1);
		}
	}
	self = oldself;
};

void(entity inflictor, entity attacker, float damage, entity ignore) T_RadiusDamage =
{
	local float points;
	local entity head;
	local vector org;

	head = findradius(inflictor.origin, (damage + 40));
	while (head)
	{
		if ((head != ignore))
		{
			if (head.takedamage)
			{
				org = (head.origin + ((head.mins + head.maxs) * 0.5));
				points = (0.5 * vlen((inflictor.origin - org)));
				if ((points < DAMAGE_NO))
				{
					points = DAMAGE_NO;
				}
				points = (damage - points);
				if ((head == attacker))
				{
					points = (points * 0.5);
				}
				if ((points > DAMAGE_NO))
				{
					if (CanDamage(head, inflictor))
					{
						if ((head.classname == "monster_shambler"))
						{
							T_Damage(head, inflictor, attacker, (points * 0.5));
						}
						else
						{
							T_Damage(head, inflictor, attacker, points);
						}
					}
				}
			}
		}
		head = head.chain;
	}
};

void(entity attacker, float damage) T_BeamDamage =
{
	local float points;
	local entity head;

	head = findradius(attacker.origin, (damage + 40));
	while (head)
	{
		if (head.takedamage)
		{
			points = (0.5 * vlen((attacker.origin - head.origin)));
			if ((points < DAMAGE_NO))
			{
				points = DAMAGE_NO;
			}
			points = (damage - points);
			if ((head == attacker))
			{
				points = (points * 0.5);
			}
			if ((points > DAMAGE_NO))
			{
				if (CanDamage(head, attacker))
				{
					if ((head.classname == "monster_shambler"))
					{
						T_Damage(head, attacker, attacker, (points * 0.5));
					}
					else
					{
						T_Damage(head, attacker, attacker, points);
					}
				}
			}
		}
		head = head.chain;
	}
};