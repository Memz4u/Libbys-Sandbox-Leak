-- "lua\\autorun\\botplayermodelchanger.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function spawnRun(ply)
	
	if ply:IsBot() then
		local colors = {Vector(255,0,0),Vector(0,255,0),Vector(0,0,255),Vector(255,0,255),Vector(255,255,0),Vector(0,255,255)}
		-- local sm,ms = file.Find( "models/player/*.mdl", "MOD", nameasc )
		local crdm = math.random(1,#colors)
		
		-- timer.Simple(0.25,function() ply:SetModel("models/player/"..sm[math.random(1,#sm)]) end )
		local model = table.Random( player_manager.AllValidModels())
		timer.Simple(0.25,function()
			ply:SetModel( model )
		end)
		timer.Simple(0.1,function() ply:SetPlayerColor(colors[crdm]) end)



	end
end

hook.Add("PlayerSpawn","spawnRun",spawnRun)

-- "lua\\autorun\\botplayermodelchanger.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function spawnRun(ply)
	
	if ply:IsBot() then
		local colors = {Vector(255,0,0),Vector(0,255,0),Vector(0,0,255),Vector(255,0,255),Vector(255,255,0),Vector(0,255,255)}
		-- local sm,ms = file.Find( "models/player/*.mdl", "MOD", nameasc )
		local crdm = math.random(1,#colors)
		
		-- timer.Simple(0.25,function() ply:SetModel("models/player/"..sm[math.random(1,#sm)]) end )
		local model = table.Random( player_manager.AllValidModels())
		timer.Simple(0.25,function()
			ply:SetModel( model )
		end)
		timer.Simple(0.1,function() ply:SetPlayerColor(colors[crdm]) end)



	end
end

hook.Add("PlayerSpawn","spawnRun",spawnRun)

-- "lua\\autorun\\botplayermodelchanger.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function spawnRun(ply)
	
	if ply:IsBot() then
		local colors = {Vector(255,0,0),Vector(0,255,0),Vector(0,0,255),Vector(255,0,255),Vector(255,255,0),Vector(0,255,255)}
		-- local sm,ms = file.Find( "models/player/*.mdl", "MOD", nameasc )
		local crdm = math.random(1,#colors)
		
		-- timer.Simple(0.25,function() ply:SetModel("models/player/"..sm[math.random(1,#sm)]) end )
		local model = table.Random( player_manager.AllValidModels())
		timer.Simple(0.25,function()
			ply:SetModel( model )
		end)
		timer.Simple(0.1,function() ply:SetPlayerColor(colors[crdm]) end)



	end
end

hook.Add("PlayerSpawn","spawnRun",spawnRun)

-- "lua\\autorun\\botplayermodelchanger.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function spawnRun(ply)
	
	if ply:IsBot() then
		local colors = {Vector(255,0,0),Vector(0,255,0),Vector(0,0,255),Vector(255,0,255),Vector(255,255,0),Vector(0,255,255)}
		-- local sm,ms = file.Find( "models/player/*.mdl", "MOD", nameasc )
		local crdm = math.random(1,#colors)
		
		-- timer.Simple(0.25,function() ply:SetModel("models/player/"..sm[math.random(1,#sm)]) end )
		local model = table.Random( player_manager.AllValidModels())
		timer.Simple(0.25,function()
			ply:SetModel( model )
		end)
		timer.Simple(0.1,function() ply:SetPlayerColor(colors[crdm]) end)



	end
end

hook.Add("PlayerSpawn","spawnRun",spawnRun)

-- "lua\\autorun\\botplayermodelchanger.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
function spawnRun(ply)
	
	if ply:IsBot() then
		local colors = {Vector(255,0,0),Vector(0,255,0),Vector(0,0,255),Vector(255,0,255),Vector(255,255,0),Vector(0,255,255)}
		-- local sm,ms = file.Find( "models/player/*.mdl", "MOD", nameasc )
		local crdm = math.random(1,#colors)
		
		-- timer.Simple(0.25,function() ply:SetModel("models/player/"..sm[math.random(1,#sm)]) end )
		local model = table.Random( player_manager.AllValidModels())
		timer.Simple(0.25,function()
			ply:SetModel( model )
		end)
		timer.Simple(0.1,function() ply:SetPlayerColor(colors[crdm]) end)



	end
end

hook.Add("PlayerSpawn","spawnRun",spawnRun)

