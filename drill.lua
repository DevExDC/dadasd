-- Auto Gas Bot + Auto Buy + Auto Place
-- LocalScript in StarterPlayerScripts

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- =====================
--       CONFIG
-- =====================
local CONFIG = {
    MIN_SELL_PRICE   = 12,       -- Sell gas at $12+
    COLLECT_INTERVAL = 2,        -- Collect every 2 seconds
    AUTO_BUY_ENABLED = true,     -- Toggle auto buy
    AUTO_SELL_ENABLED = true,    -- Toggle auto sell
    AUTO_COLLECT_ENABLED = true, -- Toggle auto collect
    BUY_ITEM_SHOP    = "DrillShop",
    BUY_ITEM_NAME    = "Huge Long Drill",
    BUY_ITEM_COST    = 40000000, -- 40m
}

-- =====================
--      REMOTES
-- =====================
local Knit = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Knit"):WaitForChild("Services")

local SellRemote = Knit
    :WaitForChild("BaseService"):WaitForChild("RE"):WaitForChild("SellGas")

local BuyRemote = Knit
    :WaitForChild("StoresService"):WaitForChild("RE"):WaitForChild("Purchase")

local GasPrice = ReplicatedStorage:WaitForChild("GasPrice")

-- =====================
--      CASH & BACKPACK
-- =====================
local function getCash()
    local stats = LocalPlayer:FindFirstChild("leaderstats")
    return stats and stats:FindFirstChild("Cash") and stats.Cash.Value or 0
end

local function hasItemInBackpack(itemName)
    local backpack = LocalPlayer:FindFirstChild("Backpack")
    if not backpack then return false end
    for _, item in backpack:GetChildren() do
        if item.Name == itemName then return true end
    end
    -- also check equipped (character)
    local char = LocalPlayer.Character
    if char then
        for _, item in char:GetChildren() do
            if item.Name == itemName then return true end
        end
    end
    return false
end

-- =====================
--       PLOT
-- =====================
local function getPlayerPlot()
    local plots = workspace:WaitForChild("Plots")
    for _, plot in plots:GetChildren() do
        local ownerTag = plot:FindFirstChild("OwnerTag")
        if ownerTag then
            local billboard = ownerTag:FindFirstChild("BillboardGui")
            if billboard then
                local label = billboard:FindFirstChild("Main") and billboard.Main:FindFirstChild("TextLabel")
                if label and label.Text == LocalPlayer.Name then
                    return plot
                end
            end
        end
    end
    return nil
end

-- =====================
--         GUI
-- =====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AutoGasHUD"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Main Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 370)
Frame.Position = UDim2.new(0, 16, 0.5, -185)
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui
Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 14)

-- Top accent bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 4)
TopBar.BackgroundColor3 = Color3.fromRGB(255, 80, 40)
TopBar.BorderSizePixel = 0
TopBar.Parent = Frame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 14)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -16, 0, 30)
Title.Position = UDim2.new(0, 12, 0, 10)
Title.BackgroundTransparency = 1
Title.Text = "⛽  AUTO GAS BOT"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Frame

-- Cash display top right
local CashLabel = Instance.new("TextLabel")
CashLabel.Size = UDim2.new(0, 110, 0, 18)
CashLabel.Position = UDim2.new(1, -118, 0, 16)
CashLabel.BackgroundTransparency = 1
CashLabel.Text = "💵 $0"
CashLabel.TextColor3 = Color3.fromRGB(100, 220, 100)
CashLabel.TextSize = 11
CashLabel.Font = Enum.Font.GothamBold
CashLabel.TextXAlignment = Enum.TextXAlignment.Right
CashLabel.Parent = Frame

-- Divider
local Div1 = Instance.new("Frame")
Div1.Size = UDim2.new(1, -24, 0, 1)
Div1.Position = UDim2.new(0, 12, 0, 46)
Div1.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Div1.BorderSizePixel = 0
Div1.Parent = Frame

-- Row helper
local function makeRow(yPos, icon, label, defaultVal, valueColor)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -24, 0, 26)
    row.Position = UDim2.new(0, 12, 0, yPos)
    row.BackgroundTransparency = 1
    row.Parent = Frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.6, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = icon .. "  " .. label
    lbl.TextColor3 = Color3.fromRGB(120, 120, 140)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.Gotham
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local val = Instance.new("TextLabel")
    val.Size = UDim2.new(0.4, 0, 1, 0)
    val.Position = UDim2.new(0.6, 0, 0, 0)
    val.BackgroundTransparency = 1
    val.Text = defaultVal
    val.TextColor3 = valueColor or Color3.fromRGB(255, 255, 255)
    val.TextSize = 11
    val.Font = Enum.Font.GothamBold
    val.TextXAlignment = Enum.TextXAlignment.Right
    val.Parent = row

    return val
end

