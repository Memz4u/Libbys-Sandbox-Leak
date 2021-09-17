-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_hologram.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function WireHologramsShowOwners()
	for _,ent in pairs( ents.FindByClass( "gmod_wire_hologram" ) ) do
		local id = ent:GetNWInt( "ownerid" )

		for _,ply in pairs( player.GetAll() ) do
			if ply:UserID() == id then
				local vec = ent:GetPos():ToScreen()

				draw.DrawText( ply:Name() .. "\n" .. ply:SteamID(), "DermaDefault", vec.x, vec.y, Color(255,0,0,255), 1 )
				break
			end
		end
	end
end

local display_owners = false
concommand.Add( "wire_holograms_display_owners", function()
	display_owners = !display_owners
	if display_owners then
		hook.Add( "HUDPaint", "wire_holograms_showowners", WireHologramsShowOwners)
	else
		hook.Remove("HUDPaint", "wire_holograms_showowners")
	end
end )


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_hologram.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function WireHologramsShowOwners()
	for _,ent in pairs( ents.FindByClass( "gmod_wire_hologram" ) ) do
		local id = ent:GetNWInt( "ownerid" )

		for _,ply in pairs( player.GetAll() ) do
			if ply:UserID() == id then
				local vec = ent:GetPos():ToScreen()

				draw.DrawText( ply:Name() .. "\n" .. ply:SteamID(), "DermaDefault", vec.x, vec.y, Color(255,0,0,255), 1 )
				break
			end
		end
	end
end

local display_owners = false
concommand.Add( "wire_holograms_display_owners", function()
	display_owners = !display_owners
	if display_owners then
		hook.Add( "HUDPaint", "wire_holograms_showowners", WireHologramsShowOwners)
	else
		hook.Remove("HUDPaint", "wire_holograms_showowners")
	end
end )


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_hologram.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function WireHologramsShowOwners()
	for _,ent in pairs( ents.FindByClass( "gmod_wire_hologram" ) ) do
		local id = ent:GetNWInt( "ownerid" )

		for _,ply in pairs( player.GetAll() ) do
			if ply:UserID() == id then
				local vec = ent:GetPos():ToScreen()

				draw.DrawText( ply:Name() .. "\n" .. ply:SteamID(), "DermaDefault", vec.x, vec.y, Color(255,0,0,255), 1 )
				break
			end
		end
	end
end

local display_owners = false
concommand.Add( "wire_holograms_display_owners", function()
	display_owners = !display_owners
	if display_owners then
		hook.Add( "HUDPaint", "wire_holograms_showowners", WireHologramsShowOwners)
	else
		hook.Remove("HUDPaint", "wire_holograms_showowners")
	end
end )


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_hologram.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function WireHologramsShowOwners()
	for _,ent in pairs( ents.FindByClass( "gmod_wire_hologram" ) ) do
		local id = ent:GetNWInt( "ownerid" )

		for _,ply in pairs( player.GetAll() ) do
			if ply:UserID() == id then
				local vec = ent:GetPos():ToScreen()

				draw.DrawText( ply:Name() .. "\n" .. ply:SteamID(), "DermaDefault", vec.x, vec.y, Color(255,0,0,255), 1 )
				break
			end
		end
	end
end

local display_owners = false
concommand.Add( "wire_holograms_display_owners", function()
	display_owners = !display_owners
	if display_owners then
		hook.Add( "HUDPaint", "wire_holograms_showowners", WireHologramsShowOwners)
	else
		hook.Remove("HUDPaint", "wire_holograms_showowners")
	end
end )


-- "addons\\wiremod\\lua\\entities\\gmod_wire_expression2\\core\\cl_hologram.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function WireHologramsShowOwners()
	for _,ent in pairs( ents.FindByClass( "gmod_wire_hologram" ) ) do
		local id = ent:GetNWInt( "ownerid" )

		for _,ply in pairs( player.GetAll() ) do
			if ply:UserID() == id then
				local vec = ent:GetPos():ToScreen()

				draw.DrawText( ply:Name() .. "\n" .. ply:SteamID(), "DermaDefault", vec.x, vec.y, Color(255,0,0,255), 1 )
				break
			end
		end
	end
end

local display_owners = false
concommand.Add( "wire_holograms_display_owners", function()
	display_owners = !display_owners
	if display_owners then
		hook.Add( "HUDPaint", "wire_holograms_showowners", WireHologramsShowOwners)
	else
		hook.Remove("HUDPaint", "wire_holograms_showowners")
	end
end )


