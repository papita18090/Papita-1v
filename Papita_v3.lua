-- Script: Papita v3
-- Autor: Papita (con la ayuda de Kavo UI)
-- Versión: 1.0

-- Cargar la librería Kavo UI (asegúrate de que el archivo KavoU1.txt esté en la misma carpeta o proporciona la ruta correcta)
local Kavo = loadstring(game:HttpGet("https://raw.githubusercontent.com/Visualizem/KavoFiles/main/KavoUI.lua"))()

-- Crear la ventana principal del panel
local PapitaV3 = Kavo.CreateLib("Papita v3", "DarkCrimson")

-- Apartado: Principal
local PrincipalTab = PapitaV3:NewTab("Principal")

PrincipalTab:NewLabel("¡Bienvenido a Papita v3!")
PrincipalTab:NewLabel("El script más épico para Roblox.")
PrincipalTab:AddParagraph("Información", "Este panel ha sido desarrollado por Papita con el objetivo de proporcionar una experiencia de usuario premium y funcionalidades avanzadas. Disfruta de las múltiples herramientas y hacks disponibles.")
PrincipalTab:AddParagraph("Créditos", "- Papita (Desarrollador Principal)\n- Kavo UI (Librería de Interfaz)\n- Comunidad de Roblox Modding (Inspiración y Recursos)")
PrincipalTab:NewLabel("Versión: 1.0")

PrincipalTab:NewButton("Acceso Rápido 1", "Función popular 1", function()
    print("Botón de Acceso Rápido 1 presionado")
    -- Aquí iría la lógica de la función
end)

PrincipalTab:NewButton("Acceso Rápido 2", "Función popular 2", function()
    print("Botón de Acceso Rápido 2 presionado")
    -- Aquí iría la lógica de la función
end)

-- Aquí se añadirán más apartados y funcionalidades

-- Mostrar la UI
PapitaV3:ToggleUI()



-- Apartado: Combate
local CombateTab = PapitaV3:NewTab("Combate")
local CombateSection = CombateTab:NewSection("Aimbot y Asistencia")

-- Aimbot
CombateSection:NewToggle("Aimbot", "Apunta automáticamente a los enemigos", function(state)
    if state then
        print("Aimbot activado")
        -- Código para activar el aimbot
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Camera = workspace.CurrentCamera
        local RunService = game:GetService("RunService")
        
        local function GetClosestPlayer()
            local MaxDistance = math.huge
            local Target = nil
            
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                    local Position, Visible = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                    if Visible then
                        local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                        
                        if Distance < MaxDistance then
                            MaxDistance = Distance
                            Target = v
                        end
                    end
                end
            end
            
            return Target
        end
        
        _G.AimbotEnabled = true
        
        RunService.RenderStepped:Connect(function()
            if _G.AimbotEnabled then
                local Target = GetClosestPlayer()
                if Target then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.HumanoidRootPart.Position)
                end
            end
        end)
    else
        print("Aimbot desactivado")
        -- Código para desactivar el aimbot
        _G.AimbotEnabled = false
    end
end)

-- Ajustes de Aimbot
CombateSection:NewSlider("Precisión Aimbot", "Ajusta la precisión del aimbot", 100, 0, function(s)
    print("Precisión del aimbot ajustada a: " .. s .. "%")
    -- Código para ajustar la precisión
end)

CombateSection:NewDropdown("Objetivo Aimbot", "Selecciona la parte del cuerpo a la que apuntar", {"Cabeza", "Torso", "Piernas"}, function(currentOption)
    print("Objetivo del aimbot cambiado a: " .. currentOption)
    -- Código para cambiar el objetivo
end)

-- ESP
local ESPSection = CombateTab:NewSection("ESP y Visibilidad")

ESPSection:NewToggle("ESP Básico", "Ver jugadores a través de paredes", function(state)
    if state then
        print("ESP Básico activado")
        -- Código para activar ESP básico
        local ESP = {}
        
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game:GetService("Players").LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                local BillboardGui = Instance.new("BillboardGui")
                local TextLabel = Instance.new("TextLabel")
                
                BillboardGui.Parent = v.Character.HumanoidRootPart
                BillboardGui.AlwaysOnTop = true
                BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                
                TextLabel.Parent = BillboardGui
                TextLabel.BackgroundTransparency = 1
                TextLabel.Size = UDim2.new(1, 0, 1, 0)
                TextLabel.Text = v.Name
                TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                TextLabel.TextScaled = true
                
                table.insert(ESP, BillboardGui)
            end
        end
        
        _G.ESPEnabled = true
    else
        print("ESP Básico desactivado")
        -- Código para desactivar ESP básico
        _G.ESPEnabled = false
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BillboardGui") then
                v:Destroy()
            end
        end
    end
end)

-- Hitbox Extender
ESPSection:NewToggle("Hitbox Extender", "Amplía el hitbox de los enemigos", function(state)
    if state then
        print("Hitbox Extender activado")
        -- Código para activar Hitbox Extender
        local Players = game:GetService("Players")
        
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                v.Character.HumanoidRootPart.Transparency = 0.7
            end
        end
        
        _G.HitboxEnabled = true
        
        game:GetService("RunService").RenderStepped:Connect(function()
            if _G.HitboxEnabled then
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        v.Character.HumanoidRootPart.Size = Vector3.new(10, 10, 10)
                        v.Character.HumanoidRootPart.Transparency = 0.7
                    end
                end
            end
        end)
    else
        print("Hitbox Extender desactivado")
        -- Código para desactivar Hitbox Extender
        _G.HitboxEnabled = false
        
        for _, v in pairs(Players:GetPlayers()) do
            if v ~= Players.LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                v.Character.HumanoidRootPart.Transparency = 1
            end
        end
    end
end)

-- Otras funciones de combate
local OtherCombatSection = CombateTab:NewSection("Otras Funciones de Combate")

OtherCombatSection:NewToggle("Kill Aura", "Daña automáticamente a los enemigos cercanos", function(state)
    if state then
        print("Kill Aura activado")
        -- Código para activar Kill Aura
        _G.KillAuraEnabled = true
        
        while _G.KillAuraEnabled do
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local Distance = (v.Character.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    
                    if Distance <= 15 then
                        -- Simular daño (esto variará según el juego)
                        local args = {
                            [1] = v.Character.Humanoid
                        }
                        
                        game:GetService("ReplicatedStorage").DamageEvent:FireServer(unpack(args))
                    end
                end
            end
            
            wait(0.1)
        end
    else
        print("Kill Aura desactivado")
        -- Código para desactivar Kill Aura
        _G.KillAuraEnabled = false
    end
end)

OtherCombatSection:NewToggle("Rapid Fire", "Dispara más rápido", function(state)
    if state then
        print("Rapid Fire activado")
        -- Código para activar Rapid Fire
        _G.RapidFireEnabled = true
        
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            if method == "FireServer" and self.Name == "WeaponFired" and _G.RapidFireEnabled then
                for i = 1, 3 do
                    old(self, ...)
                end
                return
            end
            
            return old(self, ...)
        end)
        
        setreadonly(mt, true)
    else
        print("Rapid Fire desactivado")
        -- Código para desactivar Rapid Fire
        _G.RapidFireEnabled = false
    end
end)

OtherCombatSection:NewToggle("No Recoil", "Elimina el retroceso al disparar", function(state)
    if state then
        print("No Recoil activado")
        -- Código para activar No Recoil
        _G.NoRecoilEnabled = true
        
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            if method == "FireServer" and self.Name == "RecoilEvent" and _G.NoRecoilEnabled then
                return
            end
            
            return old(self, ...)
        end)
        
        setreadonly(mt, true)
    else
        print("No Recoil desactivado")
        -- Código para desactivar No Recoil
        _G.NoRecoilEnabled = false
    end
end)

OtherCombatSection:NewToggle("Wallbang", "Dispara a través de paredes", function(state)
    if state then
        print("Wallbang activado")
        -- Código para activar Wallbang
        _G.WallbangEnabled = true
        
        local mt = getrawmetatable(game)
        local old = mt.__namecall
        setreadonly(mt, false)
        
        mt.__namecall = newcclosure(function(self, ...)
            local args = {...}
            local method = getnamecallmethod()
            
            if method == "FireServer" and self.Name == "RaycastEvent" and _G.WallbangEnabled then
                args[2] = true
                return old(self, unpack(args))
            end
            
            return old(self, ...)
        end)
        
        setreadonly(mt, true)
    else
        print("Wallbang desactivado")
        -- Código para desactivar Wallbang
        _G.WallbangEnabled = false
    end
end)


-- Apartado: Movimiento
local MovimientoTab = PapitaV3:NewTab("Movimiento")
local MovimientoSection = MovimientoTab:NewSection("Velocidad y Vuelo")

-- Speed Hack
MovimientoSection:NewToggle("Speed Hack", "Aumenta tu velocidad de movimiento", function(state)
    if state then
        print("Speed Hack activado")
        -- Código para activar Speed Hack
        _G.SpeedHackEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        
        local SpeedMultiplier = 2 -- Valor predeterminado
        
        RunService.RenderStepped:Connect(function()
            if _G.SpeedHackEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 16 * SpeedMultiplier
            end
        end)
        
        -- Guardar el valor de velocidad para uso posterior
        _G.SpeedMultiplier = SpeedMultiplier
    else
        print("Speed Hack desactivado")
        -- Código para desactivar Speed Hack
        _G.SpeedHackEnabled = false
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- Velocidad predeterminada
        end
    end
end)

-- Ajuste de velocidad
MovimientoSection:NewSlider("Multiplicador de Velocidad", "Ajusta el multiplicador de velocidad", 10, 1, function(s)
    print("Multiplicador de velocidad ajustado a: " .. s)
    -- Código para ajustar el multiplicador de velocidad
    _G.SpeedMultiplier = s
end)

