## MaxHotbarToolSlots

This setting controls the maximum amount of tool slots allowed to be used reguardless of the client's screen size.

_Setting set to 5_

![Setting set to 5](images/MaxHBSlots5.png)

## MinHotbarSlots

This setting controls the minimum amount of tool slots allowed to be used reguardless of the client's screen size.

_Setting set to 6_

![Setting set to 6](images/MinHBSlots6.png)

## NeededFreeSpace

This setting determines how many pixels is "reserved" when calculating how many tool slots the client should have.

!!!notice 
    Having a higher number may result in less tool slots.

## EquipCooldown

This setting determines how long the client has to wait in between equipping. Useful for preventing equip spam.

## ViewportSpeed

This setting determines how fast tools move in their viewport frame.

_Setting set to 10_

![Setting set to 10](images/ViewportSpeed10.gif)

## SweepInterval

This setting determines how long it takes for reusable inventory slots to be destroyed.

When a inventory slot is created for a tool, BackpackManager does not delete it immediately when it is not needed anymore instead BackpackManager reuses slots whenever one is needed. These reusable slots are only deleted when a sweep occurs.

![SweepInterval Example](images/SweepInterval.gif)

## MaxHeldTools

This setting determines how many tools can be held at once by the player.

_Setting set to 3_

![Setting set to 3](images/MaxHeldTools3.png)

## DragWaitTime

This setting determines how long the player needs to hold left click on a tool before it starts dragging.

_Setting set to 1_

![Setting set to 1](images/DragWaitTime1.gif)

## ToolTipSpeed

This setting determines how fast tool tips display.

_Setting set to 0.012_

![Setting set to 0.012](images/ToolTipSpeed.gif)

## AutoCalculateMaxToolSlots

This setting determines if BackpackManager will dynamically set the max tool slots depending on screen size.

!!!notice 
    This setting will respect the preset maximum and minimum tools by the developer and will never go below the minimum or above the maximum.

_Setting set to true_

![Setting set to true](images/AutoCalculateMaxToolSlots.gif)

## UseViewportFrame

This setting when enabled will automatically display tools in viewport mode.

_Setting set to true_

![Setting set to true](images/ViewportSpeed10.gif)

## UseScrollWheel

This setting when enabled will allow for the client to cycle through tools using their mouse's scroll wheel.

## CanOrganize

This setting determines if the client is allowed to move tools.

## Animate

This setting determines if BackpackManager will use animations.

_Setting set to false_

![Setting set to false](images/Animate.gif)

## AutoSortSlots

This setting determines if BackpackManager will automatically sort tool slots when a tool is removed.

_Setting set to true_

![Setting set to true](images/AutoSortTools.gif)

## PreventEquippingOnToolCooldown

This setting determines if a tool that has a cooldown active on it will be allowed to be equipped.

## UseGamepadCursor

This setting determines if the gamepad cursor is used when the inventory is opened.

_Setting set to true_

![Setting set to true](images/GamepadCursor.gif)

_Setting set to false_

![Setting set to false](images/NoGamepadCursor.gif)

## ShowHints

This setting determines if input hints are shown.

_Setting set to true_

![Setting set to true](images/ShowHints.png)

## ShowBackpackIcon

This setting determines if the backpack icon will be displayed.

_Setting set to true_

![Setting set to true](images/ShowBackpackIconYes.png)

_Setting set to false_

![Setting set to false](images/ShowBackpackIconNo.png)

## ShowInactiveHotbarSlots

This setting determines if unused hotbar slots are displayed.

_Setting set to true_

![Setting set to true](images/InactiveHotbarSlotsTrue.png)

_Setting set to false_

![Setting set to false](images/InactiveHotbarSlotsFalse.png)

!!! notice
    If this setting is disabled then you will have to implement your own backpack button for mobile users to access the inventory.

## BackpackButtonOpenedColor

This setting determines the color of the backpack icon's color when the inventory has been opened.

_Setting set to RGB(203, 53, 53)_

![Setting set to RGB(203, 53, 53)_](images/BackpackOpenedColor.png)

## DesiredPadding

This setting determines the spacing of tool slot gui elements.

_Setting set to UDIM(0, 2)_

![Setting set to UDIM(0, 2)](images/DesiredPadding.png)

## InventoryYOffset

This setting determines the offset of the inventory in the Y axis.

## HotbarYOffset

This setting determines the offset of the hotbar in the Y axis.

## GlueContainerXOffset

This setting determines the offset of the glue container in the X axis.

## BackpackButtonXOffset

This setting determines the offset of the backpack button in the X axis.

## BackpackButtonYOffset

This setting determines the offset of the backpack button in the Y axis.

## SlotAnimateStartYOffset

This setting determines the start offset of the highlight in the Y axis.

## SlotAnimateStartXOffset

This setting determines the start offset of the highlight in the X axis.

## ToolTipYOffset

This setting determines the offset of tool tips in the Y axis.

## INVENTORY_OPENANDCLOSE_KEYCODES

This setting determines which keybinds open and close the inventory.

## FASTMOVE_KEYCODES

This setting determines which keybinds while pressing left click on a tool while the inventory is opened will preform a fast move.

## GUI_SELECTION_KEYCODES

This setting determines which keybinds will select tool slots while in UI navigation mode.

## CYCLE_LEFT_KEYCODES

This setting determines which keybinds will cycle left through the hotbar.

## CYCLE_RIGHT_KEYCODES

This setting determines which keybinds will cycle right through the hotbar.