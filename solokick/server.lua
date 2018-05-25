local function countPlayer() -- count all players
	local counter = 0
	for _ in pairs(GetPlayers()) do
		counter = counter + 1
	end
	return counter
end

RegisterServerEvent('sendSession:PlayerNumber')
AddEventHandler('sendSession:PlayerNumber', function(clientPlayerNumber)
	if source ~= nil then
		serverPlayerNumber = countPlayer()
		if serverPlayerNumber-clientPlayerNumber > 2 then 
			DropPlayer(source, '[Kick] Solo session.') -- Kick player
			print("sendSession:PlayerNumber clientPlayerNumber-"..clientPlayerNumber.." serverPlayerNumber-"..serverPlayerNumber) -- Debug
		end
	end
end)

AddEventHandler( 'playerConnecting', function( name, setReason )  -- Fix player connecting
	-- 'source' now working on playerConnecting event.
	TriggerClientEvent('sendSession:PlayerConnecting', -1, name)
	print("------Solo PlayerConnecting "..name.."------") -- Debug
end)

RegisterServerEvent('sendSession:PlayerSpawned') -- Fix player connecting
AddEventHandler('sendSession:PlayerSpawned', function()
	TriggerClientEvent('sendSession:PlayerSpawned', -1, GetPlayerName(source))
	print("------Solo PlayerSpawned "..GetPlayerName(source).."------") -- Debug
end)

AddEventHandler("playerDropped",function(reason) -- Fix player connecting
	TriggerClientEvent('sendSession:PlayerSpawned', -1, GetPlayerName(source))
	print("------Solo PlayerDroped "..GetPlayerName(source).."------") -- Debug
end)




-- Check for update
local CurrentVersion = [[3.2
]]
PerformHttpRequest('https://raw.githubusercontent.com/chaixshot/fivem/master/solokick/version', function(Error, NewestVersion, Header)
	if CurrentVersion ~= NewestVersion then
		print('\n')
		print('##')
		print('## Solo Kick')
		print('##')
		print('## Current Version: ' .. CurrentVersion)
		print('## Newest Version: ' .. NewestVersion)
		print('##')
		print('## Download')
		print('## https://github.com/chaixshot/fivem/tree/master/solokick')
		print('##')
		print('\n')
	end
end)
