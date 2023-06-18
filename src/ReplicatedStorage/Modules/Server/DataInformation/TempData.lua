local TempData = {
	LogInTimes = 0,
	GamePlayDuration = {
		["Hours"] = 00,
		["Minutes"] = 00,
		["Seconds"] = 00,
	},
	Ability = "",
	SelectedSlot = "Owned_1";
	Gold = 0,
	Gems = 0,
	Level = 0,
	LevelInfo = {
		MaxExp = 100,
		Exp = 0
	},
	RedeemedCodes = {
		
	},
	SkipRolls = 0,
	Spins = 5,
	RareSpins = 0,
	LegendarySpins = 0,
	Kills = 0,
	Deaths = 0,
	KD = 0,
	DoubleEXPTime = 0,
	DoubleGoldTime = 0,
	DoubleGemTime = 0,
};

TempData.Settings = {
	["CameraShakes"] = true,
	["MusicVolume"] = 0,
	["EffectVolume"] = 0,	
};

TempData.EndGameStats = {
	["Kills"] = 0,
	["TimeAlive"] = 0,
	["Downs"] = 0,
}

TempData.Stats = {
	["Kills"] = 0,
	["Deaths"] = 0,
	["KDR"] = 0,
}

TempData.PrivateServer = {
	LastPSCode = "",
	BannedPlayers = {},
	Admins = {},
	Mods = {},
}


TempData.PowerStorage = {
	MaxSlots = 10,
	ExtraSlots = 0,
	Slots = {
		
	};
	SelectedSlots = {
		["Q"] = "", 
		["E"] = "", 
		["R"] = "", 
		["C"] = "", 
		["V"] = "", 
	};
	Levels = {
		SkillSets = {
			
		};
		Skills = {
			
		};
	};
}


TempData.AFKWorld = {
	["Gems"] = 0,
	["Gold"] = 0,
}

TempData.MatchMakingStats = {
	["1v1Rank"] = 0,
	["2v2Rank"] = 0,
	["TotalKills"] = 0,
	["TotalDeaths"] = 0,
	["TotalWins"] = 0,
	["TotalLoses"] = 0,
	["Kills"] = 0, --- Per Season/Rank Reset if we doing that
	["Deaths"] = 0, --- Per Season/Rank Reset if we doing that
	["Wins"] = 0, --- Per Season/Rank Reset if we doing that
	["Loses"] = 0, --- Per Season/Rank Reset if we doing that
}


--TempData.Settings = {
--	["CameraShakes"] = true,
--	["MusicVolume"] = 0,
--	["EffectVolume"] = 0,	
--};


return TempData


--local TempData = {
--	PlayerData = {
--		PlayerInformation = {
--			LogInTimes = 0,
--			GamePlayDuration = 0,
--		},
--		Stats = {
--			Gold = 300,
--			Ability = "", 
--			FightingStyle = "",
--			Spins = 5,
--			Skins = {
--				Default = true,
--				NewSkin001 = false,
--				NewSkin002 = false,
--				NewSkin003 = false,
--				NewSkin004 = false,
--				NewSkin005 = false,
--			};
--			Costmetics = {};
--		}	
--	},

--	CharacterData = {
--		Class = {}
--	}
--};



--return TempData