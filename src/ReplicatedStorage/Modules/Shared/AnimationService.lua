local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local Shared = ReplicatedStorage.Modules.Shared
local Server = ReplicatedStorage.Modules.Server
local Data = Shared.Data

local AnimationService = {}


local CurrentAnimation = {}
local LoopAnimations = {}

function AnimationService:ChangeAnimationSet(Character,AnimationData)
	local StateService = require(ReplicatedStorage.Modules.Server.Data.CombatInfo.StateService)
	local Humanoid = Character:WaitForChild("Humanoid")
	local Animate = Character:FindFirstChild("Animate")

	local animTracks = Humanoid.Animator:GetPlayingAnimationTracks()
	for i,track in ipairs(animTracks) do
		track:Stop()
		track:Destroy()
	end

	--Animate.idle.Animation1.AnimationId = AnimationData["Idle"].ID
	--Animate.idle.Animation1.Weight.Value = AnimationData["Idle"].Weight or 3
	--Animate.idle.Animation2.AnimationId = AnimationData["Idle"].ID
	--Animate.idle.Animation2.Weight.Value = AnimationData["Idle"].Weight or 3
	Animate.walk.WalkAnim.AnimationId = AnimationData["Walk"].ID
	Animate.run.RunAnim.AnimationId = AnimationData["Walk"].ID

	local animTracks = Humanoid.Animator:GetPlayingAnimationTracks()
	for i,track in ipairs(animTracks) do
		track:Stop()
		track:Destroy()
	end

end
function AnimationService:StopAnimationKey(SearchKey: String,Character)
	for i = 1, #LoopAnimations do
		if not LoopAnimations[i] then continue end
		if LoopAnimations[i].Name:lower():match(SearchKey:lower()) and LoopAnimations[i].Name:lower():match(Character.Name:lower()) then 
			LoopAnimations[i].Looped = false
			LoopAnimations[i]:Stop()
			table.remove(LoopAnimations,i)
			break
		end
	end
end

function AnimationService:StopLoopingAnimation(Character)
	for i = 1, #LoopAnimations do
		if not LoopAnimations[i] then continue end
		if LoopAnimations[i].Name:lower():match(Character.Name:lower()) then 
			LoopAnimations[i].Looped = false
			LoopAnimations[i]:Stop()
			table.remove(LoopAnimations,i)
		end
	end
end

function AnimationService:StopAllAnimations(Character)
	for i = 1, #LoopAnimations do
		if not LoopAnimations[i] then continue end
		if LoopAnimations[i].Name:lower():match(Character.Name:lower()) then 
			LoopAnimations[i].Looped = false
			LoopAnimations[i]:Stop()
			table.remove(LoopAnimations,i)
		end
	end
	
	local animTracks = Character.Humanoid.Animator:GetPlayingAnimationTracks()
	for i,track in ipairs(animTracks) do
		track:Stop()
		track:Destroy()
	end
end

function AnimationService:PlayAnimation(Animation,Humanoid,AnimationData)
	local Animator = Humanoid:WaitForChild("Animator")
	local Track
	if type(Animation) == "string" then
		Track = Instance.new("Animation")
		Track.Name = AnimationData.Name..":"..Humanoid.Parent.Name
		Track.AnimationId = Animation
	else
		Track = Animation
	end
	local LoadedTrack = Humanoid:LoadAnimation(Track)
	if AnimationData.Looped == "Looped" then 
		table.insert(LoopAnimations,LoadedTrack)
	else
		table.insert(CurrentAnimation,LoadedTrack)
	end
	LoadedTrack:Play()
end

function AnimationService:CheckAnimationKey(SearchKey: String,Character)
	local Send = false
	for i = 1, #LoopAnimations do
		if not LoopAnimations[i] then continue end
		if LoopAnimations[i].Name:lower():match(SearchKey:lower()) and LoopAnimations[i].Name:lower():match(Character.Name:lower()) then 
			Send = true
		end
	end
	
	for i = 1, #CurrentAnimation do
		if not CurrentAnimation[i] then continue end
		if CurrentAnimation[i].Name:lower():match(SearchKey:lower()) and CurrentAnimation[i].Name:lower():match(Character.Name:lower()) then 
			Send = true
		end
	end
	
	return Send
end

function AnimationService:LoadAnimation(Animation,Humanoid,AnimationData)
	if not Humanoid:FindFirstChild("Animator") then
		local Animator = Instance.new("Animator")
		Animator.Parent = Humanoid
	end
	local Animator = Humanoid:WaitForChild("Animator")
	local Track
	if type(Animation) == "string" then
		Track = Instance.new("Animation")
		Track.Name = AnimationData.Name..":"..Humanoid.Parent.Name
		Track.AnimationId = Animation
	else
		Track = Animation
	end

	local LoadedTrack = Humanoid.Animator:LoadAnimation(Track)

	if AnimationData.Looped == true then
		table.insert(LoopAnimations,LoadedTrack)
		LoadedTrack.Looped = true
	else
		table.insert(CurrentAnimation,LoadedTrack)
	end

	task.spawn(function()
		LoadedTrack.Stopped:Connect(function()
			for i = 1 , #CurrentAnimation do 
				table.remove(CurrentAnimation,i)
			end
			LoadedTrack:Destroy()
		end)
	end)

	return LoadedTrack
end

return AnimationService