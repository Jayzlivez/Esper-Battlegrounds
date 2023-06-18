--// Game Services
local Players = game:GetService('Players')
local ReplicatedStorage = game:GetService('ReplicatedStorage')

--// Modules

--// Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Service
local CharacterService = Knit.CreateService {
    Name = "CharacterService";
    Client = {};
}

function CharacterService:KnitInit()
    
end

function CharacterService:KnitStart()
    -------------Variables-----------
    
    -------------Variables-----------
    -------------Classes-------------
    
    -------------Classes-------------
    -----------Initialize------------
    Players.PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(Character: Model & {Humanoid: Humanoid, HumanoidRootPart: BasePart})
            
        end)

        self:Setup()
    end)
    -----------Initialize------------
end


function CharacterService:Setup(Player: Player)
    
end

return CharacterService