-- Fly
MovimientoSection:NewToggle("Fly", "Permite volar libremente", function(state)
    if state then
        print("Fly activado")
        -- Código para activar Fly
        _G.FlyEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Mouse = LocalPlayer:GetMouse()
        
        local MaxSpeed = 100
        local Speed = 0
        
        local Part = Instance.new("Part", workspace)
        Part.Size = Vector3.new(6, 1, 6)
        Part.Transparency = 1
        Part.Anchored = true
        Part.Name = "FlyPart"
        
        while _G.FlyEnabled do
            local Character = LocalPlayer.Character
            if Character and Character:FindFirstChild("HumanoidRootPart") then
                Part.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0)
                
                if Character:FindFirstChild("Humanoid") then
                    Character.Humanoid.PlatformStand = true
                end
                
                if Character.HumanoidRootPart.Velocity.Y < 0 then
                    Speed = math.min(Speed + 1, MaxSpeed)
                else
                    Speed = 0
                end
                
                if Speed > 0 then
                    Character.HumanoidRootPart.Velocity = Vector3.new(0, Speed, 0)
                end
                
                if Mouse.KeyDown:Connect(function(Key)
                    if Key == "w" then
                        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, -1)
                    elseif Key == "s" then
                        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1)
                    elseif Key == "a" then
                        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(-1, 0, 0)
                    elseif Key == "d" then
                        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(1, 0, 0)
                    elseif Key == "e" then
                        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, 1, 0)
                    elseif Key == "q" then
                        Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, -1, 0)
                    end
                end) then end
            end
            
            wait()
        end
        
        if Part then
            Part:Destroy()
        end
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    else
        print("Fly desactivado")
        -- Código para desactivar Fly
        _G.FlyEnabled = false
        
        local FlyPart = workspace:FindFirstChild("FlyPart")
        if FlyPart then
            FlyPart:Destroy()
        end
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.PlatformStand = false
        end
    end
end)

-- Noclip
local ClippingSection = MovimientoTab:NewSection("Clipping y Teleport")

