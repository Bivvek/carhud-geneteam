local hp = 0
local armor = 0
local hunger = 0
local thirst = 0
local oxygen = 100
local oxygen1 = 0
local isInVehicle = 0
local fuel = 0
local vehicleSpeed = 0
local ulica = "Strwaberry Ave"
local direction = 'N'
local Paused = false
local directions = {
    N = 360, 0,
    NE = 315,
    E = 270,
    SE = 225,
    S = 180,
    SW = 135,
    W = 90,
    NW = 45
}

local zoness = 'Ease Vinewood'

local Zones = {
	['AIRP'] = 'Los Santos International Airport',
	['ALAMO'] = 'Alamo Sea',
	['ALTA'] = 'Alta',
	['ARMYB'] = 'Fort Zancudo',
	['BANHAMC'] = 'Banham Canyon Dr',
	['BANNING'] = 'Banning',
	['BEACH'] = 'Vespucci Beach',
	['BHAMCA'] = 'Banham Canyon',
	['BRADP'] = 'Braddock Pass',
	['BRADT'] = 'Braddock Tunnel',
	['BURTON'] = 'Burton',
	['CALAFB'] = 'Calafia Bridge',
	['CANNY'] = 'Raton Canyon',
	['CCREAK'] = 'Cassidy Creek',
	['CHAMH'] = 'Chamberlain Hills',
	['CHIL'] = 'Vinewood Hills',
	['CHU'] = 'Chumash',
	['CMSW'] = 'Chiliad Mountain State Wilderness',
	['CYPRE'] = 'Cypress Flats',
	['DAVIS'] = 'Davis',
	['DELBE'] = 'Del Perro Beach',
	['DELPE'] = 'Del Perro',
	['DELSOL'] = 'La Puerta',
	['DESRT'] = 'Grand Senora Desert',
	['DOWNT'] = 'Downtown',
	['DTVINE'] = 'Downtown Vinewood',
	['EAST_V'] = 'East Vinewood',
	['EBURO'] = 'El Burro Heights',
	['ELGORL'] = 'El Gordo Lighthouse',
	['ELYSIAN'] = 'Elysian Island',
	['GALFISH'] = 'Galilee',
	['GOLF'] = 'GWC and Golfing Society',
	['GRAPES'] = 'Grapeseed',
	['GREATC'] = 'Great Chaparral',
	['HARMO'] = 'Harmony',
	['HAWICK'] = 'Hawick',
	['HORS'] = 'Vinewood Racetrack',
	['HUMLAB'] = 'Humane Labs and Research',
	['ISHEIST'] = 'Cayo Perico',
	['JAIL'] = 'Bolingbroke Penitentiary',
	['KOREAT'] = 'Little Seoul',
	['LACT'] = 'Land Act Reservoir',
	['LAGO'] = 'Lago Zancudo',
	['LDAM'] = 'Land Act Dam',
	['LEGSQU'] = 'Legion Square',
	['LMESA'] = 'La Mesa',
	['LOSPUER'] = 'La Puerta',
	['MIRR'] = 'Mirror Park',
	['MORN'] = 'Morningwood',
	['MOVIE'] = 'Richards Majestic',
	['MTCHIL'] = 'Mount Chiliad',
	['MTGORDO'] = 'Mount Gordo',
	['MTJOSE'] = 'Mount Josiah',
	['MURRI'] = 'Murrieta Heights',
	['NCHU'] = 'North Chumash',
	['NOOSE'] = 'N.O.O.S.E',
	['OCEANA'] = 'Pacific Ocean',
	['PALCOV'] = 'Paleto Cove',
	['PALETO'] = 'Paleto Bay',
	['PALFOR'] = 'Paleto Forest',
	['PALHIGH'] = 'Palomino Highlands',
	['PALMPOW'] = 'Palmer-Taylor Power Station',
	['PBLUFF'] = 'Pacific Bluffs',
	['PBOX'] = 'Pillbox Hill',
	['PROCOB'] = 'Procopio Beach',
	['RANCHO'] = 'Rancho',
	['RGLEN'] = 'Richman Glen',
	['RICHM'] = 'Richman',
	['ROCKF'] = 'Rockford Hills',
	['RTRAK'] = 'Redwood Lights Track',
	['SANAND'] = 'San Andreas',
	['SANCHIA'] = 'San Chianski Mountain Range',
	['SANDY'] = 'Sandy Shores',
	['SKID'] = 'Mission Row',
	['SLAB'] = 'Stab City',
	['STAD'] = 'Maze Bank Arena',
	['STRAW'] = 'Strawberry',
	['TATAMO'] = 'Tataviam Mountains',
	['TERMINA'] = 'Terminal',
	['TEXTI'] = 'Textile City',
	['TONGVAH'] = 'Tongva Hills',
	['TONGVAV'] = 'Tongva Valley',
	['VCANA'] = 'Vespucci Canals',
	['VESP'] = 'Vespucci',
	['VINE'] = 'Vinewood',
	['WINDF'] = 'Ron Alternates Wind Farm',
	['WVINE'] = 'West Vinewood',
	['ZANCUDO'] = 'Zancudo River',
	['ZP_ORT'] = 'Port of South Los Santos',
	['ZQ_UAR'] = 'Davis Quartz'
}


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    Citizen.Wait(100)
    PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(400)

        hp = GetEntityHealth(PlayerPedId()) / GetPedMaxHealth(PlayerPedId()) * 100
        --print(hp)
        
        armor = GetPedArmour(PlayerPedId())
        --print(armor)

        if GetPlayerUnderwaterTimeRemaining(PlayerId()) > oxygen1 then
            oxygen1 = GetPlayerUnderwaterTimeRemaining(PlayerId())
        end
        oxygen = GetPlayerUnderwaterTimeRemaining(PlayerId()) / oxygen1 * 100
        --print(oxygen)

        Paused = ThefeedIsPaused()

        TriggerEvent('esx_status:getStatus', 'hunger', function(status)
            hunger = status.val / 1000000 * 100
            --print(hunger)
        TriggerEvent('esx_status:getStatus', 'thirst', function(status)
            thirst = status.val / 1000000 * 100
            --print(thirst)
        TriggerEvent('esx_status:getStatus', 'stress', function(status)
            stress = status.val / 1000000 * 100
            --print(thirst)    
        end)
        end)
        end)

        ESX.TriggerServerCallback('hud:voice', function(data)
            if data ~= nil then
                SendNUIMessage({ type = 'VOICE', mode = data })
            else
                if NetworkGetTalkerProximity() == 1.5 then
                    SendNUIMessage({ type = 'VOICE', mode = 'Whisper' })
                elseif NetworkGetTalkerProximity() == 3.0 then
                    SendNUIMessage({ type = 'VOICE', mode = 'Normal' })
                elseif NetworkGetTalkerProximity() == 6.0 then
                    SendNUIMessage({ type = 'VOICE', mode = 'Shouting' })
                end
            end
        end)

        local voiceOn = MumbleIsPlayerTalking(PlayerId())


        --carhud

        local inVehicle = IsPedInAnyVehicle(PlayerPedId(), false)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local playerHeading = GetEntityHeading(PlayerPedId())
        local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)

        if inVehicle then
            local asd, dsa = GetStreetNameAtCoord(playerCoords.x, playerCoords.y, playerCoords.z, Citizen.ResultAsInteger(), Citizen.ResultAsInteger())
            fuel = GetVehicleFuelLevel(vehicle)
            ulica = GetStreetNameFromHashKey(asd)
            local zone = GetNameOfZone(playerCoords.x, playerCoords.y, playerCoords.z)
		    zoness = Zones[zone:upper()] or zone:upper()
            vehicleSpeed = (math.floor(GetEntitySpeed(PlayerPedId())*3.6))
            for k, v in pairs(directions) do
                if (math.abs(playerHeading - v) < 22.5) then
                    direction = k
        
                    if (direction == 1) then
                        direction = 'N'
                        break
                    end
        
                    break
                end
            end
        end

        SendNUIMessage({
            type = "UPDATE",
            hp = hp,
            armor = armor,
            hunger = hunger,
            thirst = thirst,
            voiceOn = voiceOn,
            oxygen = oxygen,
            stress = stress,

            inVehicle = inVehicle,
            vehicleSpeed = vehicleSpeed,
            carFuel = fuel,
            location = ulica,
            direction = direction,
            zone = zoness,
            gamePaused = Paused
        })

    end
