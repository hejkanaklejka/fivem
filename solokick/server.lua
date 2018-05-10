RegisterServerEvent('sendSessionPlayerNumber')
AddEventHandler('sendSessionPlayerNumber', function(clientPlayerNumber)
	if source ~= nil then
		serverPlayerNumber = countPlayer()
		if clientPlayerNumber ~= serverPlayerNumber and clientPlayerNumber == 1 then
			DropPlayer(source, '[Kick] Solo session.') -- kick player
			print("Solo session clientPlayerNumber-"..clientPlayerNumber.." serverPlayerNumber-"..serverPlayerNumber) -- debug
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