--// Services
local ReplicatedStorage = game:GetService('ReplicatedStorage')

--// Modules
local BasicState = require(ReplicatedStorage.Packages.BasicState)

--// Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Controller
local PlayerController = Knit.CreateController { Name = "PlayerController" }

--// Variables
function PlayerController:KnitInit()
    
end

function PlayerController:KnitStart()
    -------------Variables-----------
    Knit.State = BasicState.new({
        Character = Knit.Player.Character or Knit.Player.CharacterAdded
    })
    -------------Variables-----------
    -------------Classes-------------
    
    -------------Classes-------------
    -----------Initialize------------
    Knit.Player.CharacterAdded:Connect(function(character)
        Knit.State:Set("Character", character)
    end)

    Knit.State:GetChangedSignal("Character"):Connect(function()
        
    end)
    -----------Initialize------------
end

return PlayerController