-- Toggle button helper
local function makeToggle(yPos, icon, label, configKey)
    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, -24, 0, 30)
    row.Position = UDim2.new(0, 12, 0, yPos)
    row.BackgroundTransparency = 1
    row.Parent = Frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.65, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = icon .. "  " .. label
    lbl.TextColor3 = Color3.fromRGB(200, 200, 210)
    lbl.TextSize = 11
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = row

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 52, 0, 22)
    btn.Position = UDim2.new(1, -52, 0.5, -11)
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 10
    btn.Parent = row
    Instance.new("UICorner", btn).CornerRadius = UDim.new(1, 0)

    local function refreshBtn()
        if CONFIG[configKey] then
            btn.BackgroundColor3 = Color3.fromRGB(60, 200, 100)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = "ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            btn.TextColor3 = Color3.fromRGB(140, 140, 160)
            btn.Text = "OFF"
        end
    end
    refreshBtn()

    btn.MouseButton1Click:Connect(function()
        CONFIG[configKey] = not CONFIG[configKey]
        refreshBtn()
    end)

    return btn
end

-- Section header helper
local function makeSection(yPos, text)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -24, 0, 20)
    lbl.Position = UDim2.new(0, 12, 0, yPos)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(255, 80, 40)
    lbl.TextSize = 10
    lbl.Font = Enum.Font.GothamBold
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = Frame
    return lbl
end

-- Divider helper
local function makeDivider(yPos)
    local d = Instance.new("Frame")
    d.Size = UDim2.new(1, -24, 0, 1)
    d.Position = UDim2.new(0, 12, 0, yPos)
    d.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
    d.BorderSizePixel = 0
    d.Parent = Frame
end

-- ── GAS STATS ──
makeSection(50, "▸  GAS")
local PriceLabel    = makeRow(68,  "💰", "Gas Price",   "$" .. GasPrice.Value, Color3.fromRGB(255, 210, 60))
local SellAtLabel   = makeRow(94,  "🎯", "Sell At",     "$" .. CONFIG.MIN_SELL_PRICE .. "+", Color3.fromRGB(100, 220, 100))
local SellStatusLbl = makeRow(120, "📡", "Sell Status", "Waiting", Color3.fromRGB(160, 160, 160))
local CollectLbl    = makeRow(146, "🔄", "Collects",    "0", Color3.fromRGB(100, 180, 255))
local SellsLbl      = makeRow(172, "✅", "Sells Done",  "0", Color3.fromRGB(100, 220, 100))

makeDivider(202)

-- ── DRILL STATS ──
makeSection(208, "▸  DRILL")
local BuyStatusLbl  = makeRow(226, "🛒", "Buy Status",  "Waiting", Color3.fromRGB(160, 160, 160))
local BuyCountLbl   = makeRow(252, "📦", "Bought",      "0", Color3.fromRGB(255, 180, 60))
local PlaceLbl      = makeRow(278, "📍", "Placed",      "0", Color3.fromRGB(180, 130, 255))

makeDivider(308)

-- ── TOGGLES ──
makeToggle(314, "🛒", "Auto Buy",     "AUTO_BUY_ENABLED")
makeToggle(346, "📡", "Auto Sell",    "AUTO_SELL_ENABLED")

-- Progress bar
local BarBg = Instance.new("Frame")
BarBg.Size = UDim2.new(1, -24, 0, 5)
BarBg.Position = UDim2.new(0, 12, 1, -8)
BarBg.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
BarBg.BorderSizePixel = 0
BarBg.Parent = Frame
Instance.new("UICorner", BarBg).CornerRadius = UDim.new(1, 0)

local BarFill = Instance.new("Frame")
BarFill.Size = UDim2.new(0, 0, 1, 0)
BarFill.BackgroundColor3 = Color3.fromRGB(255, 80, 40)
BarFill.BorderSizePixel = 0
BarFill.Parent = BarBg
Instance.new("UICorner", BarFill).CornerRadius = UDim.new(1, 0)

-- =====================
--     GUI HELPERS
-- =====================
local collectCount = 0
local sellCount = 0
local buyCount = 0
local placeCount = 0

local function flash(label, color)
    local orig = label.TextColor3
    label.TextColor3 = color
    task.delay(0.3, function() label.TextColor3 = orig end)
end

local function formatCash(n)
    if n >= 1e9 then return ("%.1fb"):format(n/1e9)
    elseif n >= 1e6 then return ("%.1fm"):format(n/1e6)
    elseif n >= 1e3 then return ("%.1fk"):format(n/1e3)
    else return tostring(n) end
end

local function animBar(pct)
    TweenService:Create(BarFill, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
        Size = UDim2.new(math.clamp(pct, 0, 1), 0, 1, 0)
    }):Play()
end

local function setPriceColor(price)
    if price >= 13 then return Color3.fromRGB(180, 100, 255)
    elseif price >= 10 then return Color3.fromRGB(100, 220, 100)
    elseif price >= 5 then return Color3.fromRGB(255, 210, 60)
    else return Color3.fromRGB(255, 80, 40) end
end

