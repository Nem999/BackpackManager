local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")

local BackpackGui = script.Parent:WaitForChild("BackpackGui")
local SlotTemplate = BackpackGui.BackpackSlot
local BackpackButton = BackpackGui.BackpackButton
local SelectionUi = BackpackGui.SelectionUI
local ToolTip = BackpackGui.ToolTip
local InventoryUI = BackpackGui.InventoryMain
local HintUI = BackpackGui.Hint


local BackpackManager = require(script.Parent:WaitForChild("BackpackManager"))

function TVScreenDetected() -- Change or remove if you have tool slots with custom sizes in mind.
	SlotTemplate.Button.ToolNum.Size = UDim2.fromOffset(24, 27)
	BackpackButton.Size = UDim2.fromOffset(93, 78)
	SlotTemplate.Size = UDim2.fromOffset(100, 100)
	SelectionUi.Size = UDim2.fromOffset(140, 135)
	ToolTip.Size = UDim2.fromOffset(130, 35)
	
	SlotTemplate.Button.ToolName.TextSize = 24
	ToolTip.TipText.TextSize = 22
	SlotTemplate.Button.CooldownText.TextSize = 40
	
	BackpackManager.Settings.HotbarYOffset += 25
	BackpackManager.Settings.BackpackButtonXOffset += 60
	BackpackManager.Settings.ToolTipYOffset -= 10
end

function SmallMobileScreenDetected()  -- Change or remove if you have the inventory with a custom size in mind.
	InventoryUI.Size = UDim2.fromOffset(401, 218)
	BackpackManager.Settings.InventoryYOffset -= 40
	HintUI.Size = UDim2.fromOffset(104, 30)
end

if GuiService:IsTenFootInterface() then 
	TVScreenDetected()
end

if UserInputService.TouchEnabled and (workspace.CurrentCamera.ViewportSize.Y < 450 or workspace.CurrentCamera.ViewportSize.X < 550) then
	SmallMobileScreenDetected()
end

-- //

BackpackManager.StartBackpack() -- :D