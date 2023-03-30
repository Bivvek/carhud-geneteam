TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('hud:voice', function(source, cb)
	local plyState = Player(source).state
	local proximity = plyState.proximity
	if proximity ~= nil then
		cb(proximity.mode)
	else
		cb(nil)
	end
end)