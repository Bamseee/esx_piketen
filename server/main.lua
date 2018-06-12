ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj 
end)

if Config.MaxInService ~= -1 then
  TriggerEvent('esx_service:activateService', 'swat', Config.MaxInService)
end

TriggerEvent('esx_phone:registerNumber', 'swat', _U('alert_swat'), true, true)
TriggerEvent('esx_society:registerSociety', 'swat', 'Swat', 'society_swat', 'society_swat', 'society_swat', {type = 'public'})

RegisterServerEvent('esx_swatjob:giveWeapon')
AddEventHandler('esx_swatjob:giveWeapon', function(weapon, ammo)
  local xPlayer = ESX.GetPlayerFromId(source)
  
  xPlayer.addWeapon(weapon, ammo)
end)

RegisterServerEvent('esx_swatjob:spawnWeapon')
AddEventHandler('esx_swatjob:spawnWeapon', function(weapon, ammo, attachments, station)
  local xPlayer = ESX.GetPlayerFromId(source)
  
  xPlayer.addWeapon(weapon, ammo)
  
  if attachments == true then
	TriggerClientEvent('esx_swatjob:addAttachments', source, weapon, station)
  end
end)

RegisterServerEvent('esx_swatjob:confiscatePlayerItem')
AddEventHandler('esx_swatjob:confiscatePlayerItem', function(target, itemType, itemName, amount)

  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if itemType == 'item_standard' then

    local label = sourceXPlayer.getInventoryItem(itemName).label

    targetXPlayer.removeInventoryItem(itemName, amount)
    sourceXPlayer.addInventoryItem(itemName, amount)

    TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_have_confinv') .. amount .. ' ' .. label .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. _U('confinv') .. amount .. ' ' .. label )

  end

  if itemType == 'item_account' then

    targetXPlayer.removeAccountMoney(itemName, amount)
    sourceXPlayer.addAccountMoney(itemName, amount)

    TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_have_confdm') .. amount .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. _U('confdm') .. amount)

  end

  if itemType == 'item_weapon' then

    targetXPlayer.removeWeapon(itemName)
    sourceXPlayer.addWeapon(itemName, amount)

    TriggerClientEvent('esx:showNotification', sourceXPlayer.source, _U('you_have_confweapon') .. ESX.GetWeaponLabel(itemName) .. _U('from') .. targetXPlayer.name)
    TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~b~' .. targetXPlayer.name .. _U('confweapon') .. ESX.GetWeaponLabel(itemName))

  end

end)

RegisterServerEvent('esx_swatjob:handcuff')
AddEventHandler('esx_swatjob:handcuff', function(target)
  TriggerClientEvent('esx_swatjob:handcuff', target)
end)

RegisterServerEvent('esx_swatjob:drag')
AddEventHandler('esx_swatjob:drag', function(target)
  local _source = source
  TriggerClientEvent('esx_swatjob:drag', target, _source)
end)

RegisterServerEvent('esx_swatjob:putInVehicle')
AddEventHandler('esx_swatjob:putInVehicle', function(target)
  TriggerClientEvent('esx_swatjob:putInVehicle', target)
end)

RegisterServerEvent('esx_swatjob:OutVehicle')
AddEventHandler('esx_swatjob:OutVehicle', function(target)
    TriggerClientEvent('esx_swatjob:OutVehicle', target)
end)

function deleteLicense(owner, license)
    MySQL.Sync.execute("DELETE FROM user_licenses WHERE `owner` = @owner AND `type` = @license", {
        ['@owner'] = owner,
        ['@license'] = license,
    })
    print('Permis suppr - '..owner)
    print('Permis suppr - '..license)

end

RegisterServerEvent('esx_swatjob:license_see')
AddEventHandler('esx_swatjob:license_see', function(target)

  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  local identifier = GetPlayerIdentifiers(target)[1]


  TriggerClientEvent('esx:showNotification', sourceXPlayer.source, '~b~'..targetXPlayer.name)
  ShowPermis(source,identifier)




end)

