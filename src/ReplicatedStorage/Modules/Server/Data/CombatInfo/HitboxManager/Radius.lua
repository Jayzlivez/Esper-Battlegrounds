local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local PhysicsService = game:GetService("PhysicsService")
local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local SS = game:GetService("ServerStorage")
local SS2 = game:GetService("ServerScriptService")
local Maid = require(RS.Source.Utils.Maid)


local Debris = game:GetService("Debris")


local RadiusHitbox = {}
RadiusHitbox.__index = RadiusHitbox


function RadiusHitbox.new(Data)
	local self = setmetatable({},RadiusHitbox)
	self.Data = Data or {AutoClean = true}
	self.maid = Maid.new()
	self.conmaid = Maid.new()
	self.OnHit = require(script.Parent.HitTask).new()
	self.maid:GiveTask(self.OnHit)
	return self
end

function RadiusHitbox:CleanConnection()
	self.conmaid:DoCleaning()
end

function RadiusHitbox:RepeatTick(Data)

	
end

function RadiusHitbox:FireTick(Data)
	local Origin = Data.Origin
	local FilterList = Data.FilterList or {workspace.World.Live}
	local FilterType = Data.FilterType or Enum.RaycastFilterType.Include
	local Radius = Data.Radius
	local MaxYDiff = Data.MaxYDiff
	local Caster = Data.Caster
	
	local Para = OverlapParams.new()
	Para.FilterType = FilterType
	Para.FilterDescendantsInstances = FilterList
	
	local AlrHit = {}
	
	local HC = workspace:GetPartBoundsInRadius(Origin,Radius,Para)
	
	for _,Part in pairs(HC) do
		local Character: Model = Part.Parent
		if not Character:FindFirstChild("Humanoid") then continue end
		if Character:FindFirstChild("Humanoid").Health <= 0 then continue end
		if Character == Caster then continue end
		if AlrHit[Character] then continue end
		if not Character.PrimaryPart then continue end
		AlrHit[Character] = true
		self.OnHit:Fire(Character)
	end
	
	if self.Data.AutoClean == true then
		self:Destroy()
	end
	
end


function RadiusHitbox:Destroy()
	self.conmaid:DoCleaning()
	self.conmaid:Destroy()
	self.maid:DoCleaning()
	self.maid:Destroy()
	self = nil
end

return RadiusHitbox


