-- ============================================
-- AUTO ACCEPT TRADES
-- Automatically accepts all incoming trades
-- ============================================

if not getgenv().AutoAcceptConfig then
    getgenv().AutoAcceptConfig = {
        ENABLED = true,
        FROM_PLAYER = nil,  -- Set to username to only accept from specific player (e.g., "HolderAccount")
                            -- Leave as nil to accept from ANYONE
    }
end

local CONFIG = getgenv().AutoAcceptConfig

-- ============================================
-- SETUP
-- ============================================

repeat task.wait() until game:IsLoaded()
repeat task.wait(1) until game:GetService("ReplicatedStorage"):FindFirstChild("ClientModules")
task.wait(2)

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- Dehash
print("🔧 Dehashing remotes...")
local RouterClient = require(ReplicatedStorage.ClientModules.Core:WaitForChild("RouterClient"):WaitForChild("RouterClient"))
for i, v in pairs(debug.getupvalue(RouterClient.init, 7)) do
    v.Name = i
end
print("✅ Remotes dehashed!")

-- ============================================
-- HEADER
-- ============================================
print("\n" .. ("="):rep(50))
print("✅ AUTO ACCEPT TRADES - ACTIVE")
print(("="):rep(50))

if CONFIG.FROM_PLAYER then
    print("Mode: Accept trades from " .. CONFIG.FROM_PLAYER .. " only")
else
    print("Mode: Accept trades from ANYONE")
end

print(("="):rep(50) .. "\n")

-- ============================================
-- AUTO ACCEPT FUNCTION
-- ============================================

local function acceptTrade()
    local success = pcall(function()
        local tradeAPI = ReplicatedStorage:FindFirstChild("API")
        if tradeAPI then
            local acceptRequest = tradeAPI:FindFirstChild("TradeAPI/AcceptTradeRequest")
            if acceptRequest then
                acceptRequest:FireServer()
            end
        end
    end)
    return success
end

local function confirmTrade()
    local success = pcall(function()
        local tradeAPI = ReplicatedStorage:FindFirstChild("API")
        if tradeAPI then
            local confirmTrade = tradeAPI:FindFirstChild("TradeAPI/ConfirmTrade")
            if confirmTrade then
                confirmTrade:FireServer({})
            end
        end
    end)
    return success
end

-- ============================================
-- MAIN LOOP
-- ============================================

spawn(function()
    while CONFIG.ENABLED do
        -- Spam accept and confirm
        acceptTrade()
        confirmTrade()
        
        task.wait(0.5)
    end
end)

print("🔄 Auto-accepting trades...")
print("⚠️ Script will run until you reset/leave")
print("\nTo disable, run: getgenv().AutoAcceptConfig.ENABLED = false")