function ShowPermis(source,identifier)
  local _source = source
  local licenses = MySQL.Sync.fetchAll("SELECT * FROM user_licenses where `owner`= @owner",{['@owner'] = identifier})

    for i=1, #licenses, 1 do

        if(licenses[i].type =="weapon")then
         TriggerClientEvent('esx:showNotification',_source,"Vapen License")
        end
        if(licenses[i].type =="dmv")then
            TriggerClientEvent('esx:showNotification',_source,"Körkorts skola")
        end
        if(licenses[i].type =="drive")then
            TriggerClientEvent('esx:showNotification',_source,"Körkort")
        end
        if(licenses[i].type =="drive_bike")then
           TriggerClientEvent('esx:showNotification',_source,"Motorcykellicens")
        end
        if(licenses[i].type =="drive_truck")then
          TriggerClientEvent('esx:showNotification',_source,"Lastbil licens")
        end


    end

end

RegisterServerEvent('esx_swatjob:deletelicense')
AddEventHandler('esx_swatjob:deletelicense', function(target, license)
  local text = ""
  local sourceXPlayer = ESX.GetPlayerFromId(source)
  local targetXPlayer = ESX.GetPlayerFromId(target)

  if(license =="weapon")then
    text= "Licens att bära ett vapen"
  end
  if(license =="dmv")then
    text = "Körkorts skola"
  end
  if(license =="drive")then
    text= "Körkort"
  end
  if(license =="drive_bike")then
    text= "Motorcykellicens"
  end
  if(license =="drive_truck")then
    text="Lastbil licens"
  end

  TriggerClientEvent('esx:showNotification', sourceXPlayer.source, 'Du ~r~tog ~w~ : '..text..' av ~b~'..targetXPlayer.name )
  TriggerClientEvent('esx:showNotification', targetXPlayer.source, '~r~' .. sourceXPlayer.name .. ' tog din : '.. text)


  local identifier = GetPlayerIdentifiers(target)[1]



  deleteLicense(identifier,license)




end)


RegisterServerEvent('esx_swatjob:getStockItem')
AddEventHandler('esx_swatjob:getStockItem', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_swat', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= count then
      inventory.removeItem(itemName, count)
      xPlayer.addInventoryItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn') .. count .. ' ' .. item.label)

  end)

end)

RegisterServerEvent('esx_swatjob:putStockItems')
AddEventHandler('esx_swatjob:putStockItems', function(itemName, count)

  local xPlayer = ESX.GetPlayerFromId(source)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_swat', function(inventory)

    local item = inventory.getItem(itemName)

    if item.count >= 0 then
      xPlayer.removeInventoryItem(itemName, count)
      inventory.addItem(itemName, count)
    else
      TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
    end

    TriggerClientEvent('esx:showNotification', xPlayer.source, _U('added') .. count .. ' ' .. item.label)

  end)

end)

ESX.RegisterServerCallback('esx_swatjob:getOtherPlayerData', function(source, cb, target)

  if Config.EnableESXIdentity then

    local xPlayer = ESX.GetPlayerFromId(target)

    local identifier = GetPlayerIdentifiers(target)[1]

    local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
      ['@identifier'] = identifier
    })

    local user      = result[1]
    local firstname     = user['firstname']
    local lastname      = user['lastname']
    local sex           = user['sex']
    local dob           = user['dateofbirth']
    local height        = user['height'] .. " Inches"

    local data = {
      name        = GetPlayerName(target),
      job         = xPlayer.job,
      inventory   = xPlayer.inventory,
      accounts    = xPlayer.accounts,
      weapons     = xPlayer.loadout,
      firstname   = firstname,
      lastname    = lastname,
      sex         = sex,
      dob         = dob,
      height      = height
    }

    TriggerEvent('esx_status:getStatus', source, 'drunk', function(status)

      if status ~= nil then
        data.drunk = math.floor(status.percent)
      end

    end)

    if Config.EnableLicenses then

      TriggerEvent('esx_license:getLicenses', source, function(licenses)
        data.licenses = licenses
        cb(data)
      end)

    else
      cb(data)
    end

  else

    local xPlayer = ESX.GetPlayerFromId(target)

    local data = {
      name       = GetPlayerName(target),
      job        = xPlayer.job,
      inventory  = xPlayer.inventory,
      accounts   = xPlayer.accounts,
      weapons    = xPlayer.loadout
    }

    TriggerEvent('esx_status:getStatus', _source, 'drunk', function(status)

      if status ~= nil then
        data.drunk = status.getPercent()
      end

    end)

    TriggerEvent('esx_license:getLicenses', _source, function(licenses)
      data.licenses = licenses
    end)

    cb(data)

  end

