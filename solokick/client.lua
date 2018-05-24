local state_ready = false

AddEventHandler("playerSpawned",function() -- delay state recording
	SetTimeout(30000, function()
		state_ready = true
	end)
end)

RegisterNetEvent("sendSession:CheckSoloPlayer")
AddEventHandler("sendSession:CheckSoloPlayer", function(timer)
	if state_ready then
		TriggerServerEvent('sendSession:PlayerNumber', GetNumberOfPlayers())
		print("sendSession:PlayerNumber")
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			Citizen.Wait(10000)
			TriggerServerEvent( "sendSession:firstJoin")
			print("sendSession:firstJoin")
			return
		end
	end
end)
