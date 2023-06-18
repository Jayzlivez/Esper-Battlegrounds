---/// SERVICES
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Debris = game:GetService("Debris")
local RunService = game:GetService("RunService")

local StatesManager = require(ReplicatedStorage.Modules.Server.Data.CombatInfo.StatesManager)
local Utility = require(ReplicatedStorage.Modules.Shared.Utility)

_G.Debounces = {}
local Debounces = _G.Debounces
local overlapParams = OverlapParams.new()

local module = {}

function module:RepeatSpatialQuery(Data)
	local HitInstance = require(script.BoxInstance).NewHitInstance(Data,"CRepeatCFrame")
	return HitInstance
end

function module:ProjectileCast()
	local Instances = require(script.AoeProjectile).new()
	return Instances
end


function module:MagnitudeCast(Data)
	local Instances = require(script.Magnitude).new(Data)
	return Instances
end


function module:RadiusHitBox(Data)
	local Instances = require(script.Radius).new(Data)
	return Instances
end

function module:SpatialQuery(Data,Function)
	local Enemies = {}

	local Point = ReplicatedStorage.Assets.Models.Combat.MidPoint:Clone()
	Point.Size = Data.Size
	Point.CFrame = Data.Target.CFrame * CFrame.new(Data.Distance)
	Point.Anchored = true
	Point.Transparency = 1
	Point.CanCollide = false
	Point.Parent = workspace.World.Visuals
	Debris:AddItem(Point,Data.LifeTime)

	local Result = nil 
	
	
	overlapParams.FilterDescendantsInstances = {workspace.World.Map,Data.Character,Point}
    overlapParams.FilterType = Enum.RaycastFilterType.Exclude
	
	local TouchingList = workspace:GetPartsInPart(Point,overlapParams)
	
	for i ,Parts in pairs(TouchingList) do 
		if tostring(Parts) == "HumanoidRootPart" then 
			local Result = Parts.Parent
			if Result then 
				coroutine.wrap(function()
					task.wait(2)
					Enemies = nil
				end)()
				table.insert(Enemies,Result)
			end
		end
	end
	return Function(Enemies)
end

function module:Magnitude(Data,Function)
	local MidPoint = ReplicatedStorage.Assets.Models.Combat.MidPoint:Clone()

	MidPoint.Size = Vector3.new(1,1,1)
	MidPoint.CFrame = Data.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
	MidPoint.Transparency = 0.5
	MidPoint.CFrame = MidPoint.CFrame * CFrame.new(0,0,MidPoint.Size.Z/-2)
	MidPoint.Anchored = true
	MidPoint.Parent = workspace.Visuals
	Debris:AddItem(MidPoint,.3)

	local MinimalTarget = Data.Range

	for i , v in pairs(Data.TargetFolder:GetDescendants()) do
		if v:FindFirstChild("Humanoid") and v ~= Data.Character then 		
			local Distance = (MidPoint.Position - v.HumanoidRootPart.Position).Magnitude
			if Distance <= MinimalTarget then 
				local Result = v
				if v.Humanoid.Health == 0 then return end
				--	StatesManager:Sweep(Result)

				if Result then 
					coroutine.wrap(function()
						if StatesManager:Peek(Result,"Blocking",true) or StatesManager:Peek(Result,"PerfectBlock",true) or Data.Key == "Transmission" then return end
						local Combo = Data.Character:WaitForChild("Hits")
						local HitAtt = Combo:GetAttribute("Keys")
						if HitAtt == '' then
							Combo:SetAttribute("Keys",HitAtt..Data.Key)
							Combo:SetAttribute("Delay",0)
							Debounces["lastPress"..Data.p.Name] = tick()
							Combo:SetAttribute("Target",Result.Name)
						elseif HitAtt~='' then
							if Combo:GetAttribute("Target") ~= '' then
								Combo:SetAttribute("Keys",HitAtt..Data.Key)
								Combo:SetAttribute("Delay",0)
								Debounces["lastPress"..Data.p.Name] = tick()
								Combo:SetAttribute("Target",Result.Name)
							end	
							local Delays = Utility.SplitString(Combo:GetAttribute("Delay"))
							local Gap = tostring(tick()-Debounces["lastPress"..Data.p.Name])
							Gap = string.sub(Gap,1,4)
							Combo:SetAttribute("Keys",HitAtt..','..Data.Key)
							Combo:SetAttribute("Delay",Combo:GetAttribute("Delay")..","..Gap)
							Debounces["lastPress"..Data.p.Name] = tick()
						end
					end)()
					return Function(Result)
				end
				break
			end
		end
	end
end

return module
