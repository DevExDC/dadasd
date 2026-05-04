repeat task.wait() until game:IsLoaded()
repeat task.wait(1) until game:GetService("ReplicatedStorage"):FindFirstChild("ClientModules")
task.wait(2)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local playerName = LocalPlayer.Name

-- Dehash
local router = require(ReplicatedStorage.ClientModules.Core.RouterClient.RouterClient)
for i = 1, 20 do
    local upv = debug.getupvalue(router.init, i)
    if type(upv) == "table" then
        local valid, count = true, 0
        for k, v in pairs(upv) do
            count += 1
            if typeof(v) ~= "Instance" then valid = false break end
        end
        if valid and count > 0 then
            for name, remote in pairs(upv) do
                pcall(function() remote.Name = name end)
            end
            print("✅ Dehash done")
            break
        end
    end
end

task.wait(2)

-- Step 1: Find house ID from HouseExteriors mailbox
print("🔍 Searching HouseExteriors for: " .. playerName)
local houseId = nil

local houseExteriors = workspace:FindFirstChild("HouseExteriors")
if houseExteriors then
    for _, house in pairs(houseExteriors:GetChildren()) do
        pcall(function()
            local label = house:FindFirstChild("Micro.Mailbox.Top", true)
                and house:FindFirstChild("Micro.Mailbox.Top", true):FindFirstChild("BillboardGui")
                and house:FindFirstChild("Micro.Mailbox.Top", true):FindFirstChild("BillboardGui"):FindFirstChild("TextLabel")

            -- Also try direct path
            if not label then
                label = house:FindFirstChild("Micro.Mailbox.Top") 
                    and house["Micro.Mailbox.Top"]:FindFirstChild("BillboardGui")
                    and house["Micro.Mailbox.Top"].BillboardGui:FindFirstChild("TextLabel")
            end

            if label and label.Text:lower() == playerName:lower() then
                houseId = house.Name
                print("✅ Found house! ID:", houseId, "| Label:", label.Text)
            end
        end)
    end
else
    print("❌ HouseExteriors not found in workspace")
end

if not houseId then
    error("❌ Could not find house for: " .. playerName)
end

-- Step 2: Reset character to get inside own house
print("🔄 Resetting character to enter house...")
LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
task.wait(4)

-- Step 3: Wait until inside HouseInteriors and confirm by player name
print("⏳ Waiting to load inside house...")
local insideHouse = false
local attempts = 0

repeat
    attempts += 1
    task.wait(2)
    local interiors = workspace:FindFirstChild("HouseInteriors")
    if interiors then
        local blueprint = interiors:FindFirstChild("blueprint")
        if blueprint then
            -- Look for a child named after the player
            for _, obj in pairs(blueprint:GetDescendants()) do
                if obj.Name:lower() == playerName:lower() then
                    insideHouse = true
                    print("✅ Confirmed inside own house!")
                    break
                end
            end
        end
    end
until insideHouse or attempts >= 10

if not insideHouse then
    print("⚠️ Could not confirm inside house, trying anyway...")
end

task.wait(2)

-- Step 4: Get floor CFrame from HouseInteriors
print("📍 Finding floor CFrame...")
local plotCFrame = nil

pcall(function()
    local interiors = workspace:FindFirstChild("HouseInteriors")
    local blueprint = interiors and interiors:FindFirstChild("blueprint")
    if blueprint then
        local floor = blueprint:FindFirstChild("Floor")
            or blueprint:FindFirstChild("Base")
            or blueprint:FindFirstChildWhichIsA("BasePart")
        if floor then
            plotCFrame = floor.CFrame
            print("✅ Floor found:", floor.Name, "| Pos:", tostring(plotCFrame.Position))
        end
    end
end)

-- Fallback: character position
if not plotCFrame then
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        plotCFrame = hrp.CFrame
        print("⚠️ Fallback: using character position:", tostring(plotCFrame.Position))
    end
end

if not plotCFrame then
    error("❌ Could not get floor CFrame!")
end

-- Step 5: Place mannequin
local offset = CFrame.new(10.099609375, 0, -13.699999809265137)
local mannequinCFrame = plotCFrame * offset

print("📍 Placing mannequin at:", tostring(mannequinCFrame.Position))

local success, err = pcall(function()
    ReplicatedStorage:WaitForChild("API"):WaitForChild("HousingAPI/BuyFurnitures"):InvokeServer({
        {
            kind = "mannequins_2024_mannequin",
            properties = {
                cframe = mannequinCFrame
            }
        }
    })
end)

if success then
    print("✅ Mannequin placed!")
else
    print("❌ Failed:", err)
end

-- Step 6: Glow nearby parts
task.wait(1)
for _, obj in pairs(workspace:GetDescendants()) do
    if obj:IsA("BasePart") then
        if (obj.Position - mannequinCFrame.Position).Magnitude < 5 then
            obj.Material = Enum.Material.Neon
            obj.BrickColor = BrickColor.new("Bright yellow")
        end
    end
end
print("✅ Glow applied!")