ClippingSection:NewToggle("Noclip", "Atraviesa paredes y objetos", function(state)
    if state then
        print("Noclip activado")
        -- Código para activar Noclip
        _G.NoclipEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        
        RunService.Stepped:Connect(function()
            if _G.NoclipEnabled and LocalPlayer.Character then
                for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide == true then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        print("Noclip desactivado")
        -- Código para desactivar Noclip
        _G.NoclipEnabled = false
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if LocalPlayer.Character then
            for _, v in pairs(LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") and v.CanCollide == false then
                    v.CanCollide = true
                end
            end
        end
    end
end)

-- Teleport
ClippingSection:NewButton("Teleport a Jugador", "Teleportarse a un jugador seleccionado", function()
    print("Teleport a Jugador presionado")
    -- Código para teleportarse a un jugador
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local PlayerList = {}
    for _, v in pairs(Players:GetPlayers()) do
        if v ~= LocalPlayer then
            table.insert(PlayerList, v.Name)
        end
    end
    
    -- Crear un dropdown para seleccionar el jugador
    local TeleportDropdown = ClippingSection:NewDropdown("Seleccionar Jugador", "Elige a qué jugador teleportarte", PlayerList, function(playerName)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local TargetPlayer = Players:FindFirstChild(playerName)
            if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                LocalPlayer.Character.HumanoidRootPart.CFrame = TargetPlayer.Character.HumanoidRootPart.CFrame
            end
        end
    end)
end)

ClippingSection:NewButton("Teleport a Posición", "Teleportarse a una posición específica", function()
    print("Teleport a Posición presionado")
    -- Código para teleportarse a una posición específica
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Mouse = LocalPlayer:GetMouse()
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p)
    end
end)

-- Otras funciones de movimiento
local OtherMovementSection = MovimientoTab:NewSection("Otras Funciones de Movimiento")

OtherMovementSection:NewToggle("Infinite Jump", "Salta infinitamente sin límites", function(state)
    if state then
        print("Infinite Jump activado")
        -- Código para activar Infinite Jump
        _G.InfiniteJumpEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local UserInputService = game:GetService("UserInputService")
        
        UserInputService.JumpRequest:Connect(function()
            if _G.InfiniteJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        print("Infinite Jump desactivado")
        -- Código para desactivar Infinite Jump
        _G.InfiniteJumpEnabled = false
    end
end)

OtherMovementSection:NewToggle("Auto-Sprint", "Corre automáticamente a máxima velocidad", function(state)
    if state then
        print("Auto-Sprint activado")
        -- Código para activar Auto-Sprint
        _G.AutoSprintEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        
        RunService.RenderStepped:Connect(function()
            if _G.AutoSprintEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                LocalPlayer.Character.Humanoid.WalkSpeed = 32 -- Velocidad de sprint
            end
        end)
    else
        print("Auto-Sprint desactivado")
        -- Código para desactivar Auto-Sprint
        _G.AutoSprintEnabled = false
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = 16 -- Velocidad normal
        end
    end
end)

OtherMovementSection:NewSlider("Gravity Modifier", "Modifica la gravedad del personaje", 200, 0, function(s)
    print("Gravity Modifier ajustado a: " .. s)
    -- Código para modificar la gravedad
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        workspace.Gravity = s
    end
end)


-- Apartado: Visuals
local VisualsTab = PapitaV3:NewTab("Visuals")
local ESPSection = VisualsTab:NewSection("ESP Avanzado")

-- ESP Personalizado
ESPSection:NewToggle("ESP Personalizado", "ESP con opciones avanzadas de personalización", function(state)
    if state then
        print("ESP Personalizado activado")
        -- Código para activar ESP Personalizado
        _G.CustomESPEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        
        local ESPSettings = {
            BoxesEnabled = true,
            BoxesColor = Color3.fromRGB(255, 0, 0),
            NamesEnabled = true,
            NamesColor = Color3.fromRGB(255, 255, 255),
            DistanceEnabled = true,
            DistanceColor = Color3.fromRGB(255, 255, 0),
            TracersEnabled = false,
            TracersColor = Color3.fromRGB(255, 0, 0),
            HealthEnabled = true,
            TeamCheck = false
        }
        
        local ESPObjects = {}
        
        local function CreateESP(player)
            if player == LocalPlayer then return end
            
            local ESP = {}
            
            -- Box ESP
            local BoxOutline = Drawing.new("Square")
            BoxOutline.Visible = ESPSettings.BoxesEnabled
            BoxOutline.Color = Color3.new(0, 0, 0)
            BoxOutline.Thickness = 3
            BoxOutline.Transparency = 1
            BoxOutline.Filled = false
            
            local Box = Drawing.new("Square")
            Box.Visible = ESPSettings.BoxesEnabled
            Box.Color = ESPSettings.BoxesColor
            Box.Thickness = 1
            Box.Transparency = 1
            Box.Filled = false
            
            -- Name ESP
            local NameOutline = Drawing.new("Text")
            NameOutline.Visible = ESPSettings.NamesEnabled
            NameOutline.Color = Color3.new(0, 0, 0)
            NameOutline.Size = 18
            NameOutline.Outline = true
            NameOutline.Center = true
            
            local Name = Drawing.new("Text")
            Name.Visible = ESPSettings.NamesEnabled
            Name.Color = ESPSettings.NamesColor
            Name.Size = 18
            Name.Outline = false
            Name.Center = true
            Name.Text = player.Name
            
            -- Distance ESP
            local DistanceOutline = Drawing.new("Text")
            DistanceOutline.Visible = ESPSettings.DistanceEnabled
            DistanceOutline.Color = Color3.new(0, 0, 0)
            DistanceOutline.Size = 16
            DistanceOutline.Outline = true
            DistanceOutline.Center = true
            
            local Distance = Drawing.new("Text")
            Distance.Visible = ESPSettings.DistanceEnabled
            Distance.Color = ESPSettings.DistanceColor
            Distance.Size = 16
            Distance.Outline = false
            Distance.Center = true
            
            -- Tracer ESP
            local Tracer = Drawing.new("Line")
            Tracer.Visible = ESPSettings.TracersEnabled
            Tracer.Color = ESPSettings.TracersColor
            Tracer.Thickness = 1
            Tracer.Transparency = 1
            
            -- Health ESP
            local HealthOutline = Drawing.new("Line")
            HealthOutline.Visible = ESPSettings.HealthEnabled
            HealthOutline.Color = Color3.new(0, 0, 0)
            HealthOutline.Thickness = 3
            HealthOutline.Transparency = 1
            
            local Health = Drawing.new("Line")
            Health.Visible = ESPSettings.HealthEnabled
            Health.Color = Color3.new(0, 1, 0)
            Health.Thickness = 1
            Health.Transparency = 1
            
            ESP.Box = Box
            ESP.BoxOutline = BoxOutline
            ESP.Name = Name
            ESP.NameOutline = NameOutline
            ESP.Distance = Distance
            ESP.DistanceOutline = DistanceOutline
            ESP.Tracer = Tracer
            ESP.Health = Health
            ESP.HealthOutline = HealthOutline
            ESP.Player = player
            
            ESPObjects[player] = ESP
        end
        
        local function RemoveESP(player)
            if ESPObjects[player] then
                for _, obj in pairs(ESPObjects[player]) do
                    if obj ~= "Player" and obj.Remove then
                        obj:Remove()
                    end
                end
                ESPObjects[player] = nil
            end
        end
        
        local function UpdateESP()
            for player, esp in pairs(ESPObjects) do
                if player and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") and player.Character:FindFirstChild("Head") then
                    local character = player.Character
                    local position, onScreen = workspace.CurrentCamera:WorldToViewportPoint(character.HumanoidRootPart.Position)
                    local distance = (character.HumanoidRootPart.Position - workspace.CurrentCamera.CFrame.Position).Magnitude
                    local teamCheck = ESPSettings.TeamCheck and player.Team == LocalPlayer.Team
                    
                    if onScreen and not teamCheck then
                        -- Update Box ESP
                        local headPosition = workspace.CurrentCamera:WorldToViewportPoint(character.Head.Position)
                        local legPosition = workspace.CurrentCamera:WorldToViewportPoint(character.HumanoidRootPart.Position - Vector3.new(0, 3, 0))
                        
                        local boxSize = Vector2.new(2000 / distance, headPosition.Y - legPosition.Y)
                        local boxPosition = Vector2.new(headPosition.X - boxSize.X / 2, headPosition.Y - boxSize.Y / 2)
                        
                        esp.Box.Size = boxSize
                        esp.Box.Position = boxPosition
                        esp.Box.Visible = ESPSettings.BoxesEnabled
                        
                        esp.BoxOutline.Size = boxSize
                        esp.BoxOutline.Position = boxPosition
                        esp.BoxOutline.Visible = ESPSettings.BoxesEnabled
                        
                        -- Update Name ESP
                        esp.Name.Position = Vector2.new(headPosition.X, headPosition.Y - boxSize.Y / 2 - 16)
                        esp.Name.Visible = ESPSettings.NamesEnabled
                        
                        esp.NameOutline.Position = Vector2.new(headPosition.X, headPosition.Y - boxSize.Y / 2 - 16)
                        esp.NameOutline.Text = player.Name
                        esp.NameOutline.Visible = ESPSettings.NamesEnabled
                        
                        -- Update Distance ESP
                        esp.Distance.Position = Vector2.new(headPosition.X, legPosition.Y + 16)
                        esp.Distance.Text = math.floor(distance) .. " studs"
                        esp.Distance.Visible = ESPSettings.DistanceEnabled
                        
                        esp.DistanceOutline.Position = Vector2.new(headPosition.X, legPosition.Y + 16)
                        esp.DistanceOutline.Text = math.floor(distance) .. " studs"
                        esp.DistanceOutline.Visible = ESPSettings.DistanceEnabled
                        
                        -- Update Tracer ESP
                        esp.Tracer.From = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
                        esp.Tracer.To = Vector2.new(position.X, position.Y)
                        esp.Tracer.Visible = ESPSettings.TracersEnabled
                        
                        -- Update Health ESP
                        local healthPercent = character.Humanoid.Health / character.Humanoid.MaxHealth
                        local healthBarSize = Vector2.new(2, boxSize.Y)
                        local healthBarPosition = Vector2.new(boxPosition.X - 5, boxPosition.Y)
                        
                        esp.HealthOutline.From = Vector2.new(healthBarPosition.X, healthBarPosition.Y)
                        esp.HealthOutline.To = Vector2.new(healthBarPosition.X, healthBarPosition.Y + boxSize.Y)
                        esp.HealthOutline.Visible = ESPSettings.HealthEnabled
                        
                        esp.Health.From = Vector2.new(healthBarPosition.X, healthBarPosition.Y + boxSize.Y - (boxSize.Y * healthPercent))
                        esp.Health.To = Vector2.new(healthBarPosition.X, healthBarPosition.Y + boxSize.Y)
                        esp.Health.Color = Color3.fromRGB(255 - (255 * healthPercent), 255 * healthPercent, 0)
                        esp.Health.Visible = ESPSettings.HealthEnabled
                    else
                        esp.Box.Visible = false
                        esp.BoxOutline.Visible = false
                        esp.Name.Visible = false
                        esp.NameOutline.Visible = false
                        esp.Distance.Visible = false
                        esp.DistanceOutline.Visible = false
                        esp.Tracer.Visible = false
                        esp.Health.Visible = false
                        esp.HealthOutline.Visible = false
                    end
                else
                    RemoveESP(player)
                end
            end
        end
        
        -- Create ESP for existing players
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                CreateESP(player)
            end
        end
        
        -- Handle new players
        Players.PlayerAdded:Connect(function(player)
            CreateESP(player)
        end)
        
        -- Handle players leaving
        Players.PlayerRemoving:Connect(function(player)
            RemoveESP(player)
        end)
        
        -- Update ESP
        RunService.RenderStepped:Connect(function()
            if _G.CustomESPEnabled then
                UpdateESP()
            end
        end)
        
        -- Guardar configuración para uso posterior
        _G.ESPSettings = ESPSettings
    else
        print("ESP Personalizado desactivado")
        -- Código para desactivar ESP Personalizado
        _G.CustomESPEnabled = false
        
        for player, esp in pairs(ESPObjects) do
            RemoveESP(player)
        end
    end
end)

-- Opciones de ESP
ESPSection:NewToggle("Mostrar Cajas", "Muestra cajas alrededor de los jugadores", function(state)
    if _G.ESPSettings then
        _G.ESPSettings.BoxesEnabled = state
    end
end)

ESPSection:NewToggle("Mostrar Nombres", "Muestra los nombres de los jugadores", function(state)
    if _G.ESPSettings then
        _G.ESPSettings.NamesEnabled = state
    end
end)

ESPSection:NewToggle("Mostrar Distancia", "Muestra la distancia a los jugadores", function(state)
    if _G.ESPSettings then
        _G.ESPSettings.DistanceEnabled = state
    end
end)

ESPSection:NewToggle("Mostrar Trazadores", "Muestra líneas hacia los jugadores", function(state)
    if _G.ESPSettings then
        _G.ESPSettings.TracersEnabled = state
    end
end)

ESPSection:NewToggle("Mostrar Salud", "Muestra la salud de los jugadores", function(state)
    if _G.ESPSettings then
        _G.ESPSettings.HealthEnabled = state
    end
end)

ESPSection:NewToggle("Comprobar Equipo", "No muestra ESP para compañeros de equipo", function(state)
    if _G.ESPSettings then
        _G.ESPSettings.TeamCheck = state
    end
end)

-- Chams
local ChamsSection = VisualsTab:NewSection("Chams y Efectos Visuales")

ChamsSection:NewToggle("Chams", "Ver jugadores con colores a través de paredes", function(state)
    if state then
        print("Chams activado")
        -- Código para activar Chams
        _G.ChamsEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        local function ApplyChams(player)
            if player == LocalPlayer then return end
            
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        local chams = Instance.new("BoxHandleAdornment")
                        chams.Name = "Chams"
                        chams.Adornee = part
                        chams.AlwaysOnTop = true
                        chams.ZIndex = 10
                        chams.Size = part.Size
                        chams.Transparency = 0.5
                        chams.Color3 = Color3.fromRGB(255, 0, 0)
                        chams.Parent = part
                    end
                end
            end
        end
        
        local function RemoveChams(player)
            if player.Character then
                for _, part in pairs(player.Character:GetDescendants()) do
                    if part:IsA("BoxHandleAdornment") and part.Name == "Chams" then
                        part:Destroy()
                    end
                end
            end
        end
        
        -- Apply chams to existing players
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                ApplyChams(player)
            end
        end
        
        -- Handle new players
        Players.PlayerAdded:Connect(function(player)
            if _G.ChamsEnabled then
                player.CharacterAdded:Connect(function()
                    wait(1)
                    ApplyChams(player)
                end)
            end
        end)
        
        -- Handle character respawning
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                player.CharacterAdded:Connect(function()
                    if _G.ChamsEnabled then
                        wait(1)
                        ApplyChams(player)
                    end
                end)
            end
        end
    else
        print("Chams desactivado")
        -- Código para desactivar Chams
        _G.ChamsEnabled = false
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                RemoveChams(player)
            end
        end
    end
end)

-- Fullbright
ChamsSection:NewToggle("Fullbright", "Elimina las sombras y oscuridad", function(state)
    if state then
        print("Fullbright activado")
        -- Código para activar Fullbright
        _G.FullbrightEnabled = true
        
        local Lighting = game:GetService("Lighting")
        
        _G.OriginalBrightness = Lighting.Brightness
        _G.OriginalClockTime = Lighting.ClockTime
        _G.OriginalFogEnd = Lighting.FogEnd
        _G.OriginalGlobalShadows = Lighting.GlobalShadows
        
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        
        local function UpdateFullbright()
            if _G.FullbrightEnabled then
                Lighting.Brightness = 2
                Lighting.ClockTime = 14
                Lighting.FogEnd = 100000
                Lighting.GlobalShadows = false
            end
        end
        
        game:GetService("RunService").RenderStepped:Connect(UpdateFullbright)
    else
        print("Fullbright desactivado")
        -- Código para desactivar Fullbright
        _G.FullbrightEnabled = false
        
        local Lighting = game:GetService("Lighting")
        
        Lighting.Brightness = _G.OriginalBrightness or 1
        Lighting.ClockTime = _G.OriginalClockTime or 12
        Lighting.FogEnd = _G.OriginalFogEnd or 10000
        Lighting.GlobalShadows = _G.OriginalGlobalShadows or true
    end
end)

-- Remove Fog/Blur
ChamsSection:NewToggle("Eliminar Niebla/Desenfoque", "Elimina efectos de niebla y desenfoque", function(state)
    if state then
        print("Eliminar Niebla/Desenfoque activado")
        -- Código para eliminar niebla y desenfoque
        _G.NoFogBlurEnabled = true
        
        local Lighting = game:GetService("Lighting")
        
        _G.OriginalFogStart = Lighting.FogStart
        _G.OriginalFogEnd = Lighting.FogEnd
        _G.OriginalFogColor = Lighting.FogColor
        
        Lighting.FogStart = 100000
        Lighting.FogEnd = 100000
        
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        
        Lighting.DescendantAdded:Connect(function(child)
            if _G.NoFogBlurEnabled and (child:IsA("BlurEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") or child:IsA("BloomEffect") or child:IsA("DepthOfFieldEffect")) then
                child.Enabled = false
            end
        end)
    else
        print("Eliminar Niebla/Desenfoque desactivado")
        -- Código para restaurar niebla y desenfoque
        _G.NoFogBlurEnabled = false
        
        local Lighting = game:GetService("Lighting")
        
        Lighting.FogStart = _G.OriginalFogStart or 0
        Lighting.FogEnd = _G.OriginalFogEnd or 10000
        Lighting.FogColor = _G.OriginalFogColor or Color3.fromRGB(192, 192, 192)
        
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = true
            end
        end
    end
end)

-- Custom Crosshair
local CrosshairSection = VisualsTab:NewSection("Crosshair y Trazadores")

CrosshairSection:NewToggle("Custom Crosshair", "Usa un crosshair personalizado", function(state)
    if state then
        print("Custom Crosshair activado")
        -- Código para activar Custom Crosshair
        _G.CustomCrosshairEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        local Camera = workspace.CurrentCamera
        
        -- Crear el crosshair
        local CrosshairParts = {}
        
        -- Línea horizontal
        local HorizontalLine = Drawing.new("Line")
        HorizontalLine.Visible = true
        HorizontalLine.Thickness = 2
        HorizontalLine.Color = Color3.fromRGB(255, 0, 0)
        HorizontalLine.Transparency = 1
        table.insert(CrosshairParts, HorizontalLine)
        
        -- Línea vertical
        local VerticalLine = Drawing.new("Line")
        VerticalLine.Visible = true
        VerticalLine.Thickness = 2
        VerticalLine.Color = Color3.fromRGB(255, 0, 0)
        VerticalLine.Transparency = 1
        table.insert(CrosshairParts, VerticalLine)
        
        -- Círculo central
        local CenterDot = Drawing.new("Circle")
        CenterDot.Visible = true
        CenterDot.Thickness = 0
        CenterDot.NumSides = 12
        CenterDot.Radius = 2
        CenterDot.Filled = true
        CenterDot.Color = Color3.fromRGB(255, 0, 0)
        CenterDot.Transparency = 1
        table.insert(CrosshairParts, CenterDot)
        
        -- Actualizar posición del crosshair
        local function UpdateCrosshair()
            local ViewportSize = Camera.ViewportSize
            local Center = Vector2.new(ViewportSize.X / 2, ViewportSize.Y / 2)
            
            HorizontalLine.From = Vector2.new(Center.X - 10, Center.Y)
            HorizontalLine.To = Vector2.new(Center.X + 10, Center.Y)
            
            VerticalLine.From = Vector2.new(Center.X, Center.Y - 10)
            VerticalLine.To = Vector2.new(Center.X, Center.Y + 10)
            
            CenterDot.Position = Center
        end
        
        -- Actualizar visibilidad del crosshair
        local function UpdateCrosshairVisibility()
            for _, part in pairs(CrosshairParts) do
                part.Visible = _G.CustomCrosshairEnabled
            end
        end
        
        RunService.RenderStepped:Connect(function()
            if _G.CustomCrosshairEnabled then
                UpdateCrosshair()
                UpdateCrosshairVisibility()
            end
        end)
    else
        print("Custom Crosshair desactivado")
        -- Código para desactivar Custom Crosshair
        _G.CustomCrosshairEnabled = false
        
        for _, part in pairs(CrosshairParts) do
            part.Visible = false
        end
    end
end)

-- Bullet Tracers
CrosshairSection:NewToggle("Bullet Tracers", "Muestra trazadores de balas", function(state)
    if state then
        print("Bullet Tracers activado")
        -- Código para activar Bullet Tracers
        _G.BulletTracersEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local RunService = game:GetService("RunService")
        local UserInputService = game:GetService("UserInputService")
        
        local BulletTracers = {}
        local MaxTracers = 10
        
        local function CreateTracer(origin, destination)
            local Tracer = Drawing.new("Line")
            Tracer.Visible = true
            Tracer.Thickness = 2
            Tracer.Color = Color3.fromRGB(255, 0, 0)
            Tracer.Transparency = 1
            Tracer.From = origin
            Tracer.To = destination
            
            table.insert(BulletTracers, 1, {
                Tracer = Tracer,
                Time = tick(),
                Duration = 1
            })
            
            if #BulletTracers > MaxTracers then
                local oldestTracer = table.remove(BulletTracers)
                oldestTracer.Tracer:Remove()
            end
        end
        
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if _G.BulletTracersEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 then
                local Camera = workspace.CurrentCamera
                local MousePosition = UserInputService:GetMouseLocation()
                
                local Ray = Camera:ScreenPointToRay(MousePosition.X, MousePosition.Y)
                local Direction = Ray.Direction * 1000
                local Target = Ray.Origin + Direction
                
                local ViewportPosition = Camera:WorldToViewportPoint(Target)
                
                CreateTracer(Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2), Vector2.new(ViewportPosition.X, ViewportPosition.Y))
            end
        end)
        
        RunService.RenderStepped:Connect(function()
            if _G.BulletTracersEnabled then
                local currentTime = tick()
                
                for i = #BulletTracers, 1, -1 do
                    local tracer = BulletTracers[i]
                    local elapsed = currentTime - tracer.Time
                    
                    if elapsed >= tracer.Duration then
                        tracer.Tracer:Remove()
                        table.remove(BulletTracers, i)
                    else
                        tracer.Tracer.Transparency = 1 - (elapsed / tracer.Duration)
                    end
                end
            end
        end)
    else
        print("Bullet Tracers desactivado")
        -- Código para desactivar Bullet Tracers
        _G.BulletTracersEnabled = false
        
        for _, tracer in pairs(BulletTracers) do
            tracer.Tracer:Remove()
        end
        
        BulletTracers = {}
    end
end)