end)

ESX.RegisterServerCallback('esx_swatjob:getFineList', function(source, cb, category)

  MySQL.Async.fetchAll(
    'SELECT * FROM fine_types WHERE category = @category',
    {
      ['@category'] = category
    },
    function(fines)
      cb(fines)
    end
  )

end)

ESX.RegisterServerCallback('esx_swatjob:getVehicleInfos', function(source, cb, plate)

  if Config.EnableESXIdentity then

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles',
      {},
      function(result)

        local foundIdentifier = nil

        for i=1, #result, 1 do

          local vehicleData = json.decode(result[i].vehicle)

          if vehicleData.plate == plate then
            foundIdentifier = result[i].owner
            break
          end

        end

        if foundIdentifier ~= nil then

          MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE identifier = @identifier',
            {
              ['@identifier'] = foundIdentifier
            },
            function(result)

              local ownerName = result[1].firstname .. " " .. result[1].lastname

              local infos = {
                plate = plate,
                owner = ownerName
              }

              cb(infos)

            end
          )

        else

          local infos = {
          plate = plate
          }

          cb(infos)

        end

      end
    )

  else

    MySQL.Async.fetchAll(
      'SELECT * FROM owned_vehicles',
      {},
      function(result)

        local foundIdentifier = nil

        for i=1, #result, 1 do

          local vehicleData = json.decode(result[i].vehicle)

          if vehicleData.plate == plate then
            foundIdentifier = result[i].owner
            break
          end

        end

        if foundIdentifier ~= nil then

          MySQL.Async.fetchAll(
            'SELECT * FROM users WHERE identifier = @identifier',
            {
              ['@identifier'] = foundIdentifier
            },
            function(result)

              local infos = {
                plate = plate,
                owner = result[1].name
              }

              cb(infos)

            end
          )

        else

          local infos = {
          plate = plate
          }

          cb(infos)

        end

      end
    )

  end

end)

ESX.RegisterServerCallback('esx_swatjob:getArmoryWeapons', function(source, cb)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_swat', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    cb(weapons)

  end)

end)

ESX.RegisterServerCallback('esx_swatjob:addArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.removeWeapon(weaponName)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_swat', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = weapons[i].count + 1
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 1
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)

ESX.RegisterServerCallback('esx_swatjob:removeArmoryWeapon', function(source, cb, weaponName)

  local xPlayer = ESX.GetPlayerFromId(source)

  xPlayer.addWeapon(weaponName, 1000)

  TriggerEvent('esx_datastore:getSharedDataStore', 'society_swat', function(store)

    local weapons = store.get('weapons')

    if weapons == nil then
      weapons = {}
    end

    local foundWeapon = false

    for i=1, #weapons, 1 do
      if weapons[i].name == weaponName then
        weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
        foundWeapon = true
      end
    end

    if not foundWeapon then
      table.insert(weapons, {
        name  = weaponName,
        count = 0
      })
    end

     store.set('weapons', weapons)

     cb()

  end)

end)


ESX.RegisterServerCallback('esx_swatjob:buy', function(source, cb, amount)

  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_swat', function(account)

    if account.money >= amount then
      account.removeMoney(amount)
      cb(true)
    else
      cb(false)
    end

  end)

end)

ESX.RegisterServerCallback('esx_swatjob:getStockItems', function(source, cb)

  TriggerEvent('esx_addoninventory:getSharedInventory', 'society_swat', function(inventory)
    cb(inventory.items)
  end)

end)

ESX.RegisterServerCallback('esx_swatjob:getPlayerInventory', function(source, cb)

  local xPlayer = ESX.GetPlayerFromId(source)
  local items   = xPlayer.inventory

  cb({
    items = items
  })

end)
