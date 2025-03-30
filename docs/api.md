# API

## Events

!!! warning
    When using events that interact with tool slots such as `.OnSlotRefresh` or `.ToolAdded` be sure to connect your function before calling `.StartBackpack()` or this event will not fire for tools that were already in your backpack when BackpackManager started.

### .ToolAdded

Fires when a tool is added.

``` lua
BackpackManager.ToolAdded:Connect(function(Tool, ToolSlotFrame)
    print(Tool.Name.." was added living in", ToolSlot)
end)
```

### .ToolRemoving

Fires right before a tool gets removed.

``` lua
BackpackManager.ToolRemoving:Connect(function(Tool, ToolSlotFrame, GhostSlot)
    print(Tool.Name.." is removing living in", ToolSlot)
end)
```

### .OnSlotRefresh

Fires when a tool slot is refreshed.

Unlike ToolRemoving this event can fire whenever a tool has been swapped or moved.

``` lua
BackpackManager.OnSlotRefresh:Connect(function(Tool, ToolSlotFrame)
    local TextLabel = Instance.new("TextLabel")
	
	TextLabel.BackgroundTransparency = 1
	TextLabel.Size = UDim2.fromOffset(30, 30)
	TextLabel.TextScaled = true
	TextLabel.Text = "Hi"
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.Name = "MyTextLabel"
	
	TextLabel.Parent = ToolSlot
end)
```

### .OnSlotRemoving

Fires when a tool slot is being removed.

``` lua
BackpackManager.OnSlotRefresh:Connect(function(Tool, ToolSlotFrame)
    local TextLabel = ToolSlot:FindFirstChild("MyTextLabel")
	
	if TextLabel then TextLabel:Destroy() end
end)
```

### .DragStarted

Fires when a tool slot is starts being dragged.

!!! notice
    Tool and GhostSlot can be nil if the tool is being dragged on controller.

``` lua
BackpackManager.DragStarted:Connect(function(Tool, ToolSlotFrame, GhostSlot, isControllerDragging)
    if not isControllerDragging then
        print(Tool.Name.." is being dragged in toolslot", ToolSlot, GhostSlot)
    else
        print("The tool is being dragged on a controller or UI navigation mode.")
    end
end)
```

### .DragEnded

Fires when a tool slot stops being dragged.

``` lua
BackpackManager.DragEnded:Connect(function(Tool, ToolSlot, GhostSlot, isControllerDragging, Position)
    if not isControllerDragging then
        print(Tool.Name.." is being no longer being dragged in toolslot", ToolSlot, GhostSlot)

        print("The drag stopped at position", Position)
    else
        print("The tool was being dragged on a controller or UI navigation mode.")
    end
end)
```

### .HoverStarted

Fires when a tool slot is being hovered over.

``` lua
BackpackManager.HoverStarted:Connect(function(ToolSlot)
    local Tool = BackpackManager:GetToolFromSlot(ToolSlot)

    print(Tool, "is being hovered over.")
end)
```

### .HoverEnded

Fires when a tool slot stops being hovered over.

``` lua
BackpackManager.HoverEnded:Connect(function(ToolSlot)
    local Tool = BackpackManager:GetToolFromSlot(ToolSlot)

    print(Tool, "is no longer being hovered over.")
end)
```

### .InventoryOpened

Fires when the inventory is opened.

``` lua
BackpackManager.InventoryOpened:Connect(function()
    print("The inventory was opened.")
end)
```

### .InventoryClosed

Fires when the inventory is closed.

``` lua
BackpackManager.InventoryClosed:Connect(function()
    print("The inventory was closed.")
end)
```

### .CooldownEnded

Fires when a tool's cooldown ends.

``` lua
BackpackManager.CooldownEnded:Connect(function(Tool, ToolSlot)
    print(Tool.Name.."'s cooldown has ended")
end)
```

### .ToolEquipped

Fires when a tool gets equipped.

``` lua
BackpackManager.ToolEquipped:Connect(function(Tool, ToolSlotFrame, Highlight)
    print(Tool.Name.." was equipped and is using highlight:", Highlight)
end)
```

### .ToolUnequipped

Fires when a tool gets equipped.

