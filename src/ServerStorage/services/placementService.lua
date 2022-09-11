local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local serverStorage = game:GetService("ServerStorage")

local knit = require(replicatedStorage.packages.Knit)
local dataStore2 = require(serverStorage.modules.dataStore2)

local placementService = knit.CreateService{
    Name = "placementService",
    Client = {
        placeBlock = knit.CreateSignal(),
        destroyBlock = knit.CreateSignal()
    }
}
local function _placeBlock(block, position)
    --was going for fancy animations but didn't see a need for it.
    block = block:Clone()
    block.Parent = workspace
    block.Position = position
end

function placementService:KnitInit()
    self.Client.placeBlock:Connect(function(block, position)
        _placeBlock(block, position)
    end)

    self.Client.destroyBlock:Connect(function(block)
        block:Destroy()
    end)
end

return placementService