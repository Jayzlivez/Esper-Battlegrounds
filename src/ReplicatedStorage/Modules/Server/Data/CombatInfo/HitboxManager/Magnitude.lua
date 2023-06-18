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


local MagnitudeHitbox = {}
MagnitudeHitbox.__index = MagnitudeHitbox


function MagnitudeHitbox.new(Data)
	local self = setmetatable({},MagnitudeHitbox)
	self.Data = Data or {AutoClean = true}
	self.maid = Maid.new()
	self.conmaid = Maid.new()
	self.OnHit = require(script.Parent.HitTask).new()
	self.maid:GiveTask(self.OnHit)
	return self
end

function MagnitudeHitbox:CleanConnection()
	self.conmaid:DoCleaning()
end

function MagnitudeHitbox:RepeatTick(Settings)
	local Origin = Settings.Origin
	if typeof(Origin) == "CFrame" then
		Origin = Settings.Origin.Position
	end
	local Range = Settings.Range
	local YRange = Settings.YRange or NumberRange.new(-math.huge,math.huge)
	local AutoClean = self.Data.AutoClean
	
	local BreakOnHit = Settings.BreakOnHit
	local Rate = Settings.Rete
	local HitOnce = Settings.HitOnce
	local MultHit = Settings.MultHit
	local Duration = Settings.Duration
	
	
	local Vis = Settings.Visual or false
	
	
	
	task.spawn(function()
		local Flag = false
		local StartTime = os.clock()
		
		local AlrProcessed = {}
		local CheckHit = {}
		local TimeCD = {}
		local VisPart
		if Vis then
			VisPart = Instance.new("Part")
			VisPart.Anchored = true
			VisPart.Material = Enum.Material.ForceField
			VisPart.CanCollide = false
			VisPart.CanQuery = false
			VisPart.CanTouch = false
			VisPart.Parent = workspace.World.Visuals
			VisPart.Size = Vector3.new(Range,Range,Range)
			VisPart.Shape = Enum.PartType.Ball
			VisPart.CFrame = CFrame.new(Origin)
		end
		
		
		repeat
			local HitLar = true
			for i = 1,2 do
				for _,Character in pairs(workspace.World.Live:GetChildren()[i]:GetChildren()) do
					if Character == Settings.Caster then continue end
					local Dist = (Character.HumanoidRootPart.CFrame.Position - Origin).Magnitude
					local YDiff = math.abs(Character.HumanoidRootPart.CFrame.Position.Y - Origin.Y)
					local YRangeCon = (YDiff > YRange.Min and YDiff < YRange.Max)
					if not YRangeCon or Dist > Range then continue end
					if HitLar == false then continue end
					if TimeCD[Character.Parent] and MultHit == true then continue end
					if HitOnce == true then
						CheckHit[Character.Parent] = true
					end
					if MultHit == false then
						HitLar = false
					end
					if BreakOnHit == true then 
						Flag = true
					end
					if Rate then
						TimeCD[Character.Parent] = true
						task.delay(Rate,function()
							TimeCD[Character.Parent] = false
							TimeCD[Character.Parent] = nil
						end)
					end		
					self.OnHit:Fire(Character)
				end
			end
			RunService.Heartbeat:Wait()
		until os.clock() - StartTime > Duration or Flag == true
		
		if VisPart then
			VisPart:Destroy()
			VisPart = nil
		end
		
		print(AutoClean)
		if AutoClean == true then
			self:Destroy()
		end
	end)
	
	
end

function MagnitudeHitbox:FireTick(Settings)
	local Origin = Settings.Origin
	if typeof(Origin) == "CFrame" then
		Origin = Settings.Origin.Position
	end
	local Range = Settings.Range
	local YRange = Settings.YRange or NumberRange.new(-math.huge,math.huge)
	local AutoClean = self.Data.AutoClean
	
	
	for i = 1,2 do
		for _,Character in pairs(workspace.World.Live:GetChildren()[i]:GetChildren()) do
			if Character == Settings.Caster then continue end
			local Dist = (Character.HumanoidRootPart.CFrame.Position - Origin).Magnitude
			local YDiff = math.abs(Character.HumanoidRootPart.CFrame.Position.Y - Origin.Y)
			local YRangeCon = (YDiff > YRange.Min and YDiff < YRange.Max)
			if not YRangeCon or Dist > Range then continue end
			
			
			self.OnHit:Fire(Character)
		end
	end
	
	if AutoClean then
		self:Destroy()
	end
end


function MagnitudeHitbox:Destroy()
	self.conmaid:DoCleaning()
	self.conmaid:Destroy()
	self.maid:DoCleaning()
	self.maid:Destroy()
	self = nil
end

return MagnitudeHitbox


