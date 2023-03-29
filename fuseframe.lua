getgenv().statdeck = "SaswareForTheeW-000004"
game:HttpGet(string.format("https://statsdeck.hypernite.xyz/API/deckit?public_key=%s&exploit=%s&user=%s", getgenv().statdeck, (syn and not is_sirhurt_closure and not pebc_execute and "syn") or (OXYGEN_LOADED and "oxy") or (KRNL_LOADED and "krnl") or (gethui and "sw") or (fluxus and fluxus.request and "flux") or (is_comet_function and "comet") or ("uns"), game.Players.LocalPlayer.Name))

local isLGPremium = true
local function isLGPremium()
    return true
end

-- uselessly overcomplicate instead of working on the actual code?? yes.
local SupportedGames = {}
SupportedGames["Refinery Caves"] = 8726743209
SupportedGames["Life Sentence"] = 8726743209

CurrentGame = "Unknown"

if game.PlaceId == 8726743209 then
    CurrentGame = "Refinery Caves"
end

-- if tonumber(os.date("%d",os.time()-24*60*60)) > 21 then
--     game.Players.LocalPlayer:Kick("Trial expired. Sorry!")
-- end

-- < Load in and assign services. >

local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- < Load in and assign services. />


-- < Allocate instance paths to variables. >

local Hash = 523502443733188633
local InteractRemote = workspace.Map.Buildings.UCS.Other.DeliveryJob.IPart.Interact
local Grabbables = workspace.Grabable
local LocalPlayer = game.Players.LocalPlayer
local Players = game.Players
--local NightSky = game.Lighting.NightSky
local CustomTPPos = LocalPlayer.Character.HumanoidRootPart.CFrame
local DialogFrame = LocalPlayer.PlayerGui.UserGui.Dialog
local Mouse = LocalPlayer:GetMouse()
local Events = ReplicatedStorage.Events
local Myplot
repeat
    wait()
    for _,v in next, game:GetService("Workspace").Plots:GetChildren() do
        if v.Owner and v.Owner.Value == LocalPlayer then
            Myplot = v.Base
        end
    end
until Myplot ~= nil

local ESPTable = {}

-- < Allocate instance paths to variables. />


-- < Allocate miscellaneous startup variables. >

local Startup = tick()
local SelectedFurnace = nil
local Debug = false
local Version = "2.1.1"

-- < Allocate miscellaneous startup variables. />


-- -- < Initialize connections. >
local owochan = LocalPlayer.Character:FindFirstChild("OwoChan Character")
if owochan:FindFirstChild("Main") then
    owochan.Main:Destroy()
end

LocalPlayer.CharacterAdded:Connect(function(character)
    character.ChildAdded:Connect(function(v)
        if v.Name == "OwoChan Character" and v:FindFirstChild("Main") then
            wait()
            v.Main:Destroy()
        end
    end)
end)
print("Owochan Deleted!")
-- for i,v in pairs(getconnections(LocalPlayer.Character.Humanoid.Changed)) do
--     v:Disable()
-- end

-- local SeatWeld = Instance.new("Weld",game:GetService("Workspace").Map.Sky)
-- SeatWeld.Name = "SeatWeld"
-- SeatWeld.Part0 = game:GetService("Workspace").Map.Sky
-- SeatWeld.Part1 = LocalPlayer.Character.HumanoidRootPart
-- SeatWeld.Enabled = false

-- < Initialize connections. />                                                                                                                                                                                     made by sashaa/centerepic sashaa#5351

local function CoreNotify(Title : string,Subtitle : string,Duration : number)
    local CoreGui = game:GetService("CoreGui")
    local CorePackages = game:GetService("CorePackages")
    
    local UIBlox = getrenv().require(CorePackages.UIBlox)
    
    UIBlox.init()

    local StylePalette = getrenv().require(CorePackages.AppTempCommon.LuaApp.Style.StylePalette)
    local stylePalette = StylePalette.new()
    stylePalette:updateTheme("dark")
    stylePalette:updateFont("gotham")

    local Roact = getrenv().require(CorePackages.Roact)
    local Images = getrenv().require(CorePackages.Packages._Index.UIBlox.UIBlox.App.ImageSet.Images)
    
    local Gui = Roact.createElement("ScreenGui", {IgnoreGuiInset = true,ZIndexBehavior = Enum.ZIndexBehavior.Global}, {Gui = Roact.createElement(UIBlox.Core.Style.Provider, {style = stylePalette}, {Toast = Roact.createElement(UIBlox.App.Dialog.Toast, {toastContent = {toastTitle = Title or "Title",toastSubtitle = Subtitle or "Subtitle",iconImage = Images['icons/status/warning']}})})})
    
    Roact.mount(Gui, CoreGui, "InternalStuff")

    wait(Duration or 3)

    game:GetService("CoreGui").InternalStuff:Destroy()
end

local function Set3D(State)
    game:GetService("RunService"):Set3dRenderingEnabled(State)
end

local Welds = {}

task.spawn(function()
    for _,v in pairs(workspace.Plots:GetDescendants()) do
        if v.Name == "Welds" and v:IsA("Folder") then
            for _,x in pairs(v:GetChildren()) do
                table.insert(Welds,x)
            end
        end
    end
end)

local function IsWelded(Model)

    for _,v in next,Welds do
        if v:IsDescendantOf(Model) then
            return true
        end
    end

    for _,v in next,Model:GetDescendants() do
        if v.Name == "__ThatWeld" then
            return true
        end
    end
    
    return false
end

local function GetLighterColor(Color)
    local H, S, V = Color3.toHSV(Color);
    return Color3.fromHSV(H, S, V * 5);
end

local function Grab(Bool : boolean, Part : BasePart)
    task.spawn(function()
        if Bool == true then
            Part.Velocity = Vector3.new(0,1,0)
            Events.Grab:InvokeServer(Part, {}) 
        elseif Bool == false then
            Events.Ungrab:FireServer(Part, false, {})
        end
    end)
end

local function table_count(tt : table, item : string)
    local count
    count = 0
    for ii,xx in next, tt do
      if item == xx then count = count + 1 end
    end
    return count
  end

local function BetterRound(num : number, numDecimalPlaces : number)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local function BeatWait()
    RunService.Heartbeat:Wait()
end

local function TP(Position : CFrame)

    if typeof(Position) == "Instance" then
        Position = Position.CFrame
    end

    if typeof(Position) == "Vector3" then
        Position = CFrame.new(Position)
    end
    
    if typeof(Position) == "CFrame" then
        LocalPlayer.Character:PivotTo(Position)
    else
        warn("[!] Invalid Argument Passed to TP()")
    end
    
end

local function TP2(Position)

    if typeof(Position) == "Instance" then
        Position = Position.CFrame
    end

    if typeof(Position) == "Vector3" then
        Position = CFrame.new(Position)
    end
    
    if typeof(Position) == "CFrame" then
        Set3D(false)
        TP(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(0,2000,0))
        wait()
        TP(Position + Vector3.new(0,2000,0))
        wait()
        --TP(CFrame.new(5.58793545e-09, -3.40282347e+38, -1.39698386e-09, 0, 0, -1, 0))
        wait()
        TP(Position)
        Set3D(true)
    else
        warn("[!] Invalid Argument Passed to TP2()")
    end

end

local function TTP(Position : CFrame)

    if typeof(Position) == "Instance" then
        Position = Position.CFrame
    end

    if typeof(Position) == "Vector3" then
        Position = CFrame.new(Position)
    end

    if typeof(Position) ~= "CFrame" then
        warn("[!] Invalid Argument Passed to TTP()")
    else
        local OP = LocalPlayer.Character.HumanoidRootPart.Position
        local TTW = (OP - Position.Position).Magnitude / 15
    
        if TTW < 2 then
            TP(Position)
        else
            local Tween =  TweenService:Create(LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(TTW),{CFrame = Position})
            Tween:Play()
            Tween.Completed:Wait()
        end
    end
    
end;

