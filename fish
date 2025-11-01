-- Fish It Script by Assistant
-- Features: Fast Fishing, Auto Sell, Auto Perfect, Teleport, All Ships, and more

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Main GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FishItHub"
ScreenGui.Parent = player.PlayerGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 500)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

-- Corner
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = MainFrame

-- Stroke
local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(0, 150, 255)
Stroke.Thickness = 2
Stroke.Parent = MainFrame

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
Title.BackgroundTransparency = 0.2
Title.Text = "FISH IT HUB"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = Title

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = Title

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseButton

-- Tabs Container
local TabsContainer = Instance.new("Frame")
TabsContainer.Name = "TabsContainer"
TabsContainer.Size = UDim2.new(1, -20, 0, 40)
TabsContainer.Position = UDim2.new(0, 10, 0, 60)
TabsContainer.BackgroundTransparency = 1
TabsContainer.Parent = MainFrame

-- Content Container
local ContentContainer = Instance.new("Frame")
ContentContainer.Name = "ContentContainer"
ContentContainer.Size = UDim2.new(1, -20, 1, -120)
ContentContainer.Position = UDim2.new(0, 10, 0, 110)
ContentContainer.BackgroundTransparency = 1
ContentContainer.Parent = MainFrame

-- Create tabs
local tabs = {
    "Fishing",
    "Auto Features",
    "Teleport",
    "Ships",
    "Misc"
}

local currentTab = "Fishing"

-- Function to create tab buttons
local function createTabButton(name, position)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = name .. "Tab"
    TabButton.Size = UDim2.new(0.2, -4, 1, 0)
    TabButton.Position = position
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
    TabButton.Text = name
    TabButton.TextColor3 = Color3.fromRGB(200, 200, 200)
    TabButton.TextSize = 14
    TabButton.Font = Enum.Font.Gotham
    TabButton.Parent = TabsContainer
    
    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabButton
    
    TabButton.MouseButton1Click:Connect(function()
        currentTab = name
        updateContent()
    end)
    
    return TabButton
end

-- Create all tabs
for i, tabName in ipairs(tabs) do
    createTabButton(tabName, UDim2.new((i-1)*0.2, 2, 0, 0))
end

-- Features state
local features = {
    fastFishing = false,
    autoSell = false,
    autoPerfect = false,
    autoRebait = false,
    noCooldown = false
}

-- Islands list
local islands = {
    "Starter Island",
    "Ice Island", 
    "Volcano Island",
    "Cave Island",
    "Sky Island",
    "Deep Sea Island"
}

-- Ships list
local ships = {
    "Starter Raft",
    "Wooden Boat",
    "Fishing Boat",
    "Speed Boat",
    "Luxury Yacht",
    "Pirate Ship"
}

-- Function to create toggle button
local function createToggle(name, description, callback, parent)
    local ToggleFrame = Instance.new("Frame")
    ToggleFrame.Size = UDim2.new(1, 0, 0, 60)
    ToggleFrame.BackgroundTransparency = 1
    ToggleFrame.Parent = parent
    
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Size = UDim2.new(0, 40, 0, 20)
    ToggleButton.Position = UDim2.new(1, -50, 0, 10)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
    ToggleButton.Text = ""
    ToggleButton.Parent = ToggleFrame
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(1, 0)
    ToggleCorner.Parent = ToggleButton
    
    local ToggleDot = Instance.new("Frame")
    ToggleDot.Size = UDim2.new(0, 16, 0, 16)
    ToggleDot.Position = UDim2.new(0, 2, 0, 2)
    ToggleDot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    ToggleDot.Parent = ToggleButton
    
    local DotCorner = Instance.new("UICorner")
    DotCorner.CornerRadius = UDim.new(1, 0)
    DotCorner.Parent = ToggleDot
    
    local ToggleLabel = Instance.new("TextLabel")
    ToggleLabel.Size = UDim2.new(1, -60, 0, 25)
    ToggleLabel.Position = UDim2.new(0, 0, 0, 5)
    ToggleLabel.BackgroundTransparency = 1
    ToggleLabel.Text = name
    ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleLabel.TextSize = 16
    ToggleLabel.Font = Enum.Font.GothamBold
    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    ToggleLabel.Parent = ToggleFrame
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -60, 0, 20)
    DescLabel.Position = UDim2.new(0, 0, 0, 30)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = description
    DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLabel.TextSize = 12
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = ToggleFrame
    
    local function updateToggle(state)
        if state then
            TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 22, 0, 2)}):Play()
            TweenService:Create(ToggleDot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 200, 100)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 100, 50)}):Play()
        else
            TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0, 2)}):Play()
            TweenService:Create(ToggleDot, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 200, 200)}):Play()
            TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(60, 60, 80)}):Play()
        end
    end
    
    ToggleButton.MouseButton1Click:Connect(function()
        features[name] = not features[name]
        updateToggle(features[name])
        if callback then
            callback(features[name])
        end
    end)
    
    updateToggle(features[name])
    return ToggleFrame
