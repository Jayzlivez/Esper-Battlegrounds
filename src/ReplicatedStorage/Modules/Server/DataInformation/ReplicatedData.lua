local RunService = game:GetService('RunService')
local HttpService = game:GetService('HttpService')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local RemotesFolder = ReplicatedStorage:WaitForChild('Remotes')
local RemoteEvents = ReplicatedStorage.Remotes.RemoteEvents
local Players = game:GetService("Players")
-- // Module // --
local Module = {}

if RunService:IsServer() then
	Module.Replicants = {
		Private = {},
		Public = {},
	}

	function Module:SetData(Category,Data,PlayerTable)
		if PlayerTable then 
			table.insert(Module.Replicants.Private,{Category,Data,PlayerTable})
		else
			Module.Replicants.Public[Category] = Data
		end
	end

	function Module:RemoveData(Category)
		if Module.Replicants.Public[Category] then 
			Module.Replicants.Public[Category] = nil 
		end

		for i, ReplicatedInfo in ipairs(Module.Replicants.Private) do 
			if ReplicatedInfo[1] == Category then 
				table.remove(Module.Replicants.Private,i)
			end
		end
	end

	function Module:UpdateData(Category,Data,PlayerTable)
		if PlayerTable then
			for _, LocalPlayer in ipairs( PlayerTable ) do
				RemoteEvents.Data:FireClient(LocalPlayer,Category,Data)
			end
		else
			RemoteEvents.Data:FireAllClients(Category,Data)
		end
	end

	RemoteEvents.Data.OnServerEvent:Connect(function(Player)
		for publicCategory, publicData in pairs( Module.Replicants.Public ) do
			RemoteEvents.Data:FireClient(Player, publicCategory, publicData )
		end
		for _, replicationInfo in ipairs(Module.Replicants.Private) do
			local Category, Data, PlayerTable = unpack( replicationInfo )
			if table.find( PlayerTable, Player ) then
				RemoteEvents.Data:FireClient(Player,Category,Data)
			end
		end
	end)

	task.spawn(function()
		local comparisonCache = {
			Private = {},
			Public = {}
		}
		while task.wait(.2) do 
			for publicCategory,PublicData in ipairs(Module.Replicants.Public) do 
				local newEncodedString = HttpService:JSONEncode(PublicData) 
				if (not comparisonCache.Public[publicCategory]) or comparisonCache.Public[publicCategory] ~= newEncodedString then 
					comparisonCache.Public[publicCategory] = newEncodedString

					Module:UpdateData(publicCategory,PublicData,nil)
				end
			end

			for _, replicationInfo in ipairs(Module.Replicants.Private) do
				local Category, Data, PlayerTable = unpack( replicationInfo )
				local newEncodedString = HttpService:JSONEncode(Data)
				local newIndex = Category..tostring(PlayerTable)
				if (not comparisonCache.Private[newIndex] ) or comparisonCache.Private[newIndex] ~= newEncodedString then 
					comparisonCache.Private[newIndex] = newEncodedString
					Module:UpdateData( Category, Data, PlayerTable )
				end
			end
		end
	end)
else
	local DataContainer = {}

	local Player = Players.LocalPlayer
	Module.OnUpdate = Instance.new('BindableEvent')

	function Module:GetData(Category,Yield) 
		if DataContainer[Category] then 
			return DataContainer[Category]
		end
		if Yield then 
			local YieldStart = os.clock()
			repeat wait(.01) until DataContainer[Category] or (os.clock() - YieldStart) > 5
		end
		return DataContainer[Category]
	end

	RemoteEvents.Data.OnClientEvent:Connect(function(Category,Data)
		DataContainer[Category] = Data
		Module.OnUpdate:Fire(Category,Data)
	end)
	RemoteEvents.Data:FireServer()
end

return Module
