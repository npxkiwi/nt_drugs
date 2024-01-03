vRP = Proxy.getInterface("vRP")

local farmkokain = false
local omdankokain = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k,v in pairs(Config.farmcoords) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true ) < 15 then
            DrawMarker(25, v.x, v.y, v.z -1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 7.0, 7.0, 7.0, 0, 120, 0, 152, false, true, 2, nil, nil, false)
            if farmkokain == false then
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true ) < 4 then
                    lib.showTextUI('[E] - Farm Kokain')
                    if IsControlJustReleased(1, 38) then
                        farmkokain = true
                    end
                else
                    lib.hideTextUI()
                    end
                else
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true ) < 4 then
                        lib.showTextUI('[E] - Stop Farm Kokain')
                        if IsControlJustReleased(1, 38) then
                            farmkokain = false
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
        if farmkokain == true then
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            lib.progressBar({
                duration = Config.proggressbarTime,
                label = 'Farmer Kokain',
                useWhileDead = false,
                canCancel = false,
                disable = {
                }
            })
            local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}, 'easy'}, {'w'})
            if success then
                giveitem('kokainblade')
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
                farmkokain = false
                ClearPedTasksImmediately(GetPlayerPed(-1))
            end
        end
    end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k,v in pairs(Config.omdancoords) do
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true ) < 15 then
            DrawMarker(25, v.x, v.y, v.z -1, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 7.0, 7.0, 7.0, 0, 120, 0, 152, false, true, 2, nil, nil, false)
            if omdankokain == false then
                if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true ) < 4 then
                    lib.showTextUI('[E] - Omdan Kokain')
                    if IsControlJustReleased(1, 38) then
                        omdankokain = true
                    end
                else
                    lib.hideTextUI()
                    end
                else
                    if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), v.x, v.y, v.z, true ) < 4 then
                        lib.showTextUI('[E] - Stop Omdan Kokain')
                        if IsControlJustReleased(1, 38) then
                            omdankokain = false
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
        if omdankokain == true then
            TaskStartScenarioInPlace(PlayerPedId(), 'PROP_HUMAN_PARKING_METER', 0, true)
            lib.progressBar({
                duration = Config.proggressbarTime,
                label = 'Omdanner Kokain',
                useWhileDead = false,
                canCancel = false,
                disable = {
                }
            })
            local success = lib.skillCheck({'easy', 'easy', {areaSize = 60, speedMultiplier = 1}, 'easy'}, {'w'})
            if success then
                omdanitem('kokainblade', 'kokain')
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
                omdankokain = false
                ClearPedTasksImmediately(GetPlayerPed(-1))
            end
        end
    end
end)

function omdanitem(omdanitem, item)
    TriggerServerEvent('nt_drugs:omdan', omdanitem, item)
end

function giveitem(item)
    TriggerServerEvent('nt_drugs:giveitem', item)
end
