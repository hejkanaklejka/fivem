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
		if clientPlayerNumber ~= serverPlayerNumber then -- For first spawn solo
			DropPlayer(source, '[Kick] Solo session.') -- kick player
			print("sendSession:PlayerNumber clientPlayerNumber-"..clientPlayerNumber.." serverPlayerNumber-"..serverPlayerNumber) -- debug
		end
	end
end)

AddEventHandler( 'playerConnecting', function( name, setReason )  -- Fix player connecting
	TriggerClientEvent('sendSession:PlayerConnecting', -1, name)
	print("----------------sendSession:PlayerConnecting "..name)
end)

RegisterServerEvent('sendSession:PlayerSpawned') -- Fix player connecting
AddEventHandler('sendSession:PlayerSpawned', function()
	TriggerClientEvent('sendSession:PlayerSpawned', -1, GetPlayerName(source))
	print("----------------sendSession:PlayerSpawned "..GetPlayerName(source))
end)

AddEventHandler("playerDropped",function(reason) -- Fix player connecting
	TriggerClientEvent('sendSession:PlayerSpawned', -1, GetPlayerName(source))
	print("----------------playerDropped:sendSession:PlayerDroped "..GetPlayerName(source))
end)




-- Check for update
local CurrentVersion = [[3.1
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