``` lua
BackpackManager.ToolUnequipped:Connect(function(Tool, ToolSlotFrame)
    print(Tool.Name.." was unequipped")
end)
```

## Functions

### .StartBackpack()

``` lua
BackpackManager.StartBackpack()
```

*Starts the backpack, builds the gui, disables Roblox's default backpack, and only runs once.*

!!! failure
    Call this function in a script that will not be deleted. NEVER call this in a CharacterScript.

!!! failure
    Calling any of the functions below except `:IsRunning()` without calling this function first will result in an error.

Example usage:

``` lua
local BackpackManager = require(BackpackManager)

BackpackManager.StartBackpack()

-- Starts the backpack.
```

### :MapKeybind()

``` lua
BackpackManager:MapKeybind(SlotNumber: number , Keycode: Enum.Keycode)
```

Maps a slot's equip function to a certain keycode.

!!! failure
    This only works for hotbar slots and not inventory slots.

Example usage:

``` lua
BackpackManager:MapKeybind(2 , Enum.Keycode.P) -- Maps the 2nd tool slots equip to P
```

### :UnmapKeybind()

``` lua
BackpackManager:UnmapKeybind(SlotNumber: number)
```

Unmap a slot's equip function.

Example usage:

``` lua
BackpackManager:UnmapKeybind(2) -- Unmaps the 2nd tool slots equip function
```

### :Equip()

``` lua
BackpackManager:Equip(ToolOrSlot: (number | string | ToolSlot | Tool), Generic: boolean, RespectsCooldown: boolean)

-- ToolOrSlot: The Tool being equipped
-- Generic: Whether BackpackManager should traverse all of the tools or only the tools in the hotbar.
-- RespectsCooldown: If BackpackManager should take the cooldown into account when equipping the tool.
```

Equips a tool if it's not currently equipped and unequips it if it is.

Example usage:

``` lua
BackpackManager:Equip(2 , true, false) 
-- Equips the 2nd tool only searching in the hotbar slots and ignoring any equip cooldown.
```

### :IsInventoryOpen()

``` lua
BackpackManager:IsInventoryOpen():boolean
```

Returns true if the inventory is currently open and false if it's not.

Example usage:

``` lua
if BackpackManager:IsInventoryOpen() then
    print("The inventory is open.")
end
```

### :IsEnabled()

``` lua
BackpackManager:IsEnabled():boolean
```

Returns true if the backpack is currently enabled and false if it's not currently enabled.

Example usage:

``` lua
if BackpackManager:IsEnabled() then
    print("BackpackManager is currently enabled.")
end
```

### :IsInventoryEnabled()

``` lua
BackpackManager:IsInventoryEnabled():boolean
```

Returns true if the inventory is currently enabled and false if it's not currently enabled.

Example usage:

``` lua
if BackpackManager:IsInventoryEnabled() then
    print("The inventory is currently enabled.")
end
```

### :OpenInventory()

``` lua
BackpackManager:OpenInventory(RespectsCooldown: boolean)
-- RespectsCooldown: If BackpackManager should take the cooldown into account when opening the inventory.
```

Opens the inventory.

Example usage:

``` lua
BackpackManager:OpenInventory(false)
-- Open the inventory and ignore any cooldown
```

### :CloseInventory()

``` lua
BackpackManager:CloseInventory(RespectsCooldown: boolean)
-- RespectsCooldown: If BackpackManager should take the cooldown into account when closing the inventory.
```

Closes the inventory.

Example usage:

``` lua
BackpackManager:CloseInventory(false)
-- Close the inventory and ignore any cooldown
```

### :MoveToolToHotbarSlotNumber()

``` lua
BackpackManager:MoveToolToHotbarSlotNumber(ToolOrSlot: (number | string | ToolSlot | Tool), SlotNumber: number):table

-- ToolOrSlot: The Tool being moved
-- SlotNumber: The number the tool is being moved into.
```

Moves a tool to a certain hotbar slot number.

!!! warning
    Trying to move a tool into a slot that is occupied will result in a warning. Consider using `:SwapTools()` in that case.

Example usage:

``` lua
BackpackManager:MoveToolToHotbarSlotNumber(Tool, 3)
-- Moves a tool into slot 3
```

