--// Game Services
local ReplicatedStorage = game:GetService('ReplicatedStorage')

--// Modules

--// Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Service
local DataService = Knit.CreateService {
    Name = "DataService";
    Client = {
    };
}



function DataService:KnitInit()
	self.DataRemote = _G.API.CreateRF("DataRemote")
	self.setforPlayers = {}
	self.StateReplicas = {}
	-- self.StateClassToken = ReplicaService.NewClassToken("StateProfileReplication")
end

function DataService:KnitStart()
    -------------Variables-----------
    
    -------------Variables-----------
    -------------Classes-------------
    
    -------------Classes-------------
    -----------Initialize------------
    
    -----------Initialize------------
end

return DataService