local AvailableInteractions = {}
local CanStartInteraction = true
local CurrentInteraction = nil
local InMenu = false
local MaxRadius = 0.0
local MenuData = nil

if Config.Framework == "rsg" then
    MenuData = {}
    TriggerEvent("rsg-menubase:getData", function(call)
        MenuData = call
    end)
elseif Config.Framework == "vorp" then
    MenuData = exports.vorp_menu:GetMenuData()
end

local StartingCoords = nil

local function Debug(...)
    if Config.DevMode then
        print(...)
    end
end

local function EnumerateEntities(firstFunc, nextFunc, endFunc)
    return coroutine.wrap(function()
        local iter, id = firstFunc()

        if not id or id == 0 then
            endFunc(iter)
            return
        end

        local enum = { handle = iter, destructor = endFunc }
        setmetatable(enum, entityEnumerator)

        local next = true
        repeat
            coroutine.yield(id)
            next, id = nextFunc(iter)
        until not next

        enum.destructor, enum.handle = nil, nil
        endFunc(iter)
    end)
end

local function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
end

local function HasCompatibleModel(entity, models)
    local entityModel = GetEntityModel(entity)
    for _, model in ipairs(models) do
        if entityModel == GetHashKey(model) then
            return model
        end
    end
    return nil
end

local function CanStartInteractionAtObject(interaction, object, playerCoords, objectCoords)
    local distance = #(playerCoords - objectCoords)
    if distance > interaction.radius then
        return nil
    end
    return HasCompatibleModel(object, interaction.objects)
end

local function PlayAnimation(ped, anim)
    if not DoesAnimDictExist(anim.dict) then
        return
    end
    RequestAnimDict(anim.dict)
    while not HasAnimDictLoaded(anim.dict) do
        Wait(0)
    end
    TaskPlayAnim(ped, anim.dict, anim.name, 0.0, 0.0, -1, 1, 1.0, false, false, false, "", false)
    RemoveAnimDict(anim.dict)
end

local function StartInteractionAtCoords(interaction)
    local x, y, z, h = interaction.x, interaction.y, interaction.z, interaction.heading
    if not StartingCoords then
        StartingCoords = GetEntityCoords(PlayerPedId())
    end
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), true)
    if interaction.scenario then
        TaskStartScenarioAtPosition(PlayerPedId(), GetHashKey(interaction.scenario), x, y, z, h, -1, false, true)
    elseif interaction.animation then
        SetEntityCoordsNoOffset(PlayerPedId(), x, y, z)
        SetEntityHeading(PlayerPedId(), h)
        PlayAnimation(PlayerPedId(), interaction.animation)
    end
    if interaction.effect then
        Config.Effects[interaction.effect]()
    end
    CurrentInteraction = interaction
end

local function StartInteractionAtObject(interaction)
    local objectHeading = GetEntityHeading(interaction.object)
    local objectCoords = GetEntityCoords(interaction.object)
    local r = math.rad(objectHeading)
    local cosr = math.cos(r)
    local sinr = math.sin(r)
    local x = interaction.x * cosr - interaction.y * sinr + objectCoords.x
    local y = interaction.y * cosr + interaction.x * sinr + objectCoords.y
    local z = interaction.z + objectCoords.z
    local h = interaction.heading + objectHeading
    interaction.x, interaction.y, interaction.z, interaction.heading = x, y, z, h
    StartInteractionAtCoords(interaction)
end

local function IsCompatible(t, ped)
    return not t.isCompatible or t.isCompatible(ped)
end

local function StopInteraction()
    CurrentInteraction = nil
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    Debug('ClearPedTasksImmediately: ^1OFF^0 \n FreezeEntityPosition: ^1OFF^0')
    if StartingCoords then
        SetEntityCoordsNoOffset(PlayerPedId(), StartingCoords.x, StartingCoords.y, StartingCoords.z)
        StartingCoords = nil
    end
end

