local state_ready = false
local playerconnecting = false

AddEventHandler("playerSpawned",function() -- Delay client state
	Citizen.Wait(30000)
	state_ready = true
end)

RegisterNetEvent("sendSession:PlayerConnecting") -- Call when other player connecting
AddEventHandler("sendSession:PlayerConnecting", function()
	playerconnecting = true
end)

RegisterNetEvent("sendSession:PlayerSpawned") -- Call when other player connected
AddEventHandler("sendSession:PlayerSpawned", function()
	playerconnecting= false
end)

Citizen.CreateThread(function() -- Check solo session every 1 minute
	while true do
		if state_ready and not playerconnecting then
			TriggerServerEvent('sendSession:PlayerNumber', GetNumberOfPlayers())
			print("sendSession:PlayerNumber") -- Debug
			Wait(60000)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function() -- Call when other player connected
 	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			TriggerServerEvent("sendSession:PlayerSpawned")
			return
		end
 	end
 end)