local function updatePrice(price)
    PriceLabel.Text = "$" .. price
    PriceLabel.TextColor3 = setPriceColor(price)
    if price >= CONFIG.MIN_SELL_PRICE and CONFIG.AUTO_SELL_ENABLED then
        SellStatusLbl.Text = "SELLING!"
        SellStatusLbl.TextColor3 = Color3.fromRGB(100, 220, 100)
        animBar(1)
    else
        SellStatusLbl.Text = "Waiting..."
        SellStatusLbl.TextColor3 = Color3.fromRGB(160, 160, 160)
        animBar(price / CONFIG.MIN_SELL_PRICE)
    end
end

-- Update cash label periodically
task.spawn(function()
    while true do
        local cash = getCash()
        CashLabel.Text = "💵 $" .. formatCash(cash)
        task.wait(1)
    end
end)

-- =====================
--    AUTO SELL LOGIC
-- =====================
local function tryAutoSell(price)
    updatePrice(price)
    if CONFIG.AUTO_SELL_ENABLED and price >= CONFIG.MIN_SELL_PRICE then
        SellRemote:FireServer()
        sellCount += 1
        SellsLbl.Text = tostring(sellCount)
        flash(SellsLbl, Color3.fromRGB(255, 255, 255))
        print(("[AutoSell] Sold at $%d"):format(price))
    end
end

GasPrice.Changed:Connect(function(v) tryAutoSell(v) end)
tryAutoSell(GasPrice.Value)

-- =====================
--   AUTO COLLECT LOGIC
-- =====================
task.spawn(function()
    task.wait(3)
    local plot = getPlayerPlot()
    if not plot then
        SellStatusLbl.Text = "No plot!"
        warn("[AutoCollect] No plot found")
        return
    end

    while true do
        if CONFIG.AUTO_COLLECT_ENABLED then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if hrp then
                local buildings = plot:FindFirstChild("Buildings")
                if buildings then
                    for _, building in buildings:GetChildren() do
                        local primary = building:FindFirstChild("Primary")
                        if primary and primary:FindFirstChild("TouchInterest") then
                            firetouchinterest(primary, hrp, 0)
                            firetouchinterest(primary, hrp, 1)
                            collectCount += 1
                            CollectLbl.Text = tostring(collectCount)
                            flash(CollectLbl, Color3.fromRGB(255, 255, 255))
                        end
                    end
                end
            end
        end
        task.wait(CONFIG.COLLECT_INTERVAL)
    end
end)

-- =====================
--   AUTO BUY + PLACE
-- =====================
task.spawn(function()
    task.wait(4)

    while true do
        if CONFIG.AUTO_BUY_ENABLED then
            local cash = getCash()
            local alreadyHas = hasItemInBackpack(CONFIG.BUY_ITEM_NAME)

            if not alreadyHas and cash >= CONFIG.BUY_ITEM_COST then
                -- BUY
                BuyStatusLbl.Text = "Buying..."
                BuyStatusLbl.TextColor3 = Color3.fromRGB(255, 210, 60)
                BuyRemote:FireServer(CONFIG.BUY_ITEM_SHOP, CONFIG.BUY_ITEM_NAME)
                buyCount += 1
                BuyCountLbl.Text = tostring(buyCount)
                flash(BuyCountLbl, Color3.fromRGB(255, 255, 255))
                print(("[AutoBuy] Bought " .. CONFIG.BUY_ITEM_NAME))
                task.wait(0.5)

                -- PLACE via PlaceArea TouchInterest
                local plot = getPlayerPlot()
                if plot then
                    local placeArea = plot:FindFirstChild("PlaceArea")
                    if placeArea and placeArea:FindFirstChild("TouchInterest") then
                        local char = LocalPlayer.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            firetouchinterest(placeArea, hrp, 0)
                            firetouchinterest(placeArea, hrp, 1)
                            placeCount += 1
                            PlaceLbl.Text = tostring(placeCount)
                            flash(PlaceLbl, Color3.fromRGB(255, 255, 255))
                            BuyStatusLbl.Text = "Placed! ✓"
                            BuyStatusLbl.TextColor3 = Color3.fromRGB(100, 220, 100)
                            print(("[AutoPlace] Placed " .. CONFIG.BUY_ITEM_NAME))
                        end
                    end
                end

            elseif alreadyHas then
                -- Has item but not placed yet, try placing
                local plot = getPlayerPlot()
                if plot then
                    local placeArea = plot:FindFirstChild("PlaceArea")
                    if placeArea and placeArea:FindFirstChild("TouchInterest") then
                        local char = LocalPlayer.Character
                        local hrp = char and char:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            firetouchinterest(placeArea, hrp, 0)
                            firetouchinterest(placeArea, hrp, 1)
                        end
                    end
                end
            elseif cash < CONFIG.BUY_ITEM_COST then
                local needed = CONFIG.BUY_ITEM_COST - cash
                BuyStatusLbl.Text = "Need $" .. formatCash(needed)
                BuyStatusLbl.TextColor3 = Color3.fromRGB(255, 80, 40)
            end
        end

        task.wait(1)
    end
end)
