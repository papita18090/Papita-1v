local Enabled = false
local Delay = 0.01
local VirtualInputManager = game:GetService("VirtualInputManager")
local UserInputService = game:GetService("UserInputService")
local player = game:GetService("Players").LocalPlayer

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "PapitaAutoClick"
gui.ResetOnSpawn = false

local panel = Instance.new("Frame")
panel.Size = UDim2.new(0, 180, 0, 50)
panel.Position = UDim2.new(0, 20, 0.7, 0)
panel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
panel.BorderSizePixel = 0
panel.Parent = gui

local boton = Instance.new("TextButton")
boton.Size = UDim2.new(1, 0, 1, 0)
boton.Position = UDim2.new(0, 0, 0, 0)
boton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
boton.Text = "Abrir AutoClick"
boton.TextColor3 = Color3.new(1, 1, 1)
boton.Font = Enum.Font.GothamBold
boton.TextScaled = true
boton.Parent = panel

boton.MouseButton1Click:Connect(function()
    Enabled = not Enabled
    boton.Text = Enabled and "Cerrar AutoClick" or "Abrir AutoClick"
    boton.BackgroundColor3 = Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.KeyCode == Enum.KeyCode.Z then
        Enabled = not Enabled
        boton.Text = Enabled and "Cerrar AutoClick" or "Abrir AutoClick"
        boton.BackgroundColor3 = Enabled and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    end
end)

task.spawn(function()
    while true do
        if Enabled then
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
        end
        task.wait(Delay)
    end
end)

-- Hacer panel movible
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    panel.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

panel.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = panel.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

panel.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