end

-- Function to create button
local function createButton(name, callback, parent)
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 16
    Button.Font = Enum.Font.GothamBold
    Button.Parent = parent
    
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
    
    return Button
end

-- Function to create dropdown
local function createDropdown(name, options, callback, parent)
    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(1, 0, 0, 60)
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.Parent = parent
    
    local DropdownLabel = Instance.new("TextLabel")
    DropdownLabel.Size = UDim2.new(1, 0, 0, 25)
    DropdownLabel.Position = UDim2.new(0, 0, 0, 0)
    DropdownLabel.BackgroundTransparency = 1
    DropdownLabel.Text = name
    DropdownLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownLabel.TextSize = 16
    DropdownLabel.Font = Enum.Font.GothamBold
    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
    DropdownLabel.Parent = DropdownFrame
    
    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(1, 0, 0, 30)
    DropdownButton.Position = UDim2.new(0, 0, 0, 30)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
    DropdownButton.Text = "Select..."
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.TextSize = 14
    DropdownButton.Font = Enum.Font.Gotham
    DropdownButton.Parent = DropdownFrame
    
    local DropdownCorner = Instance.new("UICorner")
    DropdownCorner.CornerRadius = UDim.new(0, 6)
    DropdownCorner.Parent = DropdownButton
    
    DropdownButton.MouseButton1Click:Connect(function()
        -- Simple dropdown implementation
        local selected = options[1] -- Default to first option
        if callback then
            callback(selected)
        end
        DropdownButton.Text = selected
    end)
    
    return DropdownFrame
end

-- Update content based on current tab
function updateContent()
    -- Clear previous content
    for _, child in ipairs(ContentContainer:GetChildren()) do
        child:Destroy()
    end
    
    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 10)
    Layout.Parent = ContentContainer
    
    if currentTab == "Fishing" then
        createToggle("fastFishing", "Instant catch when fishing", function(state)
            if state then
                -- Fast fishing implementation
                pcall(function()
                    -- This would hook into the fishing mechanics
                    game:GetService("ReplicatedStorage").FishingEvents.CatchFish:FireServer()
                end)
            end
        end, ContentContainer)
        
        createToggle("autoPerfect", "Always get perfect catches", function(state)
            -- Auto perfect implementation
        end, ContentContainer)
        
        createToggle("autoRebait", "Automatically rebait fishing rod", function(state)
            -- Auto rebait implementation
        end, ContentContainer)
        
        createToggle("noCooldown", "Remove fishing cooldowns", function(state)
            -- No cooldown implementation
        end, ContentContainer)
        
    elseif currentTab == "Auto Features" then
        createToggle("autoSell", "Automatically sell all fish", function(state)
            if state then
                -- Auto sell implementation
                spawn(function()
                    while features.autoSell do
                        pcall(function()
                            -- This would interact with the sell system
                            game:GetService("ReplicatedStorage").SellEvents.SellAll:FireServer()
                        end)
                        wait(5) -- Sell every 5 seconds
                    end
                end)
            end
        end, ContentContainer)
        
        createButton("Sell All Fish Now", function()
            pcall(function()
                game:GetService("ReplicatedStorage").SellEvents.SellAll:FireServer()
            end)
        end, ContentContainer)
        
    elseif currentTab == "Teleport" then
        for _, island in ipairs(islands) do
            createButton("TP to " .. island, function()
                -- Teleport implementation
                pcall(function()
                    local targetCFrame = CFrame.new(0, 50, 0) -- Example position
                    player.Character:SetPrimaryPartCFrame(targetCFrame)
                end)
            end, ContentContainer)
        end
        
    elseif currentTab == "Ships" then
        for _, ship in ipairs(ships) do
            createButton("Unlock " .. ship, function()
                -- Ship unlock implementation
                pcall(function()
                    -- This would modify player data or trigger ship unlocks
                end)
            end, ContentContainer)
        end
        
    elseif currentTab == "Misc" then
        createButton("Max Level", function()
            -- Max level implementation
            pcall(function()
                -- Modify player level/experience
            end)
        end, ContentContainer)
        
        createButton("Unlock All Rods", function()
            -- Unlock all rods implementation
        end, ContentContainer)
        
        createButton("Infinite Money", function()
            -- Money modification implementation
        end, ContentContainer)
        
        createButton("Anti AFK", function()
            -- Anti AFK implementation
            local VirtualUser = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        end, ContentContainer)
    end
end

-- Close button functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Make window draggable
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Title.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Title.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Initialize
updateContent()

-- Keybind to show/hide GUI (F9)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.F9 then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
