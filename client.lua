--Coded by Albo1125.

penitentiary = {x = 1677.233, y = 2658.618, z = 45.216}
penitentiaryR = {x = 1855.807, y = 2601.949, z = 45.323}

HOSPITAL = {
pillbox = {x = 348.73, y = -571.14, z = 29.5},
pillboxR = {x = 350.64, y = -582.11, z = 29.5},
sandy = {x = 1825.98, y = 3675.14, z = 34.37},
sandyR = {x = 1835.27, y = 3675.01, z = 34.37},
--paleto = {x = -247.1, y = 6330.68, z = 32.53},
--paletoR = {x = -247.1, y = 6330.68, z = 32.53}
}

---------------------
local cJ = false
local eJE = false
local cH = false
local eHE = false
---------------------
RegisterNetEvent("JP")
AddEventHandler("JP", function(jT)
	if cJ == true then
		return
	end
	local pP = GetPlayerPed(-1)
	if DoesEntityExist(pP) then
		
		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, penitentiary.x, penitentiary.y, penitentiary.z)
			cJ = true
			eJE = false
			while jT > 0 and not eJE do
				pP = GetPlayerPed(-1)
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				if jT % 5 == 0 then
					TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, jT .." more seconds until release.")
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local D = Vdist(penitentiary.x, penitentiary.y, penitentiary.z, pL['x'], pL['y'], pL['z'])
				if D > 90 then
					SetEntityCoords(pP, penitentiary.x, penitentiary.y, penitentiary.z)
					if D > 100 then
						jT = jT + 60
						if jT > 1500 then
							jT = 1500
						end
						TriggerEvent('chatMessage', 'JUDGE', { 0, 0, 0 }, "Your jail time was extended for an unlawful escape attempt.")
						Citizen.Wait(5000)
					end
				end
				jT = jT - 0.5
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." was released from jail.")
			SetEntityCoords(pP, penitentiaryR.x, penitentiaryR.y, penitentiaryR.z)
			cJ = false
			SetEntityInvincible(pP, false)
		end)
	end
end)

RegisterNetEvent("HP")
AddEventHandler("HP", function(hT, location)
	if cH == true then
		return
	end
	local pP = GetPlayerPed(-1)
	local loc = location
	local locR = location .. 'R'
	if DoesEntityExist(pP) then
		
		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, HOSPITAL[loc].x, HOSPITAL[loc].y, HOSPITAL[loc].z)
			cH = true
			eHE = false
			while hT > 0 and not eHE do
				pP = GetPlayerPed(-1)
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				if hT % 10 == 0 then
					TriggerEvent('chatMessage', 'SYSTEM', { 0, 0, 0 }, hT .." more seconds until release.")
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local D = Vdist(HOSPITAL[loc].x, HOSPITAL[loc].y, HOSPITAL[loc].z, pL['x'], pL['y'], pL['z'])
				if D > 10 then
					SetEntityCoords(pP, HOSPITAL[loc].x, HOSPITAL[loc].y, HOSPITAL[loc].z)
					if D > 100 then
						hT = hT + 60
						if hT > 1500 then
							hT = 1500
						end
						TriggerEvent('chatMessage', 'Doctor', { 0, 0, 0 }, "Your hospitalization was extended, you were hurt while trying to leave.")
						Citizen.Wait(5000)
					end
				end
				hT = hT - 0.5
			end
			TriggerServerEvent('chatMessageEntered', "SYSTEM", { 0, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
			SetEntityCoords(pP, HOSPITAL[locR].x, HOSPITAL[locR].y, HOSPITAL[locR].z)
			cH = false
			SetEntityInvincible(pP, false)
		end)
	end
end)

RegisterNetEvent("UnJP")
AddEventHandler("UnJP", function()
	eJE = true
end)

RegisterNetEvent("UnHP")
AddEventHandler("UnHP", function()
	eHE = true
end)


--Coded by Albo1125 Modified by TrevorBarns