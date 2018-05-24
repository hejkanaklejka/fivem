local state_ready = false
local playerconnecting = false

AddEventHandler("playerSpawned",function() -- delay state recording
	Citizen.Wait(30000)
	state_ready = true
end)

RegisterNetEvent("sendSession:PlayerConnecting")
AddEventHandler("sendSession:PlayerConnecting", function()
	playerconnecting = true
	Citizen.Wait(120000)
	playerconnecting= false
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
