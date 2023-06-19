--// Services
local ReplicatedStorage = game:GetService('ReplicatedStorage')

--// Modules

--// Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

--// Controller
local CameraController = Knit.CreateController { Name = "CameraController" }

--// Variables
function CameraController:KnitInit()
    self.CameraSubject = "Humanoid"
end

function CameraController:KnitStart()
    -------------Variables-----------
    
    -------------Variables-----------
    -------------Classes-------------
    
    -------------Classes-------------
    -----------Initialize------------
    
    -----------Initialize------------
end

function CameraController:CutToScene()
    
end

return CameraController