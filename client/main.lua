-- @marker

Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)

      local playerCoords = GetEntityCoords(PlayerPedId())
      local distance = Vdist(playerCoords.x, playerCoords.y, playerCoords.z, Config.Marker.x, Config.Marker.y, Config.Marker.z)

      if distance <= 3.0 then
          ESX.ShowFloatingHelpNotification("~INPUT_CONTEXT~ - Municipalidad", vector3(Config.Marker.x, Config.Marker.y, Config.Marker.z + 2))

          if IsControlJustReleased(0, 38) then
              ShowJobListingMenu()
          end
      end
  end
end)

-- @blip

Citizen.CreateThread(function()
  local blip = AddBlipForCoord(Config.Marker.x, Config.Marker.y, Config.Marker.z)

  SetBlipSprite(blip, Config.Marker.Blip.Sprite)
  SetBlipDisplay(blip, Config.Marker.Blip.Display)
  SetBlipScale(blip, Config.Marker.Blip.Scale)
  SetBlipColour(blip, Config.Marker.Blip.Colour)
  SetBlipAsShortRange(blip, Config.Marker.Blip.ShortRange)

  BeginTextCommandSetBlipName("STRING")
  AddTextComponentSubstringPlayerName(Config.Marker.Blip.Name)
  EndTextCommandSetBlipName(blip)
end)

-- @npc

Citizen.CreateThread(function()
  for _, npcConfig in pairs(Config.Npc) do
      RequestModel(GetHashKey(npcConfig.model))
      while not HasModelLoaded(GetHashKey(npcConfig.model)) do
          Wait(1)
      end

      RequestAnimDict(npcConfig.animDict)
      while not HasAnimDictLoaded(npcConfig.animDict) do
          Wait(1)
      end

      local ped = CreatePed(4, npcConfig.model, npcConfig.x, npcConfig.y, npcConfig.z, 3374176, false, true)
      SetEntityHeading(ped, npcConfig.heading)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped, npcConfig.animDict, npcConfig.animName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
  end
end)

---- @code

-- @funcs

function SetJob(jobName)
  TriggerServerEvent('gta_muni:setJob-' .. jobName)
end

-- Esta función establece el waypoint en el GPS del jugador - This function sets the waypoint on the player's GPS.
RegisterNetEvent('gta_muni:setWaypoint')
AddEventHandler('gta_muni:setWaypoint', function(gps)
    SetNewWaypoint(gps.x, gps.y)
end)

-- @menu

function ShowJobListingMenu()
  local alert = lib.alertDialog({
    header = '✨ Municipalidad GTA:ARG',
    content = 'Bienvenido a la Municipalidad de GTA:ARG. Aqui podras gestionar tus licecias, Elegir un trabajo, etc. ¿Deseas Continuar?',
    centered = true,
    cancel = true
  })

  if alert == 'confirm' then
      lib.registerContext({
        id = 'municipalidad',
        title = '✨ Municipalidad',
        options = {
          {
            title = 'Gestionar Licencias',
            description = 'Aqui podras gestionar tus licencias',
            icon = 'id-card',
            iconColor = '#ff8000',
            menu = 'licencias_menu',
          },
          {
            title = 'Centro de Trabajos',
            description = 'Aqui podras elegir los trabajos disponibles.',
            icon = 'briefcase',
            iconColor = '#ff8000',
            menu = 'trabajos_menu',
          },
          {
            title = 'Ver Facciones',
            description = 'Aqui ver los trabajos como policia,same.',
            icon = 'business-time',
           iconColor = '#ff8000',
            menu = 'trabajoswhitelist_menu',
          }
        }
      })
      lib.showContext('municipalidad')
      ESX.UI.Menu.CloseAll()
  end
end

