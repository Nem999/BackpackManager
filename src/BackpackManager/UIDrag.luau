-- Special thanks to Spynaz

local UDim2_new = UDim2.new

local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local Spring = require(script.Parent:WaitForChild("Spring"))

local DraggableObject 		= {}
DraggableObject.__index 	= DraggableObject
local DraggingObj = nil
local waiting = false
local StartTime


function MouseOrTouchMovement(input)
	return input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch
end

function DraggableObject.new(Object, MainGui, MoveCodes, BP, fn)
	local self 			= {}
	self.Object			= Object.Frame.Button
	self.DragStarted	= nil
	self.DragEnded		= nil
	self.Dragged		= nil
	self.Dragging		= false
	self.DragEnabled	= false
	self.MainGui 		= MainGui
	self.FastMoveCodes 	= MoveCodes
	self.BP = BP
	self.Data = Object
	self.ClearHighlights = fn

	setmetatable(self, DraggableObject)

	return self
end

function DraggableObject:Enable()
	local object:ImageButton			= self.Object
	local dragInput			= nil
	local dragStart			= nil
	local startPos			= nil
	local preparingToDrag	= false
	local isDragging = false
	local Data = self.Data
	
	self.DragEnabled = true

	local GhostObject
	
	if self.InputBegan then
		
	end
	
	if self.InputChanged then
		
	end

	local function update(input)
		local mouselocation = UserInputService:GetMouseLocation()

		local newPosition	= UDim2_new(0, mouselocation.X + GuiService:GetGuiInset().X - (object.AbsoluteSize.X / 2), 0, mouselocation.Y + (object.AbsoluteSize.Y / 2) - GuiService:GetGuiInset().Y)
		
		if GhostObject then
			Spring.target(GhostObject, 1.1, 8, {
				Position = newPosition
			})

		end
		
		-- GhostObject.Position = newPosition

		return newPosition
	end

	local function doDragging (input, _, ignore)
		if not object then self:Disable() return end
		if not object:IsDescendantOf(game) then self:Disable() return end
		if not self.BP.Settings.CanOrganize then return end

		if object.Parent.Parent == self.MainGui.Inventory.InventoryMain.Background.ScrollingFrame and not isDragging then
			if not self.BP:IsInventoryOpen() then return end
		end

		if UserInputService.TouchEnabled then
			if not self.BP:IsInventoryOpen() then return end
		end

		if not object.Parent.Tool.Value then self:Disable(true) return end

		if ignore or MouseOrTouchMovement(input) and preparingToDrag then
			if DraggingObj then return end
			preparingToDrag = false


			if ignore or self.DragStarted then
				if not isDragging then return end

				StartTime = workspace:GetServerTimeNow()
				local LoggedStartTime = StartTime
				local NeededTime = workspace:GetServerTimeNow() + self.BP.Settings.DragWaitTime

				if self.BP.Settings.DragWaitTime > 0 then
					local Stroke = Instance.new("UIStroke")
					Stroke.Color = Color3.fromRGB(255, 255, 255)
					Stroke.Thickness = 2
					Stroke.Transparency = 1

					Stroke.Parent = object
					waiting = true

					while workspace:GetServerTimeNow() < NeededTime do
						if not isDragging then
							Stroke:Destroy()
							DraggingObj = nil
							return
						end
						
						if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
							DraggingObj = nil
							Stroke:Destroy()
							return
						end
						
						if StartTime ~= LoggedStartTime then
							DraggingObj = nil
							Stroke:Destroy()
							return
						end

						Stroke.Transparency = 1 + math.abs(1 - (workspace:GetServerTimeNow() - LoggedStartTime) / ((LoggedStartTime + self.BP.Settings.DragWaitTime) - LoggedStartTime))
						task.wait()
					end
					

					Stroke:Destroy()

					if not isDragging then
						return
					end
					
					if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
						return
					end

					if StartTime ~= LoggedStartTime then
						return
					end
				end
				
				waiting = false

				if GhostObject then GhostObject:Destroy() self.GhostObject = nil end
				
				isDragging = true
				DraggingObj = object

				GhostObject = self.Object.Parent:Clone()
				self.GhostObject = GhostObject

				if GhostObject.Parent ~= self.MainGui then 
					GhostObject.Parent = self.MainGui

					GhostObject.Visible = true
				end

				GhostObject.Name = "_Ghost"
				
				local mouselocation = UserInputService:GetMouseLocation()

				local newPosition	= UDim2_new(0, mouselocation.X + GuiService:GetGuiInset().X - (object.AbsoluteSize.X / 2), 0, mouselocation.Y + (object.AbsoluteSize.Y / 2) - GuiService:GetGuiInset().Y)

				GhostObject.Position = newPosition
				
				local Slot1, Slot2 = self.ClearHighlights()

				if Slot1 then
					self.BP.DragEnded:Fire(Slot1.Tool, Slot1.Frame, nil, true, UDim2.fromOffset(Slot1.Frame.AbsolutePosition.X, Slot1.Frame.AbsolutePosition.Y))
				end

				self.BP.DragStarted:Fire(Data.Tool, Data.Frame, GhostObject, false)

				self.DragStarted()
			end

			if not input then
				local mouselocation = UserInputService:GetMouseLocation()
				self.Dragging = true
				dragStart = UDim2_new(0, mouselocation.X + GuiService:GetGuiInset().X - (object.AbsoluteSize.X / 2), 0, mouselocation.Y + (object.AbsoluteSize.Y / 2) - GuiService:GetGuiInset().Y)
			else
				dragStart 		= input.Position
			end

			self.Dragging	= true
			startPos 		= UDim2.fromOffset(object.AbsolutePosition.X + GuiService:GetGuiInset().X,  object.AbsolutePosition.Y + GuiService:GetGuiInset().Y)
		end

		if self.Dragging then			
			local newPosition = update(input)

			if self.Dragged then
				self.Dragged(newPosition)
			end
		end
	end

	self.InputBegan = object.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch and input.UserInputState == Enum.UserInputState.Begin then
			if Data.Locked then return end
			if Data.Glued then return end
			if not Data.Tool then return end
			
			local isOneKeyDown = false

			for _, key in pairs(self.FastMoveCodes) do
				if UserInputService:IsKeyDown(key) then
					isOneKeyDown = true
					break
				end
			end

			if isOneKeyDown then return end

			preparingToDrag = true
			isDragging = true

			if self.BP.Settings.DragWaitTime > 0 then
				doDragging(false, nil, true)
			end

			
			self.connection = input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End and (self.Dragging or preparingToDrag or isDragging) then
					self.Dragging = false
					self.connection:Disconnect()

					local previous = DraggingObj

					DraggingObj = nil

					if self.DragEnded and not preparingToDrag and GhostObject then
						
						local MouseLocation = UserInputService:GetMouseLocation()

						local GhostPosition = UDim2.fromOffset(MouseLocation.X + GuiService:GetGuiInset().X, MouseLocation.Y - GuiService:GetGuiInset().Y) -- doing this because of possible animations

						if GhostObject then GhostObject:Destroy() self.GhostObject = nil end

						if previous then
							self.BP.DragEnded:Fire(Data.Tool, Data.Frame, GhostObject, false, GhostPosition)
						end
						
						if not waiting then
							self.DragEnded(GhostPosition)
						end
						
						waiting = false
					end

					isDragging = false
					preparingToDrag = false
				end
			end)
		end
	end)

	self.InputChanged = object.InputChanged:Connect(function(input)
		if MouseOrTouchMovement(input) then
			dragInput = input
		end
	end)

	self.InputChanged2 = UserInputService.InputChanged:Connect(function(input)
		doDragging(input)
	end)
end

function DraggableObject:Disable(ignoreDragEnded)
	self.InputBegan:Disconnect()
	self.InputChanged:Disconnect()
	self.InputChanged2:Disconnect()
	
	if self.connection then
		self.connection:Disconnect()
	end
	
	self.DragEnabled = true

	local Previous = DraggingObj

	DraggingObj = nil

	local GhostPosition

	if self.GhostObject then
		local MouseLocation = UserInputService:GetMouseLocation()

		GhostPosition = UDim2.fromOffset(MouseLocation.X + GuiService:GetGuiInset().X, MouseLocation.Y - GuiService:GetGuiInset().Y)
		self.GhostObject:Destroy()

		self.GhostObject = nil
	end

	if self.Dragging then
		self.Dragging = false

		if Previous then
			self.BP.DragEnded:Fire(self.Data.Tool, self.Data.Frame, self.GhostObject, false, GhostPosition or UDim2_new())
		end

		if self.DragEnded then
			self.DragEnded(GhostPosition, ignoreDragEnded)
		end
	end
end

return DraggableObject