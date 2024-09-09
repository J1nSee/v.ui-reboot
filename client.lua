RegisterNetEvent('rebootNotice')
AddEventHandler('rebootNotice', function (minute)
  if tonumber(minute) >= 1 then
    SendNUIMessage({type = 'rebootNotify',minute = minute});
  end
end)

RegisterNetEvent('rebootstop')
AddEventHandler('rebootstop', function()
    SendNUIMessage({
      type = 'rebootstop',
    });
end)