lib.registerContext({
  id = 'trabajos_menu',
  title = '🍎 Centro de Trabajo',
  menu = 'municipalidad',
  onBack = function()
    exports['gta_notify']:NormalNoti('success', 'Volviste a la Municipalidad')
  end,
  options = {
    {
      title = 'Basurero',
      icon = 'recycle',
      iconColor = '#49E60A',
      onSelect = function()
        SetJob('garbage')
        exports['gta_notify']:CustomNoti('success', '<i class="fa-solid fa-circle-check" style="color:#2eff46;padding:5px;"></i> <span class="title">¡Trabajo nuevo!</span> <hr> <div><span>Elegiste el trabajo de <span style="color:pink;" class="bold">Basurero <i class="fa-solid fa-trash-can"></i></span>. La ubicacion de tu trabajo fue <span style="color:#4853FF;" class="bold"><i class="fa-solid fa-location-dot fa-bounce"></i> ubicada</span> en tu GPS. Recuerda <span style="color:#FF8848;" class="bold">respetar las normativas</span> de la ciudad.</span></div><div>&nbsp;</div><div class="core">Municipalidad de GTA:ARG</div>', 10000)
      end,
    },
    {
      title = 'Leñador',
      icon = 'tree',
      iconColor = '#49E60A',
      onSelect = function()
        SetJob('lumberjack')
		exports['gta_notify']:CustomNoti('success', '<i class="fa-solid fa-circle-check" style="color:#2eff46;padding:5px;"></i> <span class="title">¡Trabajo nuevo!</span> <hr> <div><span>Elegiste el trabajo de <span style="color:pink;" class="bold">Leñador <i class="fa-solid fa-tree"></i></span></span>. La ubicacion de tu trabajo fue <span style="color:#4853FF;" class="bold"><i class="fa-solid fa-location-dot fa-bounce"></i> ubicada</span> en tu GPS. Recuerda <span style="color:#FF8848;" class="bold">respetar las normativas</span> de la ciudad.</span></div><div>&nbsp;</div><div class="core">Municipalidad de GTA:ARG</div>', 10000)
      end,
    },
    {
      title = 'Minero',
      icon = 'truck-pickup',
      iconColor = '#49E60A',
      onSelect = function()
        SetJob('miner')
		exports['gta_notify']:CustomNoti('success', '<i class="fa-solid fa-circle-check" style="color:#2eff46;padding:5px;"></i> <span class="title">¡Trabajo nuevo!</span> <hr> <div><span>Elegiste el trabajo de <span style="color:pink;" class="bold">Minero <i class="fa-solid fa-truck-pickup"></i></span></span>. La ubicacion de tu trabajo fue <span style="color:#4853FF;" class="bold"><i class="fa-solid fa-location-dot fa-bounce"></i> ubicada</span> en tu GPS. Recuerda <span style="color:#FF8848;" class="bold">respetar las normativas</span> de la ciudad.</span></div><div>&nbsp;</div><div class="core">Municipalidad de GTA:ARG</div>', 10000)
      end,
    },
    {
      title = 'Desempleado',
      description = 'Dejaras tu trabajo actual y recibiras un plan economico.',
      icon = 'circle-xmark',
      iconColor = '#FF4848',
      onSelect = function()
        SetJob('unemployed')
        exports['gta_notify']:CustomNoti('success', '<i class="fa-solid fa-circle-check" style="color: #2eff46;padding:5px;"></i> <span style="color:white;font-weight:bold;font-style:italic;">¡Ahora estas desempleado!</span> <hr> <div><span>Decidiste estar <span style="color:pink;">Desempleado <i class="fa-solid fa-person-walking-luggage"></i></span>. Recibiras un plan economico de <span style="color:#74FF48;"><i class="fa-solid fa-sack-dollar"></i> $10.000 ARS</span> en tu Banco. Recuerda <span style="color:#FF8848;">respetar las normativas</span> de la ciudad.</span></div><div>&nbsp;</div><div style="padding:5px;background-color:#4854ff6a;border-radius:5px;text-align: center;">Municipalidad de GTA:ARG</div>', 10000)
      end,
      metadata = {
        {label = 'Plan Economico', value = '$10000 Por Mes'}
      },
    }
  }
})

