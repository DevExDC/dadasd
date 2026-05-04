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

-- Subscribe to own house
print("🏠 Subscribing to own house...")
pcall(function()
    ReplicatedStorage:WaitForChild("API"):WaitForChild("HousingAPI/SubscribeToHouse"):InvokeServer(LocalPlayer)
end)
task.wait(5)

-- Find plot CFrame
print("🔍 Finding house plot...")
local plotCFrame = nil

-- Method 1: ClientData house ID
pcall(function()
    local Data = require(ReplicatedStorage.ClientModules.Core.ClientData)
    local playerData = Data.get_data()[playerName]
    local houseId = playerData and playerData.housing and (
        playerData.housing.subscribed_house_id or
        playerData.housing.owned_house_id or
        playerData.housing.house_id
    )
    print("🏠 House ID:", houseId)

    if houseId then
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("Model") or obj:IsA("Folder") then
                local id = obj:GetAttribute("HouseId") or obj:GetAttribute("house_id")
                    or obj:GetAttribute("PlotId") or obj:GetAttribute("OwnerId")
                if tostring(id) == tostring(houseId) then
                    local base = (obj:IsA("Model") and obj.PrimaryPart)
                        or obj:FindFirstChild("Base") or obj:FindFirstChild("Floor")
                        or obj:FindFirstChild("Plot") or obj:FindFirstChildWhichIsA("BasePart")
                    if base then
                        plotCFrame = base.CFrame
                        print("✅ Method 1 found plot:", obj.Name, "| Pos:", tostring(plotCFrame.Position))
                        break
                    end
                end
            end
        end
    end
end)

-- Method 2: UserId attribute
if not plotCFrame then
    local uid = tostring(LocalPlayer.UserId)
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Folder") then
            local owner = obj:GetAttribute("OwnerId") or obj:GetAttribute("owner_id") or obj:GetAttribute("UserId")
            if tostring(owner) == uid then
                local base = (obj:IsA("Model") and obj.PrimaryPart)
                    or obj:FindFirstChild("Base") or obj:FindFirstChild("Floor")
                    or obj:FindFirstChildWhichIsA("BasePart")
                if base then
                    plotCFrame = base.CFrame
                    print("✅ Method 2 found plot:", obj.Name, "| Pos:", tostring(plotCFrame.Position))
                    break
                end
            end
        end
    end
end

-- Method 3: OwnerName attribute
if not plotCFrame then
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Folder") then
            local owner = obj:GetAttribute("OwnerName") or obj:GetAttribute("owner_name") or obj:GetAttribute("PlayerName")
            if owner and owner:lower() == playerName:lower() then
                local base = (obj:IsA("Model") and obj.PrimaryPart)
                    or obj:FindFirstChild("Base") or obj:FindFirstChild("Floor")
                    or obj:FindFirstChildWhichIsA("BasePart")
                if base then
                    plotCFrame = base.CFrame
                    print("✅ Method 3 found plot:", obj.Name, "| Pos:", tostring(plotCFrame.Position))
                    break
                end
            end
        end
    end
end

-- Fallback: character position
if not plotCFrame then
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        plotCFrame = hrp.CFrame
        print("⚠️ Fallback: using character position:", tostring(plotCFrame.Position))
    end
end

if not plotCFrame then
    error("❌ Could not find house plot at all!")
end

-- Place mannequin relative to plot
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
    print("✅ Mannequin placed successfully!")
else
    print("❌ Failed to place mannequin:", err)
end
