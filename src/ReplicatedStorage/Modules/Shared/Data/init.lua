--|| SERVICES ||--
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

--|| MODULES ||--
local module = {}

for _, Module in ipairs(script:GetChildren()) do
	if Module:IsA("ModuleScript") then
		module[Module.Name] = require(Module)
	end
end

return module
