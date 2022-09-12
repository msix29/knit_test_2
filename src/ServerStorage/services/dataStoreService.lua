local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local serverStorage = game:GetService("ServerStorage")

local knit = require(replicatedStorage.packages.Knit)
local dataStore2 = require(serverStorage.modules.dataStore2)

local dataStoreService = knit.CreateService{
	Name = "dataStoreService",
	
	data = {
		leaderstats = {},
		stats = {}
	},
	
	baseData = {
		leaderstats = {
			coins = 0,
			gems = 0
		},
		
		stats = {
			studs = 0,
			placedBlocks = 0,
			destroyedBlocks = 0
		},
	}
}

function dataStoreService:CreateDataStore(player, item)
	if self.data[item][player] then return end

	local data = dataStore2("data" , player)

	self.data[item][player] = data
end

function dataStoreService:GetBaseData(item)
	return self.baseData[item]
end

function dataStoreService:GetDataStore(player, item)
	self:CreateDataStore(player, item)
	
	return self.data[item][player]:Get(self.baseData[item])
end

function dataStoreService:SetDataStore(player , name , value, item)
	local data = self.data[item][player]:Get()
	data[name] = value

	self.data[item][player]:Set(data)
end

return dataStoreService