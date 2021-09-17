-- "lua\\entities\\ent_jumpgame\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "JumpGame"
ENT.Author= "Nak"
ENT.Contact= "Via steam"
ENT.Information		= "A Minigame"
ENT.Instructions= "Uhh .. jump?"
ENT.Category		= "Fun + Games"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= false
ENT.RenderGroup		= RENDERGROUP_TRANSLUCENT

function ENT:SpawnFunction( ply, tr, ClassName )
	if IsValid(ply) and type(ply)=="Player" then
		if IsValid(ply.MyJGGame) then
			net.Start("NaksJumpGame")
			net.WriteString("SpawnMessage")
			net.WriteString("Max 1 platform pr player.")
		net.Send(ply)
		return
		end
	end

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent.Player = nil -- Idk what sets it .. but annoying
	ply.MyJGGame = ent
	return ent
	
end

-- "lua\\entities\\ent_jumpgame\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "JumpGame"
ENT.Author= "Nak"
ENT.Contact= "Via steam"
ENT.Information		= "A Minigame"
ENT.Instructions= "Uhh .. jump?"
ENT.Category		= "Fun + Games"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= false
ENT.RenderGroup		= RENDERGROUP_TRANSLUCENT

function ENT:SpawnFunction( ply, tr, ClassName )
	if IsValid(ply) and type(ply)=="Player" then
		if IsValid(ply.MyJGGame) then
			net.Start("NaksJumpGame")
			net.WriteString("SpawnMessage")
			net.WriteString("Max 1 platform pr player.")
		net.Send(ply)
		return
		end
	end

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent.Player = nil -- Idk what sets it .. but annoying
	ply.MyJGGame = ent
	return ent
	
end

-- "lua\\entities\\ent_jumpgame\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "JumpGame"
ENT.Author= "Nak"
ENT.Contact= "Via steam"
ENT.Information		= "A Minigame"
ENT.Instructions= "Uhh .. jump?"
ENT.Category		= "Fun + Games"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= false
ENT.RenderGroup		= RENDERGROUP_TRANSLUCENT

function ENT:SpawnFunction( ply, tr, ClassName )
	if IsValid(ply) and type(ply)=="Player" then
		if IsValid(ply.MyJGGame) then
			net.Start("NaksJumpGame")
			net.WriteString("SpawnMessage")
			net.WriteString("Max 1 platform pr player.")
		net.Send(ply)
		return
		end
	end

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent.Player = nil -- Idk what sets it .. but annoying
	ply.MyJGGame = ent
	return ent
	
end

-- "lua\\entities\\ent_jumpgame\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "JumpGame"
ENT.Author= "Nak"
ENT.Contact= "Via steam"
ENT.Information		= "A Minigame"
ENT.Instructions= "Uhh .. jump?"
ENT.Category		= "Fun + Games"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= false
ENT.RenderGroup		= RENDERGROUP_TRANSLUCENT

function ENT:SpawnFunction( ply, tr, ClassName )
	if IsValid(ply) and type(ply)=="Player" then
		if IsValid(ply.MyJGGame) then
			net.Start("NaksJumpGame")
			net.WriteString("SpawnMessage")
			net.WriteString("Max 1 platform pr player.")
		net.Send(ply)
		return
		end
	end

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent.Player = nil -- Idk what sets it .. but annoying
	ply.MyJGGame = ent
	return ent
	
end

-- "lua\\entities\\ent_jumpgame\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
 
ENT.PrintName= "JumpGame"
ENT.Author= "Nak"
ENT.Contact= "Via steam"
ENT.Information		= "A Minigame"
ENT.Instructions= "Uhh .. jump?"
ENT.Category		= "Fun + Games"

ENT.Editable		= true
ENT.Spawnable		= true
ENT.AdminOnly		= false
ENT.RenderGroup		= RENDERGROUP_TRANSLUCENT

function ENT:SpawnFunction( ply, tr, ClassName )
	if IsValid(ply) and type(ply)=="Player" then
		if IsValid(ply.MyJGGame) then
			net.Start("NaksJumpGame")
			net.WriteString("SpawnMessage")
			net.WriteString("Max 1 platform pr player.")
		net.Send(ply)
		return
		end
	end

	if ( !tr.Hit ) then return end
	
	local SpawnPos = tr.HitPos
	
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent.Player = nil -- Idk what sets it .. but annoying
	ply.MyJGGame = ent
	return ent
	
end

