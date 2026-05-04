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

-- Step 1: Reset character to enter own house
print("🔄 Resetting character to enter house...")
LocalPlayer.Character:FindFirstChildOfClass("Humanoid").Health = 0
task.wait(6)

-- Step 2: Wait until inside HouseInteriors and confirmed by player name
print("⏳ Waiting to load inside house...")
local insideHouse = false
local attempts = 0
local blueprint = nil

repeat
    attempts += 1
    task.wait(2)
    pcall(function()
        local interiors = workspace:FindFirstChild("HouseInteriors")
        if interiors then
            for _, bp in pairs(interiors:GetChildren()) do
                if bp:FindFirstChild(playerName) then
                    insideHouse = true
                    blueprint = bp
                    print("✅ Confirmed inside house! Blueprint:", bp.Name)
                end
            end
        end
    end)
until insideHouse or attempts >= 15

if not insideHouse then
    print("⚠️ Could not confirm inside house, trying anyway...")
    pcall(function()
        blueprint = workspace:FindFirstChild("HouseInteriors"):GetChildren()[1]
    end)
end

-- Step 3: Get floor CFrame
print("📍 Finding floor CFrame...")
local plotCFrame = nil

pcall(function()
    if blueprint then
        print("📦 Blueprint contents:")
        for _, obj in pairs(blueprint:GetChildren()) do
            print("  -", obj.Name, obj.ClassName)
        end

        local floor = blueprint:FindFirstChild("Floor")
            or blueprint:FindFirstChild("Base")
            or blueprint:FindFirstChild("Plot")
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

-- Step 4: Place mannequin
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

-- Step 5: Glow nearby parts
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
