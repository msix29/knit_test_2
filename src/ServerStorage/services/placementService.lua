local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local serverStorage = game:GetService("ServerStorage")

local knit = require(replicatedStorage.packages.Knit)

local placementService = knit.CreateService{
    Name = "placementService",
    Client = {
        placeBlock = knit.CreateSignal(),
        destroyBlock = knit.CreateSignal()
	},
	placedBlocks = {},
	destroyedBlocks = {},
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
		if not self.placedBlocks[player] then self.placedBlocks[player] = 0 end
		
		self.placedBlocks[player] += 1
		player.stats.placedBlocks.Value += 1
		
        _placeBlock(block, position)
    end)

	self.Client.destroyBlock:Connect(function(player, block)
		if not self.destroyedBlocks[player] then self.destroyedBlocks[player] = 0 end

		self.destroyedBlocks[player] += 1
		player.stats.destroyedBlocks.Value += 1
		
        block:Destroy()
    end)
end

function placementService:GetPlacedBlocks(player)
	return self.placedBlocks[player] or 0
end

function placementService:GetDestroyedBlocks(player)
	return self.destroyedBlocks[player] or 0
end

return placementService