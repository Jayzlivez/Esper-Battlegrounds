
return {
	["DamageTable"] = {

	},
	["WeaveTable"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,

		WeaveID = "",
		Range = 5,
		
		AllOn = false,
	},
	["Grab"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["Knocked"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["GrabCD"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["Grabbing"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["Ragdolled"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["Ragdolledcancel"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["WeaveCD"] = {
		Type = "NumberValue",


		StartTime = workspace:GetServerTimeNow(),
		Duration =  0,
	},
	["GuardBroken"] = {
		Type = "NumberValue",


		StartTime = workspace:GetServerTimeNow(),
		Duration =  0,
	},
	["Dashing"] = {
		Type = "NumberValue",


		StartTime = workspace:GetServerTimeNow(),
		Duration =  0,
	},
	["IFrame"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["EndLag"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["DoubleJump"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["Counter"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,

		CounterID = "",
		Projectiles = false,
		ProjectilesOnly = false,
		Range = 5,
	},	
	["Weaving"] = {
		Type = "NumberValue",


		StartTime = workspace:GetServerTimeNow(),
		Duration =  0,


		CanUse = {}
	},
	["Blocking"] = {
		Type = "UniqueBoolean",


		Bool = false,

		MaxBar = 30,
		Bar = 3,

		LastRegenTick = workspace:GetServerTimeNow(),
		Rate = 0.5,


		CanUse = {}
	},
	["Running"] = {
		Bool = false,
		Type = "Boolean",
	},
	["Stunned"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["CanJump"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["PerfectBlock"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
		CD = 0,
		AllOn = false,
		CDTick = workspace:GetServerTimeNow(),
	},
	["CantRun"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["CantDash"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["CantBlock"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["CantM1"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["M1Cooldown"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["M1CooldownOver"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["Swing"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["SwingP"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["UsingSkill"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["UsingUlt"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["DashCooldown"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["BlockCooldown"] = {
		Type = "UniqueNumberValue",
		StartTime = workspace:GetServerTimeNow(),
		Duration = 0,
		LastPriority = 0,
	},
	["M1Count"] = {
		Type = "SPNumberValue",
		Count = 1,
	},
	["ComboCount"] = {
		Type = "SPNumberValue",
		Count = 1,
	},
	["UniversalCounter"] = {
		Type = "SPNumberValue",
		Count = 1,
	},	
	["LastAttacker"] = {
		Type = "CustomState",

		LastAttackTime = workspace:GetServerTimeNow(),

		LastAttackMove = "",

		LastAttacker = "None",


	},

	["AirCombo"] = {
		Bool = false,
		HitConnect = false,
	},
}