### :MoveToolToInventory()

``` lua
BackpackManager:MoveToolToInventory(ToolOrSlot: (number | string | ToolSlot | Tool)):table

-- ToolOrSlot: The tool being moved
```

Moves a tool to the inventory.

Example usage:

``` lua
BackpackManager:MoveToolToInventory(2)
-- Moves whatever tool is in slot 2 to the inventory.
```

### :MoveToolToHotbar()

``` lua
BackpackManager:MoveToolToHotbar(ToolOrSlot: (number | string | ToolSlot | Tool)):table

-- ToolOrSlot: The tool being moved
```

Moves a tool to a free hotbar slot if one exist.

!!! warning
    Trying to use this function while the hotbar is full will result in a warning. Use `:GetMaxHotbarTools()` and `:GetHotbarTools()` to check if the hotbar is full beforehand.

Example usage:

``` lua
BackpackManager:MoveToolToHotbar(13)
-- Moves whatever tool is in slot 13 to the hotbar.
```

### :SwapTools()

``` lua
BackpackManager:SwapTools(ToolOrSlot1: (number | string | ToolSlot | Tool), ToolOrSlot2: (number | string | ToolSlot | Tool)):(table | table)

-- ToolOrSlot: The tool being moved
```

Swaps two tools.

Example usage:

``` lua
BackpackManager:SwapTools(Tool1, Tool2)
-- Swaps Tool1 and Tool2 with each other.
```

### :SortTools()

``` lua
BackpackManager:SortTools()
```

*Sorts the tools in the hotbar filling any missing gap.*

!!! notice
    If a tool has been moved using `:MoveToolToHotbarSlotNumber()` then this function will ignore sorting that tool.

Example usage:

``` lua
if BackpackManager:GetToolFromNumber(1) and not BackpackManager:GetToolFromNumber(2) and BackpackManager:GetToolFromNumber(3) then
    BackpackManager:SortTools()
end
```

### :PopNotificationIcon()

``` lua
BackpackManager:PopNotificationIcon(State: boolean)

-- State: the visibility state of the notification icon.
```

*Shows the notification icon on the backpack icon.*

Example usage:

``` lua
BackpackManager:PopNotificationIcon(true)
-- Displays the notification icon

task.wait(2)

BackpackManager:PopNotificationIcon(false)
-- Removes the notification icon
```

### :UnequipTools()

``` lua
BackpackManager:UnequipTools()
```

*Unequips non glued tools.*

Example usage:

``` lua
task.wait(1)

BackpackManager:UnequipTools()

-- Unequips any tool that isn't glued.
```

### :GetEquippedTools()

``` lua
BackpackManager:GetEquippedTools():table
```

*Returns a table of all tools that are currently equipped.*

Example usage:

``` lua
print(BackpackManager:GetEquippedTools())
-- Prints a table of all the tools that are equipped.
```

### :GetTools()

``` lua
BackpackManager:GetTools():table
```

*Returns a table of all tools that are currently in the backpack and on the current character.*

Example usage:

``` lua
print(BackpackManager:GetTools())
-- Prints a table of all the tools.
```

### :GetToolFromFrame()

``` lua
BackpackManager:GetToolFromFrame(Frame: Frame):Tool

-- Frame: The ToolSlot's Frame
```

*Returns the tool that corresponds to the given backpack slot.*

Example usage:

``` lua
local Tool = BackpackManager:GetToolFromFrame(Frame)

print(Tool)
-- Prints a tool
```

### :GetToolFromSlot()

``` lua
BackpackManager:GetToolFromSlot(ToolOrSlot: (number | string | ToolSlot | Tool)):Tool

-- ToolOrSlot: The tool being moved
```

*Returns the tool that corresponds to the given tool slot.*

Example usage:

``` lua
local Tool = BackpackManager:GetToolFromSlot(ToolSlot)

print(Tool)
-- Prints a tool
```

### :GetToolFromNumber()

``` lua
BackpackManager:GetToolFromNumber(Number: number):Tool

-- Number: The tool slot's number
```

*Returns the tool that corresponds to the given slot number.*

Example usage:

