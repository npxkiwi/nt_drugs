local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local farmlogs = "DISCORD LOGS HER"
local omdanlogs = "DISCORD LOGS HER"

function sendToDiscord(color, name, message, footer, webhook)
    local embed = {
          {
              ["color"] = color,
              ["title"] = "**".. name .."**",
              ["description"] = message,
              ["footer"] = {
                  ["text"] = footer,
              },
          }
      }
    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = name, embeds = embed}), { ['Content-Type'] = 'application/json' })
  end

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","nt_drugs")

RegisterServerEvent('nt_drugs:giveitem')
AddEventHandler('nt_drugs:giveitem', function(item)
    local user_id = vRP.getUserId({source})
    if item == "kokainblade" or item == "hash" then
        vRP.giveInventoryItem({user_id,item,10,true})
        sendToDiscord(16753920, "[Notepad's Drugs System]", "Spiller Id: ```"..user_id.."```\nItem:\n```"..item.."```", "Lavet af Notepad", farmlogs)
    else
        --vRP.kick({user_id, "[Notepad's Drugs System]\nHvorfor prøver du at exploit dette script?\nHvorfor er du en virgin?"})
        --DropPlayer({user_id, "[Notepad's Drug System]\nHvorfor prøver du at exploit dette script?"})
        sendToDiscord(16753920, "[Notepad's Drugs System]", "Spiller Id: ```"..user_id.."```\nHan prøver at exploit dette script!\nItem:\n```"..item.."```", "Lavet af Notepad", farmlogs)
    end
end)

RegisterNetEvent('nt_drugs:omdan')
AddEventHandler('nt_drugs:omdan', function(omdanitem, item)
    local user_id = vRP.getUserId({source})
    if omdanitem == "kokainblade" or item == "hash" then
        if item == "kokain" or item == "skunk" then
            if vRP.tryGetInventoryItem({user_id, omdanitem, 3}) then
                vRP.giveInventoryItem({user_id,item, 1})
                sendToDiscord(16753920, "[Notepad's Drugs System]", "Spiller Id: ```"..user_id.."```\nOmdan Item:\n```"..omdanitem.."```\nItem:```"..item.."```", "Lavet af Notepad", omdanlogs)
            end
        else
            sendToDiscord(16753920, "[Notepad's Drugs System]", "Spiller Id: ```"..user_id.."```\nHan prøver at exploit dette script!\nOmdan Item:\n```"..omdanitem.."```\nItem:```"..item.."```", "Lavet af Notepad", omdanlogs)
        end
    else
        sendToDiscord(16753920, "[Notepad's Drugs System]", "Spiller Id: ```"..user_id.."```\nHan prøver at exploit dette script!\nOmdan Item:\n```"..omdanitem.."```\nItem:```"..item.."```", "Lavet af Notepad", omdanlogs)
    end
end)