-- Apartado: Misc (Misceláneos)
local MiscTab = PapitaV3:NewTab("Misc")
local MiscSection = MiscTab:NewSection("Utilidades Generales")

-- Anti-AFK
MiscSection:NewToggle("Anti-AFK", "Evita ser expulsado por inactividad", function(state)
    if state then
        print("Anti-AFK activado")
        -- Código para activar Anti-AFK
        _G.AntiAFKEnabled = true
        
        local VirtualUser = game:GetService("VirtualUser")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        _G.AntiAFKConnection = LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
            print("Anti-AFK: Movimiento simulado para evitar desconexión")
        end)
    else
        print("Anti-AFK desactivado")
        -- Código para desactivar Anti-AFK
        _G.AntiAFKEnabled = false
        
        if _G.AntiAFKConnection then
            _G.AntiAFKConnection:Disconnect()
        end
    end
end)

-- Auto-Respawn
MiscSection:NewToggle("Auto-Respawn", "Reaparece automáticamente al morir", function(state)
    if state then
        print("Auto-Respawn activado")
        -- Código para activar Auto-Respawn
        _G.AutoRespawnEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        _G.AutoRespawnConnection = LocalPlayer.CharacterAdded:Connect(function(character)
            character:WaitForChild("Humanoid").Died:Connect(function()
                if _G.AutoRespawnEnabled then
                    wait(1)
                    LocalPlayer:LoadCharacter()
                end
            end)
        end)
        
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.Died:Connect(function()
                if _G.AutoRespawnEnabled then
                    wait(1)
                    LocalPlayer:LoadCharacter()
                end
            end)
        end
    else
        print("Auto-Respawn desactivado")
        -- Código para desactivar Auto-Respawn
        _G.AutoRespawnEnabled = false
        
        if _G.AutoRespawnConnection then
            _G.AutoRespawnConnection:Disconnect()
        end
    end
end)

-- Chat Spammer
local ChatSection = MiscTab:NewSection("Chat y Servidor")

ChatSection:NewToggle("Chat Spammer", "Envía mensajes automáticamente al chat", function(state)
    if state then
        print("Chat Spammer activado")
        -- Código para activar Chat Spammer
        _G.ChatSpammerEnabled = true
        
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local ChatRemote = ReplicatedStorage:FindFirstChild("SayMessageRequest", true)
        
        local Messages = {
            "Papita v3 - El mejor script para Roblox",
            "Papita v3 - Script premium y épico",
            "Papita v3 - Domina cualquier juego",
            "Papita v3 - Desarrollado por Papita",
            "Papita v3 - La mejor experiencia de hack"
        }
        
        _G.ChatSpammerLoop = coroutine.create(function()
            while _G.ChatSpammerEnabled do
                local randomMessage = Messages[math.random(1, #Messages)]
                
                if ChatRemote then
                    ChatRemote:FireServer(randomMessage, "All")
                else
                    game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar:CaptureFocus()
                    game:GetService("Players").LocalPlayer.PlayerGui.Chat.Frame.ChatBarParentFrame.Frame.BoxFrame.Frame.ChatBar.Text = randomMessage
                    game:GetService("VirtualUser"):SetKeyDown(Enum.KeyCode.Return)
                    game:GetService("VirtualUser"):SetKeyUp(Enum.KeyCode.Return)
                end
                
                wait(5) -- Esperar 5 segundos entre mensajes
            end
        end)
        
        coroutine.resume(_G.ChatSpammerLoop)
    else
        print("Chat Spammer desactivado")
        -- Código para desactivar Chat Spammer
        _G.ChatSpammerEnabled = false
    end
end)

-- Server Crasher
ChatSection:NewButton("Server Crasher", "Intenta crashear el servidor (usar con precaución)", function()
    print("Server Crasher presionado")
    -- Código para intentar crashear el servidor
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    
    local warning = "ADVERTENCIA: Esta función puede resultar en un baneo. ¿Estás seguro de querer continuar?"
    
    local confirmation = MiscTab:NewSection("Confirmación")
    
    confirmation:NewButton("Sí, continuar", "Confirmar Server Crasher", function()
        print("Server Crasher confirmado")
        
        -- Método 1: Spam de eventos remotos
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local remotes = {}
        
        for _, v in pairs(ReplicatedStorage:GetDescendants()) do
            if v:IsA("RemoteEvent") then
                table.insert(remotes, v)
            end
        end
        
        for i = 1, 100 do
            for _, remote in pairs(remotes) do
                spawn(function()
                    for j = 1, 50 do
                        remote:FireServer(string.rep("a", 10000))
                    end
                end)
            end
        end
        
        -- Método 2: Spam de instancias
        spawn(function()
            while wait() do
                for i = 1, 100 do
                    spawn(function()
                        for j = 1, 100 do
                            Instance.new("Part", workspace)
                        end
                    end)
                end
            end
        end)
        
        -- Método 3: Spam de físicas
        spawn(function()
            for i = 1, 100 do
                local part = Instance.new("Part", workspace)
                part.Size = Vector3.new(10, 10, 10)
                part.Position = LocalPlayer.Character.HumanoidRootPart.Position
                part.Anchored = false
                part.CanCollide = true
                
                local attachment = Instance.new("Attachment", part)
                
                local constraint = Instance.new("RopeConstraint", part)
                constraint.Attachment0 = attachment
                constraint.Attachment1 = LocalPlayer.Character.HumanoidRootPart:FindFirstChildOfClass("Attachment") or Instance.new("Attachment", LocalPlayer.Character.HumanoidRootPart)
                constraint.Length = 5
            end
        end)
    end)
    
    confirmation:NewButton("No, cancelar", "Cancelar Server Crasher", function()
        print("Server Crasher cancelado")
    end)
end)

-- FPS Booster
local PerformanceSection = MiscTab:NewSection("Rendimiento")

PerformanceSection:NewButton("FPS Booster", "Optimiza el juego para mejorar FPS", function()
    print("FPS Booster presionado")
    -- Código para optimizar FPS
    
    -- Reducir calidad gráfica
    local UserSettings = UserSettings()
    local RenderSettings = UserSettings.GameSettings
    
    RenderSettings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
    RenderSettings.MasterVolume = 0
    
    -- Desactivar efectos gráficos
    local Lighting = game:GetService("Lighting")
    
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 100000
    Lighting.Brightness = 0
    
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    
    for _, v in pairs(Lighting:GetDescendants()) do
        if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
            v.Enabled = false
        end
    end
    
    -- Eliminar texturas y detalles
    for _, v in pairs(workspace:GetDescendants()) do
        if v:IsA("BasePart") and not v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 0
            v.BlastRadius = 0
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    
    -- Desactivar animaciones de personajes lejanos
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        if player ~= game:GetService("Players").LocalPlayer then
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
            end
        end
    end
    
    -- Mostrar mensaje de éxito
    PerformanceSection:NewLabel("FPS Booster aplicado correctamente")
end)

-- Ping Spoofer
PerformanceSection:NewToggle("Ping Spoofer", "Falsifica tu ping para engañar a los sistemas anti-cheat", function(state)
    if state then
        print("Ping Spoofer activado")
        -- Código para activar Ping Spoofer
        _G.PingSpoofEnabled = true
        
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local Stats = game:GetService("Stats")
        
        local oldPing = Stats.Network.ServerStatsItem["Data Ping"]
        local fakePing = math.random(30, 60) -- Ping falso entre 30ms y 60ms
        
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        setreadonly(mt, false)
        
        mt.__index = newcclosure(function(self, key)
            if _G.PingSpoofEnabled and self == Stats.Network.ServerStatsItem and key == "Data Ping" then
                return fakePing
            end
            return oldIndex(self, key)
        end)
        
        setreadonly(mt, true)
    else
        print("Ping Spoofer desactivado")
        -- Código para desactivar Ping Spoofer
        _G.PingSpoofEnabled = false
    end
end)

-- Auto-Farm
local FarmingSection = MiscTab:NewSection("Farming")

FarmingSection:NewToggle("Auto-Farm", "Farmea automáticamente recursos o experiencia", function(state)
    if state then
        print("Auto-Farm activado")
        -- Código para activar Auto-Farm
        _G.AutoFarmEnabled = true
        
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        
        -- Detectar tipo de juego para aplicar la estrategia adecuada
        local gameId = game.PlaceId
        
        if gameId == 2753915549 or gameId == 4442272183 or gameId == 7449423635 then
            -- Blox Fruits
            FarmingSection:NewLabel("Blox Fruits detectado")
            
            _G.AutoFarmLoop = coroutine.create(function()
                while _G.AutoFarmEnabled do
                    -- Buscar enemigos cercanos
                    local nearestMob = nil
                    local shortestDistance = math.huge
                    
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                            
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestMob = v
                            end
                        end
                    end
                    
                    if nearestMob and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Teleportarse al enemigo
                        LocalPlayer.Character.HumanoidRootPart.CFrame = nearestMob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        
                        -- Atacar
                        local args = {
                            [1] = nearestMob.HumanoidRootPart.Position
                        }
                        
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Combat", "Farm", args)
                    end
                    
                    wait(0.1)
                end
            end)
            
            coroutine.resume(_G.AutoFarmLoop)
        elseif gameId == 6284583030 or gameId == 10321372166 or gameId == 6284583030 then
            -- Pet Simulator X
            FarmingSection:NewLabel("Pet Simulator X detectado")
            
            _G.AutoFarmLoop = coroutine.create(function()
                while _G.AutoFarmEnabled do
                    -- Buscar coins cercanos
                    local nearestCoin = nil
                    local shortestDistance = math.huge
                    
                    for _, v in pairs(workspace["__THINGS"].Coins:GetChildren()) do
                        if v:FindFirstChild("Coin") and v:FindFirstChild("Coin").Position then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude
                            
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestCoin = v
                            end
                        end
                    end
                    
                    if nearestCoin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Teleportarse a la moneda
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nearestCoin.Coin.Position)
                        
                        -- Recolectar
                        local args = {
                            [1] = nearestCoin.Name
                        }
                        
                        game:GetService("ReplicatedStorage").Network.Coins.CollectCoin:FireServer(unpack(args))
                    end
                    
                    wait(0.1)
                end
            end)
            
            coroutine.resume(_G.AutoFarmLoop)
        else
            -- Auto-farm genérico
            FarmingSection:NewLabel("Auto-farm genérico activado")
            
            _G.AutoFarmLoop = coroutine.create(function()
                while _G.AutoFarmEnabled do
                    -- Buscar partes con nombres comunes de coleccionables
                    local collectibleNames = {"Coin", "Gem", "Orb", "Diamond", "Cash", "Money", "XP", "Experience"}
                    local nearestCollectible = nil
                    local shortestDistance = math.huge
                    
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") then
                            for _, name in pairs(collectibleNames) do
                                if string.find(string.lower(v.Name), string.lower(name)) then
                                    local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
                                    
                                    if distance < shortestDistance and distance < 100 then
                                        shortestDistance = distance
                                        nearestCollectible = v
                                    end
                                    
                                    break
                                end
                            end
                        end
                    end
                    
                    if nearestCollectible and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Teleportarse al coleccionable
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nearestCollectible.Position)
                        
                        -- Esperar a que se recoja
                        wait(0.5)
                    else
                        -- Si no hay coleccionables, moverse aleatoriamente
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            local randomOffset = Vector3.new(math.random(-10, 10), 0, math.random(-10, 10))
                            LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(randomOffset)
                        end
                        
                        wait(1)
                    end
                end
            end)
            
            coroutine.resume(_G.AutoFarmLoop)
        end
    else
        print("Auto-Farm desactivado")
        -- Código para desactivar Auto-Farm
        _G.AutoFarmEnabled = false
    end
end)


