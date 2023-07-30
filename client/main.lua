 --[[

  $$\      $$\           $$\                   $$\                         
$$ | $\  $$ |          $$ |                  $$ |                        
$$ |$$$\ $$ | $$$$$$\  $$$$$$$\   $$$$$$$\ $$$$$$\    $$$$$$\   $$$$$$\  
$$ $$ $$\$$ |$$  __$$\ $$  __$$\ $$  _____|\_$$  _|  $$  __$$\ $$  __$$\ 
$$$$  _$$$$ |$$$$$$$$ |$$ |  $$ |\$$$$$$\    $$ |    $$$$$$$$ |$$ |  \__|
$$$  / \$$$ |$$   ____|$$ |  $$ | \____$$\   $$ |$$\ $$   ____|$$ |      
$$  /   \$$ |\$$$$$$$\ $$$$$$$  |$$$$$$$  |  \$$$$  |\$$$$$$$\ $$ |      
\__/     \__| \_______|\_______/ \_______/    \____/  \_______|\__|      
                                                                         
                                                                         
                                                                         
--]]



local UserGroup

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('sendProximityMessage')
AddEventHandler('sendProximityMessage', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
  end
end)

RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
  end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then

  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then

  end
end)

function GetPlayers()
    local players = {}
    for i = 0, 31 do
        if NetworkIsPlayerActive(i) then
            players[#players + 1] = i
        end
    end
    return players
end

RegisterNetEvent('poke_rpchat:sendProximityMessageB')
AddEventHandler('poke_rpchat:sendProximityMessageB', function(playerId, title, message, color)
	local source = PlayerId()
	local target = GetPlayerFromServerId(playerId)

	if target ~= -1 then
        local sourcePed, targetPed = PlayerPedId(), GetPlayerPed(target)
        local sourceCoords, targetCoords = GetEntityCoords(sourcePed), GetEntityCoords(targetPed)

        if targetPed == source or #(sourceCoords - targetCoords) < 20 then
            TriggerServerEvent("fuckmylife2", title, message, playerId)
        end
    end
end)


RegisterNetEvent('sendMessageAdmin')
AddEventHandler('sendMessageAdmin', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
		UserGroup = Group
		if pid == myId then
			TriggerServerEvent("fuckmylife", name, message)
		elseif UserGroup ~= 'user' and pid ~= myId then
			TriggerServerEvent("fuckmylife", name, message)
		end
  end)
end)


RegisterNetEvent('sendRelyMessage')
AddEventHandler('sendRelyMessage', function(id, target, name, message)
    print(target)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
		UserGroup = Group
		if pid == myId then
			TriggerServerEvent("sendtoownplayer", name, message)
		elseif pid ~= myId then
			TriggerServerEvent("sendreplytoplayer", target, name, message)
		end
end)

RegisterNetEvent('sendMessageAdmin2')
AddEventHandler('sendMessageAdmin2', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)
	ESX.TriggerServerCallback('esx_chatforadmin:GetGroup', function(Group)
		UserGroup = Group
		if pid == myId then
			TriggerServerEvent("sendtoownplayer2", name, message)
		elseif UserGroup ~= 'user' and pid ~= myId then
			TriggerServerEvent("fuckmylife3", id, name, message)
		end
  end)
end)

RegisterNetEvent('2')
AddEventHandler('2', function(playerId, playerName, msg, type, targetCoords)
	local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local target = GetPlayerFromServerId(playerId)
    
    local color = '41, 41, 41'
    local chattype = 'Lokal OOC'

    if target == player or #(playerCoords - targetCoords) <= 15.0 then
        if type == 'local' then
            color = '41, 41, 41'
            chattype = 'Lokal OOC'
        elseif type == 'me' then
            color = '51, 204, 51'
            chattype = 'ME'
        elseif type == 'do' then
            chattype = 'DO'
            color = '255, 102, 0'
        end
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin-top: 0.05vw; margin-bottom: 0.05vw; background-color: rgba(' .. color .. ', 0.8); border-radius: 3px;" class="testing animated zoomIn delay-2s"><i class="fas fa-globe"></i> <b style="font-weight:700;">' .. chattype .. ' @ {0}</b>: {1}</div>',
        })
	end
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/mobilepay', 'Betal en anden spiller vha. ID', {
        {name = "ID", help = "Spillerens ID"},
        {name = "Beløb", help = "Beløbet du vil overføre til personens konto"}
    })
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/removecomp', 'Fjern dine attachments', {
        {name = "Type", help = "silencer/scope/flashlight/clip/yusuf"},
    })
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/removeammo', 'Fjern ammunition', {
        {name = "Antal", help = "Antal"},
    })
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/removevest', 'Fjern skudsikkervest')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/toggleblip', 'Fjern/Tilføj GPS')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/anker', 'Sænk/Hæv GPS')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/a emsbag', 'Få en førstehjælpskasse frem')
end)

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/a', 'Fjern førstehjælpskasse')
end)


 --[[
  _____                  _  ____  _   _          
 |  __ \                (_)/ __ \| \ | |         
 | |__) |_ _ _ __   __ _ _| |  | |  \| |___  ___ 
 |  ___/ _` | '_ \ / _` | | |  | | . ` / __|/ _ \
 | |  | (_| | |_) | (_| | | |__| | |\  \__ \  __/
 |_|   \__,_| .__/ \__,_| |\____/|_| \_|___/\___|
            | |        _/ |                      
            |_|       |__/                                                                                            
--]]
