local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local serverStorage = game:GetService("ServerStorage")

local knit = require(replicatedStorage.packages.Knit)
local dataStore2 = require(serverStorage.modules.dataStore2)

local dataStoreService = knit.CreateService{
    Name = "dataStoreService",
    data = {},
    baseData = {
        coins = 0,
        gems = 0
    }
}

function dataStoreService:CreateDataStore(player)
    if self.data[player] then return end

    local data = dataStore2("data" , player)

    self.data[player] = data
end

function dataStoreService:GetDataStore(player)
    self:CreateDataStore(player)

    return self.data[player]:Get(self.baseData)
end

function dataStoreService:SetDataStore(player , name , value)
    local data = self.data[player]:Get()
    data[name] = value
    
    self.data[player]:Set(data)
end

return dataStoreService