-- Apartado: Juegos Específicos
local JuegosTab = PapitaV3:NewTab("Juegos")

-- Detectar juego actual
local gameId = game.PlaceId
local gameName = "Juego Desconocido"

-- Mapeo de IDs de juegos populares
local gameIds = {
    [286090429] = "Arsenal",
    [292439477] = "Phantom Forces",
    [2753915549] = "Blox Fruits",
    [4442272183] = "Blox Fruits",
    [7449423635] = "Blox Fruits",
    [6284583030] = "Pet Simulator X",
    [10321372166] = "Pet Simulator X",
    [3956818381] = "Ninja Legends",
    [4616652839] = "Shindo Life",
    [6299805723] = "Anime Fighters Simulator",
    [2788229376] = "Da Hood",
    [3101667897] = "Legends Of Speed",
    [6872265039] = "BedWars",
    [6872274481] = "BedWars",
    [8542275097] = "BedWars",
    [8542275583] = "BedWars",
    [6872265039] = "BedWars",
    [6872274481] = "BedWars",
    [142823291] = "Murder Mystery 2",
    [621129760] = "KAT",
    [1962086868] = "Tower of Hell",
    [3527629287] = "Big Paintball",
    [4924922222] = "Brookhaven RP",
    [2041312716] = "Ragdoll Engine",
    [537413528] = "Build A Boat For Treasure",
    [5326405001] = "Jail Break"
}

-- Obtener nombre del juego
if gameIds[gameId] then
    gameName = gameIds[gameId]
else
    -- Intentar obtener el nombre del juego desde MarketplaceService
    local success, result = pcall(function()
        return game:GetService("MarketplaceService"):GetProductInfo(gameId).Name
    end)
    
    if success then
        gameName = result
    end
end

-- Sección para el juego actual
local CurrentGameSection = JuegosTab:NewSection("Juego Actual: " .. gameName)

-- Funciones específicas según el juego
if gameName == "Arsenal" then
    CurrentGameSection:NewToggle("Aimbot Arsenal", "Aimbot específico para Arsenal", function(state)
        if state then
            print("Aimbot Arsenal activado")
            -- Código específico para Arsenal
            _G.ArsenalAimbotEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            local RunService = game:GetService("RunService")
            
            local function GetClosestPlayer()
                local MaxDistance = math.huge
                local Target = nil
                
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= LocalPlayer.Team then
                        local Position, Visible = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        if Visible then
                            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                            
                            if Distance < MaxDistance then
                                MaxDistance = Distance
                                Target = v
                            end
                        end
                    end
                end
                
                return Target
            end
            
            RunService.RenderStepped:Connect(function()
                if _G.ArsenalAimbotEnabled then
                    local Target = GetClosestPlayer()
                    if Target then
                        Camera.CFrame = CFrame.new(Camera.CFrame.Position, Target.Character.Head.Position)
                    end
                end
            end)
        else
            print("Aimbot Arsenal desactivado")
            -- Código para desactivar
            _G.ArsenalAimbotEnabled = false
        end
    end)
    
    CurrentGameSection:NewToggle("ESP Arsenal", "ESP específico para Arsenal", function(state)
        if state then
            print("ESP Arsenal activado")
            -- Código específico para Arsenal
            _G.ArsenalESPEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v.Team ~= LocalPlayer.Team then
                    local BillboardGui = Instance.new("BillboardGui")
                    local TextLabel = Instance.new("TextLabel")
                    
                    BillboardGui.Parent = v.Character.HumanoidRootPart
                    BillboardGui.AlwaysOnTop = true
                    BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                    BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    BillboardGui.Name = "ArsenalESP"
                    
                    TextLabel.Parent = BillboardGui
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                    TextLabel.Text = v.Name
                    TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    TextLabel.TextScaled = true
                end
            end
        else
            print("ESP Arsenal desactivado")
            -- Código para desactivar
            _G.ArsenalESPEnabled = false
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BillboardGui") and v.Name == "ArsenalESP" then
                    v:Destroy()
                end
            end
        end
    end)
    
    CurrentGameSection:NewToggle("Wallbang Arsenal", "Dispara a través de paredes en Arsenal", function(state)
        if state then
            print("Wallbang Arsenal activado")
            -- Código específico para Arsenal
            _G.ArsenalWallbangEnabled = true
            
            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if method == "FireServer" and self.Name == "RemoteEvent" and args[1] == "createparticle" and _G.ArsenalWallbangEnabled then
                    args[2] = "bullethole"
                    return oldNamecall(self, unpack(args))
                end
                
                return oldNamecall(self, ...)
            end)
            
            setreadonly(mt, true)
        else
            print("Wallbang Arsenal desactivado")
            -- Código para desactivar
            _G.ArsenalWallbangEnabled = false
        end
    end)
    
elseif gameName == "Blox Fruits" then
    CurrentGameSection:NewToggle("Auto Farm Blox Fruits", "Farmea automáticamente en Blox Fruits", function(state)
        if state then
            print("Auto Farm Blox Fruits activado")
            -- Código específico para Blox Fruits
            _G.BloxFruitsAutoFarmEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            _G.BloxFruitsAutoFarmLoop = coroutine.create(function()
                while _G.BloxFruitsAutoFarmEnabled do
                    -- Buscar enemigos cercanos
                    local nearestMob = nil
                    local shortestDistance = math.huge
                    
                    for _, v in pairs(workspace.Enemies:GetChildren()) do
                        if v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Humanoid.Health > 0 then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.HumanoidRootPart.Position).Magnitude
                            
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestMob = v
                            end
                        end
                    end
                    
                    if nearestMob and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Teleportarse al enemigo
                        LocalPlayer.Character.HumanoidRootPart.CFrame = nearestMob.HumanoidRootPart.CFrame * CFrame.new(0, 5, 0)
                        
                        -- Atacar
                        local args = {
                            [1] = nearestMob.HumanoidRootPart.Position
                        }
                        
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Combat", "Farm", args)
                    end
                    
                    wait(0.1)
                end
            end)
            
            coroutine.resume(_G.BloxFruitsAutoFarmLoop)
        else
            print("Auto Farm Blox Fruits desactivado")
            -- Código para desactivar
            _G.BloxFruitsAutoFarmEnabled = false
        end
    end)
    
    CurrentGameSection:NewToggle("Auto Collect Fruits", "Recoge frutas automáticamente", function(state)
        if state then
            print("Auto Collect Fruits activado")
            -- Código específico para recoger frutas
            _G.AutoCollectFruitsEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            _G.AutoCollectFruitsLoop = coroutine.create(function()
                while _G.AutoCollectFruitsEnabled do
                    -- Buscar frutas en el workspace
                    for _, v in pairs(workspace:GetChildren()) do
                        if string.find(v.Name, "Fruit") and v:IsA("Tool") then
                            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                LocalPlayer.Character.HumanoidRootPart.CFrame = v.Handle.CFrame
                                wait(1)
                                v.Handle.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame
                            end
                        end
                    end
                    
                    wait(1)
                end
            end)
            
            coroutine.resume(_G.AutoCollectFruitsLoop)
        else
            print("Auto Collect Fruits desactivado")
            -- Código para desactivar
            _G.AutoCollectFruitsEnabled = false
        end
    end)
    
