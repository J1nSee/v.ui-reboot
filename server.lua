local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

local vRP = Proxy.getInterface("vRP")
local vRPclient = Tunnel.getInterface("vRP","v.ui-reboot")

local reboot = false
local rebootTime = 0

RegisterServerEvent('playerConnecting')

RegisterCommand('리부팅시작', function(source, args, rawCommand)
    local user_id = vRP.getUserId({source})
  
    if vRP.hasPermission({user_id, "admin.permission"}) == true then -- 펄미션 권한 
        reboot = true
        rebootTime = args[1]
        
        TriggerClientEvent('rebootNotice', -1, args[1]);
        Wait(rebootTime * 60 * 1000)
        for _, v in ipairs(GetPlayers()) do
        vRP.kick({v, "[프로젝트] 리부팅이 진행중입니다 디스코드 서버상태를 확인후 접속해주세요."})
        end
    end
end, false)

RegisterCommand('리부팅종료', function(source, args, rawCommand)
    local user_id = vRP.getUserId({source})
    if vRP.hasPermission({user_id, "admin.permission"}) == true then -- 펄미션 권한
        TriggerClientEvent('rebootstop', -1)
    end
end, false)

AddEventHandler('playerConnecting', function(name, setKickReason, deferrals)
    local user_id = vRP.getUserId({source})
    deferrals.defer()
    deferrals.update("[프로젝트] 서버 리부팅이 예정되어 있는지 확인하는 중입니다 ...")
    Wait(2000)
    if reboot == true then
        deferrals.done("[프로젝트] 서버 리부팅이 약 " .. rebootTime .. "분 뒤 예정되어 있습니다! 리부팅이 완료된 후 접속해주세요!")
    else
        Wait(0)
        deferrals.done()
    end
end)
