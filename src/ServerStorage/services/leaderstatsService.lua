local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")

local knit = require(replicatedStorage.packages.Knit)

local leaderstatsService = knit.CreateService{
	Name = "leaderstatsService",
	Client = {},
}

function leaderstatsService:KnitInit()
	self.dataStoreService = knit.GetService("dataStoreService")
end

function leaderstatsService:KnitStart()
	players.PlayerAdded:Connect(function(player)
		local data = self.dataStoreService:GetDataStore(player, "leaderstats")

		local leaderstats = Instance.new("Folder")
		leaderstats.Name = "leaderstats"
		leaderstats.Parent = player

		local instancesToCreate = self.dataStoreService:GetBaseData("leaderstats")
		
		for i, v in pairs(instancesToCreate) do
			local item = Instance.new("NumberValue")
			item.Name = i
			item.Value = data[i] or v
			item.Parent = leaderstats
			
			item:GetPropertyChangedSignal("Value"):Connect(function()
				self.dataStoreService:SetDataStore(player , item.Name:lower() , item.Value, "leaderstats")
			end)
		end
	end)
end

return leaderstatsService