elseif gameName == "Pet Simulator X" then
    CurrentGameSection:NewToggle("Auto Farm Coins", "Farmea monedas automáticamente", function(state)
        if state then
            print("Auto Farm Coins activado")
            -- Código específico para Pet Simulator X
            _G.PetSimXAutoFarmEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            _G.PetSimXAutoFarmLoop = coroutine.create(function()
                while _G.PetSimXAutoFarmEnabled do
                    -- Buscar coins cercanos
                    local nearestCoin = nil
                    local shortestDistance = math.huge
                    
                    for _, v in pairs(workspace["__THINGS"].Coins:GetChildren()) do
                        if v:FindFirstChild("Coin") and v:FindFirstChild("Coin").Position then
                            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.Coin.Position).Magnitude
                            
                            if distance < shortestDistance then
                                shortestDistance = distance
                                nearestCoin = v
                            end
                        end
                    end
                    
                    if nearestCoin and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Teleportarse a la moneda
                        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(nearestCoin.Coin.Position)
                        
                        -- Recolectar
                        local args = {
                            [1] = nearestCoin.Name
                        }
                        
                        game:GetService("ReplicatedStorage").Network.Coins.CollectCoin:FireServer(unpack(args))
                    end
                    
                    wait(0.1)
                end
            end)
            
            coroutine.resume(_G.PetSimXAutoFarmLoop)
        else
            print("Auto Farm Coins desactivado")
            -- Código para desactivar
            _G.PetSimXAutoFarmEnabled = false
        end
    end)
    
    CurrentGameSection:NewToggle("Auto Hatch Eggs", "Abre huevos automáticamente", function(state)
        if state then
            print("Auto Hatch Eggs activado")
            -- Código específico para abrir huevos
            _G.AutoHatchEggsEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            -- Dropdown para seleccionar el huevo
            local eggTypes = {"Basic Egg", "Rare Egg", "Epic Egg", "Legendary Egg", "Mythical Egg"}
            local selectedEgg = eggTypes[1]
            
            CurrentGameSection:NewDropdown("Seleccionar Huevo", "Elige el huevo a abrir", eggTypes, function(egg)
                selectedEgg = egg
            end)
            
            _G.AutoHatchEggsLoop = coroutine.create(function()
                while _G.AutoHatchEggsEnabled do
                    -- Abrir huevo
                    local args = {
                        [1] = selectedEgg,
                        [2] = 1 -- Cantidad
                    }
                    
                    game:GetService("ReplicatedStorage").Network.Eggs.OpenEgg:InvokeServer(unpack(args))
                    
                    wait(1)
                end
            end)
            
            coroutine.resume(_G.AutoHatchEggsLoop)
        else
            print("Auto Hatch Eggs desactivado")
            -- Código para desactivar
            _G.AutoHatchEggsEnabled = false
        end
    end)
    
else
    -- Scripts genéricos para otros juegos
    CurrentGameSection:NewLabel("Scripts genéricos para " .. gameName)
    
    CurrentGameSection:NewToggle("ESP Universal", "ESP que funciona en la mayoría de juegos", function(state)
        if state then
            print("ESP Universal activado")
            -- Código para ESP universal
            _G.UniversalESPEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                    local BillboardGui = Instance.new("BillboardGui")
                    local TextLabel = Instance.new("TextLabel")
                    
                    BillboardGui.Parent = v.Character.HumanoidRootPart
                    BillboardGui.AlwaysOnTop = true
                    BillboardGui.Size = UDim2.new(0, 50, 0, 50)
                    BillboardGui.StudsOffset = Vector3.new(0, 3, 0)
                    BillboardGui.Name = "UniversalESP"
                    
                    TextLabel.Parent = BillboardGui
                    TextLabel.BackgroundTransparency = 1
                    TextLabel.Size = UDim2.new(1, 0, 1, 0)
                    TextLabel.Text = v.Name
                    TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    TextLabel.TextScaled = true
                end
            end
        else
            print("ESP Universal desactivado")
            -- Código para desactivar
            _G.UniversalESPEnabled = false
            
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BillboardGui") and v.Name == "UniversalESP" then
                    v:Destroy()
                end
            end
        end
    end)
    
    CurrentGameSection:NewToggle("Auto Click", "Hace clic automáticamente (útil para juegos de clicker)", function(state)
        if state then
            print("Auto Click activado")
            -- Código para Auto Click
            _G.AutoClickEnabled = true
            
            _G.AutoClickLoop = coroutine.create(function()
                while _G.AutoClickEnabled do
                    game:GetService("VirtualUser"):ClickButton1(Vector2.new(500, 500))
                    wait(0.1)
                end
            end)
            
            coroutine.resume(_G.AutoClickLoop)
        else
            print("Auto Click desactivado")
            -- Código para desactivar
            _G.AutoClickEnabled = false
        end
    end)
end

-- Categorías de juegos populares
local PopularGamesSection = JuegosTab:NewSection("Juegos Populares")

PopularGamesSection:NewButton("Arsenal", "Cargar scripts para Arsenal", function()
    print("Scripts de Arsenal cargados")
    
    local ArsenalSection = JuegosTab:NewSection("Arsenal Scripts")
    
    ArsenalSection:NewToggle("Aimbot", "Aimbot para Arsenal", function(state)
        if state then
            print("Aimbot Arsenal activado")
            -- Código para Aimbot de Arsenal
        else
            print("Aimbot Arsenal desactivado")
        end
    end)
    
    ArsenalSection:NewToggle("ESP", "ESP para Arsenal", function(state)
        if state then
            print("ESP Arsenal activado")
            -- Código para ESP de Arsenal
        else
            print("ESP Arsenal desactivado")
        end
    end)
    
    ArsenalSection:NewToggle("Silent Aim", "Silent Aim para Arsenal", function(state)
        if state then
            print("Silent Aim Arsenal activado")
            -- Código para Silent Aim de Arsenal
        else
            print("Silent Aim Arsenal desactivado")
        end
    end)
end)

PopularGamesSection:NewButton("Blox Fruits", "Cargar scripts para Blox Fruits", function()
    print("Scripts de Blox Fruits cargados")
    
    local BloxFruitsSection = JuegosTab:NewSection("Blox Fruits Scripts")
    
    BloxFruitsSection:NewToggle("Auto Farm", "Auto Farm para Blox Fruits", function(state)
        if state then
            print("Auto Farm Blox Fruits activado")
            -- Código para Auto Farm de Blox Fruits
        else
            print("Auto Farm Blox Fruits desactivado")
        end
    end)
    
    BloxFruitsSection:NewToggle("Auto Raid", "Auto Raid para Blox Fruits", function(state)
        if state then
            print("Auto Raid Blox Fruits activado")
            -- Código para Auto Raid de Blox Fruits
        else
            print("Auto Raid Blox Fruits desactivado")
        end
    end)
    
    BloxFruitsSection:NewToggle("Devil Fruit ESP", "Devil Fruit ESP para Blox Fruits", function(state)
        if state then
            print("Devil Fruit ESP Blox Fruits activado")
            -- Código para Devil Fruit ESP de Blox Fruits
        else
            print("Devil Fruit ESP Blox Fruits desactivado")
        end
    end)
end)

PopularGamesSection:NewButton("Adopt Me", "Cargar scripts para Adopt Me", function()
    print("Scripts de Adopt Me cargados")
    
    local AdoptMeSection = JuegosTab:NewSection("Adopt Me Scripts")
    
    AdoptMeSection:NewToggle("Auto Farm Money", "Auto Farm Money para Adopt Me", function(state)
        if state then
            print("Auto Farm Money Adopt Me activado")
            -- Código para Auto Farm Money de Adopt Me
        else
            print("Auto Farm Money Adopt Me desactivado")
        end
    end)
    
    AdoptMeSection:NewToggle("Auto Hatch Eggs", "Auto Hatch Eggs para Adopt Me", function(state)
        if state then
            print("Auto Hatch Eggs Adopt Me activado")
            -- Código para Auto Hatch Eggs de Adopt Me
        else
            print("Auto Hatch Eggs Adopt Me desactivado")
        end
    end)
end)

-- Apartado: Ajustes
local AjustesTab = PapitaV3:NewTab("Ajustes")
local UISection = AjustesTab:NewSection("Personalización de la Interfaz")

