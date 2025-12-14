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
	
	BackpackManager.InventoryOpened:Connect(function()
		BackpackManager.Settings.CanOrganize = true
	end)

	BackpackManager.InventoryClosed:Connect(function()
		BackpackManager.Settings.CanOrganize = false
	end)

end

if GuiService:IsTenFootInterface() then 
	LargeScreenDetected()
end

if GuiService.ViewportDisplaySize == Enum.DisplaySize.Small then
	SmallScreenDetected()
end

if not UserInputService.KeyboardEnabled then
	NoKeyboardDetected()
end

if UserInputService.TouchEnabled then
	disableOrganizingOnMobileDevices() -- You may need to remove this if you want to change the "CanOrganize" setting.
end

-- //

BackpackManager.StartBackpack() -- :D