end)

Citizen.CreateThread(function()
    local minimap = RequestScaleformMovie("minimap")
    SetRadarBigmapEnabled(false, false)
    Wait(1500)
    SetRadarBigmapEnabled(false, false)
    while true do
        Wait(1500)
        BeginScaleformMovieMethod(minimap, "SETUP_HEALTH_ARMOUR")
        ScaleformMovieMethodAddParamInt(3)
        EndScaleformMovieMethod()
    end
end)

-- Usuwanie minimapki w momencie gdy gracz nie jest w pojeździe 
Citizen.CreateThread(function()
    Citizen.Wait(1500)
    while true do
        local sleepThread = 1500
        local radarEnabled = IsRadarEnabled()
        if not IsPedInAnyVehicle(PlayerPedId()) and radarEnabled then
            DisplayRadar(false)
        elseif IsPedInAnyVehicle(PlayerPedId()) and not radarEnabled then
            DisplayRadar(true)
        end
        Citizen.Wait(sleepThread)
    end
end)

RegisterCommand('tp', function(source, args, rawCommand)
    if tonumber(args[1]) ~= nil and tonumber(args[2]) ~= nil and tonumber(args[3]) ~= nil then
    local posx = tonumber(args[1])
    local posy = tonumber(args[2])
    local posz = tonumber(args[3])
    local coords = { x = posx, y = posy, z = posz}
    ESX.Game.Teleport(PlayerPedId(), coords)
    end
    end)