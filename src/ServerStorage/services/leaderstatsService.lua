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
        local data = self.dataStoreService:GetDataStore(player)

        local leaderstats = Instance.new("Folder")
        leaderstats.Name = "leaderstats"
        leaderstats.Parent = player

        local coins = Instance.new("NumberValue")
        coins.Name = "Coins"
        coins.Value = data.coins
        coins.Parent = leaderstats

        local gems = Instance.new("NumberValue")
        gems.Name = "Gems"
        gems.Value = data.gems
        gems.Parent = leaderstats

        coins:GetPropertyChangedSignal("Value"):Connect(function()
            self.dataStoreService:SetDataStore(player , "coins" , coins.Value)
        end)

        gems:GetPropertyChangedSignal("Value"):Connect(function()
            self.dataStoreService:SetDataStore(player , "gems" , gems.Value)
        end)
    end)
end

return leaderstatsService