local players = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")

local player = players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local mouse = player:GetMouse()

-- local function _snipToGrid(position, grid)
--     return Vector3.new(
--         (math.floor(position.X / grid) * grid) + grid / 2,
--         (math.floor(position.Y / grid) * grid) + grid / 2,
--         (math.floor(position.Z / grid) * grid) + grid / 2
--     )
-- end

local knit = require(replicatedStorage.packages.Knit)

knit.Start()

local placementService = knit.GetService("placementService")

character.ChildAdded:Connect(function(child)
    if child:IsA("Tool") then
        -- local clone = child.Handle:Clone()
        -- clone.Parent = workspace
        -- clone.Transparency = .8

        -- runService.RenderStepped:Connect(function()
        --     clone.Orientation = Vector3.new(0, 0, 0)
        --     clone.Position = _snipToGrid(mouse.Hit.Position, 2)
        -- end)

        child.Activated:Connect(function()
            placementService.placeBlock:Fire(child.Handle, mouse.Hit.Position)
        end)
    end
end)