``` lua
local Tool = BackpackManager:GetToolFromNumber(3)

print(Tool)
-- Prints the tool that lives in slot 3 if any
```

### :GetMaxHotbarTools()

``` lua
BackpackManager:GetMaxHotbarTools():number
```

*Returns the max amount of slots that can fit in the hotbar at the moment.*

Example usage:

``` lua
local MaxToolSlots = BackpackManager:GetMaxHotbarTools()
local HotbarTools = BackpackManager:GetHotbarTools()

if MaxToolSlots ~= #HotbarTools then
    BackpackManager:MoveToolToHotbar(11)
end

-- Checks if the max hotbar slots have been reached before moving a tool into the hotbar
```

### :GetSlotFromTool()

``` lua
BackpackManager:GetSlotFromTool(ToolOrSlot: (number | string | ToolSlot | Tool)):table

-- ToolOrSlot: The tool being used to get the slot from.
```

*Returns the slot data for a certain tool.*

Example usage:

``` lua
local SlotData = BackpackManager:GetSlotFromTool(2)

if SlotData then
    print(SlotData)
end

-- Prints the slot data in slot 2
```

### :GetSlotFromFrame()

``` lua
BackpackManager:GetSlotFromFrame(Frame: Frame):table

-- Frame: The tool slot's frame instance
```

*Returns the slot data for a certain frame.*

Example usage:

``` lua
local SlotData = BackpackManager:GetSlotFromFrame(Frame)

if SlotData then
    print(SlotData)
end

-- Prints the slot data that coressponds to said frame.
```

### :GetSlotFromNumber()

``` lua
BackpackManager:GetSlotFromNumber(Number: number):table

-- Number: The tool slot's number
```

*Returns the slot data for a certain tool slots number.*

Example usage:

``` lua
local SlotData = BackpackManager:GetSlotFromNumber(13)

if SlotData then
    print(SlotData)
end

-- Prints the slot data that coressponds to slot 13
```

### :GetHotbarTools()

``` lua
BackpackManager:GetHotbarTools():table
```

*Returns a table of all tools that are currently in the hotbar.*

Example usage:

``` lua
local HotbarTools = BackpackManager:GetHotbarTools()

for _, Tool in pairs(HotbarTools) do
    print(Tool.Name)
end

-- Prints each name for each tool that is in the hotbar.
```

### :GetInventoryTools()

``` lua
BackpackManager:GetInventoryTools():table
```

*Returns a table of all tools that are currently in the inventory.*

Example usage:

``` lua
local InventoryTools = BackpackManager:GetInventoryTools()

for _, Tool in pairs(InventoryTools) do
    print(Tool.Name)
end

-- Prints each name for each tool that is in the inventory.
```

### :GetHighlights()

``` lua
BackpackManager:GetHighlights():table
```

*Returns a table of all highlights.*

Example usage:

``` lua
local Highlights = BackpackManager:GetHighlights()

for _, Highlight in pairs(Highlights) do
    print(Highlight)
end

-- Prints each highlight
```

### :SetViewportEnabled()

``` lua
BackpackManager:SetViewportEnabled(ToolOrSlot: (number | string | ToolSlot | Tool), boolean: boolean)

-- ToolOrSlot: The tool being used.
-- boolean: The state the viewport is being set to
```

*Enables or disables the viewport frame displaying the physical tool.*

Example usage:

``` lua
BackpackManager.ToolAdded:Connect(function(Tool)
    if Tool.Name == "Sword" then
        BackpackManager:SetViewportEnabled(Tool)
    end
end)

-- Enables viewport mode if a tool with the name of "Sword" gets added
```

### :SetViewportOffset()

``` lua
BackpackManager:SetViewportOffset(ToolOrSlot: (number | string | ToolSlot | Tool), OffsetCFrame: CFrame)

-- ToolOrSlot: The tool being used.
-- OffsetCFrame: The offset CFrame the viewport's camera uses.
```

*Sets the camera offset for the viewport frame displaying the physical tool.*

Example usage:

