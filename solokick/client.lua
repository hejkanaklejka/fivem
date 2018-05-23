local state_ready = false
local playerconnecting = false

AddEventHandler("playerSpawned",function() -- delay state recording
	SetTimeout(60000, function()
		state_ready = true
	end)
end)

RegisterNetEvent("sendSession:DelayCheck")
AddEventHandler("sendSession:DelayCheck", function(timer)
	playerconnecting = true
	SetTimeout(timer ,function() -- Delay Checking
		playerconnecting= false
	end)
end)

Citizen.CreateThread(function()
	while true do
		if state_ready and not playerconnecting then
			TriggerServerEvent('sendSession:PlayerNumber', GetNumberOfPlayers())
			Wait(60000)
		end
		Wait(0)
	end
end)
