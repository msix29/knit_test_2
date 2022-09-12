local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local players = game:GetService("Players")

local knit = require(replicatedStorage.packages.Knit)

local statsService = knit.CreateService{
	Name = "statsService",
	data = {},
	baseData = {
		coins = 0,
		gems = 0
	}
}

function statsService:KnitInit()
	self.dataStoreService = knit.GetService("dataStoreService")
end

function statsService:KnitStart()
	players.PlayerAdded:Connect(function(player)
		local data = self.dataStoreService:GetDataStore(player, "stats")

		local statsFolder = Instance.new("Folder")
		statsFolder.Name = "stats"
		statsFolder.Parent = player

		local instancesToCreate = self.dataStoreService:GetBaseData("stats")
		
		for i, v in pairs(instancesToCreate) do
			local item = Instance.new("NumberValue")
			item.Name = i
			item.Value = data[i] or v
			item.Parent = statsFolder
			
			if item.Name:lower() == "studs" then
				local character = player.Character or player.CharacterAdded:Wait()
				local oldPositionX, oldPositionZ = character.PrimaryPart.Position.X, character.PrimaryPart.Position.Z
				
				runService.Heartbeat:Connect(function()
					item.Value += math.abs(character.PrimaryPart.Position.X - oldPositionX + character.PrimaryPart.Position.Z - oldPositionZ)

					oldPositionX, oldPositionZ = character.PrimaryPart.Position.X, character.PrimaryPart.Position.Z
				end)
			end
			
			item:GetPropertyChangedSignal("Value"):Connect(function()
				self.dataStoreService:SetDataStore(player , item.Name , item.Value, "stats")
			end)
		end
	end)
end

return statsService