local function TeleportGrabbable(Instance : Model,TargetPosition : CFrame,StoreItem : boolean, OreOnly : boolean)
    if Debug then
        print("Teleporting grabbable "..Instance.Name,TargetPosition,"StoreItem - ",StoreItem)
    end

    if Instance and TargetPosition and not StoreItem and not IsWelded(Instance) then
        
        if Instance.Name == "MaterialPart" and Instance:FindFirstChild("Owner") and Instance.Owner.Value == LocalPlayer and Instance.Part.Material ~= Enum.Material.Neon then
        
            -- local IsFar = true

            -- if (Instance.Part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 15 then
            --     IsFar = false
            -- end

            -- if IsFar == true then
            --     --TTP(Instance.Part)
            -- end

            -- if Toggles.TeleportMethod.Value == true and IsFar == true then
            --     task.wait(0.15)
            -- end

            Grab(true,Instance.Part)

            --task.wait()

            Instance:PivotTo(TargetPosition)

        elseif not OreOnly and (Instance:FindFirstChild("Owner") and Instance.Owner.Value == LocalPlayer and Instance:FindFirstChildOfClass("BasePart")) then
            Grab(true,Instance:FindFirstChildOfClass("BasePart"))
            Instance:PivotTo(TargetPosition)
        end

    elseif Instance and Instance:FindFirstChildOfClass("BasePart") and Instance:IsA("Model") and TargetPosition and StoreItem and not IsWelded(Instance) then
        local OP = LocalPlayer.Character.HumanoidRootPart.CFrame

        local GrabPart = Instance:FindFirstChildOfClass("BasePart")
        
        if Instance:FindFirstChild("Shop") then

            --TTP(GrabPart)
            Grab(true,GrabPart)

            local Tween = TweenService:Create(LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(1),{CFrame = TargetPosition + Vector3.new(5,0,0)})
            Tween:Play()

            repeat BeatWait()
                GrabPart:PivotTo(LocalPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(2,0,0))
            until Tween.PlaybackState == Enum.PlaybackState.Completed
            
            Instance:PivotTo(TargetPosition + Vector3.new(0,2,0))
        end

    end
end

local function IsOwned(Instance)
    if Instance.Owner.Value == LocalPlayer then
        return true
    end
    return false
end

local GetStoreItemAttempts = 0

local function GetStoreItem(Name : string)
    local Model = nil
    for _,v in next, Grabbables:GetChildren() do
        if v:FindFirstChild("Shop") and v.Name == Name then
            Model = v
        end
    end
    if Model then
        GetStoreItemAttempts = 0
        return Model
    elseif GetStoreItemAttempts < 1200 then
        GetStoreItemAttempts += 1
        BeatWait()
        return(GetStoreItem(Name))
    else
        return error("Timeout for finding Store Item.")
    end
end

local RefinedOreNames = {''}

local function IsRefined(Ore : Model)
    
end

local function GetClosestPart(tables)
    local Distances = {}
    for i,v in next, tables do
        Distances[i] = LocalPlayer:DistanceFromCharacter(v.Position)
    end
    local BestDistance = math.huge
    local Closest
    for i,v in next, Distances do
        if v < BestDistance then
            BestDistance = v
            Closest = tables[i]
        end
    end
    return Closest
end

local t = tostring(tick())

local Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/centerepic/RefineryCaves/main/library.lua?t='..t))()
local ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/32e2058fcd7eae8b677dbe799eef1445e9c88b8e/addons/ThemeManager.lua?t='..t))()
local SaveManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/wally-rblx/LinoriaLib/32e2058fcd7eae8b677dbe799eef1445e9c88b8e/addons/SaveManager.lua?t='..t))()

local Window 

if isLGPremium and isLGPremium() then
Window = Library:CreateWindow({
    Title = 'FuseFrame v'..Version.." | Refinery Caves GUI",
    Center = true, 
    AutoShow = true,
})
else
Window = Library:CreateWindow({
    Title = 'FuseFrame v'..Version.." | Refinery Caves GUI",
    Center = true, 
    AutoShow = true,
})
end

local Tabs = {
    Main = Window:AddTab('Main'),
    Automation = Window:AddTab('AutoFarm'),
	Dupe = Window:AddTab('Dupe'),
	Hub = Window:AddTab('Other'),
    UISettings = Window:AddTab('UI Settings')
}

local TargetPart

local Hitboxes = {}

-- < Define Coroutines. >

local function GetBlueprint(...)
    if not LocalPlayer.Values.Blueprints:FindFirstChild(...) then
        local BlueprintValue = Instance.new("BoolValue", LocalPlayer.Values.Blueprints)
        BlueprintValue.Value = true
        BlueprintValue.Name = (...)
    end
end

if isLGPremium and isLGPremium() then

    OwnershipESPCoro = coroutine.create(function()

    for i,v in ipairs(workspace.Grabable:GetChildren()) do
        if v:FindFirstChild("Owner") then
            ESPIfy(v)
        end
    end

    Grabbables.ChildAdded:Connect(function(Child)
        wait()
        if Child:FindFirstChild("Owner") then
            ESPIfy(Child)
        end
    end)

    Toggles.OwnerESP:OnChanged(function()
        for i,v in pairs(ESPTable) do
            v.Visible = Toggles.OwnerESP.Value
        end
    end)

end)

end

local AutoMineCoro = coroutine.create(function()
    while task.wait(0.8) do
        pcall(function()
            if Toggles.MineAura.Value == true and LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                
                Hitboxes = {}
                
                for i,v in next, game:GetService("Workspace").WorldSpawn:GetChildren() do
                    if v:FindFirstChild("Part") and not v:FindFirstChild("Stage1") then
                        table.insert(Hitboxes,v.Part)
                    end
                end

                local RockChosen
                RockChosen = GetClosestPart(Hitboxes).Parent

                local RockChosen = RockChosen.Rock:FindFirstChildOfClass("Model"):FindFirstChild("Part")

                TargetPart = RockChosen

                for i,v in next, LocalPlayer.Character:GetChildren() do
                    if v:IsA("Tool") and v.Name:find("Pickaxe") then
                        v:Activate()
                    end
                end

            end
        end)
    end
end)

local ModDetectionCoro = coroutine.create(function()
    for i,Player in pairs(game:GetService("Players"):GetPlayers()) do
        if Player:IsInGroup(9486589) and Player:GetRoleInGroup(9486589):lower() ~= "common" then
            CoreNotify("Moderator detected!","Consider finishing whatever you are doing and leaving.",5)
        end
    end
    Players.PlayerAdded:Connect(function(Player)
        if Player:IsInGroup(9486589) and Player:GetRoleInGroup(9486589):lower() ~= "common" then
            CoreNotify("Moderator detected!","Consider finishing whatever you are doing and leaving.",5)
        end
    end)
end)

local VehicleSpawners = {}

for i,v in next, Myplot.Parent.Objects:GetChildren() do
    if v.Name:find("Spawner") then
        if not table.find(VehicleSpawners,v.Name) then
            table.insert(VehicleSpawners, v.Name)
        end
    end
end

local AutoNeonCarCoro = coroutine.create(function()
    while wait(1) do
        if Toggles.AutoNeon.Value == true then
            local IsShiny = false

            for i,_ in pairs(Options.SelectedSpawners1.Value) do
                if Toggles.AutoNeon.Value == true then

                    if Debug then print("Spawning car(s) of type",i) end

                    local ActualSpawners = {}

                    for _,s in pairs(Myplot.Parent.Objects:GetChildren()) do
                        if s.Name == i then
                            table.insert(ActualSpawners,s)
                        end
                    end

                    if Debug then print(#ActualSpawners,"valid spawners found.") end

                    for _,rs in pairs(ActualSpawners) do
                        if Toggles.AutoNeon.Value == true then
                            for _,x in pairs(workspace.Vehicles:GetChildren()) do
                                if x:FindFirstChild("Configuration") and x:FindFirstChild("Configuration"):FindFirstChild("Data") and x:FindFirstChild("Configuration"):FindFirstChild("Data"):FindFirstChild("id") and x.Configuration.Data.id.Value == rs.Configuration.Data.id.Value and x.Configuration.Data.Shiny.Value == true then
                                    IsShiny = true
                                end
                            end
            
                            if IsShiny == false then
                                rs.Hitbox.Interact:FireServer()
                            end
            
                            IsShiny = false

                            wait(3/#ActualSpawners)
                        end
                    end
                end
            end
        end
    end
end)

local IdleMoneyCoro = coroutine.create(function()
    while wait(11) do
        pcall(function()
            if Toggles.IdleIncome.Value == true then
                game:GetService("ReplicatedStorage").Events.TransferCash:FireServer(LocalPlayer,0.5)
            end
        end)
    end
end)

local LoopMoneyCoro = coroutine.create(function()
    while wait(11) do
        if Toggles.LoopMoney.Value == true and Players[Options.MoneyUsername.Value] then
            local args = {
                [1] = Players[Options.MoneyUsername.Value],
                [2] = 100000
            }
            
            game:GetService("ReplicatedStorage").Events.TransferCash:FireServer(unpack(args))            
        end
    end
end)

local AutoOreTeleportCoro = coroutine.create(function()

    Grabbables.ChildAdded:Connect(function(Child)
        if Toggles.AutoOreTeleport.Value == true then
            for _,v in next, game:GetService("Workspace").Plots:GetChildren() do
                if v.Owner and v.Owner.Value == LocalPlayer then
                    Myplot = v.Base
                end
            end
            wait()
            if Child.Name == "MaterialPart" and Child.Part and (Child.Part.Position - Myplot.Position).Magnitude > Myplot.Size.X then
                if Child:FindFirstChild("Owner") and Child.Owner.Value == LocalPlayer then
                    TeleportGrabbable(Child,Myplot.CFrame + Vector3.new(0,3,0),false)
                    task.delay(3,function()
                        Grab(false,Child.Part)
                    end)
                end
            end
        end
        if Toggles.CAutoOreTeleport.Value == true then
            for _,v in next, game:GetService("Workspace").Plots:GetChildren() do
                if v.Owner and v.Owner.Value == LocalPlayer then
                    Myplot = v.Base
                end
            end
            wait()
            if Child.Name == "MaterialPart" and Child.Part and (Child.Part.Position - Myplot.Position).Magnitude > Myplot.Size.X then
                if Child:FindFirstChild("Owner") and Child.Owner.Value == LocalPlayer then
                    TeleportGrabbable(Child,CustomTPPos,false)
                    task.delay(3,function()
                        Grab(false,Child.Part)
                    end)
                end
            end
        end
        if Toggles.AutoOreRefine.Value == true and SelectedFurnace then
            wait()
            if Child.Name == "MaterialPart" and Child.Part and (Child.Part.Position - Myplot.Position).Magnitude > Myplot.Size.X then
                if Child:FindFirstChild("Owner") and Child.Owner.Value == LocalPlayer then
                    TeleportGrabbable(Child,(SelectedFurnace.CFrame + SelectedFurnace.CFrame.LookVector.Unit * 5),false)
                    firetouchinterest(Child.Part,SelectedFurnace,0)
                    wait()
                    firetouchinterest(Child.Part,SelectedFurnace,1)

                    task.delay(3,function()
                        Grab(false,Child.Part)
                    end)
                end
            end
        end
    end)

    
end)

--local LastOrePosition = Vector3.new(0,0,0)

if isLGPremium and isLGPremium() then
AutoOreCoro = coroutine.create(function()
    while wait() do
        pcall(function()
            local TTE
            if Toggles.OreAutoFarm.Value == true and Options.OreDropdown.Value ~= nil then
                for OreString,fs in pairs(Options.OreDropdown.Value) do
                    for _,Node in next, workspace.WorldSpawn:GetChildren() do
                        if (Toggles.OreAutoFarm.Value == true and Options.OreDropdown.Value ~= nil) and Node.RockString and Node.RockString.Value == OreString and (Node.Rock:FindFirstChild("Stage2") or Node.Rock:FindFirstChild("Stage3")) then
                            local Spored = false

                            for i,v in next, Node:GetDescendants() do
                                if v:IsA("Highlight") then
                                    Spored = true
                                end
                            end

                            --TTP(Node.Part.Position + Vector3.new(0,3,0))

                            if not Spored then
                                for _,Ore in next, Node.Rock:FindFirstChildOfClass("Model"):GetChildren() do

                                    if (Toggles.OreAutoFarm.Value == true and Options.OreDropdown.Value ~= nil) and Ore.Name ~= 'Hitbox' and Ore.Name ~= 'Bedrock' then
                                        repeat
                                        task.wait()

                                        TargetPart = Ore

                                        Ore.CanCollide = false
                                        Ore.Transparency = 1
                                        Ore.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2,6,0)

                                        -- ttw = 1 * math.abs((LastOrePosition - Ore.Position).Magnitude)/80
                                        -- if ttw > 2 and Toggles.OreAutoFarm.Value == true and LastOrePosition ~= Vector3.new(0,0,0) then
                                        --     Library:Notify("Waiting for serverside cooldown... ("..tostring(BetterRound(ttw,2)).." seconds)",3)
                                        --     wait(ttw)
                                        -- end

                                        --LastOrePosition = Node.Part.Position

                                        -- anticheat bypass if they implement checks for this

                                        if not LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                                            for _,Tool in next, LocalPlayer.Backpack:GetChildren() do
                                                if Tool.Name:find("Pickaxe") then
                                                    if TTE ~= nil then
                                                        if Tool.Configuration and Tool.Configuration.Tier and Tool.Configuration.Tier.Value > TTE.Configuration.Tier.Value then
                                                            TTE = Tool
                                                        end
                                                    else
                                                        TTE = Tool
                                                    end
                                                end
                                            end
                                            pcall(function()
                                                TTE.RedOutline.SelectionBox.Visible = false
                                            end)
                                            LocalPlayer.Character.Humanoid:EquipTool(TTE)
                                        end

                                        LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                                        
                                        for i,v in next, Node:GetDescendants() do
                                            if v:IsA("Highlight") then
                                                Spored = true
                                            end
                                        end
                                        
                                        until
                                        Ore.Parent ~= Node.Rock:FindFirstChildOfClass("Model") or (Toggles.OreAutoFarm.Value == false or Options.OreDropdown.Value == nil) or Spored == true
                                        pcall(function()
                                            TTE.RedOutline.SelectionBox.Visible = true
                                        end)
                                    end
                                end
                            end
                        end
                    end
                end
                TargetPart = nil
            --else
                --LastOrePosition = Vector3.new(0,0,0)
            end
        end)
    end
end)
end


-- local OrePackCoro = coroutine.create(function()
--     OrePack = {}
    
-- end)

-- broken unfinished code above (shield your eyes)

-- < Define Coroutines. />


-- < Configure UI (Create tabs, toggles, etc.) >

local OreTeleports = Tabs.Main:AddLeftGroupbox('Ore Utilities')
-- OreTeleports:AddToggle('TeleportMethod', {
--     Text = 'Old Teleport Method',
--     Default = false,
--     Tooltip = 'Uses a slower, more stable method to teleport ores.',
-- })

-- OreTeleports:AddButton('Teleport all owned ores to player', function()
--     local OP = LocalPlayer.Character.HumanoidRootPart.CFrame

--     task.spawn(function()
--         for i,v in pairs(workspace:GetDescendants()) do
--             if v.Name == "Welds" and v:IsA("Folder") then
--                 for i,x in pairs(v:GetChildren()) do
--                     table.insert(Welds,x)
--                 end
--             end
--         end
--     end)

--     for i = 4,1,-1 do
--         wait(0.1)
--         local GrabbablesCache = {}

--             for _,v in ipairs(Grabbables:GetChildren()) do
--                 if v:FindFirstChild("Part") then
--                     table.insert(GrabbablesCache,v)
--                 end
--             end

--             table.sort(GrabbablesCache,function(a,b)
--                 return (a.Part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < (b.Part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
--             end)

--             for _,v in ipairs(GrabbablesCache) do
--                 TeleportGrabbable(v,OP + Vector3.new(0,3,0),false,true)
--             end

--     end
-- end)

local MaxStuds = 30

local function OreTeleport(Area,NoUp)
    for i = 4,1,-1 do
        for _,v in pairs(workspace.Grabable:GetChildren()) do
            local owner = v:FindFirstChild("Owner")
            if v:FindFirstChild("Part") and ((owner and (owner.Value == game.Players.LocalPlayer))) and not IsWelded(v) then
                if v.Name == "MaterialPart" and (v.Part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= MaxStuds then
                    Grab(true,v.Part)
                    if not NoUp then
                        Area = Area + Vector3.new(0,2,0)
                    end
                    v:PivotTo(CFrame.new(Area))
                end
            end
        end
        wait()
    end
end   

local function EntityTeleport(Area)
    for i = 4,1,-1 do
        for _,v in pairs(workspace.Grabable:GetChildren()) do
            local owner = v:FindFirstChild("Owner")
            if v:FindFirstChildOfClass("Part") and ((owner and (owner.Value == game.Players.LocalPlayer))) and not IsWelded(v) then
                if v.Name ~= "MaterialPart" and (v:FindFirstChildOfClass("Part").Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= MaxStuds then
                    Grab(true,v:FindFirstChildOfClass("Part"))
                    Area = Area + Vector3.new(0,2,0)
                    v:PivotTo(CFrame.new(Area))
                end
            end
        end
        wait()
    end
end   

OreTeleports:AddButton('Save current location', function()
    CustomTPPos = LocalPlayer.Character.HumanoidRootPart.CFrame
end)

OreTeleports:AddButton('Teleport nearby ores to saved position', function()
    Welds = {}
    task.spawn(function()
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == "Welds" and v:IsA("Folder") then
                for i,x in pairs(v:GetChildren()) do
                    table.insert(Welds,x)
                end
            end
        end
    end)
    OreTeleport(CustomTPPos.Position)
end)

OreTeleports:AddButton('Teleport nearby ores to plot', function()
    -- Welds = {}
    -- task.spawn(function()
    --     for i,v in pairs(workspace:GetDescendants()) do
    --         if v.Name == "Welds" and v:IsA("Folder") then
    --             for i,x in pairs(v:GetChildren()) do
    --                 table.insert(Welds,x)
    --             end
    --         end
    --     end
    -- end)
    OreTeleport(Myplot.Position,false)
end)

OreTeleports:AddButton('Teleport nearby entities to plot', function()
    Welds = {}
    task.spawn(function()
        for i,v in pairs(workspace:GetDescendants()) do
            if v.Name == "Welds" and v:IsA("Folder") then
                for i,x in pairs(v:GetChildren()) do
                    table.insert(Welds,x)
                end
            end
        end
    end)
    EntityTeleport(Myplot.Position)
end)

OreTeleports:AddButton('Refine nearby ores', function()
    -- Welds = {}
    -- task.spawn(function()
    --     for i,v in pairs(workspace:GetDescendants()) do
    --         if v.Name == "Welds" and v:IsA("Folder") then
    --             for i,x in pairs(v:GetChildren()) do
    --                 table.insert(Welds,x)
    --             end
    --         end
    --     end
    -- end)
    OreTeleport((SelectedFurnace.CFrame - SelectedFurnace.CFrame.LookVector.Unit * 2).Position,true)
end)

OreTeleports:AddToggle('MineAura', {
    Text = 'Mine aura',
    Default = false,
    Tooltip = 'Automatically mines ores around you',
})


OreTeleports:AddToggle('AutoOreTeleport', {
    Text = 'Automatically Teleport Ores',
    Default = false,
    Tooltip = 'Automatically teleports ores to your plot when you mine them.',
})

OreTeleports:AddToggle('CAutoOreTeleport', {
    Text = 'Auto TP Ores to Saved Position',
    Default = false,
    Tooltip = 'Automatically teleports ores to your position when you mine them.',
})

OreTeleports:AddToggle('AutoOreRefine', {
    Text = 'Automatically Refine Ores',
    Default = false,
    Tooltip = 'Automatically teleports ores to your smelter.',
})

-- < Make sure 2 autofarms aren't enabled at once. >

Toggles.AutoOreTeleport:OnChanged(function()
    if Toggles.AutoOreTeleport.Value == true and Toggles.AutoOreRefine.Value == true then
        Toggles.AutoOreRefine:SetValue(false)
    end
end)

Toggles.AutoOreRefine:OnChanged(function()
    if Toggles.AutoOreRefine.Value == true and Toggles.AutoOreTeleport.Value == true then
        Toggles.AutoOreTeleport:SetValue(false)
    end
end)

Toggles.CAutoOreTeleport:OnChanged(function()
    if Toggles.CAutoOreTeleport.Value == true and Toggles.AutoOreRefine.Value == true or Toggles.AutoOreTeleport.Value == true then
        Toggles.AutoOreTeleport:SetValue(false)
        Toggles.AutoOreRefine:SetValue(false)
    end
end)

-- < Make sure 2 autofarms aren't enabled at once. />

local Teleports = Tabs.Main:AddLeftGroupbox('Teleports')

-- Teleports:AddButton('Teleport nearby entities to plot', function()
--     local OP = LocalPlayer.Character.HumanoidRootPart.Position

--     for i = 4,1,-1 do
--         wait(0.1)
        
--         for _,v in ipairs(Grabbables:GetChildren()) do
--             if v:FindFirstChildOfClass("BasePart") then
--                 if (v:FindFirstChildOfClass("BasePart").Position - OP).Magnitude < 20 then
--                     TeleportGrabbable(v,Myplot.CFrame + Vector3.new(0,4,0),false,false)
--                 end
--             end
--         end

--     end
-- end)

Teleports:AddButton('Teleport to plot', function()

    for i,v in next, game:GetService("Workspace").Plots:GetChildren() do
        if v.Owner and v.Owner.Value == LocalPlayer then
            Myplot = v.Base
        end
    end

    TP2(Myplot.CFrame + Vector3.new(0,4,0))
end)

local PlotFurnaces = {}

for i,v in next, Myplot.Parent.Objects:GetChildren() do
    if v.Name:find("Furnace") then
        table.insert(PlotFurnaces, v.Name .. " ["..tostring(table_count(PlotFurnaces,v.Name) + 1).."]")
        v.Name = v.Name .. " ["..tostring(table_count(PlotFurnaces,v.Name) + 1).."]"
    end
end

Teleports:AddDropdown('SelectedFurnace1', {
    Values = PlotFurnaces,
    Default = nil,
    Multi = false,
    Text = 'Selected Furnace',
    Tooltip = 'List of furnace on your plot.',
})

Options.SelectedFurnace1:OnChanged(function()
    if Options.SelectedFurnace1.Value ~= nil then
        if Myplot.Parent.Objects:FindFirstChild(Options.SelectedFurnace1.Value) then
            SelectedFurnace = Myplot.Parent.Objects:FindFirstChild(Options.SelectedFurnace1.Value).Refine.Part
        end
    end
end)

local TPIDX = {}
TPIDX['Utility Convenient Store'] = Vector3.new(-1002.573, 4.25, -611.692)
TPIDX['Land Agency'] = Vector3.new(-1008, 4, -723)
TPIDX['Ore Sellary'] = Vector3.new(-422.667, 6.5, -77.358)
TPIDX['Utility Store'] = Vector3.new(-468.379, 5.75, -4.919)
TPIDX['Pickaxe Shop'] = Vector3.new(736.24, 2.25, 64.567)
TPIDX["M's Dealership"] = Vector3.new(709.589, 8.25, -997.523)
TPIDX['Mighty Furniture of ZD'] = Vector3.new(-1017.249, 4.25, 700.392)
TPIDX['Electronics Antishop'] = Vector3.new(-106.961, 240, 1122.705) 
TPIDX['Secret Stash'] = Vector3.new(-504.2, 4.25, -664.323)
TPIDX['Meteor Rug'] = Vector3.new(-3475.94, 18, 1040.367)

Teleports:AddDropdown('StoreTeleportDropDown', {
    Values = { 'Utility Convenient Store', 'Land Agency', 'Ore Sellary', 'Utility Store', 'Pickaxe Shop' , "M's Dealership", 'Mighty Furniture of ZD', 'Electronics Antishop', 'Secret Stash', 'Meteor Rug'},
    Default = nil,
    Multi = false,
    Text = 'Building Teleports',
    Tooltip = 'List of shops to teleport to.',
})

Options.StoreTeleportDropDown:OnChanged(function()
    if Options.StoreTeleportDropDown.Value ~= nil then
        TP2(TPIDX[Options.StoreTeleportDropDown.Value])
        Options.StoreTeleportDropDown:SetValue(nil)
    end
end)

local TPIDX2 = {}
TPIDX2['Volcanium'] = Vector3.new(-2871.984, -776.293, 2789.415)
TPIDX2['Cloudnite'] = Vector3.new(472.196, 431.75, 1265.718)
TPIDX2['Emerald'] = Vector3.new(549.64, 273.75, 347.393)
TPIDX2['Marble'] = Vector3.new(520.628, 11.75, -973.84)
TPIDX2['Gold'] = Vector3.new(662.51, 16.5, -1502.161)

Teleports:AddDropdown('OreTeleportDropDown', {
    Values = {'Volcanium','Cloudnite','Emerald','Marble','Gold'},
    Default = nil,
    Multi = false,
    Text = 'Ore/Map teleports',
    Tooltip = 'List of locations to teleport to.',
})

Options.OreTeleportDropDown:OnChanged(function()
    if Options.OreTeleportDropDown.Value ~= nil then
        TP2(TPIDX2[Options.OreTeleportDropDown.Value])
        Options.OreTeleportDropDown:SetValue(nil)
    end
end)

local MiscTab = Tabs.Main:AddRightGroupbox('Grab Utilities')

-- MiscTab:AddButton('Spawn Meteor for FREE!', function()
--     for i = 3,1,-1 do
--         local OPos = LocalPlayer.Character.HumanoidRootPart.CFrame
--         local Totem
--         for i,v in next, game:GetService("Workspace").Grabable:GetChildren() do
--             if v.Name == "Meteorite Totem" and v:FindFirstChild("Shop") then
--                 v.Shop:Destroy()
--                 v.Configuration.Price:Destroy()
--                 v.Configuration.Price:Destroy()
--                 Totem = v
--             end
--         end
--         if Totem then
--             TTP(Totem.Ball)
--             task.wait(0.2)
--             Grab(true,Totem.Ball)
--             TTP(CFrame.new(workspace.Map.MeteoriteRoom.Piedestal.Touch.Position))
--             Totem:PivotTo(CFrame.new(workspace.Map.MeteoriteRoom.Piedestal.Touch.Position))
--             firetouchinterest(Totem.Ball,workspace.Map.MeteoriteRoom.Piedestal.Touch,1)
--             wait()
--             firetouchinterest(Totem.Ball,workspace.Map.MeteoriteRoom.Piedestal.Touch,0)
--             TTP(OPos)
--         end
--     end
-- end)

-- MiscTab:AddButton('Make Trusty Pickaxe', function()
   
--     local StonePick
--     local RustyPick
--     local IronPick

--     for i,v in next, game:GetService("Workspace").Grabable:GetChildren() do
--         if v.Name == "Boxed Stone Pickaxe" and v:FindFirstChild("Shop") then
--             StonePick = v
--         end
--         if v.Name == "Boxed Rusty Pickaxe" and v:FindFirstChild("Shop") then
--             RustyPick = v
--         end
--         if v.Name == "Boxed Iron Pickaxe" and v:FindFirstChild("Shop") then
--             IronPick = v
--         end
--     end

--     StonePick.Shop:Destroy()
--     StonePick.Configuration.Desc:Destroy()
--     StonePick.Configuration.Price:Destroy()
--     StonePick.Part.Info.Desc:Destroy()
--     StonePick.Part.Info.Subtitle:Destroy()

--     RustyPick.Shop:Destroy()
--     RustyPick.Configuration.Desc:Destroy()
--     RustyPick.Configuration.Price:Destroy()
--     RustyPick.Part.Info.Desc:Destroy()
--     RustyPick.Part.Info.Subtitle:Destroy()

--     IronPick.Shop:Destroy()
--     IronPick.Configuration.Desc:Destroy()
--     IronPick.Configuration.Price:Destroy()
--     IronPick.Part.Info.Desc:Destroy()
--     IronPick.Part.Info.Subtitle:Destroy()

--     TP(RustyPick.Part)

--     Grab(true,StonePick.Part)
--     Grab(true,RustyPick.Part)
--     StonePick:PivotTo(game:GetService("Workspace").Map.Objects.TrustIssues.Void.CFrame)
--     RustyPick:PivotTo(game:GetService("Workspace").Map.Objects.TrustIssues.Void.CFrame)

--     TP2(IronPick.Part)

--     Grab(true,IronPick.Part)
--     IronPick:PivotTo(game:GetService("Workspace").Map.Objects.TrustIssues.Void.CFrame)

--     local LCON
--     LCON = game:GetService("Workspace").Grabable.ChildAdded:Connect(function(Child)
--         if Child.Name == "Tool" then
--             task.wait(0.1)
--             if Child:FindFirstChild("Owner") and Child:FindFirstChild("Owner").Value == LocalPlayer then
--                 for i = 50,1,-1 do
--                     task.wait()
--                     TP(Child.Part)
--                     Child.Part.Interact:FireServer()
--                 end
--                 LCON:Disconnect()
--             end
--         end
--     end)

-- end)

MiscTab:AddButton('Owner Distance Bypass', function()
			game["Run Service"].RenderStepped:connect(
		   function()
			   setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
			   game.Players.LocalPlayer.SimulationRadius = math.huge * math.huge, math.huge * math.huge * 1 / 0 * 1 / 0 * 1 / 0 * 1 / 0 * 1 / 0
		   end
		)

		local LocalPlayer = game:GetService("Players").LocalPlayer
		LocalPlayer.SimulationRadiusChanged:Connect(function(radius)
		   radius = 9e9
		   return radius
		end)
		print(gethiddenproperty(game.Players.LocalPlayer, "SimulationRadius"))
end)


MiscTab:AddButton('Get Clientside Proton-24', function()
    game:GetService("ReplicatedStorage").Tools["Proton-24"]:Clone().Parent = LocalPlayer.Backpack
    game:GetService("ReplicatedStorage").Tools["Proton-24"]:Clone().Parent = LocalPlayer.StarterGear
end)

MiscTab:AddButton('Get Clientside Stateller', function()
    game:GetService("ReplicatedStorage").Tools["Stateller"]:Clone().Parent = LocalPlayer.Backpack
    game:GetService("ReplicatedStorage").Tools["Stateller"]:Clone().Parent = LocalPlayer.StarterGear
end)

if isLGPremium and isLGPremium() then

    local CFloop

    MiscTab:AddToggle('InvisFlyBroWhyBro', {
        Text = 'Invisible fly',
        Default = false,
        Tooltip = 'Makes you fly but appear in your original spot. Bypasses blacklists.',
    })

    CFspeed = 50

    Toggles.InvisFlyBroWhyBro:OnChanged(function()
        if Toggles.InvisFlyBroWhyBro.Value == true then
            LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
            local Head = LocalPlayer.Character:WaitForChild("Head")
            Head.Anchored = true
            if CFloop then CFloop:Disconnect() end
            CFloop = RunService.Heartbeat:Connect(function(deltaTime)
                local moveDirection = LocalPlayer.Character:FindFirstChildOfClass('Humanoid').MoveDirection * (CFspeed * deltaTime)
                local headCFrame = Head.CFrame
                local cameraCFrame = workspace.CurrentCamera.CFrame
                local cameraOffset = headCFrame:ToObjectSpace(cameraCFrame).Position
                cameraCFrame = cameraCFrame * CFrame.new(-cameraOffset.X, -cameraOffset.Y, -cameraOffset.Z + 1)
                local cameraPosition = cameraCFrame.Position
                local headPosition = headCFrame.Position

                local objectSpaceVelocity = CFrame.new(cameraPosition, Vector3.new(headPosition.X, cameraPosition.Y, headPosition.Z)):VectorToObjectSpace(moveDirection)
                Head.CFrame = CFrame.new(headPosition) * (cameraCFrame - cameraPosition) * CFrame.new(objectSpaceVelocity)
            end)
        else
            if CFloop then
                CFloop:Disconnect()
                LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
                local Head = LocalPlayer.Character:WaitForChild("Head")
                Head.Anchored = false
            end
        end
    end)

    MiscTab:AddToggle('StealOwner', {
        Text = 'Owner Spoof',
        Default = false,
        Tooltip = 'Spoofs ownership of items.',
    })
    
    MiscTab:AddToggle('OwnerESP', {
        Text = 'Owner ESP',
        Default = false,
        Tooltip = 'Shows you what items you own.',
    })

else
    MiscTab:AddToggle('nilStealOwner', {
        Text = 'Owner Spoof [BUYER ONLY]',
        Default = false,
        Tooltip = 'Spoofs ownership of items.',
    })
    
    MiscTab:AddToggle('nilOwnerESP', {
        Text = 'Owner ESP [BUYER ONLY]',
        Default = false,
        Tooltip = 'Shows you what items you own.',
    })
    
end

if isLGPremium and isLGPremium() then

    function ESPIfy(Instances)

        task.spawn(function()
            if Debug then print("ESPIfy called on instance",Instances:GetFullName()) end

            local THL = Instance.new("SelectionBox",Instances)

            if IsOwned(Instances) then
                THL.Color3 = Color3.new(0.054901, 0.827450, 0.352941)
            else
                THL.Color3 = Color3.new(0.827450, 0.054901, 0.054901)
            end

            if Instances.Owner.Value ~= LocalPlayer then
                task.spawn(function()
                    while task.wait(1) and Instances.Parent == Grabbables do
                        if Toggles.OwnerESP.Value == true then
                            pcall(function()
                                THL.Adornee.Velocity = Vector3.new(0,1,0)
                                if IsOwned(Instances) == true then
                                    THL.Color3 = Color3.new(0.054901, 0.827450, 0.352941)
                                else
                                    THL.Color3 = Color3.new(0.827450, 0.054901, 0.054901)
                                end
                            end)
                        end
                    end
                end)
            end

            table.insert(ESPTable,THL)
            local IDX = #ESPTable

            Instances.Destroying:Connect(function()
                table.remove(ESPTable,IDX)
                THL:Destroy()
            end)

            THL.Visible = Toggles.OwnerESP.Value

            THL.Adornee = Instances:FindFirstChild(Instances.Name) or Instances:FindFirstChild("Part") or Instances:FindFirstChildOfClass("Part") or Instances:FindFirstChildOfClass("MeshPart")
        end)

    end

end

MiscTab:AddToggle('ForceGrab', {
    Text = 'Strong Grab',
    Default = false,
    Tooltip = 'Makes you really strong.',
})

Toggles.ForceGrab:OnChanged(function()
    if Toggles.ForceGrab.Value == true then
        LocalPlayer.PlayerGui.Grab.Grab.Pos.D = 400
        LocalPlayer.PlayerGui.Grab.Grab.Pos.P = 20000
    else
        LocalPlayer.PlayerGui.Grab.Grab.Pos.D = 40
        LocalPlayer.PlayerGui.Grab.Grab.Pos.P = 500
    end
end)

MiscTab:AddToggle('GrabPlayers', {
    Text = 'Grab Players',
    Default = false,
    Tooltip = 'Allows you to grab players.',
})

MiscTab:AddToggle('NoDrown', {
    Text = 'No drown',
    Default = false,
    Tooltip = 'Gives you infinite air capacity.',
})

MiscTab:AddToggle('InfiniteZoom', {
    Text = 'Infinite Zoom',
    Default = false,
    Tooltip = 'Allows you to zoom out infinitely.',
})

MiscTab:AddToggle('FullbrightPlayer', {
    Text = 'Fullbright',
    Default = false,
    Tooltip = 'Turns on the lights.',
})

MiscTab:AddButton('Telekinesis Gun', function()
       loadstring(game:HttpGet("https://pastebin.com/raw/fauftxLe"))()
end)

-- MiscTab:AddToggle('UnlockAllBlueprints', {
--     Text = 'Unlock All Blueprints',
--     Default = false,
--     Tooltip = 'Unlocks all blueprints for free.',
-- })

Toggles.InfiniteZoom:OnChanged(function()
    if Toggles.InfiniteZoom.Value == true then
        LocalPlayer.CameraMaxZoomDistance = math.huge
    else
        LocalPlayer.CameraMaxZoomDistance = 50
    end
end)

-- Toggles.UnlockAllBlueprints:OnChanged(function()
--     if Toggles.UnlockAllBlueprints.Value == true then
--         for i,v in next, game.ReplicatedStorage.Objects:GetChildren() do
--             if v:FindFirstChild("Configuration") and v.Configuration:FindFirstChild("Category") then
--                 GetBlueprint(v.Name)
--             end
--         end
--     end
-- end)

Toggles.FullbrightPlayer:OnChanged(function()
    if Toggles.FullbrightPlayer.Value == true then
        game.Lighting.GlobalShadows = false
        LocalPlayer.PlayerGui.ClientScreenScript.Disabled = true
        game:GetService("Workspace").Cycle.Current.RobloxLocked = true
        game:GetService("Workspace").Cycle.RobloxLocked = true
    else
        LocalPlayer.PlayerGui.ClientScreenScript.Disabled = false
        game:GetService("Workspace").Cycle.Current.RobloxLocked = false
        game:GetService("Workspace").Cycle.RobloxLocked = false
        game.Lighting.GlobalShadows = true
    end
end)

Toggles.NoDrown:OnChanged(function()
    if Toggles.NoDrown.Value == true then
       LocalPlayer.PlayerGui.ClientScreenScript.Config.WaterPulseDamage.Capacity.Value = math.huge
    else
        LocalPlayer.PlayerGui.ClientScreenScript.Config.WaterPulseDamage.Capacity.Value = 100
    end
end)

Toggles.GrabPlayers:OnChanged(function()
    if Toggles.GrabPlayers.Value == true then
       for _,v in pairs(Players:GetPlayers()) do
            if v.Character then
                v.Character.Parent = Grabbables
                for _,x in pairs(v.Character:GetChildren()) do
                    if x:IsA("BasePart") then
                        x.Locked = false
                    end
                end
            end
       end
    else
        for _,v in pairs(Players:GetPlayers()) do
            if v.Character then
                v.Character.Parent = workspace
                for _,x in pairs(v.Character:GetChildren()) do
                    if x:IsA("BasePart") then
                        x.Locked = true
                    end
                end
            end
       end
    end
end)




-- < Tabs.Money UI Setup >

local MoneyTab = Tabs.Hub:AddLeftGroupbox('Money Utilities')

MoneyTab:AddToggle('LoopMoney', {
    Text = 'Loop send 50k to player',
    Default = false,
    Tooltip = 'Sends 50k to player every 11 seconds.',
})

MoneyTab:AddInput('MoneyUsername', {
    Default = 'Input Username',
    Numeric = false, -- true / false, only allows numbers
    Finished = false, -- true / false, only calls callback when you press enter

    Text = 'Money Target Username',
    Tooltip = 'User you want to send money to', -- Information shown when you hover over the textbox

    Placeholder = 'Input Username', -- placeholder text when the box is empty
    -- MaxLength is also an option which is the max length of the text
})

MoneyTab:AddToggle('MoneyFullView', {
    Text = 'Accurate money value',
    Default = false,
    Tooltip = 'Displays your full money amount.',
})

LocalPlayer.Values.Saveable.Cash.Changed:Connect(function()
    if Toggles.MoneyFullView.Value == true then
        task.wait()
        LocalPlayer.PlayerGui.UserGui.Stats.Cash.Text = "$" .. tostring(LocalPlayer.Values.Saveable.Cash.Value)
    end
end)

Toggles.MoneyFullView:OnChanged(function()
    if Toggles.MoneyFullView.Value == true then
        task.wait()
        LocalPlayer.PlayerGui.UserGui.Stats.Cash.Text = "$" .. tostring(LocalPlayer.Values.Saveable.Cash.Value)
    else
        task.wait()
        LocalPlayer.PlayerGui.UserGui.Stats.Cash.Text = "$" .. tostring(require(game.ReplicatedStorage.Modules.Shortcut).Cash(LocalPlayer.Values.Saveable.Cash.Value));
    end
end)


MoneyTab:AddToggle('IdleIncome', {
    Text = 'Idle Income',
    Default = false,
    Tooltip = 'Automatically dupes money. (SLOW)',
})

-- < Tabs.Money UI Setup />


-- < Tabs.Automation UI Setup >

local AutofarmTab = Tabs.Automation:AddLeftGroupbox('Autofarms')

-- AutofarmTab:AddToggle('BoxAutoFarm', {
--     Text = 'Box Delivery Autofarm',
--     Default = false,
--     Tooltip = 'Automatically delivers boxes for easy idle profit.',
-- })

-- Toggles.BoxAutoFarm:OnChanged(function()
--     if Toggles.BoxAutoFarm.Value == true then
--         TTP(CFrame.new(InteractRemote.Parent.Position))
--         wait(0.5)
--     end
-- end)

if isLGPremium and isLGPremium() then

    AutofarmTab:AddToggle('OreAutoFarm', {
        Text = 'Auto Mine Ore',
        Default = false,
        Tooltip = 'Automatically mines chosen ore.',
    })

else
    AutofarmTab:AddToggle('nilOreAutoFarm', {
        Text = 'Auto Mine Ore [BUYER ONLY]',
        Default = false,
        Tooltip = 'Automatically mines chosen ore.',
    })
    
end

AutofarmTab:AddToggle('AutoNeon', {
    Text = 'Auto Neon Cars',
    Default = false,
    Tooltip = 'Automatically spawns cars until neon.',
})

AutofarmTab:AddDropdown('SelectedSpawners1', {
    Values = VehicleSpawners,
    Default = nil,
    Multi = true,
    Text = 'Selected Vehicle Spawners',
    Tooltip = 'List of vehicle spawners on your plot.',
})


if isLGPremium and isLGPremium() then

Toggles.MineAura:OnChanged(function()
    if Toggles.OreAutoFarm.Value == true and Toggles.MineAura.Value == true then
        Toggles.OreAutoFarm:SetValue(false)
    end
end)

Toggles.OreAutoFarm:OnChanged(function()
    if Toggles.OreAutoFarm.Value == true and Toggles.MineAura.Value == true then
        Toggles.MineAura:SetValue(false)
    end
end)

end

-- < Generate Ore/Material Tables. >

local OreList = {}
for i,v in next, game:GetService("ReplicatedStorage").Mineables:GetChildren() do
    if v.Name ~= "NICELY_TILED_COPY_THIS_LOL" and v.Name ~= "Mythril" and v.Name ~= "Funny" and v:FindFirstChild("Stage1") and not v.Name:find("Tree") then
        table.insert(OreList,v.Name)
    end
end

local MaterialList = {}
for i,v in next, game:GetService("ReplicatedStorage").Materials:GetChildren() do
    table.insert(MaterialList,v.Name)
end

-- < Generate Ore/Material Tables. />

AutofarmTab:AddDropdown('OreDropdown', {
    Values = OreList,
    Default = nil,
    Multi = true,
    Text = 'Target Ore',
    Tooltip = 'List of ores in the game (Automatically updated)',
})

local DupeMainUnderTab = Tabs.Dupe:AddLeftGroupbox('Dupe main')

DupeMainUnderTab:AddButton('Reload Slot', function()
       game:GetService("ReplicatedStorage").Events.ReloadSlot:InvokeServer() 
end)

DupeMainUnderTab:AddButton('Open box with materials around', function()
    for _,Box in pairs(workspace.Grabable:GetChildren()) do
            if Box.Name == "MaterialBox" then
                if (Box.Box.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude<15 then
                    if Box.Box:findFirstChild("Interact") then
                        Box.Box.Interact:FireServer()
                    end
                end
            end
    end   
end)

DupeMainUnderTab:AddButton('Pick up items around', function()
       for _,tool in pairs(workspace.Grabable:GetChildren()) do
            		if tool.Name == "Tool" then
                		if (tool.Part.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude<30 then
                   			if tool.Part:findFirstChild("Interact") then
                        		tool.Part.Interact:FireServer()
                    		end
                		end
            		end
        end
end)

DupeMainUnderTab:AddButton('Dupe box material', function()
    local yesButton = game.Players.LocalPlayer.PlayerGui.UserGui.Dialog.Yes
	for i,v in pairs(getconnections(yesButton.MouseButton1Click)) do
	v:Fire()
	end
	for _,Box in pairs(workspace.Grabable:GetChildren()) do
            if Box.Name == "MaterialBox" then
                if (Box.Box.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude<15 then
                    if Box.Box:findFirstChild("Interact") then
                        Box.Box.Interact:FireServer()
                    end
                end
            end
    end  
end)

local DupeMageUnderTab = Tabs.Dupe:AddRightGroupbox('Mage Gift')

DupeMageUnderTab:AddButton('Delete cooldown Mage Gift', function()
    game.Players.LocalPlayer:WaitForChild("Values"):WaitForChild("Saveable"):WaitForChild("MageGiftCooldown"):Destroy()
end)

DupeMageUnderTab:AddButton('Dupe MageGift', function()
    local yesButton = game.Players.LocalPlayer.PlayerGui.UserGui.Dialog.Yes
	for i,v in pairs(getconnections(yesButton.MouseButton1Click)) do
	v:Fire()
	end
	for _,Gift in pairs(workspace.Grabable:GetChildren()) do
            		if Gift.Name == "Gift of Mage" then
               			if (Gift.Gift.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude<30 then
                    			if Gift.Gift:findFirstChild("Interact") then
                        			Gift.Gift.Interact:FireServer()
								end
                		end
					end
    end 
end)

local DupeXMASUnderTab = Tabs.Dupe:AddRightGroupbox('Christmas')

DupeXMASUnderTab:AddButton('Dupe Shaman Gift', function()
    local yesButton = game.Players.LocalPlayer.PlayerGui.UserGui.Dialog.Yes
	for i,v in pairs(getconnections(yesButton.MouseButton1Click)) do
	v:Fire()
	end
	for _,Handle in pairs(workspace.Grabable:GetChildren()) do
                    if Handle.Name == "Gift of Shaman" then
                           if (Handle.Handle.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude<17 then
                                if Handle.Handle:findFirstChild("Interact") then
                                    Handle.Handle.Interact:FireServer()
                               end
                        end
                    end
            end
end)

local EspOtherTab = Tabs.Hub:AddLeftGroupbox('Esp')
local rare = {"Astatine", "Morganite", "Moonstone", "Dumortierite", "Stormite", "Pure Crystal", "Grass", "Dirt"}

EspOtherTab:AddButton('Esp Grabiel', function()
   for _,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name:lower():find("test") and v.Parent.Name:lower():find("grabiel") then
			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Parent
			Highlight.Adornee = v.Parent
			Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillColor = Color3.fromRGB(255, 0, 235)
			Highlight.FillTransparency = 0.2
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Highlight.Name = "Client"		
		end
    end
	workspace.DescendantAdded:Connect(function(v)
		task.wait(Random.new():NextNumber(0.2,0.4))
		if v.Name:lower():find("test") and v.Parent.Name:lower():find("grabiel") then
			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Parent
			Highlight.Adornee = v.Parent
			Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillColor = Color3.fromRGB(255, 0, 235)
			Highlight.FillTransparency = 0.2
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Highlight.Name = "Client"
		end
	end)
end)

EspOtherTab:AddButton('Esp Purple Seed', function()
   for _,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name:lower():find("seed") and v.Parent.Name:lower():find("purpleseed") then
			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Parent
			Highlight.Adornee = v.Parent
			Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillColor = Color3.fromRGB(255, 0, 235)
			Highlight.FillTransparency = 0.2
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Highlight.Name = "Client"		
		end
    end
	workspace.DescendantAdded:Connect(function(v)
		task.wait(Random.new():NextNumber(0.2,0.4))
		if v.Name:lower():find("seed") and v.Parent.Name:lower():find("purpleseed") then
			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Parent
			Highlight.Adornee = v.Parent
			Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillColor = Color3.fromRGB(255, 0, 235)
			Highlight.FillTransparency = 0.2
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Highlight.Name = "Client"
		end
	end)
end)

EspOtherTab:AddButton('Esp Shiny Key', function()
   for _,v in pairs(game.Workspace:GetDescendants()) do
		if v.Name:lower():find("part") and v.Parent.Name:lower():find("shiny key") then
			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Parent
			Highlight.Adornee = v.Parent
			Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillColor = Color3.fromRGB(245, 245, 0)
			Highlight.FillTransparency = 0.2
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Highlight.Name = "Client"		
		end
    end
	workspace.DescendantAdded:Connect(function(v)
		task.wait(Random.new():NextNumber(0.2,0.4))
		if v.Name:lower():find("part") and v.Parent.Name:lower():find("shiny key") then
			local Highlight = Instance.new("Highlight")
			Highlight.Parent = v.Parent
			Highlight.Adornee = v.Parent
			Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
			Highlight.FillColor = Color3.fromRGB(245, 245, 0)
			Highlight.FillTransparency = 0.2
			Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
			Highlight.Name = "Client"
		end
	end)
end)

EspOtherTab:AddButton('Esp Rudolf', function()
   print("This function not created!")
end)

EspOtherTab:AddButton('Esp Rare ores', function()
      local autoScan = false

	for _,v in pairs(workspace:WaitForChild("WorldSpawn"):GetDescendants()) do
			local rare = {"Astatine", "Morganite", "Moonstone", "Dumortierite", "Stormite", "Pure Crystal", "Grass", "Dirt"}
			if v.Name:lower():find("mineablerock") and v:FindFirstChildWhichIsA("StringValue") and table.find(rare, v.RockString.Value) then
				local BillboardGui = Instance.new("BillboardGui")
				local TextLabel = Instance.new("TextLabel")
				BillboardGui.Parent = v:WaitForChild("Part")
				BillboardGui.Adornee = v:WaitForChild("Part")
				BillboardGui.Name = "Client"
				BillboardGui.MaxDistance = math.huge
				BillboardGui.ResetOnSpawn = false
				BillboardGui.AlwaysOnTop = true
				BillboardGui.LightInfluence = 1
				BillboardGui.Size = UDim2.new(0, 30, 0, 30)
				BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
				TextLabel.Parent = BillboardGui
				TextLabel.Font = Enum.Font.DenkOne
				TextLabel.BackgroundTransparency = 1
				TextLabel.Size = UDim2.new(1.50, 0, 1.50, 0)
				TextLabel.Text = "Ore ["..v:FindFirstChildWhichIsA("StringValue").Value.."]"
				TextLabel.TextColor3 = Color3.fromRGB(92, 0, 92)
				TextLabel.TextScaled = true	
			end
	end

	if autoScan then
		while task.wait(5) do
			for _,v in pairs(workspace:WaitForChild("WorldSpawn"):GetDescendants()) do
				game:GetService("RunService").RenderStepped:Wait()
				if v.Name:lower():find("mineablerock") and v:FindFirstChildWhichIsA("StringValue") and table.find(rare, v.RockString.Value) then
					local BillboardGui = Instance.new("BillboardGui")
					local TextLabel = Instance.new("TextLabel")
					BillboardGui.Parent = v:WaitForChild("Part")
					BillboardGui.Adornee = v:WaitForChild("Part")
					BillboardGui.Name = "Client"
					BillboardGui.MaxDistance = math.huge
					BillboardGui.ResetOnSpawn = false
					BillboardGui.AlwaysOnTop = true
					BillboardGui.LightInfluence = 1
					BillboardGui.Size = UDim2.new(0, 30, 0, 30)
					BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
					TextLabel.Parent = BillboardGui
					TextLabel.Font = Enum.Font.DenkOne
					TextLabel.BackgroundTransparency = 1
					TextLabel.Size = UDim2.new(1.50, 0, 1.50, 0)
					TextLabel.Text = "Ore ["..v:FindFirstChildWhichIsA("StringValue").Value.."]"
					TextLabel.TextColor3 = Color3.fromRGB(92, 0, 92)
					TextLabel.TextScaled = true	
				end
			end
		end
	end
end)

local ServerOtherUnderTab = Tabs.Hub:AddRightGroupbox('Other Utilities')

ServerOtherUnderTab:AddButton('Server Rejoin', function()
   game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
end)

ServerOtherUnderTab:AddButton('Server Hop', function()
	local Player = game.Players.LocalPlayer    
	local Http = game:GetService("HttpService")
	local TPS = game:GetService("TeleportService")
	local Api = "https://games.roblox.com/v1/games/"

	local _place,_id = game.PlaceId, game.JobId
	local _servers = Api.._place.."/servers/Public?sortOrder=Desc&limit=100"
	function ListServers(cursor)
	   local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
	   return Http:JSONDecode(Raw)
	end

	local Next; repeat
	   local Servers = ListServers(Next)
	   for i,v in next, Servers.data do
		   if v.playing < v.maxPlayers and v.id ~= _id then
			   local s,r = pcall(TPS.TeleportToPlaceInstance,TPS,_place,v.id,Player)
			   if s then break end
		   end
	   end
	   
	   Next = Servers.nextPageCursor
	until not Next
	end)

ServerOtherUnderTab:AddButton('Hopper Bin', function()
   loadstring(game:HttpGet("https://pastebin.com/raw/xUd5yAuk", true))()
end)

-- < Make sure 2 autofarms aren't enabled at once. >

-- Toggles.OreAutoFarm:OnChanged(function()
--     if Toggles.BoxAutoFarm.Value == true and Toggles.OreAutoFarm.Value == true then
--         Toggles.BoxAutoFarm:SetValue(false)
--     end
-- end)

-- Toggles.BoxAutoFarm:OnChanged(function()
--     if Toggles.BoxAutoFarm.Value == true and Toggles.OreAutoFarm.Value == true then
--         Toggles.OreAutoFarm:SetValue(false)
--     end
-- end)

-- < Make sure 2 autofarms aren't enabled at once. />


-- < Tabs.Automation UI Setup />


-- < Tabs.Building UI Setup >

-- < Tabs.Building UI Setup >


-- < Configure UI (Create tabs, toggles, etc.) />


-- < Initialize and configure Linora addons. >

ThemeManager:SetLibrary(Library)

SaveManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings() 

SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

ThemeManager:SetFolder('Refinery_Caves')

SaveManager:SetFolder('Refinery_Caves/main')

SaveManager:BuildConfigSection(Tabs.UISettings) 

ThemeManager:ApplyToTab(Tabs.UISettings)


-- < Initialize and configure Linora addons. />

coroutine.resume(AutoMineCoro)
coroutine.resume(IdleMoneyCoro)
coroutine.resume(ModDetectionCoro)
coroutine.resume(AutoOreTeleportCoro)
coroutine.resume(LoopMoneyCoro)
coroutine.resume(AutoNeonCarCoro)

if isLGPremium and isLGPremium() then
    coroutine.resume(AutoOreCoro)
    coroutine.resume(OwnershipESPCoro)
end

-- < Mouse spoofing (For mine aura.) >

local Mouse = LocalPlayer:GetMouse()

local oldIndex = nil 
oldIndex = hookmetamethod(game, "__index", function(self, Index)

    -- < Mouse target hook (For mine aura and automine.) >

    if self == Mouse and not checkcaller() and TargetPart and (Toggles.MineAura.Value == true or Toggles.OreAutoFarm.Value == true) then

        if Index == "Target" or Index == "target" then
            return TargetPart
        elseif Index == "Hit" or Index == "hit" then 
            return CFrame.new(TargetPart.Position)
        elseif Index == "X" or Index == "x" then 
            return oldIndex(self,"X")
        elseif Index == "Y" or Index == "y" then 
            return oldIndex(self,"Y")
        elseif Index == "UnitRay" then 
            return Ray.new(self.Origin, (self.Hit - self.Origin).Unit)
        end

    -- < Owner Value hook (For owner spoofing / yoinking.) >
        
    elseif tostring(self) == "Owner" and not checkcaller() and (Toggles.StealOwner.Value == true) then

        if Index == "Value" or Index == "value" then
            return LocalPlayer
        end

    -- < Player Character Parent Index hook (For grab players) >

    end

    return oldIndex(self, Index)
end)

RunService.RenderStepped:Connect(function()
    if Toggles.FullbrightPlayer.Value == true then
        game.Lighting.ClockTime = 12
    end
end)

local GC = getconnections or get_signal_cons
if GC then
    for i,v in pairs(GC(LocalPlayer.Idled)) do
        if v["Disable"] then
            v["Disable"](v)
        elseif v["Disconnect"] then
            v["Disconnect"](v)
        end
    end
else
    LocalPlayer.Idled:Connect(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end


local OAC = Library["AccentColor"]
Library["AccentColor"] = GetLighterColor(Library["AccentColor"])

-- < Notify user everything has loaded. >

Library:Notify("All features loaded in " .. tostring(BetterRound(tick() - Startup,3)) .. " seconds.",3)
Library:Notify("Enjoy!",4)
task.defer(function()
    repeat wait()
        local H, S, V = Color3.toHSV(Library["AccentColor"])
        Library["AccentColor"] = Color3.fromHSV(H, S, V / 1.01);
        Library.AccentColorDark = Library:GetDarkerColor(Library.AccentColor);
        Library:UpdateColorsUsingRegistry()
        local OH,OS,OV = Color3.toHSV(OAC)
    until V <= OV
end)

-- < Notify user everything has loaded. />D