``` lua
BackpackManager.ToolAdded:Connect(function(Tool)
    if Tool.Name == "Sword" then
        BackpackManager:SetViewportOffset(Tool, CFrame.new(0, 0, 0) * CFrame.Angles(0 , 0, math.rad(60))
    end
end)

-- Sets the viewport offset if a tool with the name of "Sword" gets added
```

### :GlueTool()

``` lua
BackpackManager:GlueTool(ToolOrSlot: (number | string | ToolSlot | Tool))

-- ToolOrSlot: The tool being glued.
```

*Forces a tool to be equipped at all times and prevents said tool from being moved (This will not use a hotbar slot).*

Example usage:

``` lua
BackpackManager.ToolAdded:Connect(function(Tool)
    if Tool.Name == "Sword" then
        BackpackManager:GlueTool(Tool)
    end
end)

-- Glues the tool if a tool with the name of "Sword" gets added
```

### :RemoveGlue()

``` lua
BackpackManager:RemoveGlue(ToolOrSlot: (number | string | ToolSlot | Tool))

-- ToolOrSlot: The glued tool to remove from.
```

*Removes a glued tool, returning it back to normal.*

Example usage:

``` lua
local Tool

if BackpackManager:IsToolGlued(Tool) then
    BackpackManager:RemoveGlue(Tool)
end

-- Unglues a tool if the tool is glued.
```

### :IsToolGlued()

``` lua
BackpackManager:IsToolGlued(Tool: Tool):boolean

-- ToolOrSlot: The tool being used.
```

*Returns the true if the tool is glued and false if it is not glued.*

Example usage:

``` lua
local Tool

if BackpackManager:IsToolGlued(Tool) then
    print("This tool is glued")
end

-- Checks if a tool is glued.
```

### :DisableInventory()

``` lua
BackpackManager:DisableInventory()
```

*Disables the inventory, prevents it from being used, and closes it if it's currently open.*

Example usage:

``` lua

if BackpackManager:IsInventoryEnabled() then
    BackpackManager:DisableInventory()
end

-- Disables the inventory if it is enabled.
```

### :EnableInventory()

``` lua
BackpackManager:EnableInventory()
```

*Enables the inventory.*

Example usage:

``` lua

if not BackpackManager:IsInventoryEnabled() then
    BackpackManager:EnableInventory()
end

-- Enables the inventory if it is disabled.
```

### :LockTool()

``` lua
BackpackManager:LockTool(ToolOrSlot: (number | string | ToolSlot | Tool))

-- ToolOrSlot: The tool being locked.
```

*Prevents a tool from being equipped and displays a lock icon on the slot.*

Example usage:

``` lua
BackpackManager.ToolAdded:Connect(function(Tool)
    if Tool.Name == "Sword" then
        BackpackManager:LockTool(Tool)
    end
end)

-- Locks the tool if a tool with the name of "Sword" gets added
```

### :UnlockTool()

``` lua
BackpackManager:UnlockTool(ToolOrSlot: (number | string | ToolSlot | Tool))

-- ToolOrSlot: The tool being unlocked.
```

*Unlocks a tool letting it be equipped again.*

Example usage:

``` lua
local Tool

if BackpackManager:IsToolLocked(Tool) then
    BackpackManager:UnlockTool(Tool)
end

-- Unlocks a tool if the tool is locked.
```

### :IsToolLocked()

``` lua
BackpackManager:IsToolLocked(Tool: Tool):boolean

-- Tool: The tool to be checked.
```

*Returns the true if the tool is locked and false if it is not locked.*

Example usage:

``` lua
local Tool

if BackpackManager:IsToolLocked(Tool) then
    print("This tool is locked")
end

-- Checks if a tool is locked.
```

### :Disable()

``` lua
BackpackManager:Disable()
```

*Stops rendering the backpack and prevents it from responding to user input.*

Example usage:

``` lua
if not game:IsLoaded() then BackpackManager:Disable() end

-- Disables BackpackManager if the game is not loaded.
```

### :Enable()

``` lua
BackpackManager:Enable()
```

*Starts rendering the backpack, and makes the backpack respond to user input again.*

Example usage:

``` lua
if not game:IsLoaded() then BackpackManager:Disable() game.Loaded:Wait() end

BackpackManager:Enable()

-- Disables BackpackManager if the game is not loaded then enables it once the game has been loaded.
```