local function openInteractionMenu(availableInteractions)
    InMenu = true
    MenuData.CloseAll()

    local elements = {}

    for k, v in pairs(availableInteractions) do
        local data = {}

        if v.labelText then
            local label
            if v.label == "left" then
                label = tostring(v.labelText .. Translation[Config.Locale]["menu_left"])
            elseif v.label == "right" then
                label = tostring(v.labelText .. Translation[Config.Locale]["menu_right"])
            else
                label = tostring(v.labelText)
            end
            data = { label = label, value = v.scenario, interaction = availableInteractions[k] }
        else
            data = { label = v.labelText2, value = v.scenario, interaction = availableInteractions[k] }
        end

        table.insert(elements, data)
    end

    MenuData.Open("default", GetCurrentResourceName(), "menu_interactions",
        {
            title = Translation[Config.Locale]["menu_title"],
            subtext = Translation[Config.Locale]["menu_subtitle"],
            align = "top-right",
            elements = elements
        },
        function(data, menu)
            if data.current.interaction then
                if data.current.interaction.object then
                    StartInteractionAtObject(data.current.interaction)
                else
                    StartInteractionAtCoords(data.current.interaction)
                end
            end
            menu.close()
            InMenu = false
        end,
        function(data, menu)
            menu.close()
            InMenu = false
            ClearPedTasks(PlayerPedId())
        end
    )
end

local function SortInteractions(a, b)
    if a.distance == b.distance then
        if a.object == b.object then
            local aLabel = a.scenario or a.animation.label
            local bLabel = b.scenario or b.animation.label
            return aLabel < bLabel
        else
            return a.object < b.object
        end
    else
        return a.distance < b.distance
    end
end

local function AddInteractions(availableInteractions, interaction, playerCoords, targetCoords, modelName, object)
    local distance = #(playerCoords - targetCoords)
    if interaction.scenarios then
        for _, scenario in ipairs(interaction.scenarios) do
            if IsCompatible(scenario, PlayerPedId()) then
                table.insert(availableInteractions, {
                    x = interaction.x,
                    y = interaction.y,
                    z = interaction.z,
                    heading = interaction.heading,
                    scenario = scenario.name,
                    object = object,
                    modelName = modelName,
                    distance = distance,
                    label = interaction.label,
                    effect = interaction.effect,
                    labelText = scenario.label,
                    labelText2 = interaction.labelText,
                    targetCoords = targetCoords
                })
            end
        end
    end
    if interaction.animations then
        for _, animation in ipairs(interaction.animations) do
            if IsCompatible(animation, PlayerPedId()) then
                table.insert(availableInteractions, {
                    x = interaction.x,
                    y = interaction.y,
                    z = interaction.z,
                    heading = interaction.heading,
                    animation = animation,
                    object = object,
                    modelName = modelName,
                    distance = distance,
                    label = interaction.label,
                    effect = interaction.effect,
                    labelText = animation.label,
                    labelText2 = interaction.labelText,
                    targetCoords = targetCoords
                })
            end
        end
    end
end

CreateThread(function()
    while true do
        Wait(500)
        if CurrentInteraction then
            local ped = PlayerPedId()
            if IsPedRagdoll(ped) or IsPedFalling(ped) or IsPedInjured(ped) then
                StopInteraction()
            elseif not IsPedUsingAnyScenario(ped) and not IsEntityPlayingAnim(
                ped,
                CurrentInteraction.animation and CurrentInteraction.animation.dict or "",
                CurrentInteraction.animation and CurrentInteraction.animation.name or "",
                3
            ) then
                StopInteraction()
            end
        end
    end
end)

CreateThread(function()
    while true do
        CanStartInteraction = not IsPedDeadOrDying(PlayerPedId()) and not IsPedInCombat(PlayerPedId())
        if CurrentInteraction then
            Wait(2000)
        else
            Wait(1000)
        end
    end
end)

local standUpPrompt = nil

CreateThread(function()
    standUpPrompt = PromptRegisterBegin()
    PromptSetControlAction(standUpPrompt, GetHashKey("INPUT_CONTEXT_Y"))
    PromptSetText(standUpPrompt, CreateVarString(10, "LITERAL_STRING", Translation[Config.Locale]["prompt_interact"]))
    PromptSetStandardMode(standUpPrompt, true)
    PromptSetEnabled(standUpPrompt, false)
    PromptSetVisible(standUpPrompt, false)
    PromptRegisterEnd(standUpPrompt)

    while true do
        if CurrentInteraction then
            Wait(0)
            PromptSetEnabled(standUpPrompt, true)
            PromptSetVisible(standUpPrompt, true)

            if PromptIsJustPressed(standUpPrompt) then
                PromptSetEnabled(standUpPrompt, false)
                PromptSetVisible(standUpPrompt, false)
                StopInteraction()
            end
        else
            PromptSetEnabled(standUpPrompt, false)
            PromptSetVisible(standUpPrompt, false)
            Wait(500)
        end
    end
end)

