-- @centro de trabajos

-- @func
function SetJob(playerId, jobName)
  local xPlayer = ESX.GetPlayerFromId(playerId)

  if xPlayer then
      xPlayer.setJob(jobName, 0)
  end
end

-- @events

RegisterServerEvent('gta_muni:setJob-garbage') -- @basurero
AddEventHandler('gta_muni:setJob-garbage', function()
  SetJob(source, 'garbage')

  local basureroJobCoords = vector3(-320.2819519043,-1545.5126953125,27.784139633179)

  TriggerClientEvent('gta_muni:setWaypoint', source, basureroJobCoords)
end)

RegisterServerEvent('gta_muni:setJob-lumberjack') -- @leñador
AddEventHandler('gta_muni:setJob-lumberjack', function()
  SetJob(source, 'lumberjack')

  local LeniaJobCoords = vector3(-533.93267822266,5286.5625,74.174217224121)

  TriggerClientEvent('gta_muni:setWaypoint', source, LeniaJobCoords)
end)

RegisterServerEvent('gta_muni:setJob-miner') -- @minero
AddEventHandler('gta_muni:setJob-miner', function()
  SetJob(source, 'miner')

  local MineroJobCoords = vector3(2950.8122558594,2747.9555664063,43.478336334229)

  TriggerClientEvent('gta_muni:setWaypoint', source, MineroJobCoords)
end)

RegisterServerEvent('gta_muni:setJob-unemployed') -- @desempleado
AddEventHandler('gta_muni:setJob-unemployed', function()
  SetJob(source, 'unemployed')
end)

-- @blip set whitelist jobs

RegisterServerEvent('gta_muni:setBlipPFA') -- @pfa
AddEventHandler('gta_muni:setBlipPFA', function()
  local pfaComisaria = vector3(425.08969116211,-979.50360107422,30.710718154907)
  TriggerClientEvent('gta_muni:setWaypoint', source, pfaComisaria)
end)

RegisterServerEvent('gta_muni:setBlipHospital') -- @same
AddEventHandler('gta_muni:setBlipHospital', function()
  local sameHospital = vector3(-839.92315673828,-1207.5936279297,6.6259179115295)
  TriggerClientEvent('gta_muni:setWaypoint', source, sameHospital)
end)

-- @licencias

RegisterServerEvent('comprarLicenciaServer')
AddEventHandler('comprarLicenciaServer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Precio de la licencia
    local price = 10000

    TriggerEvent('esx_license:checkLicense', _source, 'weapon', function(hasLicense)
        if hasLicense then
            -- Notificación para el jugador
            TriggerClientEvent('esx:showNotification', _source, '<i class="fa-solid fa-circle-check fa-bounce" style="color:#00b837;"></i>  <span style="color:white;">  Ya tenes Licencia de Armas!</span>')
        else
            -- Verifica si el jugador tiene suficiente dinero
            if xPlayer.getMoney() >= price then
                -- Resta el dinero al jugador
                xPlayer.removeMoney(price)

                -- Agrega la licencia al jugador
                TriggerEvent('esx_license:addLicense', _source, 'weapon', function()
                    -- Notificación para el jugador
                    TriggerClientEvent('esx:showNotification', _source, '<i class="fa-solid fa-circle-check fa-bounce" style="color:#00b837;"></i>  <span style="color:white;">  Compraste la licencia por </span><span style="color:green;">$</span>' .. price)
                end)
            else
                -- Notificación para el jugador
                TriggerClientEvent('esx:showNotification', _source, '<i class="fa-solid fa-circle-exclamation" style="color: #ff0000;"></i>  <span style="color:white;"> No tenes suficiente Dinero!</span>')
            end
        end
    end)
end)

RegisterServerEvent('verLicenciasServer')
AddEventHandler('verLicenciasServer', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    -- Obtén las licencias del jugador
    TriggerEvent('esx_license:getLicenses', _source, function(licenses)
        local licenciasStr = ""
        for i=1, #licenses, 1 do
            licenciasStr = licenciasStr .. licenses[i].type .. "\n"
        end

        -- Notificación para el jugador
        TriggerClientEvent('esx:showNotification', _source, '<i class="fa-solid fa-bookmark" style="color:#e8ab02;padding:5px;"></i><span style="color:white;font-weight:bold;font-style:italic;">Tus Licencias</span> <span style="color:white;"><hr></span> <span style="color:white;">Tus Licencias en posesion <i class="fa-solid fa-check fa-bounce"></i> son</span><div style="padding:5px;background-color:#4854ff6a;border-radius:5px;text-align:center;color:white;">['..licenciasStr..']</div>')
    end)
end)