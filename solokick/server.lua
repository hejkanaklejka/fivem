RegisterServerEvent('sendSession:PlayerNumber')
AddEventHandler('sendSession:PlayerNumber', function(clientPlayerNumber)
	if source ~= nil then
		serverPlayerNumber = countPlayer()
		if clientPlayerNumber ~= serverPlayerNumber then -- Solo session check.
			DropPlayer(source, '[Kick] Solo session.') -- kick player
			print("Solo session. (clientPlayerNumber:"..clientPlayerNumber.." serverPlayerNumber:"..serverPlayerNumber..")") -- debug
		end
	end
end)

function countPlayer() -- count all players
	local counter = 0
	for _ in pairs(GetPlayers()) do
		counter = counter + 1
	end
	return counter
end

AddEventHandler("playerConnecting",function(name,setMessage) -- Fix player connecting
	TriggerClientEvent('sendSession:DelayCheck', -1, 120000)
end)

AddEventHandler("playerDropped",function(reason)
	TriggerClientEvent('sendSession:DelayCheck', -1, 60000)
end)

local CurrentVersion = '2.4'
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