### :GetBackpack()

``` lua
BackpackManager:GetBackpack():Backpack
```

*Returns the current backpack instance being used by the BackpackManager.*

Example usage:

``` lua
local Backpack = BackpackManager:GetBackpack()

print(Backpack)

-- Prints the backpack being used.

```
### :SetCooldown()

``` lua
BackpackManager:SetCooldown(ToolOrSlot: (number | string | ToolSlot | Tool))

-- ToolOrSlot: The tool being used.
```

*Puts the tool on cooldown which displays on the tool slot.*

Example usage:

``` lua
local Tool

Tool.Activated:Connect(function()
  if BackpackManager:IsOnCooldown(Tool) then return end

  BackpackManager:SetCooldown(Tool, 2)

  -- Your code 
end)

-- Checks if there is a cooldown on the tool before calling any other code and sets the cooldown to 2 seconds.
```

### :IsOnCooldown()

``` lua
BackpackManager:IsOnCooldown(ToolOrSlot: (number | string | ToolSlot | Tool)):boolean

-- ToolOrSlot: The tool being checked.
```

*Returns true if the tool has a cooldown active and false if the tool does not have a cooldown active.*

Example usage:

``` lua
local Tool

Tool.Activated:Connect(function()
  if BackpackManager:IsOnCooldown(Tool) then return end

  -- Your code 
end)

-- Checks if there is a cooldown on the tool before calling any other code.
```

### :GetSlotNumber()

``` lua
BackpackManager:GetSlotNumber(ToolOrSlot: (number | string | ToolSlot | Tool)):number

-- ToolOrSlot: The tool being used.
```

*Returns the slot number that corresponds to a tool or slot.*

Example usage:

``` lua
local Tool
local SlotNumber = BackpackManager:GetSlotNumber(Tool)

print(SlotNumber)

-- Prints the slot number of the target tool
```

### :GetFrameFromTool()

``` lua
BackpackManager:GetFrameFromTool(ToolOrSlot: (number | string | ToolSlot | Tool)):Frame

-- ToolOrSlot: The tool being used.
```

*Returns the backpack slot from the tool given.*

Example usage:

``` lua
local Tool
local Frame = BackpackManager:GetFrameFromTool(Tool)

print(Frame)

-- Prints the frame of the target tool
```

### :GetFrameFromHotbarNumber()

``` lua
BackpackManager:GetFrameFromHotbarNumber(Number: number):Frame

-- Number: The hotbar slot number to get the frame from
```

*Returns the backpack slot from the tool given.*

Example usage:

``` lua
local Frame = BackpackManager:GetFrameFromHotbarNumber(3)

print(Frame)

-- Prints the frame of the target hotbar number
```

### :IsRunning()

``` lua
BackpackManager:IsRunning():boolean
```

*Returns true if the backpack is running and false if it's not.*

Example usage:

``` lua
if not BackpackManager:IsRunning() then repeat task.wait() until BackpackManager:IsRunning()

-- Yield your code until BackpackManager is running. Useful if you have multiple different scripts interacting with BackpackManager.
```

### :SetSlotEquipable()

``` lua
BackpackManager:SetSlotEquipable(ToolOrSlot: (number | string | ToolSlot | Tool), boolean)

-- ToolOrSlot: The tool being used.
```

*Toggles if a tool slot can have its tool equipped or not.*

Example usage:

``` lua
BackpackManager:SetSlotEquipable(5, false)

task.wait(2)

BackpackManager:SetSlotEquipable(5, true)

-- Slot 5 will not be able to have any tools equipped for 2 seconds.
```

### :IsSlotEquipable()

``` lua
BackpackManager:IsSlotEquipable(ToolOrSlot: (number | string | ToolSlot | Tool)):boolean

-- ToolOrSlot: The tool being checked.
```

*Returns true if the tool slot is equippable. And false if its not (does not count for locking).*

Example usage:

``` lua
if not BackpackManager:IsSlotEquipable(5) then
    BackpackManager:SetSlotEquipable(5, true)
end

-- Checks if slot 5 can have its tool equipped and if not then enable slot 5 to have its tool equipped.
```