-- Temas
UISection:NewDropdown("Tema", "Cambia el tema del panel", {"DarkCrimson", "BloodTheme", "DragonsBreath", "Midnight", "Ocean", "Serpent", "Synapse", "GrapeTheme", "DarkTheme", "LightTheme"}, function(currentOption)
    print("Tema cambiado a: " .. currentOption)
    
    -- Código para cambiar el tema
    local themeStyles = {
        DarkCrimson = {
            SchemeColor = Color3.fromRGB(139, 0, 0),
            Background = Color3.fromRGB(10, 10, 10),
            Header = Color3.fromRGB(20, 0, 0),
            TextColor = Color3.fromRGB(220, 20, 60),
            ElementColor = Color3.fromRGB(30, 0, 0)
        },
        BloodTheme = {
            SchemeColor = Color3.fromRGB(227, 27, 27),
            Background = Color3.fromRGB(10, 10, 10),
            Header = Color3.fromRGB(5, 5, 5),
            TextColor = Color3.fromRGB(255, 255, 255),
            ElementColor = Color3.fromRGB(20, 20, 20)
        },
        DragonsBreath = {
            SchemeColor = Color3.fromRGB(255, 0, 0),
            Background = Color3.fromRGB(20, 20, 20),
            Header = Color3.fromRGB(30, 0, 0),
            TextColor = Color3.fromRGB(255, 255, 255),
            ElementColor = Color3.fromRGB(40, 0, 0)
        },
        Midnight = {
            SchemeColor = Color3.fromRGB(26, 189, 158),
            Background = Color3.fromRGB(44, 62, 82),
            Header = Color3.fromRGB(57, 81, 105),
            TextColor = Color3.fromRGB(255, 255, 255),
            ElementColor = Color3.fromRGB(52, 74, 95)
        },
        Ocean = {
            SchemeColor = Color3.fromRGB(86, 76, 251),
            Background = Color3.fromRGB(26, 32, 58),
            Header = Color3.fromRGB(38, 45, 71),
            TextColor = Color3.fromRGB(200, 200, 200),
            ElementColor = Color3.fromRGB(38, 45, 71)
        },
        Serpent = {
            SchemeColor = Color3.fromRGB(0, 166, 58),
            Background = Color3.fromRGB(31, 41, 43),
            Header = Color3.fromRGB(22, 29, 31),
            TextColor = Color3.fromRGB(255, 255, 255),
            ElementColor = Color3.fromRGB(22, 29, 31)
        },
        Synapse = {
            SchemeColor = Color3.fromRGB(46, 48, 43),
            Background = Color3.fromRGB(13, 15, 12),
            Header = Color3.fromRGB(36, 38, 35),
            TextColor = Color3.fromRGB(152, 99, 53),
            ElementColor = Color3.fromRGB(24, 24, 24)
        },
        GrapeTheme = {
            SchemeColor = Color3.fromRGB(166, 71, 214),
            Background = Color3.fromRGB(64, 50, 71),
            Header = Color3.fromRGB(36, 28, 41),
            TextColor = Color3.fromRGB(255, 255, 255),
            ElementColor = Color3.fromRGB(74, 58, 84)
        },
        DarkTheme = {
            SchemeColor = Color3.fromRGB(64, 64, 64),
            Background = Color3.fromRGB(0, 0, 0),
            Header = Color3.fromRGB(0, 0, 0),
            TextColor = Color3.fromRGB(255, 255, 255),
            ElementColor = Color3.fromRGB(20, 20, 20)
        },
        LightTheme = {
            SchemeColor = Color3.fromRGB(150, 150, 150),
            Background = Color3.fromRGB(255, 255, 255),
            Header = Color3.fromRGB(200, 200, 200),
            TextColor = Color3.fromRGB(0, 0, 0),
            ElementColor = Color3.fromRGB(224, 224, 224)
        }
    }
    
    -- Cambiar el tema
    if themeStyles[currentOption] then
        for prop, color in pairs(themeStyles[currentOption]) do
            PapitaV3:ChangeColor(prop, color)
        end
    end
end)

-- Keybinds
local KeybindsSection = AjustesTab:NewSection("Keybinds (Teclas de Acceso Rápido)")

KeybindsSection:NewKeybind("Abrir/Cerrar UI", "Abre o cierra el panel", Enum.KeyCode.RightControl, function()
    PapitaV3:ToggleUI()
end)

KeybindsSection:NewKeybind("Activar Aimbot", "Activa o desactiva el aimbot", Enum.KeyCode.F, function()
    -- Código para activar/desactivar aimbot
    if _G.AimbotEnabled then
        _G.AimbotEnabled = false
        print("Aimbot desactivado por keybind")
    else
        _G.AimbotEnabled = true
        print("Aimbot activado por keybind")
    end
end)

KeybindsSection:NewKeybind("Activar ESP", "Activa o desactiva el ESP", Enum.KeyCode.E, function()
    -- Código para activar/desactivar ESP
    if _G.CustomESPEnabled then
        _G.CustomESPEnabled = false
        print("ESP desactivado por keybind")
    else
        _G.CustomESPEnabled = true
        print("ESP activado por keybind")
    end
end)

-- Opciones de rendimiento
local PerformanceSection = AjustesTab:NewSection("Opciones de Rendimiento")

PerformanceSection:NewToggle("Modo de Bajo Rendimiento", "Reduce la calidad gráfica para mejorar el rendimiento", function(state)
    if state then
        print("Modo de Bajo Rendimiento activado")
        -- Código para activar modo de bajo rendimiento
        local UserSettings = UserSettings()
        local RenderSettings = UserSettings.GameSettings
        
        RenderSettings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
        RenderSettings.MasterVolume = 0
        
        local Lighting = game:GetService("Lighting")
        
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 100000
        Lighting.Brightness = 0
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        
        for _, v in pairs(Lighting:GetDescendants()) do
            if v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("ColorCorrectionEffect") or v:IsA("BloomEffect") or v:IsA("DepthOfFieldEffect") then
                v.Enabled = false
            end
        end
        
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") and not v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 0
                v.BlastRadius = 0
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = Enum.Material.SmoothPlastic
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
    else
        print("Modo de Bajo Rendimiento desactivado")
        -- Código para desactivar modo de bajo rendimiento
        local UserSettings = UserSettings()
        local RenderSettings = UserSettings.GameSettings
        
        RenderSettings.SavedQualityLevel = Enum.SavedQualitySetting.Automatic
        
        local Lighting = game:GetService("Lighting")
        
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 10000
        Lighting.Brightness = 1
        
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level10
    end
end)

-- Opciones de seguridad
local SecuritySection = AjustesTab:NewSection("Opciones de Seguridad")

SecuritySection:NewToggle("Anti-Ban", "Intenta evitar ser baneado (no garantizado)", function(state)
    if state then
        print("Anti-Ban activado")
        -- Código para activar Anti-Ban
        _G.AntiBanEnabled = true
        
        -- Método 1: Ocultar variables globales
        local mt = getrawmetatable(game)
        local oldIndex = mt.__index
        setreadonly(mt, false)
        
        mt.__index = newcclosure(function(self, key)
            if key == "_G" or key == "shared" or key == "getrawmetatable" or key == "hookfunction" or key == "hookmetamethod" or key == "setreadonly" then
                return nil
            end
            return oldIndex(self, key)
        end)
        
        setreadonly(mt, true)
        
        -- Método 2: Ocultar scripts en ejecución
        for _, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
            v:Disable()
        end
        
        -- Método 3: Desactivar telemetría
        for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
            v:Disable()
        end
        
        -- Método 4: Ocultar GUI
        game:GetService("CoreGui").ChildAdded:Connect(function(child)
            if child.Name == LibName then
                child.Name = "RobloxGui" .. math.random(1, 100000)
            end
        end)
    else
        print("Anti-Ban desactivado")
        -- Código para desactivar Anti-Ban
        _G.AntiBanEnabled = false
    end
end)

SecuritySection:NewToggle("Modo Sigiloso", "Oculta el script de otros jugadores y moderadores", function(state)
    if state then
        print("Modo Sigiloso activado")
        -- Código para activar Modo Sigiloso
        _G.StealthModeEnabled = true
        
        -- Ocultar GUI
        game:GetService("CoreGui")[LibName].Name = "RobloxGui" .. math.random(1, 100000)
        
        -- Reducir rastros
        for _, v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
            v:Disable()
        end
        
        -- Desactivar logs
        for _, v in pairs(getconnections(game:GetService("LogService").MessageOut)) do
            v:Disable()
        end
    else
        print("Modo Sigiloso desactivado")
        -- Código para desactivar Modo Sigiloso
        _G.StealthModeEnabled = false
    end
end)

-- Guardar/Cargar configuraciones
local ConfigSection = AjustesTab:NewSection("Configuraciones")

ConfigSection:NewButton("Guardar Configuración", "Guarda la configuración actual", function()
    print("Guardar Configuración presionado")
    -- Código para guardar configuración
    local config = {
        AimbotEnabled = _G.AimbotEnabled or false,
        ESPEnabled = _G.CustomESPEnabled or false,
        SpeedHackEnabled = _G.SpeedHackEnabled or false,
        SpeedMultiplier = _G.SpeedMultiplier or 2,
        FlyEnabled = _G.FlyEnabled or false,
        NoclipEnabled = _G.NoclipEnabled or false,
        InfiniteJumpEnabled = _G.InfiniteJumpEnabled or false,
        AutoSprintEnabled = _G.AutoSprintEnabled or false,
        FullbrightEnabled = _G.FullbrightEnabled or false,
        NoFogBlurEnabled = _G.NoFogBlurEnabled or false,
        CustomCrosshairEnabled = _G.CustomCrosshairEnabled or false,
        BulletTracersEnabled = _G.BulletTracersEnabled or false,
        AntiAFKEnabled = _G.AntiAFKEnabled or false,
        AutoRespawnEnabled = _G.AutoRespawnEnabled or false,
        ChatSpammerEnabled = _G.ChatSpammerEnabled or false,
        PingSpoofEnabled = _G.PingSpoofEnabled or false,
        AutoFarmEnabled = _G.AutoFarmEnabled or false,
        AntiBanEnabled = _G.AntiBanEnabled or false,
        StealthModeEnabled = _G.StealthModeEnabled or false
    }
    
    local HttpService = game:GetService("HttpService")
    local configJson = HttpService:JSONEncode(config)
    
    writefile("PapitaV3Config.json", configJson)
    
    ConfigSection:NewLabel("Configuración guardada correctamente")
end)

ConfigSection:NewButton("Cargar Configuración", "Carga una configuración guardada", function()
    print("Cargar Configuración presionado")
    -- Código para cargar configuración
    if isfile("PapitaV3Config.json") then
        local HttpService = game:GetService("HttpService")
        local config = HttpService:JSONDecode(readfile("PapitaV3Config.json"))
        
        -- Aplicar configuración
        _G.AimbotEnabled = config.AimbotEnabled or false
        _G.CustomESPEnabled = config.ESPEnabled or false
        _G.SpeedHackEnabled = config.SpeedHackEnabled or false
        _G.SpeedMultiplier = config.SpeedMultiplier or 2
        _G.FlyEnabled = config.FlyEnabled or false
        _G.NoclipEnabled = config.NoclipEnabled or false
        _G.InfiniteJumpEnabled = config.InfiniteJumpEnabled or false
        _G.AutoSprintEnabled = config.AutoSprintEnabled or false
        _G.FullbrightEnabled = config.FullbrightEnabled or false
        _G.NoFogBlurEnabled = config.NoFogBlurEnabled or false
        _G.CustomCrosshairEnabled = config.CustomCrosshairEnabled or false
        _G.BulletTracersEnabled = config.BulletTracersEnabled or false
        _G.AntiAFKEnabled = config.AntiAFKEnabled or false
        _G.AutoRespawnEnabled = config.AutoRespawnEnabled or false
        _G.ChatSpammerEnabled = config.ChatSpammerEnabled or false
        _G.PingSpoofEnabled = config.PingSpoofEnabled or false
        _G.AutoFarmEnabled = config.AutoFarmEnabled or false
        _G.AntiBanEnabled = config.AntiBanEnabled or false
        _G.StealthModeEnabled = config.StealthModeEnabled or false
        
        ConfigSection:NewLabel("Configuración cargada correctamente")
    else
        ConfigSection:NewLabel("No se encontró ninguna configuración guardada")
    end
end)

