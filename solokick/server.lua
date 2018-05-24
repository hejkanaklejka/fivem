RegisterServerEvent('sendSession:firstJoin')
AddEventHandler("sendSession:firstJoin",function() -- Call when player spawned
	TriggerClientEvent('sendSession:CheckSoloPlayer', -1)
	print("sendSession:CheckSoloPlayer")
end)

RegisterServerEvent('sendSession:PlayerNumber')
AddEventHandler('sendSession:PlayerNumber', function(clientPlayerNumber) -- Check solo client
	if source ~= nil then
		serverPlayerNumber = countPlayer()
		if clientPlayerNumber < serverPlayerNumber then -- Solo session check.
			DropPlayer(source, '[Kick] Solo session.') -- kick player
			print("Solo session. (clientPlayerNumber:"..clientPlayerNumber.." serverPlayerNumber:"..serverPlayerNumber..")") -- debug
		end
	end
end)

function countPlayer() -- Count all server players
	local counter = 0
	for _ in pairs(GetPlayers()) do
		counter = counter + 1
	end
	return counter
end

-- Check for update
local CurrentVersion = [[3.0
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