for _, interaction in ipairs(Config.Interactions) do
    MaxRadius = math.max(MaxRadius, interaction.radius)
end

local registeredModels = {}

CreateThread(function()
    for _, interaction in ipairs(Config.Interactions) do
        if IsCompatible(interaction, PlayerPedId()) then

            if interaction.objects then
                local modelsToRegister = {}
                for _, model in ipairs(interaction.objects) do
                    if not registeredModels[model] then
                        table.insert(modelsToRegister, model)
                        registeredModels[model] = true
                    end
                end

                if #modelsToRegister > 0 then
                    exports.ox_target:addModel(modelsToRegister, {
                        {
                            label = Translation[Config.Locale]["prompt_group"],
                            icon = "fas fa-chair",
                            onSelect = function(data)
                                if CurrentInteraction then return end
                                if not CanStartInteraction then return end

                                local playerCoords = GetEntityCoords(PlayerPedId())
                                local objectCoords = GetEntityCoords(data.entity)
                                local availableInteractions = {}

                                for _, inter in ipairs(Config.Interactions) do
                                    if inter.objects and IsCompatible(inter, PlayerPedId()) then
                                        local modelName = HasCompatibleModel(data.entity, inter.objects)
                                        if modelName then
                                            AddInteractions(
                                                availableInteractions,
                                                inter,
                                                playerCoords,
                                                objectCoords,
                                                modelName,
                                                data.entity
                                            )
                                        end
                                    end
                                end

                                if #availableInteractions == 1 then
                                    if availableInteractions[1].object then
                                        StartInteractionAtObject(availableInteractions[1])
                                    else
                                        StartInteractionAtCoords(availableInteractions[1])
                                    end
                                elseif #availableInteractions > 1 then
                                    table.sort(availableInteractions, SortInteractions)
                                    openInteractionMenu(availableInteractions)
                                end
                            end,
                            canInteract = function()
                                if CurrentInteraction then return false end
                                if IsPedDeadOrDying(PlayerPedId()) or IsPedInCombat(PlayerPedId()) then
                                    return false
                                end
                                return not interaction.isCompatible or interaction.isCompatible(PlayerPedId())
                            end
                        }
                    })
                end

            else
                exports.ox_target:addSphereZone({
                    coords = vector3(interaction.x, interaction.y, interaction.z),
                    radius = interaction.radius,
                    debug = Config.DevMode,
                    options = {
                        {
                            label = Translation[Config.Locale]["prompt_group"],
                            icon = "fas fa-chair",
                            onSelect = function()
                                if CurrentInteraction then return end
                                if not CanStartInteraction then return end

                                local playerCoords = GetEntityCoords(PlayerPedId())
                                local targetCoords = vector3(interaction.x, interaction.y, interaction.z)
                                local availableInteractions = {}
                                AddInteractions(availableInteractions, interaction, playerCoords, targetCoords)

                                if #availableInteractions == 1 then
                                    StartInteractionAtCoords(availableInteractions[1])
                                elseif #availableInteractions > 1 then
                                    table.sort(availableInteractions, SortInteractions)
                                    openInteractionMenu(availableInteractions)
                                end
                            end,
                            canInteract = function()
                                if CurrentInteraction then return false end
                                return not IsPedDeadOrDying(PlayerPedId()) and not IsPedInCombat(PlayerPedId())
                            end
                        }
                    }
                })
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    if InMenu then
        MenuData.CloseAll()
    end

    StopInteraction()

    if standUpPrompt then
        PromptDelete(standUpPrompt)
    end

    local models = {}
    for _, interaction in ipairs(Config.Interactions) do
        if interaction.objects then
            for _, model in ipairs(interaction.objects) do
                table.insert(models, model)
            end
        end
    end
    if #models > 0 then
        exports.ox_target:removeModel(models, nil)
    end
end)