lib.registerContext({
  id = 'trabajoswhitelist_menu',
  title = '🍎 Trabajos Whitelist',
  menu = 'municipalidad',
  onBack = function()
    exports['gta_notify']:NormalNoti('success', 'Volviste a la Municipalidad')
  end,
  options = {
    {
      title = 'P.F.A - Whitelist',
      icon = 'handcuffs',
      --readOnly = true,
      iconColor = '#4B71FF',
      description = 'Trabajo Whitelist de alto riesgo. La P.F.A protege con valentía, sirviendo a la comunidad con integridad para mantener la paz y seguridad.',
      onSelect = function()
        TriggerServerEvent('gta_muni:setBlipPFA')
        exports['gta_notify']:CustomNoti('success', '<i class="fa-solid fa-circle-question" style="color: #FF8C4B;padding:5px;"></i> <span style="color:white;font-weight:bold;font-style:italic;">¿Deseas ser Policia?</span> <hr> <div><span>Te marcamos la <span style="color:#4853FF;"><i class="fa-solid fa-location-dot fa-bounce"></i> Comisaria Activa</span> en tu GPS. Recuerda <span style="color:#FF8848;">respetar las normativas</span> de la ciudad.</span></div><div>&nbsp;</div><div style="padding:5px;background-color:#4854ff6a;border-radius:5px;text-align: center;">Municipalidad de GTA:ARG</div>', 10000)
      end,
    },
    {
      title = 'S.A.M.E - Whitelist',
      icon = 'truck-medical',
      --readOnly = true,
      description = 'Trabajo Whitelist de bajo riesgo. El S.A.M.E dedica su vida a cuidar la salud de otros, aplicando conocimientos y compasión para aliviar el sufrimiento y promover el bienestar.',
      iconColor = '#71FF4B',
      onSelect = function()

        TriggerServerEvent('gta_muni:setBlipHospital')
        exports['gta_notify']:CustomNoti('success', '<i class="fa-solid fa-circle-question" style="color: #FF8C4B;padding:5px;"></i> <span style="color:white;font-weight:bold;font-style:italic;">¿Deseas ser Medico?</span> <hr> <div><span>Te marcamos el <span style="color:green;"><i class="fa-solid fa-location-dot fa-bounce"></i> Hospital Activo</span> en tu GPS. Recuerda <span style="color:#FF8848;">respetar las normativas</span> de la ciudad.</span></div><div>&nbsp;</div><div style="padding:5px;background-color:#4854ff6a;border-radius:5px;text-align: center;">Municipalidad de GTA:ARG</div>', 10000)
      end,
    },
    {
      title = 'A.C.A - Whitelist',
      icon = 'toolbox',
      description = 'Trabajo Whitelist de bajo riesgo. El mecánico es el experto que resuelve problemas, manteniendo vehículos en funcionamiento y asegurando que la movilidad siga adelante con eficiencia y seguridad.',
      --iconColor = '#FF8F4B',
      disabled = true,
      onSelect = function()
      end,
    }
  }
})

lib.registerContext({
  id = 'licencias_menu',
  title = '🍎 Gestiona tus Licencias',
  menu = 'municipalidad',
  onBack = function()
    exports['gta_notify']:NormalNoti('success', 'Volviste a la Municipalidad')
  end,
  options = {
    {
      title = 'Comprar Licencia de Armas $10000',
      icon = 'id-card',
      iconColor = '#7FFF4B',
      description = 'Compra tu licencia de armas pero recuerda que si es mal utilizada sera removida por un policia.',
      onSelect = function()
        TriggerServerEvent('comprarLicenciaServer')
      end,
    },
    {
      title = 'Ver tus licencias',
      icon = 'clipboard-check',
      description = 'Aqui podras ver tus licencias.',
      iconColor = '#71FF4B',
      onSelect = function()
        TriggerServerEvent('verLicenciasServer')
      end,
    }
  }
})