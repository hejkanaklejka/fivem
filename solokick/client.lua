local state_ready = false
local playerconnecting = 0
local PlayerConnectingId = {}

AddEventHandler("playerSpawned",function() -- Delay client state
	Citizen.Wait(30000)
	state_ready = true
end)

RegisterNetEvent("sendSession:PlayerConnecting") -- Call when other player connecting
AddEventHandler("sendSession:PlayerConnecting", function(PlayerId)
	if PlayerConnectingId[PlayerId] == nil then
		playerconnecting = playerconnecting+1
		PlayerConnectingId[PlayerId] = 1
		print("sendSession:playerconnecting: "..playerconnecting)
	end
end)

RegisterNetEvent("sendSession:PlayerSpawned") -- Call when other player connected
AddEventHandler("sendSession:PlayerSpawned", function(PlayerId)
	if PlayerConnectingId[PlayerId] ~= nil then
		playerconnecting = playerconnecting-1
		PlayerConnectingId[PlayerId] = nil
		print("sendSession:playerconnecting: "..playerconnecting)
	end
end)

Citizen.CreateThread(function() -- Check solo session every 1 minute
	while true do
		if state_ready and playerconnecting == 0 then
			TriggerServerEvent('sendSession:PlayerNumber', GetNumberOfPlayers())
			print("sendSession:PlayerNumber") -- Debug
			Wait(30000)
		end
		Wait(0)
	end
end)

AddEventHandler("playerSpawned",function() -- delay state recording
	TriggerServerEvent("sendSession:PlayerSpawned")
end)
