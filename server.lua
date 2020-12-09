--Coded by Albo1125.

local jailPassword = "pswd"
local defaultHospital = "pillbox"
local defaultsecs = 10
local maxsecs = 60

-----------------------------
local locShort = nil
local locName = nil
-----------------------------

AddEventHandler('chatMessage', function(source, n, message)
    cm = stringsplit(message, " ")
	if cm[1] == "/jail" then
		CancelEvent()
		if tablelength(cm) > 2 then
			if cm[2] == jailPassword then
				local tPID = tonumber(cm[3])
				local jT = defaultsecs
				if tablelength(cm) > 3 then
					if cm[4] ~= nil then
						jT = tonumber(cm[4])				
					end
				end
				if jT > maxsecs then
					jT = maxsecs
				end
				if GetPlayerName(tPID) ~= nil then
					print("Jailing ".. GetPlayerName(tPID).. " for ".. jT .." secs - entered by ".. GetPlayerName(source))
					TriggerClientEvent("JP", tPID, jT)
					TriggerClientEvent('chatMessage', -1, 'JUDGE', { 0, 0, 0 }, GetPlayerName(tPID) ..' jailed for '.. jT ..' secs')
				end
			else
				print("Incorrect jailPassword entered by ".. GetPlayerName(source))
			end
		end
	end
end)

AddEventHandler('chatMessage', function(source, n, message)
    cm = stringsplit(message, " ")
    if cm[1] == "/hospitalize" then
		CancelEvent()
		if tablelength(cm) > 1 then
			local tPID = tonumber(cm[2])
			local hT = defaultsecs
			if tablelength(cm) > 2 then
				loc = locLookup(cm[3])
			else
				loc = locLookup(defaultHospital)
			end
			
			if GetPlayerName(tPID) ~= nil then
				print("Hospitalizing ".. GetPlayerName(tPID).. " for ".. hT .." secs at " .. locName .. " - entered by ".. GetPlayerName(source))
				TriggerClientEvent("HP", tPID, hT, locShort)
				TriggerClientEvent('chatMessage', -1, 'Doctor', { 0, 0, 0 }, GetPlayerName(tPID) ..' is in recovery for '.. hT ..' secs at '.. locName)
			end
		end
	end
end)


print('Jailer by Albo1125 (LUA, FXServer, FiveM).')
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function locLookup(str)
	if str == "sandy" then
		locShort = str
		locName = "Sandy Shores Medical Center [3004]"
	else 
		locShort = "pillbox"
		locName = "Pillbox Hill Medical Center [8038]"
	end
end


--Coded by Albo1125