local PlayersService = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local LocalizationService = game:GetService("LocalizationService")

local BackpackGui = script.Parent:WaitForChild("BackpackGui")
local SlotTemplate = BackpackGui.BackpackSlot
local BackpackButton = BackpackGui.BackpackButton
local SelectionUi = BackpackGui.SelectionUI
local ToolTip = BackpackGui.ToolTip
local InventoryUI = BackpackGui.InventoryMain
local HintUI = BackpackGui.Hint

local BackpackManager = require(script.Parent:WaitForChild("BackpackManager"))

local InventoryOpenedSignal = nil
local InventoryClosedSignal = nil

local KeyboardEnabled = false
local TouchEnabled = false
local MouseEnabled = false

function LargeScreenDetected() -- Change or remove if you have tool slots with custom sizes in mind.
	SlotTemplate.Button.ToolNum.Size = UDim2.fromOffset(24, 27)
	BackpackButton.Size = UDim2.fromOffset(93, 78)
	ToolTip.Size = UDim2.fromOffset(130, 35)

	SlotTemplate.Button.ToolName.TextSize = 24
	ToolTip.TipText.TextSize = 22
	SlotTemplate.Button.CooldownText.TextSize = 40

	InventoryUI.Size = UDim2.fromOffset(939,604)
	InventoryUI.TextBox.TextSize = 28

	HintUI.Size = UDim2.fromOffset(215,61)
	HintUI.Background.HintText.TextSize = 37
	
	BackpackManager.Settings.IconScale = 1.8
	BackpackManager.Settings.HotbarYOffset += 25
	BackpackManager.Settings.InventoryYOffset += 135
	BackpackManager.Settings.BackpackButtonXOffset += 60
	BackpackManager.Settings.ToolTipYOffset -= 10
end

function SmallScreenDetected()  -- Change or remove if you have the inventory with a custom size in mind.
	InventoryUI.Size = UDim2.fromOffset(401, 218)
	BackpackManager.Settings.InventoryYOffset -= 40
	HintUI.Background.HintIcon.Size = UDim2.fromOffset(22, 22)
	HintUI.Size = UDim2.fromOffset(104, 30)
end

function NoKeyboardDetected()
	BackpackManager.Settings.ShowToolNumber = false
end

function disableOrganizingOnMobileDevices()
	BackpackManager.Settings.CanOrganize = false
	
	InventoryOpenedSignal = BackpackManager.InventoryOpened:Connect(function()
		BackpackManager.Settings.CanOrganize = true
	end)

	InventoryClosedSignal = BackpackManager.InventoryClosed:Connect(function()
		BackpackManager.Settings.CanOrganize = false
	end)

end

local function isKeyboardEnabled()
	KeyboardEnabled = UserInputService.KeyboardEnabled
	
	if not UserInputService.KeyboardEnabled then
		NoKeyboardDetected()
	else
		BackpackManager.Settings.ShowToolNumber = true
	end
end

local function isMobileScreen()  -- You may need to change this if you want to change the "CanOrganize" setting.
	TouchEnabled = UserInputService.TouchEnabled
	MouseEnabled = UserInputService.MouseEnabled
	
	if UserInputService.TouchEnabled and not UserInputService.MouseEnabled then
		disableOrganizingOnMobileDevices()
	else
		BackpackManager.Settings.CanOrganize = true
		if InventoryClosedSignal then InventoryClosedSignal:Disconnect() end
		if InventoryOpenedSignal then InventoryOpenedSignal:Disconnect() end
	end
end

if GuiService:IsTenFootInterface() then 
	LargeScreenDetected()
end

if GuiService.ViewportDisplaySize == Enum.DisplaySize.Small then
	SmallScreenDetected()
end

isKeyboardEnabled()
isMobileScreen() 

local function KeyboardChanged()
	if UserInputService.KeyboardEnabled == KeyboardEnabled then return end
	isKeyboardEnabled()
	BackpackManager:ResetGui()
end

local function TouchScreenChanged()
	if UserInputService.TouchEnabled == TouchEnabled and UserInputService.MouseEnabled == MouseEnabled then return end
	isMobileScreen()
	BackpackManager:ResetGui()
end

UserInputService:GetPropertyChangedSignal("KeyboardEnabled"):Connect(KeyboardChanged)
UserInputService:GetPropertyChangedSignal("TouchEnabled"):Connect(TouchScreenChanged)
UserInputService:GetPropertyChangedSignal("MouseEnabled"):Connect(TouchScreenChanged)

-- //

BackpackManager.StartBackpack() -- :D
