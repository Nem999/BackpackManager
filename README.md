# BackpackManager

BackpackManager is an open source Backpack replacement with a feature rich exposed API allowing you to create a unique backpack UI within your game.

Key Features include:

* Multi-Platform Support – Works on PC, Mobile, Console, and VR.
* Customizable Tool Slots – Organize tools however you like.
* Slot Control – Limit and manage the number of available slots.
* Exposed API – Easily interact with and modify the backpack system.
* Event Signaling – Get notified of key backpack events.
* Tool Locking & Equip Prevention – Restrict access to specific tools.
* Smooth Animations – Animations can be enabled or disabled for a more polished experience.

## How to install

**From Creator Store**

1. Head over this [Roblox Creator Store Page](https://create.roblox.com/store/asset/132160096564542/Backpack) and click "Get Model"
2. Open studio into your place
3. Open the toollbox and go to "My models"
4. Drag the Module into your game (It should be a ScreenGui named "BackpackGui")

**From GitHub**

1. Head over to the [releases](https://github.com/Nem999/BackpackManager/releases).
2. Download the most recent rbxm.
3. Open studio into your place.
4. Right click the StarterGui and click on "Insert from File"


[NOTE] Once you you have BackpackManager installed you can move the module where you'd like it's recommended to place it in [ReplicatedStorage](https://create.roblox.com/docs/reference/engine/classes/ReplicatedStorage).


Create a LocalScript in StarterPlayerScripts with the following:

```luau
local BackpackManager = require(BackpackManager)

BackpackManager.StartBackpack()
```
