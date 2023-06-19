--// Game Services
local ReplicatedStorage = game:GetService('ReplicatedStorage')

--// Modules

--// Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Service
local StateService = Knit.CreateService {
    Name = "StateService";
    Profiles = {},
    Client = {
        GetState = Knit.CreateSignal(),
    };
}

function StateService:KnitInit()
    
end

function StateService:NewProfile(Character: model)
    if self.Profiles[Character] then return end
    self.Profiles[Character] = {
        StateData = {},
    }
end

function StateService:KnitStart()
    -------------Variables-----------
    
    -------------Variables-----------

    -------------Classes-------------
    


    -------------Classes-------------

    -----------Initialize------------
    
    -----------Initialize------------
end

return StateService