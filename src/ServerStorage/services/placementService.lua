local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local serverStorage = game:GetService("ServerStorage")

local knit = require(replicatedStorage.packages.Knit)

local placementService = knit.CreateService{
    Name = "placementService",
    Client = {
        placeBlock = knit.CreateSignal(),
        destroyBlock = knit.CreateSignal()
    }
}

local function _snipToGrid(position, grid)
    return Vector3.new(
        (math.floor(position.X / grid) * grid) + grid / 2,
        (math.floor(position.Y / grid) * grid) + grid / 2,
        (math.floor(position.Z / grid) * grid) + grid / 2
    )
end

local function _placeBlock(block, position)
    --was going for fancy animations but didn't see a need for it.
    block = block:Clone()
    block.Anchored = true
    block.CanCollide = true
    block.Parent = workspace
    block.Position = _snipToGrid(position, 2)
    block.Orientation = Vector3.new()
end

function placementService:KnitInit()
    self.Client.placeBlock:Connect(function(player, block, position)
        _placeBlock(block, position)
    end)

    self.Client.destroyBlock:Connect(function(player, block)
        block:Destroy()
    end)
end

return placementService