-- Apartado: Premium
local PremiumTab = PapitaV3:NewTab("Premium")
local PremiumInfoSection = PremiumTab:NewSection("Información Premium")

PremiumInfoSection:NewLabel("Papita v3 Premium")
PremiumInfoSection:NewLabel("Desarrollado por Papita")
PremiumInfoSection:NewLabel("Versión: 1.0")

-- Verificar si el usuario es premium
local isPremium = true -- Cambiar a false para usuarios no premium

if isPremium then
    PremiumInfoSection:NewLabel("Estado: Usuario Premium")
    
    -- Funciones exclusivas para usuarios premium
    local ExclusiveSection = PremiumTab:NewSection("Funciones Exclusivas")
    
    ExclusiveSection:NewToggle("Silent Aim Avanzado", "Apunta automáticamente sin mover la cámara", function(state)
        if state then
            print("Silent Aim Avanzado activado")
            -- Código para activar Silent Aim Avanzado
            _G.SilentAimEnabled = true
            
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Camera = workspace.CurrentCamera
            
            local function GetClosestPlayer()
                local MaxDistance = math.huge
                local Target = nil
                
                for _, v in pairs(Players:GetPlayers()) do
                    if v ~= LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                        local Position, Visible = Camera:WorldToScreenPoint(v.Character.HumanoidRootPart.Position)
                        if Visible then
                            local Distance = (Vector2.new(Position.X, Position.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                            
                            if Distance < MaxDistance then
                                MaxDistance = Distance
                                Target = v
                            end
                        end
                    end
                end
                
                return Target
            end
            
            local mt = getrawmetatable(game)
            local oldNamecall = mt.__namecall
            setreadonly(mt, false)
            
            mt.__namecall = newcclosure(function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                
                if method == "FireServer" and self.Name == "RemoteEvent" and _G.SilentAimEnabled then
                    local Target = GetClosestPlayer()
                    if Target then
                        args[1] = Target.Character.Head.Position
                    end
                    return oldNamecall(self, unpack(args))
                end
                
                return oldNamecall(self, ...)
            end)
            
            setreadonly(mt, true)
        else
            print("Silent Aim Avanzado desactivado")
            -- Código para desactivar Silent Aim Avanzado
            _G.SilentAimEnabled = false
        end
    end)
    
    ExclusiveSection:NewToggle("Exploits Avanzados", "Accede a exploits avanzados", function(state)
        if state then
            print("Exploits Avanzados activado")
            -- Código para activar Exploits Avanzados
            _G.AdvancedExploitsEnabled = true
            
            local AdvancedExploitsSection = PremiumTab:NewSection("Exploits Avanzados")
            
            AdvancedExploitsSection:NewToggle("Godmode", "Te hace invencible", function(state)
                if state then
                    print("Godmode activado")
                    -- Código para activar Godmode
                    _G.GodmodeEnabled = true
                    
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    
                    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                        local oldHealth = LocalPlayer.Character.Humanoid.Health
                        
                        LocalPlayer.Character.Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                            if _G.GodmodeEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                                if LocalPlayer.Character.Humanoid.Health < oldHealth then
                                    LocalPlayer.Character.Humanoid.Health = oldHealth
                                else
                                    oldHealth = LocalPlayer.Character.Humanoid.Health
                                end
                            end
                        end)
                    end
                else
                    print("Godmode desactivado")
                    -- Código para desactivar Godmode
                    _G.GodmodeEnabled = false
                end
            end)
            
            AdvancedExploitsSection:NewToggle("Infinite Cash", "Dinero infinito (en juegos compatibles)", function(state)
                if state then
                    print("Infinite Cash activado")
                    -- Código para activar Infinite Cash
                    _G.InfiniteCashEnabled = true
                    
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    
                    -- Intentar diferentes métodos según el juego
                    if LocalPlayer:FindFirstChild("leaderstats") then
                        for _, v in pairs(LocalPlayer.leaderstats:GetChildren()) do
                            if v.Name:lower():match("money") or v.Name:lower():match("cash") or v.Name:lower():match("coin") or v.Name:lower():match("gem") then
                                local mt = getrawmetatable(game)
                                local oldIndex = mt.__index
                                setreadonly(mt, false)
                                
                                mt.__index = newcclosure(function(self, key)
                                    if self == v and key == "Value" and _G.InfiniteCashEnabled then
                                        return 999999999
                                    end
                                    return oldIndex(self, key)
                                end)
                                
                                setreadonly(mt, true)
                                break
                            end
                        end
                    end
                else
                    print("Infinite Cash desactivado")
                    -- Código para desactivar Infinite Cash
                    _G.InfiniteCashEnabled = false
                end
            end)
            
            AdvancedExploitsSection:NewToggle("Teleport a Cualquier Lugar", "Teleportarse a cualquier lugar del mapa", function(state)
                if state then
                    print("Teleport a Cualquier Lugar activado")
                    -- Código para activar Teleport a Cualquier Lugar
                    _G.TeleportAnywhereEnabled = true
                    
                    local Players = game:GetService("Players")
                    local LocalPlayer = Players.LocalPlayer
                    local Mouse = LocalPlayer:GetMouse()
                    
                    Mouse.Button1Down:Connect(function()
                        if _G.TeleportAnywhereEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Mouse.Hit.p)
                        end
                    end)
                else
                    print("Teleport a Cualquier Lugar desactivado")
                    -- Código para desactivar Teleport a Cualquier Lugar
                    _G.TeleportAnywhereEnabled = false
                end
            end)
        else
            print("Exploits Avanzados desactivado")
            -- Código para desactivar Exploits Avanzados
            _G.AdvancedExploitsEnabled = false
        end
    end)
    
    ExclusiveSection:NewToggle("Scripts Exclusivos", "Accede a scripts exclusivos para usuarios premium", function(state)
        if state then
            print("Scripts Exclusivos activado")
            -- Código para activar Scripts Exclusivos
            _G.ExclusiveScriptsEnabled = true
            
            local ExclusiveScriptsSection = PremiumTab:NewSection("Scripts Exclusivos")
            
            ExclusiveScriptsSection:NewButton("Script Exclusivo 1", "Ejecuta el script exclusivo 1", function()
                print("Script Exclusivo 1 ejecutado")
                -- Código para ejecutar script exclusivo 1
                loadstring(game:HttpGet("https://example.com/exclusive_script1.lua"))()
            end)
            
            ExclusiveScriptsSection:NewButton("Script Exclusivo 2", "Ejecuta el script exclusivo 2", function()
                print("Script Exclusivo 2 ejecutado")
                -- Código para ejecutar script exclusivo 2
                loadstring(game:HttpGet("https://example.com/exclusive_script2.lua"))()
            end)
            
            ExclusiveScriptsSection:NewButton("Script Exclusivo 3", "Ejecuta el script exclusivo 3", function()
                print("Script Exclusivo 3 ejecutado")
                -- Código para ejecutar script exclusivo 3
                loadstring(game:HttpGet("https://example.com/exclusive_script3.lua"))()
            end)
        else
            print("Scripts Exclusivos desactivado")
            -- Código para desactivar Scripts Exclusivos
            _G.ExclusiveScriptsEnabled = false
        end
    end)
    
    ExclusiveSection:NewToggle("Actualizaciones Prioritarias", "Recibe actualizaciones antes que los demás usuarios", function(state)
        if state then
            print("Actualizaciones Prioritarias activado")
            -- Código para activar Actualizaciones Prioritarias
            _G.PriorityUpdatesEnabled = true
            
            -- Verificar actualizaciones
            local HttpService = game:GetService("HttpService")
            local success, result = pcall(function()
                return HttpService:JSONDecode(game:HttpGet("https://example.com/papita_v3_updates.json"))
            end)
            
            if success then
                local currentVersion = "1.0"
                local latestVersion = result.latestVersion
                
                if latestVersion > currentVersion then
                    local UpdateSection = PremiumTab:NewSection("Actualización Disponible")
                    
                    UpdateSection:NewLabel("Nueva versión disponible: " .. latestVersion)
                    UpdateSection:NewLabel("Notas de la actualización:")
                    UpdateSection:NewLabel(result.updateNotes)
                    
                    UpdateSection:NewButton("Actualizar Ahora", "Actualiza a la última versión", function()
                        print("Actualizar Ahora presionado")
                        -- Código para actualizar
                        loadstring(game:HttpGet("https://example.com/papita_v3_latest.lua"))()
                    end)
                else
                    local UpdateSection = PremiumTab:NewSection("Actualización")
                    UpdateSection:NewLabel("Ya tienes la última versión")
                end
            end
        else
            print("Actualizaciones Prioritarias desactivado")
            -- Código para desactivar Actualizaciones Prioritarias
            _G.PriorityUpdatesEnabled = false
        end
    end)
else
    PremiumInfoSection:NewLabel("Estado: Usuario No Premium")
    PremiumInfoSection:NewLabel("Actualiza a Premium para desbloquear todas las funciones")
    
    PremiumInfoSection:NewButton("Actualizar a Premium", "Actualiza tu cuenta a Premium", function()
        print("Actualizar a Premium presionado")
        -- Código para mostrar información de actualización
        local UpgradeSection = PremiumTab:NewSection("Actualizar a Premium")
        
        UpgradeSection:NewLabel("Beneficios Premium:")
        UpgradeSection:NewLabel("- Silent Aim Avanzado")
        UpgradeSection:NewLabel("- Exploits Avanzados (Godmode, Infinite Cash, etc.)")
        UpgradeSection:NewLabel("- Scripts Exclusivos")
        UpgradeSection:NewLabel("- Actualizaciones Prioritarias")
        UpgradeSection:NewLabel("- Soporte Premium")
        
        UpgradeSection:NewButton("Obtener Premium", "Visita nuestro sitio web para obtener Premium", function()
            print("Obtener Premium presionado")
            -- Código para abrir sitio web
            setclipboard("https://example.com/papita_v3_premium")
            UpgradeSection:NewLabel("Enlace copiado al portapapeles")
        end)
    end)
end

-- Inicialización y configuración final
print("Papita v3 cargado correctamente")
print("Desarrollado por Papita")
print("Versión: 1.0")

