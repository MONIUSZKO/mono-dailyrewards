local Main = {

}
ESX = exports["es_extended"]:getSharedObject()
ESX.RegisterCommand('daily', {'user'}, function(xPlayer, args, showError)
    local player = source
    local currentDay = tonumber(os.date("%j"))
    local discord = ""
    local id = ""

    local identifiers = GetNumPlayerIdentifiers(xPlayer.source)
    for i = 0, identifiers - 1 do
        if GetPlayerIdentifier(xPlayer.source, i) ~= nil then
            if string.match(GetPlayerIdentifier(xPlayer.source, i), "discord") then
                discord = GetPlayerIdentifier(xPlayer.source, i)
                id = string.sub(discord, 9, -1)
            end
        end
    end

    MySQL.query('SELECT * FROM mono-dailyrewards WHERE identifier = ?', { id }, function(response)
        if response then
            if response[1] then
                local lastRewardDay = tonumber(response[1].last_reward_day)
                local numRewards = tonumber(response[1].num_Rewards)
                if lastRewardDay == currentDay then
                    xPlayer.showNotification((_U('taken_0')))
                else
                    numRewards = numRewards + 1
                    lastRewardDay = currentDay
                    if numRewards == 31 then 
                        xPlayer.showNotification((_U('taken_1')))
                    else 
                        local rewardData = Config.rewards[numRewards]
                        Main.UpdatePlayerRewards(id, lastRewardDay, numRewards)
                        xPlayer.addInventoryItem(rewardData.item, rewardData.count)
                        xPlayer.showNotification(_U('taken_2'))
                    end
                end
            else
                local numRewards = 1
                local lastRewardDay = currentDay
                local rewardData = Config.rewards[numRewards]
                xPlayer.addInventoryItem(rewardData.item, rewardData.count)
                MySQL.execute("INSERT INTO mono-dailyrewards (identifier, last_reward_day, num_rewards) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE last_reward_day = VALUES(last_reward_day), num_rewards = VALUES(num_rewards)",
                {id, lastRewardDay, numRewards})
                xPlayer.showNotification(_U('taken_3'))
            end
        else
            xPlayer.showNotification(_U('taken_4'))
        end
    end)
end, true, {help =  _U('command_hel'), validate = true, arguments = {
}})
Main.UpdatePlayerRewards = function(playerIdent, lastRewardDay, numRewards)
    local updateQuery = string.format("UPDATE mono-dailyrewards SET last_reward_day = %d, num_rewards = %d WHERE identifier = '%s'", lastRewardDay, numRewards, playerIdent)
    MySQL.execute(updateQuery)
end
