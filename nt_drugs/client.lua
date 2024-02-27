vRP = Proxy.getInterface("vRP")

local farmkokain = false
local omdankokain = false

-- Høst/Farm -- 
local farmItem = ""
local farmItemName = ""

-- Omdan --
local omdansekitem = ""
local omdanItem = ""
local omdanItemName = ""

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k,v in pairs(Config.farmcoords) do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Coords[1], v.Coords[2], v.Coords[3], true)
            if distance < 15 then
                DrawMarker(25, v.Coords[1], v.Coords[2], v.Coords[3] - 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 7.0, 7.0, 7.0, 0, 120, 0, 152, false, true, 2, nil, nil, false)
                if not farmkokain then
                    if distance < 4 then
                        lib.showTextUI("[E] - Farm " .. v.itemname)
                        if IsControlJustReleased(1, 38) then
                            startfarm(v.Item, v.itemname, true) -- Starter omdan process med det valge drug item
                            local item = v.Item
                            print("Farm item: ".. item)
                        end
                    else
                        lib.hideTextUI()
                    end
                else
                    if distance < 4 then
                        lib.showTextUI("[E] - Stop Farm " .. v.itemname)
                        if IsControlJustReleased(1, 38) then
                            startfarm(nil, nil, false)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                        end
                    else
                        lib.hideTextUI()
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if farmkokain then
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            lib.progressBar({
                duration = Config.proggressbarTime,
                label = 'Farmer ' .. farmItemName,
                useWhileDead = false,
                canCancel = false,
                disable = {}
            })
            local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}, 'easy'}, {'w'})
            if success then
                giveitem(farmItem)
            else
                lib.notify({
                    title = 'ERROR',
                    description = 'Du fejlede. Prøv igen!',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#C1C2C5',
                        ['.description'] = {
                          color = '#909296'
                        }
                    },
                    icon = 'ban',
                    iconColor = '#C53030'
                })
                --farmkokain = false
                ClearPedTasksImmediately(PlayerPedId())
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k,v in pairs(Config.omdancoords) do
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.Coords[1], v.Coords[2], v.Coords[3], true)
            if distance < 15 then
                DrawMarker(25, v.Coords[1], v.Coords[2], v.Coords[3] - 1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 7.0, 7.0, 7.0, 0, 120, 0, 152, false, true, 2, nil, nil, false)
                if not omdankokain then
                    if distance < 4 then
                        lib.showTextUI("[E] - Omdan " .. v.itemname)
                        if IsControlJustReleased(1, 38) then
                            startOmdan(v.Item, v.itemname, v.sekitem, true) -- Starter omdan process med det valge drug item
                        end
                    else
                        lib.hideTextUI()
                    end
                else
                    if distance < 4 then
                        lib.showTextUI("[E] - Stop Omdan " .. v.itemname)
                        if IsControlJustReleased(1, 38) then
                            startOmdan(nil, nil, nil, false)
                            ClearPedTasksImmediately(GetPlayerPed(-1))
                        end
                    else
                        lib.hideTextUI()
                    end
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if omdankokain then
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            lib.progressBar({
                duration = Config.proggressbarTime,
                label = 'Omdanner ' .. omdanItemName,
                useWhileDead = false,
                canCancel = false,
                disable = {}
            })
            local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}, 'easy'}, {'w'})
            if success then
                omdanitem(omdanItem, cfg.omdancoords.Item)
            else
                lib.notify({
                    title = 'ERROR',
                    description = 'Du fejlede. Prøv igen!',
                    position = 'top',
                    style = {
                        backgroundColor = '#141517',
                        color = '#C1C2C5',
                        ['.description'] = {
                          color = '#909296'
                        }
                    },
                    icon = 'ban',
                    iconColor = '#C53030'
                })
                --omdankokain = false
                ClearPedTasksImmediately(PlayerPedId())
            end
        end
    end
end)


RegisterCommand('clearpedemote', function()
ClearPedTasksImmediately(PlayerPedId())
end)

function startfarm(item, itemName,trueorfalse)
    farmItem = item or ""
    farmItemName = itemName or ""
    farmkokain = trueorfalse
end

function startOmdan(item, itemName, sekitem,trueorfalse)
    omdansekitem = sekitem or ""
    omdanItem = item or ""
    omdanItemName = itemName 
    omdankokain = trueorfalse
end

function omdanitem(omdanitem, item)
    TriggerServerEvent('nt_drugs:omdan', omdanitem, item)
end

function giveitem(item)
    TriggerServerEvent('nt_drugs:giveitem', item)
end
