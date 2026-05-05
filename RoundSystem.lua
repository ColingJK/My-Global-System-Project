local replicatedStorage = game:GetService("ReplicatedStorage")
local Status = replicatedStorage:WaitForChild("Status")
local InGameBool = replicatedStorage:WaitForChild("InGame")
local MapsFolder = replicatedStorage:WaitForChild("Maps")
local Maps = MapsFolder:GetChildren()
local KBFOLDER = replicatedStorage:WaitForChild("KB")
local KB = KBFOLDER:GetChildren()
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")




wait(10)
Status.Value = "Welcome players to easy mode"
wait(5)
Status.Value = "Well you picked easy so ill be easier on you"
wait(6)
Status.Value = "Lets begin!"
wait(4)
Status.Value = "Alright ill Pick the events!"

InGameBool.Changed:Connect(function()
	if InGameBool.Value == "yes" then
		
		local ChosenMap = Maps[math.random(1,#Maps)]
		local ClonedMap = ChosenMap:Clone()
		ClonedMap.Parent = game.Workspace
		wait(2)
		
		for _, player in pairs(game.Players:GetChildren()) do
			local char = player.Character or player.CharacterAdded:Wait()
			char.HumanoidRootPart.CFrame = CFrame.new(ClonedMap.Spawn.Position) 
		end
		
		
		
		
		
			
	else
	
		for _, player in pairs(game.Players:GetChildren()) do
			local char = player.Character or player.CharacterAdded:Wait()
			char.HumanoidRootPart.CFrame = CFrame.new(game.Workspace.Baseplate.SpawnLocation.Position) 
			end
		for i,v in pairs (MapsFolder:GetChildren()) do
			if game.Workspace:FindFirstChild(v.Name) then
				local obj = game.Workspace[v.Name]
				obj:Destroy()
			end
		end
	end
end)
local function teleportPlayer(player)
	local TARGET_PLACE_ID = 7025298019
	local success, result = pcall(function()
		return TeleportService:TeleportAsync(TARGET_PLACE_ID, {player})
	end)

	if success then
		print("Teleporting " .. player.Name .. " after dying.")
	else
		warn("Teleport failed for " .. player.Name .. ": " .. tostring(result))
	end
end

-- Function to handle player death
local function onCharacterAdded(character)
	local humanoid = character:WaitForChild("Humanoid")

	humanoid.Died:Connect(function()
		local player = Players:GetPlayerFromCharacter(character)
		if player then
			-- Short delay to allow the death animation to play
			task.wait(1) 
			teleportPlayer(player)
		end
	end)
end

-- Connect existing and new players
local function onPlayerAdded(player)
	player.CharacterAdded:Connect(onCharacterAdded)
end

Players.PlayerAdded:Connect(onPlayerAdded)

-- Ensure players already in the server are covered
for _, player in Players:GetPlayers() do
	onPlayerAdded(player)
end
--local function changePlace()----------------------------------------------------------------------------- This segment is outdated
--	local tService = game:GetService("TeleportService")
--	local placeId = 7025298019 
--	for _, player in pairs(game.Players:GetChildren()) do
--		local cha = player.Character or player.CharacterAdded:Wait()
--		local data = {}
--			data["Wins"] = "+1"-------data store has been erased on main game
--			tService:Teleport(placeId, player, data)
--			end
--		end
local function changePlace()-----reviewed updated one, the one on top kept incase of issues for---- reference if code lacks something


	local TARGET_PLACE_ID = 7025298019

	local function teleportAllPlayers()
		local allPlayers = Players:GetPlayers()

		if #allPlayers > 0 then

			local success, result = pcall(function()
				return TeleportService:TeleportAsync(TARGET_PLACE_ID, allPlayers)
			end)

			if success then
				print("Teleporting the whole server...")
			else
				warn("Teleport failed: " .. tostring(result))
			end
		else
			print("No players in the server to teleport.")
		end
	end


	task.wait(1)
	teleportAllPlayers()



end	

	



	
local function BossTimer()
	InGameBool.Value = "BossTime"
	Status.Value = " I guess Ill make things harder .. "
	wait(2)
	Status.Value = " Cuz why not :)) "
	local CKB = KB[math.random(1,#KB)]
	local ClonedKB = CKB:Clone()
	ClonedKB.Parent = game.Workspace 
	
	for _, player in pairs(game.Players:GetChildren()) do
		local cha = player.Character or player.CharacterAdded:Wait()
		cha.HumanoidRootPart.CFrame = CFrame.new(ClonedKB.Spawn.Position) -- Teleports
	

	Status.Value = " You will play this again and again untill u find an escape :)"
	wait(6)
	Status.Value = " good luck cuz youll need it "
	wait(4)
	Status.Value = " oh and one more thing find a exit before you die  "
	wait(4)
		for i = 30,0,-1 do 
		wait(1)
			Status.Value = "Survive the event for "..i.."  more seconds!"
			
		end
		wait(1)
		Status.Value = "Good bye"
		wait(5)
		changePlace()
		
	
	end	
end
		


local function changeTimer()
	InGameBool.Value = "No"
	
	wait(5)
	for i = 0,100,1 do 
		wait(0.05)
		Status.Value = "Loading event assets "..i.." "
		
	end
	
	InGameBool.Value = "yes"
	Status.Value = "i have Picked an event!"
	wait(10)
	for i = 30,0,-1 do 
		wait(1)
		Status.Value = "Survive the event for "..i.."  more seconds!"
	end
end


while wait() do
	for e = 5,1,-1 do 
		wait(1)
		Status.Value = " Survive "..e.."  more events!"
			if e == 1 then
			BossTimer()
		else
			changeTimer()
		end
			
			
		end
end



