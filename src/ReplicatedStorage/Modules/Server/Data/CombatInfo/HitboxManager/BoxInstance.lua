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

local BoxInstance = {}

BoxInstance.__index = BoxInstance

function BoxInstance.NewHitInstance(Data,Type)
	local T = {}
	T.Data = Data
	T.Type = Type
	T.maid = Maid.new()
	T.OnHit = require(script.Parent.HitTask).new()
	T.BuildHit = require(script.Parent.HitTask).new()
	T.maid:GiveTask(T.OnHit)
	T.maid:GiveTask(T.BuildHit)
	setmetatable(T,BoxInstance)
	return T
end

function BoxInstance:Start()
	if self.Type == "CRepeatCFrame" then
		self:StartCRepeatCFrame()
	end
end

function BoxInstance:StartCRepeatCFrame()
	local Data = self.Data
	local Frame = Data.CFrame
	local Size = Data.Size
	local Offset = Data.Offset or CFrame.new(0,0,0)
	local FilterList = Data.FilterList or {workspace.World.Live}
	local FilterType = Data.FilterType or Enum.RaycastFilterType.Include
	local Caster = Data.Caster
	local OffsetPart = Data.OffsetPart
	
	
	local CanDestroyMap = Data.MapDestroy
	
	if CanDestroyMap and FilterType == Enum.RaycastFilterType.Include then
		table.insert(FilterList,workspace.World.Map)
	end
	
	local Buildings = {}
	local MaxBuildingHit = 5 or Data.MaxBuildingHit
	
	local Dur = Data.Dur
	local Rate = Data.Rate

	local BreakOnHit = Data.BreakOnHit or false
	local HitOnce = Data.HitOnce 
	local MultHit = Data.MultHit or false

	local Vis = Data.Visual or false
	
	if typeof(Data.Offset) == "Vector3" then
		Data.Offset = CFrame.new(Data.Offset.X,Data.Offset.Y,Data.Offset.Z)
	end
	
	task.spawn(function()
		local StartTick = os.clock()
		local AlrProcessed = {}
		local CheckHit = {}
		local TimeCD = {}
		
		local TriggerBreak = false

		local VisPart

		if Vis then
			VisPart = Instance.new("Part")
			VisPart.Anchored = true
			VisPart.Material = Enum.Material.ForceField
			VisPart.CanCollide = false
			VisPart.CanQuery = false
			VisPart.CanTouch = false
			VisPart.Color = Data.Color or Color3.new(1, 1, 1)
			VisPart.Parent = workspace.World.Visuals
			VisPart.Size = Size
		end
		
		
		repeat
			local Para = OverlapParams.new()
			Para.FilterType = FilterType
			Para.FilterDescendantsInstances = FilterList
			
			local TargetFrame = Frame
			if OffsetPart then
				TargetFrame = OffsetPart.CFrame * Data.Offset
			end

			if Vis then
				VisPart.CFrame = TargetFrame
			end
			local HitBox = workspace:GetPartBoundsInBox(TargetFrame,Size,Para)
			
	
			local HitLar = false
			
			
			for _,Character in pairs(HitBox) do
				if not CheckHit[Character.Parent] and Caster ~= Character.Parent and Character.Parent:FindFirstChild("Humanoid") and Character.Parent:FindFirstChild("Humanoid").Health > 0 and Character.Parent.PrimaryPart and HitLar == false then
					if TimeCD[Character.Parent] and MultHit == true then continue end
					if HitOnce == true then
						table.insert(FilterList,Character.Parent)
						CheckHit[Character.Parent] = true
					end
					if MultHit == false then
						HitLar = true
					end
					if BreakOnHit == true then 
						TriggerBreak = true
					end
					if Rate then
						TimeCD[Character.Parent] = true
						task.delay(Rate,function()
							TimeCD[Character.Parent] = false
							TimeCD[Character.Parent] = nil
						end)
					end
					self.OnHit:Fire(Character.Parent)
				end
				if Character.Parent.Name == "Buildings" and Character.Parent:GetAttribute("Health") and Character.Parent:GetAttribute("MaxHealth") and Character.Parent:GetAttribute("Health") > 0 then
					if Buildings[Character.Parent] then if Buildings[Character.Parent] >= MaxBuildingHit then return end end
					if not Buildings[Character.Parent] then
						Buildings[Character.Parent] = 0
					end
					Buildings[Character.Parent] += 1
					self.BuildHit:Fire(Character.Parent)
				end
			end


			RunService.Heartbeat:Wait()
		until os.clock() - StartTick >= Dur or TriggerBreak == true

		if VisPart then
			VisPart:Destroy()
			VisPart = nil
		end
		self:Destroy()
	end)

end



function BoxInstance:Destroy()
	self.maid:DoCleaning()
	self.maid:Destroy()
	self = nil
end

return BoxInstance
