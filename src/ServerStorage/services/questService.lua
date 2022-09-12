local replicatedStorage = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local serverStorage = game:GetService("ServerStorage")

local knit = require(replicatedStorage.packages.Knit)

local questService = knit.CreateService{
	Name = "questService",
	Client = {},
	quests = {
		placeBlocks = {
			{
				text = "place 50 blocks",
				completed = false,
				Tracker = function(self, player)
					local placedBlocks = player.stats.placedBlocks
					
					placedBlocks:GetPropertyChangedSignal("Value"):Connect(function()
						if placedBlocks.Value >= 50 and not self.completed then
							self.completed = true
							
							print(player.Name.." has finished the quest: "..self.text..". Congratulations!")
						end
					end)
				end,
			},

			{
				text = "place 100 blocks",
				completed = false,
				Tracker = function(self, player)
					local placedBlocks = player.stats.placedBlocks

					placedBlocks:GetPropertyChangedSignal("Value"):Connect(function()
						if placedBlocks.Value >= 100 and not self.completed then
							self.completed = true
							
							print(player.Name.." has finished the quest: "..self.text..". Congratulations!")
						end
					end)
				end,
			},
		},
	},
	playerQuests = {},
}

function questService:KnitInit()
	self.dataStoreService = knit.GetService("dataStoreService")
end

function questService:KnitStart()
	players.PlayerAdded:Connect(function(player)
		player:WaitForChild("stats")
		
		for _, v in pairs(self.quests) do
			for _, v2 in pairs(v) do
				print(v2.text)
				--if v2.completed then continue end

				task.spawn(v2.Tracker, v2, player)
			end
		end
	end)
end

return questService