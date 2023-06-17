--// Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--// Class
local Temp = {}
Temp.__index = Temp


function Temp.new()
    
    local info = {
        Connections = {}
    }
    setmetatable(info, Temp)
    return info
end

function Temp:Init()
    
end

function Temp:Disconnect()
    for _, c: RBXScriptConnection in pairs(self.Connections) do
        c:Disconnect()
    end
end

function Temp:Destroy()
    self:Disconnect()
    
    setmetatable(self, nil)
    table.clear(self)
    table.freeze(self)
end


return Temp