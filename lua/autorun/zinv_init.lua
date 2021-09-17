-- "lua\\autorun\\zinv_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include( "zinv_shared.lua" )
AddCSLuaFile( "zinv_shared.lua" )

if CLIENT then return end

defaultSettings = [[
{
	"npcs": [
		{
			"health": -1,
			"chance": 100,
			"model": "",
			"scale": 1,
			"class_name": "npc_zombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 30,
			"model": "",
			"scale": 1,
			"class_name": "npc_fastzombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 40,
			"model": "",
			"scale": 1,
			"class_name": "npc_headcrab_fast",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}
	],
	"heroes": [
	]
}
]]

HERO_COOLDOWN = 60

util.AddNetworkString("send_ztable_cl")
util.AddNetworkString("send_ztable_sr")
util.AddNetworkString("change_zinv_profile")
util.AddNetworkString("create_zinv_profile")
util.AddNetworkString("remove_zinv_profile")
util.AddNetworkString("zinv")
util.AddNetworkString("zinv_explode")
util.AddNetworkString("zinv_maxdist")
util.AddNetworkString("zinv_mindist")
util.AddNetworkString("zinv_maxspawn")
util.AddNetworkString("zinv_chaseplayers")
concommand.Add("zinv_reloadsettings", loadNPCInfo)


function removeHero(ent)
	if spawnedZombies[ent:EntIndex()]["hero"] == true then
		for _, spawnedHero in pairs(spawnedHeroes) do
			if spawnedHero["instance"] == ent:EntIndex() then
				spawnedHero["instance"] = -1
				spawnedHero["last_died"] = os.time()
			end
		end
	end
end

hook.Add("OnNPCKilled","NPC_Died_zinv", function(victim, killer, weapon)
	if spawnedZombies[victim:EntIndex()] then
		removeHero(victim)
		spawnedZombies[victim:EntIndex()] = nil
	end

	if GetConVarNumber("zinv_explode") == 0 then
		return
	end

	local explode = ents.Create("env_explosion")
	explode:SetPos(victim:GetPos())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "35")
	explode:Fire("Explode", 0, 0)
	explode:EmitSound("weapon_AWP.Single", 400, 400)
end)

hook.Add("EntityRemoved", "Entity_Removed_zinv", function(ent)
	if spawnedZombies[ent:EntIndex()] then
		removeHero(ent)
		spawnedZombies[ent:EntIndex()] = nil
	end
end)

hook.Add("EntityTakeDamage", "Entity_Damage_zinv", function(target, dmg)
	for ent_index, data in pairs(spawnedZombies) do
		if ent_index == dmg:GetAttacker():EntIndex() and data["damage_multiplier"] and !dmg:IsExplosionDamage() then
			dmg:ScaleDamage(data["damage_multiplier"])
		end
	end
end)

hook.Add("Initialize", "initializing_zinv", function()
	Nodes = {}
	totalChance = 0
	lastProfile = file.Read("zinv/last_profile.txt", "DATA")
	if not lastProfile then
		lastProfile = "default"
	end
	profileName = lastProfile
	spawnedZombies = {}
	spawnedHeroes = {}
	loadNPCInfo(lastProfile)
	found_ain = false
	ParseFile()
end)

hook.Add("PlayerInitialSpawn", "pinitspawn_zinv", function(ply)
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(lastProfile)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Send(ply)
end)

hook.Add("EntityKeyValue", "newkeyval_zinv", function(ent)
	if ent:GetClass() == "info_player_teamspawn" then
		local valid = true
		for k,v in pairs(Nodes) do
			if v["pos"] == ent:GetPos() then
				valid = false
			end
		end

		if valid then
			local node = {
				pos = ent:GetPos(),
				yaw = 0,
				offset = 0,
				type = 0,
				info = 0,
				zone = 0,
				neighbor = {},
				numneighbors = 0,
				link = {},
				numlinks = 0
			}
			table.insert(Nodes, node)
		end
	end
end)

--Taken from nodegraph addon - thx
local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local AINET_VERSION_NUMBER = 37
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function toInt(b)
	local i = {string.byte(b,1,SIZEOF_INT)}
	i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
	if(i > 2147483647) then return i -4294967296 end
	return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

--Taken from nodegraph addon - thx
--Types:
--1 = ?
--2 = info_nodes
--3 = playerspawns
--4 = wall climbers
function ParseFile()
	if foundain then
		return
	end

	f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
	if(!f) then
		return
	end

	found_ain = true
	local ainet_ver = ReadInt(f)
	local map_ver = ReadInt(f)
	if(ainet_ver != AINET_VERSION_NUMBER) then
		MsgN("Unknown graph file")
		return
	end

	local numNodes = ReadInt(f)
	if(numNodes < 0) then
		MsgN("Graph file has an unexpected amount of nodes")
		return
	end

	for i = 1,numNodes do
		local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
		local yaw = f:ReadFloat()
		local flOffsets = {}
		for i = 1,NUM_HULLS do
			flOffsets[i] = f:ReadFloat()
		end
		local nodetype = f:ReadByte()
		local nodeinfo = ReadUShort(f)
		local zone = f:ReadShort()

		if nodetype == 4 then
			continue
		end
		
		local node = {
			pos = v,
			yaw = yaw,
			offset = flOffsets,
			type = nodetype,
			info = nodeinfo,
			zone = zone,
			neighbor = {},
			numneighbors = 0,
			link = {},
			numlinks = 0
		}

		table.insert(Nodes,node)
	end
end

timer.Create("zombietimer_zinv", 5, 0, function()
	local status, err = pcall( function()
	local valid_nodes = {}
	local zombies = {}

	if GetConVarNumber("zinv") == 0 or table.Count(player.GetAll()) <= 0 then
		return
	end
	
	if !found_ain then
		ParseFile()
	end

	if (!npcList and !heroList) or !Nodes or table.Count(Nodes) < 1 then
		print("No info_node(s) in map! NPCs will not spawn.")
		return
	end

	if table.Count(Nodes) <= 35 then
		print("Zombies may not spawn well on this map, please try another.")
	end

	local zombies = {}
	for ent_index, _ in pairs(spawnedZombies) do
		if !IsValid(Entity(ent_index)) then
			removeHero(Entity(ent_index))
			spawnedZombies[ent_index] = nil
		else
			table.insert(zombies, Entity(ent_index))
		end
	end

	--Check zombie
	for k, v in pairs(zombies) do
		local closest = 99999
		local closest_plr = NULL
		local zombie_pos = v:GetPos()

		for k2, v2 in pairs(player.GetAll()) do
			local dist = zombie_pos:Distance(v2:GetPos())

			if dist < closest then
				closest_plr = v2
				closest = dist
			end
		end

		if closest > GetConVarNumber("zinv_maxdist")*1.25 then
			table.RemoveByValue(zombies, v)
			v:Remove()
		else
			if GetConVarNumber("zinv_chaseplayers") != 0 then
				v:SetLastPosition(closest_plr:GetPos())
				v:SetTarget(closest_plr)
				if !v:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
					v:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
	end

	if table.Count(zombies) >= GetConVarNumber("zinv_maxspawn") then
		return
	end

	--Get valid nodes
	for k, v in pairs(Nodes) do
		local valid = false

		for k2, v2 in pairs(player.GetAll()) do
			local dist = v["pos"]:Distance(v2:GetPos())

			if dist <= GetConVarNumber("zinv_mindist") then
				valid = false
				break
			elseif dist < GetConVarNumber("zinv_maxdist") then
				valid = true
			end
		end

		if !valid then
			continue
		end

		for k2, v2 in pairs(zombies) do
			local dist = v["pos"]:Distance(v2:GetPos())
			if dist <= 100 then
				valid = false
				break
			end
		end

		if valid then
			table.insert(valid_nodes, v["pos"])
		end
	end

	--Spawn zombies if not enough
	if table.Count(valid_nodes) > 0 then
		for i = 0, 5 do
			if table.Count(zombies)+i < GetConVarNumber("zinv_maxspawn") then
				local pos = table.Random(valid_nodes) 
				if pos != nil then
					table.RemoveByValue(valid_nodes, pos)
					spawnZombie(pos + Vector(0,0,30))
				end
			else
				break
			end
		end
	end
	end) 

	if !status then
		print(err)
	end
end)

function spawnZombie(pos)
	--Pick random NPC based on chance
	local rnum = math.random(0, totalChance)

	local heroChance = math.random(0, 100)
	heroSpawnEntry = nil
	if heroChance == 1 then
		for _, v in pairs(spawnedHeroes) do
			if v["instance"] == -1 and (!v["last_died"] or os.difftime(os.time(), v["last_died"]) >= HERO_COOLDOWN) then
				heroSpawnEntry = v
			end
		end

		-- Spawn hero
		if heroSpawnEntry then
			heroInfo = list.Get("NPC")[heroSpawnEntry["class_name"]]
			if !heroInfo then
				MsgN("Class name ", heroSpawnEntry["class_name"], " doesn't exist")
				return
			end
			local hero = ents.Create(heroInfo["Class"])
			if hero then
				print("Spawning hero ", hero)
				if heroSpawnEntry["weapon"] then
					hero:SetKeyValue("additionalequipment", heroSpawnEntry["weapon"])
				end
				hero:SetPos(pos)
				hero:SetAngles(Angle(0, math.random(0, 360), 0))
				hero:Spawn()

				spawnedZombies[hero:EntIndex()] = {
					damage_multiplier = 2,
					hero = true
				}

				heroSpawnEntry["instance"] = hero:EntIndex()

				if heroInfo["Model"] then
					hero:SetModel(heroInfo["Model"])
				end
				if heroSpawnEntry["model"] then
					hero:SetModel(heroSpawnEntry["model"])
				end
				hero:SetModelScale(1.3)
				if heroSpawnEntry["health"] and heroSpawnEntry["health"] > 0 then
					hero:SetHealth(heroSpawnEntry["health"])
					hero:SetMaxHealth(heroSpawnEntry["health"])
				end
				if heroInfo["SpawnFlags"] then
					hero:SetKeyValue("spawnflags", heroInfo["SpawnFlags"])
				end
				if heroSpawnEntry["overriding_spawn_flags"] and heroSpawnEntry["spawn_flags"] then
					hero:SetKeyValue("spawnflags", heroSpawnEntry["spawn_flags"])
				end
	   			if heroInfo["KeyValues"] then
	   				for k, v in pairs(heroInfo["KeyValues"]) do
	   					hero:SetKeyValue(k, v)
	   				end
	   			end
	   			if heroSpawnEntry["squad_name"] then
	   				hero:SetKeyValue("SquadName", heroSpawnEntry["squad_name"])
	   			end
				hero:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
	   			hero:Fire("StartPatrolling")
	   			hero:Fire("SetReadinessHigh")
	   			hero:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end

	if !heroSpawnEntry then
		local total = 0
		for k, v in pairs(npcList) do
			total = total + v["chance"]
			if total >= rnum then
				spawnListEntry = v
				break
			end
		end

		--Spawn NPC
		if spawnListEntry then
			npc_info = list.Get("NPC")[spawnListEntry["class_name"]]
			if !npc_info then
				MsgN("NPC list is ", list.Get("NPC"))
				MsgN("Class name is ", spawnListEntry["class_name"])
			end
			local zombie = ents.Create(npc_info["Class"])
			if zombie then
				if spawnListEntry["weapon"] then
	   				zombie:SetKeyValue("additionalequipment", spawnListEntry["weapon"])
	   			end
	   			zombie:SetPos(pos)
	   			zombie:SetAngles(Angle(0, math.random(0, 360), 0))
				zombie:Spawn()

				spawnedZombies[zombie:EntIndex()] = {
					damage_multiplier = spawnListEntry["damage_multiplier"],
					hero = false
				}
				
				if npc_info["Model"] then
					zombie:SetModel(npc_info["Model"])
				end
				if spawnListEntry["model"] then
					zombie:SetModel(spawnListEntry["model"])
				end
				if spawnListEntry["scale"] then
					zombie:SetModelScale(spawnListEntry["scale"], 0)
				end
				if spawnListEntry["health"] and spawnListEntry["health"] > 0 then
	   				zombie:SetHealth(spawnListEntry["health"])
	   				zombie:SetMaxHealth(spawnListEntry["health"])
	   			end
	   			if npc_info["SpawnFlags"] then
	   				zombie:SetKeyValue("spawnflags", npc_info["SpawnFlags"])
	   			end
	   			if spawnListEntry["overriding_spawn_flags"] and spawnListEntry["spawn_flags"] then
	   				zombie:SetKeyValue("spawnflags", spawnListEntry["spawn_flags"])
	   			end
	   			-- TODO: Possibly use bit.bxor here to combine multiple spawn flags
	   			if npc_info["KeyValues"] then
	   				for k, v in pairs(npc_info["KeyValues"]) do
	   					zombie:SetKeyValue(k, v)
	   				end
	   			end
	   			if spawnListEntry["squad_name"] then
	   				zombie:SetKeyValue("SquadName", spawnListEntry["squad_name"])
	   			end
	   			if spawnListEntry["weapon_proficiency"] then
	   				local weaponProficiency = -1
	   				if spawnListEntry["weapon_proficiency"] == "Poor" then
	   					weaponProficiency = WEAPON_PROFICIENCY_POOR
	   				elseif spawnListEntry["weapon_proficiency"] == "Average" then
	   					weaponProficiency = WEAPON_PROFICIENCY_AVERAGE
	   				elseif spawnListEntry["weapon_proficiency"] == "Good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Very good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_VERY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Perfect" then
	   					weaponProficiency = WEAPON_PROFICIENCY_PERFECT
	   				end
	   				if weaponProficiency ~= -1 then
	   					zombie:SetCurrentWeaponProficiency(weaponProficiency)
	   				end
	   			end
	   			zombie:Fire("StartPatrolling")
	   			zombie:Fire("SetReadinessHigh")
	   			zombie:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end
end

function loadNPCInfo(profileName)
	if !profileName then
		profileName = "default"
	end

	npcList = {}
	heroList = {}
	MsgN("Clearing spawn list")
	spawnedZombies = {}
	local f = file.Read("zinv/profile_"..profileName..".txt", "DATA")
	if f then
		Settings = util.JSONToTable(f)
		if !Settings then -- Support for legacy format
			Settings = util.KeyValuesToTable(f)
			MsgN("Converting legacy profile to new format...")
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		loadedNPCs = Settings["npcs"]
		loadedHeroes = Settings["heroes"]
		if !loadedNPCs or !loadedHeroes then -- Support for hero-less profiles
			MsgN("Adding missing fields to profile...")
			loadedNPCs = Settings
			loadedHeroes = {}
			Settings = {
				npcs = loadedNPCs,
				heroes = loadedHeroes
			}
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		for _, v in pairs(loadedNPCs) do
			table.insert(npcList, v)
		end
		for _, v in pairs(loadedHeroes) do
			table.insert(heroList, v)
		end
	else
		profileName = "default"
		if !file.IsDir("zinv", "DATA") then
			file.CreateDir("zinv")
		end
		Settings = util.JSONToTable(defaultSettings)
		file.Write("zinv/profile_default.txt", defaultSettings) 
		for _, v in pairs(Settings) do
			table.insert(npcList, v)
		end
		for _, v in pairs(Settings) do
			table.insert(heroList, v)
		end
		print("Initial File Created: data/zinv/profile_default.txt")
	end
	spawnedHeroes = {}
	for _, v in pairs(heroList) do
		local entry = table.Copy(v)
		entry["instance"] = -1
		table.insert(spawnedHeroes, entry)
	end

	print("Loading profile "..profileName.."...")
	file.Write("zinv/last_profile.txt", profileName)

	--Check validity
	for _, v in pairs(npcList) do
		if tonumber(v["health"]) == nil then
			v["health"] = -1
		end
		if tonumber(v["chance"]) == nil then
			v["chance"] = 100
		end
		if tonumber(v["scale"]) == nil then
			v["scale"] = 1
		end
		if !v["model"] then
			v["model"] = ""
		end
		if !v["weapon"] then
			v["weapon"] = ""
		end
		if !v["overriding_spawn_flags"] then
			v["overriding_spawn_flags"] = false
		end
		if !v["class_name"] then
			v["class_name"] = ""
		end
		if !v["spawn_flags"] then
			if v["overriding_spawn_flags"] then
				v["spawn_flags"] = 0
			else
				v["spawn_flags"] = "Default"
			end
		end
		if !v["squad_name"] then
			v["squad_name"] = ""
		end
		if !v["weapon_proficiency"] then
			v["weapon_proficiency"] = "Average"
		end
		if !v["damage_multiplier"] then
			v["damage_multiplier"] = 1
		end
		totalChance = totalChance + v["chance"]
	end

	print("Loaded "..profileName)
	print("NPCs:")
	PrintTable(npcList)
	print("Heroes:")
	PrintTable(heroList)

	--Notify players
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Broadcast()
end

function getZINVProfiles()
	profile_files, _ = file.Find("data/zinv/profile_*.txt", "MOD")
	profileNames = {}
	for k, v in pairs(profile_files) do
		profileNames[k] = string.StripExtension(string.sub(v, 9))
	end
	return profileNames
end

net.Receive("send_ztable_sr", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = net.ReadTable()
		heroList = net.ReadTable()
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true)) 
		print("NPC waves profile \""..profileName.."\"edited by: "..pl:Nick())
	end
end)

net.Receive("change_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		loadNPCInfo(profileName)
	end
end)

net.Receive("create_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = {}
		heroList = {}
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true))
		print("NPC waves profile \""..profileName.."\" created by: "..pl:Nick())
		loadNPCInfo(profileName)
	end
end)

net.Receive("remove_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		file.Delete("zinv/profile_"..profileName..".txt")
		print("NPC waves profile \""..profileName.."\" deleted by: "..pl:Nick())
		loadNPCInfo(getZINVProfiles()[1])
	end
end)

-- "lua\\autorun\\zinv_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include( "zinv_shared.lua" )
AddCSLuaFile( "zinv_shared.lua" )

if CLIENT then return end

defaultSettings = [[
{
	"npcs": [
		{
			"health": -1,
			"chance": 100,
			"model": "",
			"scale": 1,
			"class_name": "npc_zombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 30,
			"model": "",
			"scale": 1,
			"class_name": "npc_fastzombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 40,
			"model": "",
			"scale": 1,
			"class_name": "npc_headcrab_fast",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}
	],
	"heroes": [
	]
}
]]

HERO_COOLDOWN = 60

util.AddNetworkString("send_ztable_cl")
util.AddNetworkString("send_ztable_sr")
util.AddNetworkString("change_zinv_profile")
util.AddNetworkString("create_zinv_profile")
util.AddNetworkString("remove_zinv_profile")
util.AddNetworkString("zinv")
util.AddNetworkString("zinv_explode")
util.AddNetworkString("zinv_maxdist")
util.AddNetworkString("zinv_mindist")
util.AddNetworkString("zinv_maxspawn")
util.AddNetworkString("zinv_chaseplayers")
concommand.Add("zinv_reloadsettings", loadNPCInfo)


function removeHero(ent)
	if spawnedZombies[ent:EntIndex()]["hero"] == true then
		for _, spawnedHero in pairs(spawnedHeroes) do
			if spawnedHero["instance"] == ent:EntIndex() then
				spawnedHero["instance"] = -1
				spawnedHero["last_died"] = os.time()
			end
		end
	end
end

hook.Add("OnNPCKilled","NPC_Died_zinv", function(victim, killer, weapon)
	if spawnedZombies[victim:EntIndex()] then
		removeHero(victim)
		spawnedZombies[victim:EntIndex()] = nil
	end

	if GetConVarNumber("zinv_explode") == 0 then
		return
	end

	local explode = ents.Create("env_explosion")
	explode:SetPos(victim:GetPos())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "35")
	explode:Fire("Explode", 0, 0)
	explode:EmitSound("weapon_AWP.Single", 400, 400)
end)

hook.Add("EntityRemoved", "Entity_Removed_zinv", function(ent)
	if spawnedZombies[ent:EntIndex()] then
		removeHero(ent)
		spawnedZombies[ent:EntIndex()] = nil
	end
end)

hook.Add("EntityTakeDamage", "Entity_Damage_zinv", function(target, dmg)
	for ent_index, data in pairs(spawnedZombies) do
		if ent_index == dmg:GetAttacker():EntIndex() and data["damage_multiplier"] and !dmg:IsExplosionDamage() then
			dmg:ScaleDamage(data["damage_multiplier"])
		end
	end
end)

hook.Add("Initialize", "initializing_zinv", function()
	Nodes = {}
	totalChance = 0
	lastProfile = file.Read("zinv/last_profile.txt", "DATA")
	if not lastProfile then
		lastProfile = "default"
	end
	profileName = lastProfile
	spawnedZombies = {}
	spawnedHeroes = {}
	loadNPCInfo(lastProfile)
	found_ain = false
	ParseFile()
end)

hook.Add("PlayerInitialSpawn", "pinitspawn_zinv", function(ply)
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(lastProfile)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Send(ply)
end)

hook.Add("EntityKeyValue", "newkeyval_zinv", function(ent)
	if ent:GetClass() == "info_player_teamspawn" then
		local valid = true
		for k,v in pairs(Nodes) do
			if v["pos"] == ent:GetPos() then
				valid = false
			end
		end

		if valid then
			local node = {
				pos = ent:GetPos(),
				yaw = 0,
				offset = 0,
				type = 0,
				info = 0,
				zone = 0,
				neighbor = {},
				numneighbors = 0,
				link = {},
				numlinks = 0
			}
			table.insert(Nodes, node)
		end
	end
end)

--Taken from nodegraph addon - thx
local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local AINET_VERSION_NUMBER = 37
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function toInt(b)
	local i = {string.byte(b,1,SIZEOF_INT)}
	i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
	if(i > 2147483647) then return i -4294967296 end
	return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

--Taken from nodegraph addon - thx
--Types:
--1 = ?
--2 = info_nodes
--3 = playerspawns
--4 = wall climbers
function ParseFile()
	if foundain then
		return
	end

	f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
	if(!f) then
		return
	end

	found_ain = true
	local ainet_ver = ReadInt(f)
	local map_ver = ReadInt(f)
	if(ainet_ver != AINET_VERSION_NUMBER) then
		MsgN("Unknown graph file")
		return
	end

	local numNodes = ReadInt(f)
	if(numNodes < 0) then
		MsgN("Graph file has an unexpected amount of nodes")
		return
	end

	for i = 1,numNodes do
		local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
		local yaw = f:ReadFloat()
		local flOffsets = {}
		for i = 1,NUM_HULLS do
			flOffsets[i] = f:ReadFloat()
		end
		local nodetype = f:ReadByte()
		local nodeinfo = ReadUShort(f)
		local zone = f:ReadShort()

		if nodetype == 4 then
			continue
		end
		
		local node = {
			pos = v,
			yaw = yaw,
			offset = flOffsets,
			type = nodetype,
			info = nodeinfo,
			zone = zone,
			neighbor = {},
			numneighbors = 0,
			link = {},
			numlinks = 0
		}

		table.insert(Nodes,node)
	end
end

timer.Create("zombietimer_zinv", 5, 0, function()
	local status, err = pcall( function()
	local valid_nodes = {}
	local zombies = {}

	if GetConVarNumber("zinv") == 0 or table.Count(player.GetAll()) <= 0 then
		return
	end
	
	if !found_ain then
		ParseFile()
	end

	if (!npcList and !heroList) or !Nodes or table.Count(Nodes) < 1 then
		print("No info_node(s) in map! NPCs will not spawn.")
		return
	end

	if table.Count(Nodes) <= 35 then
		print("Zombies may not spawn well on this map, please try another.")
	end

	local zombies = {}
	for ent_index, _ in pairs(spawnedZombies) do
		if !IsValid(Entity(ent_index)) then
			removeHero(Entity(ent_index))
			spawnedZombies[ent_index] = nil
		else
			table.insert(zombies, Entity(ent_index))
		end
	end

	--Check zombie
	for k, v in pairs(zombies) do
		local closest = 99999
		local closest_plr = NULL
		local zombie_pos = v:GetPos()

		for k2, v2 in pairs(player.GetAll()) do
			local dist = zombie_pos:Distance(v2:GetPos())

			if dist < closest then
				closest_plr = v2
				closest = dist
			end
		end

		if closest > GetConVarNumber("zinv_maxdist")*1.25 then
			table.RemoveByValue(zombies, v)
			v:Remove()
		else
			if GetConVarNumber("zinv_chaseplayers") != 0 then
				v:SetLastPosition(closest_plr:GetPos())
				v:SetTarget(closest_plr)
				if !v:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
					v:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
	end

	if table.Count(zombies) >= GetConVarNumber("zinv_maxspawn") then
		return
	end

	--Get valid nodes
	for k, v in pairs(Nodes) do
		local valid = false

		for k2, v2 in pairs(player.GetAll()) do
			local dist = v["pos"]:Distance(v2:GetPos())

			if dist <= GetConVarNumber("zinv_mindist") then
				valid = false
				break
			elseif dist < GetConVarNumber("zinv_maxdist") then
				valid = true
			end
		end

		if !valid then
			continue
		end

		for k2, v2 in pairs(zombies) do
			local dist = v["pos"]:Distance(v2:GetPos())
			if dist <= 100 then
				valid = false
				break
			end
		end

		if valid then
			table.insert(valid_nodes, v["pos"])
		end
	end

	--Spawn zombies if not enough
	if table.Count(valid_nodes) > 0 then
		for i = 0, 5 do
			if table.Count(zombies)+i < GetConVarNumber("zinv_maxspawn") then
				local pos = table.Random(valid_nodes) 
				if pos != nil then
					table.RemoveByValue(valid_nodes, pos)
					spawnZombie(pos + Vector(0,0,30))
				end
			else
				break
			end
		end
	end
	end) 

	if !status then
		print(err)
	end
end)

function spawnZombie(pos)
	--Pick random NPC based on chance
	local rnum = math.random(0, totalChance)

	local heroChance = math.random(0, 100)
	heroSpawnEntry = nil
	if heroChance == 1 then
		for _, v in pairs(spawnedHeroes) do
			if v["instance"] == -1 and (!v["last_died"] or os.difftime(os.time(), v["last_died"]) >= HERO_COOLDOWN) then
				heroSpawnEntry = v
			end
		end

		-- Spawn hero
		if heroSpawnEntry then
			heroInfo = list.Get("NPC")[heroSpawnEntry["class_name"]]
			if !heroInfo then
				MsgN("Class name ", heroSpawnEntry["class_name"], " doesn't exist")
				return
			end
			local hero = ents.Create(heroInfo["Class"])
			if hero then
				print("Spawning hero ", hero)
				if heroSpawnEntry["weapon"] then
					hero:SetKeyValue("additionalequipment", heroSpawnEntry["weapon"])
				end
				hero:SetPos(pos)
				hero:SetAngles(Angle(0, math.random(0, 360), 0))
				hero:Spawn()

				spawnedZombies[hero:EntIndex()] = {
					damage_multiplier = 2,
					hero = true
				}

				heroSpawnEntry["instance"] = hero:EntIndex()

				if heroInfo["Model"] then
					hero:SetModel(heroInfo["Model"])
				end
				if heroSpawnEntry["model"] then
					hero:SetModel(heroSpawnEntry["model"])
				end
				hero:SetModelScale(1.3)
				if heroSpawnEntry["health"] and heroSpawnEntry["health"] > 0 then
					hero:SetHealth(heroSpawnEntry["health"])
					hero:SetMaxHealth(heroSpawnEntry["health"])
				end
				if heroInfo["SpawnFlags"] then
					hero:SetKeyValue("spawnflags", heroInfo["SpawnFlags"])
				end
				if heroSpawnEntry["overriding_spawn_flags"] and heroSpawnEntry["spawn_flags"] then
					hero:SetKeyValue("spawnflags", heroSpawnEntry["spawn_flags"])
				end
	   			if heroInfo["KeyValues"] then
	   				for k, v in pairs(heroInfo["KeyValues"]) do
	   					hero:SetKeyValue(k, v)
	   				end
	   			end
	   			if heroSpawnEntry["squad_name"] then
	   				hero:SetKeyValue("SquadName", heroSpawnEntry["squad_name"])
	   			end
				hero:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
	   			hero:Fire("StartPatrolling")
	   			hero:Fire("SetReadinessHigh")
	   			hero:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end

	if !heroSpawnEntry then
		local total = 0
		for k, v in pairs(npcList) do
			total = total + v["chance"]
			if total >= rnum then
				spawnListEntry = v
				break
			end
		end

		--Spawn NPC
		if spawnListEntry then
			npc_info = list.Get("NPC")[spawnListEntry["class_name"]]
			if !npc_info then
				MsgN("NPC list is ", list.Get("NPC"))
				MsgN("Class name is ", spawnListEntry["class_name"])
			end
			local zombie = ents.Create(npc_info["Class"])
			if zombie then
				if spawnListEntry["weapon"] then
	   				zombie:SetKeyValue("additionalequipment", spawnListEntry["weapon"])
	   			end
	   			zombie:SetPos(pos)
	   			zombie:SetAngles(Angle(0, math.random(0, 360), 0))
				zombie:Spawn()

				spawnedZombies[zombie:EntIndex()] = {
					damage_multiplier = spawnListEntry["damage_multiplier"],
					hero = false
				}
				
				if npc_info["Model"] then
					zombie:SetModel(npc_info["Model"])
				end
				if spawnListEntry["model"] then
					zombie:SetModel(spawnListEntry["model"])
				end
				if spawnListEntry["scale"] then
					zombie:SetModelScale(spawnListEntry["scale"], 0)
				end
				if spawnListEntry["health"] and spawnListEntry["health"] > 0 then
	   				zombie:SetHealth(spawnListEntry["health"])
	   				zombie:SetMaxHealth(spawnListEntry["health"])
	   			end
	   			if npc_info["SpawnFlags"] then
	   				zombie:SetKeyValue("spawnflags", npc_info["SpawnFlags"])
	   			end
	   			if spawnListEntry["overriding_spawn_flags"] and spawnListEntry["spawn_flags"] then
	   				zombie:SetKeyValue("spawnflags", spawnListEntry["spawn_flags"])
	   			end
	   			-- TODO: Possibly use bit.bxor here to combine multiple spawn flags
	   			if npc_info["KeyValues"] then
	   				for k, v in pairs(npc_info["KeyValues"]) do
	   					zombie:SetKeyValue(k, v)
	   				end
	   			end
	   			if spawnListEntry["squad_name"] then
	   				zombie:SetKeyValue("SquadName", spawnListEntry["squad_name"])
	   			end
	   			if spawnListEntry["weapon_proficiency"] then
	   				local weaponProficiency = -1
	   				if spawnListEntry["weapon_proficiency"] == "Poor" then
	   					weaponProficiency = WEAPON_PROFICIENCY_POOR
	   				elseif spawnListEntry["weapon_proficiency"] == "Average" then
	   					weaponProficiency = WEAPON_PROFICIENCY_AVERAGE
	   				elseif spawnListEntry["weapon_proficiency"] == "Good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Very good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_VERY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Perfect" then
	   					weaponProficiency = WEAPON_PROFICIENCY_PERFECT
	   				end
	   				if weaponProficiency ~= -1 then
	   					zombie:SetCurrentWeaponProficiency(weaponProficiency)
	   				end
	   			end
	   			zombie:Fire("StartPatrolling")
	   			zombie:Fire("SetReadinessHigh")
	   			zombie:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end
end

function loadNPCInfo(profileName)
	if !profileName then
		profileName = "default"
	end

	npcList = {}
	heroList = {}
	MsgN("Clearing spawn list")
	spawnedZombies = {}
	local f = file.Read("zinv/profile_"..profileName..".txt", "DATA")
	if f then
		Settings = util.JSONToTable(f)
		if !Settings then -- Support for legacy format
			Settings = util.KeyValuesToTable(f)
			MsgN("Converting legacy profile to new format...")
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		loadedNPCs = Settings["npcs"]
		loadedHeroes = Settings["heroes"]
		if !loadedNPCs or !loadedHeroes then -- Support for hero-less profiles
			MsgN("Adding missing fields to profile...")
			loadedNPCs = Settings
			loadedHeroes = {}
			Settings = {
				npcs = loadedNPCs,
				heroes = loadedHeroes
			}
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		for _, v in pairs(loadedNPCs) do
			table.insert(npcList, v)
		end
		for _, v in pairs(loadedHeroes) do
			table.insert(heroList, v)
		end
	else
		profileName = "default"
		if !file.IsDir("zinv", "DATA") then
			file.CreateDir("zinv")
		end
		Settings = util.JSONToTable(defaultSettings)
		file.Write("zinv/profile_default.txt", defaultSettings) 
		for _, v in pairs(Settings) do
			table.insert(npcList, v)
		end
		for _, v in pairs(Settings) do
			table.insert(heroList, v)
		end
		print("Initial File Created: data/zinv/profile_default.txt")
	end
	spawnedHeroes = {}
	for _, v in pairs(heroList) do
		local entry = table.Copy(v)
		entry["instance"] = -1
		table.insert(spawnedHeroes, entry)
	end

	print("Loading profile "..profileName.."...")
	file.Write("zinv/last_profile.txt", profileName)

	--Check validity
	for _, v in pairs(npcList) do
		if tonumber(v["health"]) == nil then
			v["health"] = -1
		end
		if tonumber(v["chance"]) == nil then
			v["chance"] = 100
		end
		if tonumber(v["scale"]) == nil then
			v["scale"] = 1
		end
		if !v["model"] then
			v["model"] = ""
		end
		if !v["weapon"] then
			v["weapon"] = ""
		end
		if !v["overriding_spawn_flags"] then
			v["overriding_spawn_flags"] = false
		end
		if !v["class_name"] then
			v["class_name"] = ""
		end
		if !v["spawn_flags"] then
			if v["overriding_spawn_flags"] then
				v["spawn_flags"] = 0
			else
				v["spawn_flags"] = "Default"
			end
		end
		if !v["squad_name"] then
			v["squad_name"] = ""
		end
		if !v["weapon_proficiency"] then
			v["weapon_proficiency"] = "Average"
		end
		if !v["damage_multiplier"] then
			v["damage_multiplier"] = 1
		end
		totalChance = totalChance + v["chance"]
	end

	print("Loaded "..profileName)
	print("NPCs:")
	PrintTable(npcList)
	print("Heroes:")
	PrintTable(heroList)

	--Notify players
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Broadcast()
end

function getZINVProfiles()
	profile_files, _ = file.Find("data/zinv/profile_*.txt", "MOD")
	profileNames = {}
	for k, v in pairs(profile_files) do
		profileNames[k] = string.StripExtension(string.sub(v, 9))
	end
	return profileNames
end

net.Receive("send_ztable_sr", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = net.ReadTable()
		heroList = net.ReadTable()
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true)) 
		print("NPC waves profile \""..profileName.."\"edited by: "..pl:Nick())
	end
end)

net.Receive("change_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		loadNPCInfo(profileName)
	end
end)

net.Receive("create_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = {}
		heroList = {}
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true))
		print("NPC waves profile \""..profileName.."\" created by: "..pl:Nick())
		loadNPCInfo(profileName)
	end
end)

net.Receive("remove_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		file.Delete("zinv/profile_"..profileName..".txt")
		print("NPC waves profile \""..profileName.."\" deleted by: "..pl:Nick())
		loadNPCInfo(getZINVProfiles()[1])
	end
end)

-- "lua\\autorun\\zinv_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include( "zinv_shared.lua" )
AddCSLuaFile( "zinv_shared.lua" )

if CLIENT then return end

defaultSettings = [[
{
	"npcs": [
		{
			"health": -1,
			"chance": 100,
			"model": "",
			"scale": 1,
			"class_name": "npc_zombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 30,
			"model": "",
			"scale": 1,
			"class_name": "npc_fastzombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 40,
			"model": "",
			"scale": 1,
			"class_name": "npc_headcrab_fast",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}
	],
	"heroes": [
	]
}
]]

HERO_COOLDOWN = 60

util.AddNetworkString("send_ztable_cl")
util.AddNetworkString("send_ztable_sr")
util.AddNetworkString("change_zinv_profile")
util.AddNetworkString("create_zinv_profile")
util.AddNetworkString("remove_zinv_profile")
util.AddNetworkString("zinv")
util.AddNetworkString("zinv_explode")
util.AddNetworkString("zinv_maxdist")
util.AddNetworkString("zinv_mindist")
util.AddNetworkString("zinv_maxspawn")
util.AddNetworkString("zinv_chaseplayers")
concommand.Add("zinv_reloadsettings", loadNPCInfo)


function removeHero(ent)
	if spawnedZombies[ent:EntIndex()]["hero"] == true then
		for _, spawnedHero in pairs(spawnedHeroes) do
			if spawnedHero["instance"] == ent:EntIndex() then
				spawnedHero["instance"] = -1
				spawnedHero["last_died"] = os.time()
			end
		end
	end
end

hook.Add("OnNPCKilled","NPC_Died_zinv", function(victim, killer, weapon)
	if spawnedZombies[victim:EntIndex()] then
		removeHero(victim)
		spawnedZombies[victim:EntIndex()] = nil
	end

	if GetConVarNumber("zinv_explode") == 0 then
		return
	end

	local explode = ents.Create("env_explosion")
	explode:SetPos(victim:GetPos())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "35")
	explode:Fire("Explode", 0, 0)
	explode:EmitSound("weapon_AWP.Single", 400, 400)
end)

hook.Add("EntityRemoved", "Entity_Removed_zinv", function(ent)
	if spawnedZombies[ent:EntIndex()] then
		removeHero(ent)
		spawnedZombies[ent:EntIndex()] = nil
	end
end)

hook.Add("EntityTakeDamage", "Entity_Damage_zinv", function(target, dmg)
	for ent_index, data in pairs(spawnedZombies) do
		if ent_index == dmg:GetAttacker():EntIndex() and data["damage_multiplier"] and !dmg:IsExplosionDamage() then
			dmg:ScaleDamage(data["damage_multiplier"])
		end
	end
end)

hook.Add("Initialize", "initializing_zinv", function()
	Nodes = {}
	totalChance = 0
	lastProfile = file.Read("zinv/last_profile.txt", "DATA")
	if not lastProfile then
		lastProfile = "default"
	end
	profileName = lastProfile
	spawnedZombies = {}
	spawnedHeroes = {}
	loadNPCInfo(lastProfile)
	found_ain = false
	ParseFile()
end)

hook.Add("PlayerInitialSpawn", "pinitspawn_zinv", function(ply)
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(lastProfile)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Send(ply)
end)

hook.Add("EntityKeyValue", "newkeyval_zinv", function(ent)
	if ent:GetClass() == "info_player_teamspawn" then
		local valid = true
		for k,v in pairs(Nodes) do
			if v["pos"] == ent:GetPos() then
				valid = false
			end
		end

		if valid then
			local node = {
				pos = ent:GetPos(),
				yaw = 0,
				offset = 0,
				type = 0,
				info = 0,
				zone = 0,
				neighbor = {},
				numneighbors = 0,
				link = {},
				numlinks = 0
			}
			table.insert(Nodes, node)
		end
	end
end)

--Taken from nodegraph addon - thx
local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local AINET_VERSION_NUMBER = 37
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function toInt(b)
	local i = {string.byte(b,1,SIZEOF_INT)}
	i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
	if(i > 2147483647) then return i -4294967296 end
	return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

--Taken from nodegraph addon - thx
--Types:
--1 = ?
--2 = info_nodes
--3 = playerspawns
--4 = wall climbers
function ParseFile()
	if foundain then
		return
	end

	f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
	if(!f) then
		return
	end

	found_ain = true
	local ainet_ver = ReadInt(f)
	local map_ver = ReadInt(f)
	if(ainet_ver != AINET_VERSION_NUMBER) then
		MsgN("Unknown graph file")
		return
	end

	local numNodes = ReadInt(f)
	if(numNodes < 0) then
		MsgN("Graph file has an unexpected amount of nodes")
		return
	end

	for i = 1,numNodes do
		local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
		local yaw = f:ReadFloat()
		local flOffsets = {}
		for i = 1,NUM_HULLS do
			flOffsets[i] = f:ReadFloat()
		end
		local nodetype = f:ReadByte()
		local nodeinfo = ReadUShort(f)
		local zone = f:ReadShort()

		if nodetype == 4 then
			continue
		end
		
		local node = {
			pos = v,
			yaw = yaw,
			offset = flOffsets,
			type = nodetype,
			info = nodeinfo,
			zone = zone,
			neighbor = {},
			numneighbors = 0,
			link = {},
			numlinks = 0
		}

		table.insert(Nodes,node)
	end
end

timer.Create("zombietimer_zinv", 5, 0, function()
	local status, err = pcall( function()
	local valid_nodes = {}
	local zombies = {}

	if GetConVarNumber("zinv") == 0 or table.Count(player.GetAll()) <= 0 then
		return
	end
	
	if !found_ain then
		ParseFile()
	end

	if (!npcList and !heroList) or !Nodes or table.Count(Nodes) < 1 then
		print("No info_node(s) in map! NPCs will not spawn.")
		return
	end

	if table.Count(Nodes) <= 35 then
		print("Zombies may not spawn well on this map, please try another.")
	end

	local zombies = {}
	for ent_index, _ in pairs(spawnedZombies) do
		if !IsValid(Entity(ent_index)) then
			removeHero(Entity(ent_index))
			spawnedZombies[ent_index] = nil
		else
			table.insert(zombies, Entity(ent_index))
		end
	end

	--Check zombie
	for k, v in pairs(zombies) do
		local closest = 99999
		local closest_plr = NULL
		local zombie_pos = v:GetPos()

		for k2, v2 in pairs(player.GetAll()) do
			local dist = zombie_pos:Distance(v2:GetPos())

			if dist < closest then
				closest_plr = v2
				closest = dist
			end
		end

		if closest > GetConVarNumber("zinv_maxdist")*1.25 then
			table.RemoveByValue(zombies, v)
			v:Remove()
		else
			if GetConVarNumber("zinv_chaseplayers") != 0 then
				v:SetLastPosition(closest_plr:GetPos())
				v:SetTarget(closest_plr)
				if !v:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
					v:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
	end

	if table.Count(zombies) >= GetConVarNumber("zinv_maxspawn") then
		return
	end

	--Get valid nodes
	for k, v in pairs(Nodes) do
		local valid = false

		for k2, v2 in pairs(player.GetAll()) do
			local dist = v["pos"]:Distance(v2:GetPos())

			if dist <= GetConVarNumber("zinv_mindist") then
				valid = false
				break
			elseif dist < GetConVarNumber("zinv_maxdist") then
				valid = true
			end
		end

		if !valid then
			continue
		end

		for k2, v2 in pairs(zombies) do
			local dist = v["pos"]:Distance(v2:GetPos())
			if dist <= 100 then
				valid = false
				break
			end
		end

		if valid then
			table.insert(valid_nodes, v["pos"])
		end
	end

	--Spawn zombies if not enough
	if table.Count(valid_nodes) > 0 then
		for i = 0, 5 do
			if table.Count(zombies)+i < GetConVarNumber("zinv_maxspawn") then
				local pos = table.Random(valid_nodes) 
				if pos != nil then
					table.RemoveByValue(valid_nodes, pos)
					spawnZombie(pos + Vector(0,0,30))
				end
			else
				break
			end
		end
	end
	end) 

	if !status then
		print(err)
	end
end)

function spawnZombie(pos)
	--Pick random NPC based on chance
	local rnum = math.random(0, totalChance)

	local heroChance = math.random(0, 100)
	heroSpawnEntry = nil
	if heroChance == 1 then
		for _, v in pairs(spawnedHeroes) do
			if v["instance"] == -1 and (!v["last_died"] or os.difftime(os.time(), v["last_died"]) >= HERO_COOLDOWN) then
				heroSpawnEntry = v
			end
		end

		-- Spawn hero
		if heroSpawnEntry then
			heroInfo = list.Get("NPC")[heroSpawnEntry["class_name"]]
			if !heroInfo then
				MsgN("Class name ", heroSpawnEntry["class_name"], " doesn't exist")
				return
			end
			local hero = ents.Create(heroInfo["Class"])
			if hero then
				print("Spawning hero ", hero)
				if heroSpawnEntry["weapon"] then
					hero:SetKeyValue("additionalequipment", heroSpawnEntry["weapon"])
				end
				hero:SetPos(pos)
				hero:SetAngles(Angle(0, math.random(0, 360), 0))
				hero:Spawn()

				spawnedZombies[hero:EntIndex()] = {
					damage_multiplier = 2,
					hero = true
				}

				heroSpawnEntry["instance"] = hero:EntIndex()

				if heroInfo["Model"] then
					hero:SetModel(heroInfo["Model"])
				end
				if heroSpawnEntry["model"] then
					hero:SetModel(heroSpawnEntry["model"])
				end
				hero:SetModelScale(1.3)
				if heroSpawnEntry["health"] and heroSpawnEntry["health"] > 0 then
					hero:SetHealth(heroSpawnEntry["health"])
					hero:SetMaxHealth(heroSpawnEntry["health"])
				end
				if heroInfo["SpawnFlags"] then
					hero:SetKeyValue("spawnflags", heroInfo["SpawnFlags"])
				end
				if heroSpawnEntry["overriding_spawn_flags"] and heroSpawnEntry["spawn_flags"] then
					hero:SetKeyValue("spawnflags", heroSpawnEntry["spawn_flags"])
				end
	   			if heroInfo["KeyValues"] then
	   				for k, v in pairs(heroInfo["KeyValues"]) do
	   					hero:SetKeyValue(k, v)
	   				end
	   			end
	   			if heroSpawnEntry["squad_name"] then
	   				hero:SetKeyValue("SquadName", heroSpawnEntry["squad_name"])
	   			end
				hero:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
	   			hero:Fire("StartPatrolling")
	   			hero:Fire("SetReadinessHigh")
	   			hero:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end

	if !heroSpawnEntry then
		local total = 0
		for k, v in pairs(npcList) do
			total = total + v["chance"]
			if total >= rnum then
				spawnListEntry = v
				break
			end
		end

		--Spawn NPC
		if spawnListEntry then
			npc_info = list.Get("NPC")[spawnListEntry["class_name"]]
			if !npc_info then
				MsgN("NPC list is ", list.Get("NPC"))
				MsgN("Class name is ", spawnListEntry["class_name"])
			end
			local zombie = ents.Create(npc_info["Class"])
			if zombie then
				if spawnListEntry["weapon"] then
	   				zombie:SetKeyValue("additionalequipment", spawnListEntry["weapon"])
	   			end
	   			zombie:SetPos(pos)
	   			zombie:SetAngles(Angle(0, math.random(0, 360), 0))
				zombie:Spawn()

				spawnedZombies[zombie:EntIndex()] = {
					damage_multiplier = spawnListEntry["damage_multiplier"],
					hero = false
				}
				
				if npc_info["Model"] then
					zombie:SetModel(npc_info["Model"])
				end
				if spawnListEntry["model"] then
					zombie:SetModel(spawnListEntry["model"])
				end
				if spawnListEntry["scale"] then
					zombie:SetModelScale(spawnListEntry["scale"], 0)
				end
				if spawnListEntry["health"] and spawnListEntry["health"] > 0 then
	   				zombie:SetHealth(spawnListEntry["health"])
	   				zombie:SetMaxHealth(spawnListEntry["health"])
	   			end
	   			if npc_info["SpawnFlags"] then
	   				zombie:SetKeyValue("spawnflags", npc_info["SpawnFlags"])
	   			end
	   			if spawnListEntry["overriding_spawn_flags"] and spawnListEntry["spawn_flags"] then
	   				zombie:SetKeyValue("spawnflags", spawnListEntry["spawn_flags"])
	   			end
	   			-- TODO: Possibly use bit.bxor here to combine multiple spawn flags
	   			if npc_info["KeyValues"] then
	   				for k, v in pairs(npc_info["KeyValues"]) do
	   					zombie:SetKeyValue(k, v)
	   				end
	   			end
	   			if spawnListEntry["squad_name"] then
	   				zombie:SetKeyValue("SquadName", spawnListEntry["squad_name"])
	   			end
	   			if spawnListEntry["weapon_proficiency"] then
	   				local weaponProficiency = -1
	   				if spawnListEntry["weapon_proficiency"] == "Poor" then
	   					weaponProficiency = WEAPON_PROFICIENCY_POOR
	   				elseif spawnListEntry["weapon_proficiency"] == "Average" then
	   					weaponProficiency = WEAPON_PROFICIENCY_AVERAGE
	   				elseif spawnListEntry["weapon_proficiency"] == "Good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Very good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_VERY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Perfect" then
	   					weaponProficiency = WEAPON_PROFICIENCY_PERFECT
	   				end
	   				if weaponProficiency ~= -1 then
	   					zombie:SetCurrentWeaponProficiency(weaponProficiency)
	   				end
	   			end
	   			zombie:Fire("StartPatrolling")
	   			zombie:Fire("SetReadinessHigh")
	   			zombie:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end
end

function loadNPCInfo(profileName)
	if !profileName then
		profileName = "default"
	end

	npcList = {}
	heroList = {}
	MsgN("Clearing spawn list")
	spawnedZombies = {}
	local f = file.Read("zinv/profile_"..profileName..".txt", "DATA")
	if f then
		Settings = util.JSONToTable(f)
		if !Settings then -- Support for legacy format
			Settings = util.KeyValuesToTable(f)
			MsgN("Converting legacy profile to new format...")
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		loadedNPCs = Settings["npcs"]
		loadedHeroes = Settings["heroes"]
		if !loadedNPCs or !loadedHeroes then -- Support for hero-less profiles
			MsgN("Adding missing fields to profile...")
			loadedNPCs = Settings
			loadedHeroes = {}
			Settings = {
				npcs = loadedNPCs,
				heroes = loadedHeroes
			}
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		for _, v in pairs(loadedNPCs) do
			table.insert(npcList, v)
		end
		for _, v in pairs(loadedHeroes) do
			table.insert(heroList, v)
		end
	else
		profileName = "default"
		if !file.IsDir("zinv", "DATA") then
			file.CreateDir("zinv")
		end
		Settings = util.JSONToTable(defaultSettings)
		file.Write("zinv/profile_default.txt", defaultSettings) 
		for _, v in pairs(Settings) do
			table.insert(npcList, v)
		end
		for _, v in pairs(Settings) do
			table.insert(heroList, v)
		end
		print("Initial File Created: data/zinv/profile_default.txt")
	end
	spawnedHeroes = {}
	for _, v in pairs(heroList) do
		local entry = table.Copy(v)
		entry["instance"] = -1
		table.insert(spawnedHeroes, entry)
	end

	print("Loading profile "..profileName.."...")
	file.Write("zinv/last_profile.txt", profileName)

	--Check validity
	for _, v in pairs(npcList) do
		if tonumber(v["health"]) == nil then
			v["health"] = -1
		end
		if tonumber(v["chance"]) == nil then
			v["chance"] = 100
		end
		if tonumber(v["scale"]) == nil then
			v["scale"] = 1
		end
		if !v["model"] then
			v["model"] = ""
		end
		if !v["weapon"] then
			v["weapon"] = ""
		end
		if !v["overriding_spawn_flags"] then
			v["overriding_spawn_flags"] = false
		end
		if !v["class_name"] then
			v["class_name"] = ""
		end
		if !v["spawn_flags"] then
			if v["overriding_spawn_flags"] then
				v["spawn_flags"] = 0
			else
				v["spawn_flags"] = "Default"
			end
		end
		if !v["squad_name"] then
			v["squad_name"] = ""
		end
		if !v["weapon_proficiency"] then
			v["weapon_proficiency"] = "Average"
		end
		if !v["damage_multiplier"] then
			v["damage_multiplier"] = 1
		end
		totalChance = totalChance + v["chance"]
	end

	print("Loaded "..profileName)
	print("NPCs:")
	PrintTable(npcList)
	print("Heroes:")
	PrintTable(heroList)

	--Notify players
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Broadcast()
end

function getZINVProfiles()
	profile_files, _ = file.Find("data/zinv/profile_*.txt", "MOD")
	profileNames = {}
	for k, v in pairs(profile_files) do
		profileNames[k] = string.StripExtension(string.sub(v, 9))
	end
	return profileNames
end

net.Receive("send_ztable_sr", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = net.ReadTable()
		heroList = net.ReadTable()
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true)) 
		print("NPC waves profile \""..profileName.."\"edited by: "..pl:Nick())
	end
end)

net.Receive("change_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		loadNPCInfo(profileName)
	end
end)

net.Receive("create_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = {}
		heroList = {}
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true))
		print("NPC waves profile \""..profileName.."\" created by: "..pl:Nick())
		loadNPCInfo(profileName)
	end
end)

net.Receive("remove_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		file.Delete("zinv/profile_"..profileName..".txt")
		print("NPC waves profile \""..profileName.."\" deleted by: "..pl:Nick())
		loadNPCInfo(getZINVProfiles()[1])
	end
end)

-- "lua\\autorun\\zinv_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include( "zinv_shared.lua" )
AddCSLuaFile( "zinv_shared.lua" )

if CLIENT then return end

defaultSettings = [[
{
	"npcs": [
		{
			"health": -1,
			"chance": 100,
			"model": "",
			"scale": 1,
			"class_name": "npc_zombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 30,
			"model": "",
			"scale": 1,
			"class_name": "npc_fastzombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 40,
			"model": "",
			"scale": 1,
			"class_name": "npc_headcrab_fast",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}
	],
	"heroes": [
	]
}
]]

HERO_COOLDOWN = 60

util.AddNetworkString("send_ztable_cl")
util.AddNetworkString("send_ztable_sr")
util.AddNetworkString("change_zinv_profile")
util.AddNetworkString("create_zinv_profile")
util.AddNetworkString("remove_zinv_profile")
util.AddNetworkString("zinv")
util.AddNetworkString("zinv_explode")
util.AddNetworkString("zinv_maxdist")
util.AddNetworkString("zinv_mindist")
util.AddNetworkString("zinv_maxspawn")
util.AddNetworkString("zinv_chaseplayers")
concommand.Add("zinv_reloadsettings", loadNPCInfo)


function removeHero(ent)
	if spawnedZombies[ent:EntIndex()]["hero"] == true then
		for _, spawnedHero in pairs(spawnedHeroes) do
			if spawnedHero["instance"] == ent:EntIndex() then
				spawnedHero["instance"] = -1
				spawnedHero["last_died"] = os.time()
			end
		end
	end
end

hook.Add("OnNPCKilled","NPC_Died_zinv", function(victim, killer, weapon)
	if spawnedZombies[victim:EntIndex()] then
		removeHero(victim)
		spawnedZombies[victim:EntIndex()] = nil
	end

	if GetConVarNumber("zinv_explode") == 0 then
		return
	end

	local explode = ents.Create("env_explosion")
	explode:SetPos(victim:GetPos())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "35")
	explode:Fire("Explode", 0, 0)
	explode:EmitSound("weapon_AWP.Single", 400, 400)
end)

hook.Add("EntityRemoved", "Entity_Removed_zinv", function(ent)
	if spawnedZombies[ent:EntIndex()] then
		removeHero(ent)
		spawnedZombies[ent:EntIndex()] = nil
	end
end)

hook.Add("EntityTakeDamage", "Entity_Damage_zinv", function(target, dmg)
	for ent_index, data in pairs(spawnedZombies) do
		if ent_index == dmg:GetAttacker():EntIndex() and data["damage_multiplier"] and !dmg:IsExplosionDamage() then
			dmg:ScaleDamage(data["damage_multiplier"])
		end
	end
end)

hook.Add("Initialize", "initializing_zinv", function()
	Nodes = {}
	totalChance = 0
	lastProfile = file.Read("zinv/last_profile.txt", "DATA")
	if not lastProfile then
		lastProfile = "default"
	end
	profileName = lastProfile
	spawnedZombies = {}
	spawnedHeroes = {}
	loadNPCInfo(lastProfile)
	found_ain = false
	ParseFile()
end)

hook.Add("PlayerInitialSpawn", "pinitspawn_zinv", function(ply)
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(lastProfile)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Send(ply)
end)

hook.Add("EntityKeyValue", "newkeyval_zinv", function(ent)
	if ent:GetClass() == "info_player_teamspawn" then
		local valid = true
		for k,v in pairs(Nodes) do
			if v["pos"] == ent:GetPos() then
				valid = false
			end
		end

		if valid then
			local node = {
				pos = ent:GetPos(),
				yaw = 0,
				offset = 0,
				type = 0,
				info = 0,
				zone = 0,
				neighbor = {},
				numneighbors = 0,
				link = {},
				numlinks = 0
			}
			table.insert(Nodes, node)
		end
	end
end)

--Taken from nodegraph addon - thx
local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local AINET_VERSION_NUMBER = 37
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function toInt(b)
	local i = {string.byte(b,1,SIZEOF_INT)}
	i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
	if(i > 2147483647) then return i -4294967296 end
	return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

--Taken from nodegraph addon - thx
--Types:
--1 = ?
--2 = info_nodes
--3 = playerspawns
--4 = wall climbers
function ParseFile()
	if foundain then
		return
	end

	f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
	if(!f) then
		return
	end

	found_ain = true
	local ainet_ver = ReadInt(f)
	local map_ver = ReadInt(f)
	if(ainet_ver != AINET_VERSION_NUMBER) then
		MsgN("Unknown graph file")
		return
	end

	local numNodes = ReadInt(f)
	if(numNodes < 0) then
		MsgN("Graph file has an unexpected amount of nodes")
		return
	end

	for i = 1,numNodes do
		local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
		local yaw = f:ReadFloat()
		local flOffsets = {}
		for i = 1,NUM_HULLS do
			flOffsets[i] = f:ReadFloat()
		end
		local nodetype = f:ReadByte()
		local nodeinfo = ReadUShort(f)
		local zone = f:ReadShort()

		if nodetype == 4 then
			continue
		end
		
		local node = {
			pos = v,
			yaw = yaw,
			offset = flOffsets,
			type = nodetype,
			info = nodeinfo,
			zone = zone,
			neighbor = {},
			numneighbors = 0,
			link = {},
			numlinks = 0
		}

		table.insert(Nodes,node)
	end
end

timer.Create("zombietimer_zinv", 5, 0, function()
	local status, err = pcall( function()
	local valid_nodes = {}
	local zombies = {}

	if GetConVarNumber("zinv") == 0 or table.Count(player.GetAll()) <= 0 then
		return
	end
	
	if !found_ain then
		ParseFile()
	end

	if (!npcList and !heroList) or !Nodes or table.Count(Nodes) < 1 then
		print("No info_node(s) in map! NPCs will not spawn.")
		return
	end

	if table.Count(Nodes) <= 35 then
		print("Zombies may not spawn well on this map, please try another.")
	end

	local zombies = {}
	for ent_index, _ in pairs(spawnedZombies) do
		if !IsValid(Entity(ent_index)) then
			removeHero(Entity(ent_index))
			spawnedZombies[ent_index] = nil
		else
			table.insert(zombies, Entity(ent_index))
		end
	end

	--Check zombie
	for k, v in pairs(zombies) do
		local closest = 99999
		local closest_plr = NULL
		local zombie_pos = v:GetPos()

		for k2, v2 in pairs(player.GetAll()) do
			local dist = zombie_pos:Distance(v2:GetPos())

			if dist < closest then
				closest_plr = v2
				closest = dist
			end
		end

		if closest > GetConVarNumber("zinv_maxdist")*1.25 then
			table.RemoveByValue(zombies, v)
			v:Remove()
		else
			if GetConVarNumber("zinv_chaseplayers") != 0 then
				v:SetLastPosition(closest_plr:GetPos())
				v:SetTarget(closest_plr)
				if !v:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
					v:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
	end

	if table.Count(zombies) >= GetConVarNumber("zinv_maxspawn") then
		return
	end

	--Get valid nodes
	for k, v in pairs(Nodes) do
		local valid = false

		for k2, v2 in pairs(player.GetAll()) do
			local dist = v["pos"]:Distance(v2:GetPos())

			if dist <= GetConVarNumber("zinv_mindist") then
				valid = false
				break
			elseif dist < GetConVarNumber("zinv_maxdist") then
				valid = true
			end
		end

		if !valid then
			continue
		end

		for k2, v2 in pairs(zombies) do
			local dist = v["pos"]:Distance(v2:GetPos())
			if dist <= 100 then
				valid = false
				break
			end
		end

		if valid then
			table.insert(valid_nodes, v["pos"])
		end
	end

	--Spawn zombies if not enough
	if table.Count(valid_nodes) > 0 then
		for i = 0, 5 do
			if table.Count(zombies)+i < GetConVarNumber("zinv_maxspawn") then
				local pos = table.Random(valid_nodes) 
				if pos != nil then
					table.RemoveByValue(valid_nodes, pos)
					spawnZombie(pos + Vector(0,0,30))
				end
			else
				break
			end
		end
	end
	end) 

	if !status then
		print(err)
	end
end)

function spawnZombie(pos)
	--Pick random NPC based on chance
	local rnum = math.random(0, totalChance)

	local heroChance = math.random(0, 100)
	heroSpawnEntry = nil
	if heroChance == 1 then
		for _, v in pairs(spawnedHeroes) do
			if v["instance"] == -1 and (!v["last_died"] or os.difftime(os.time(), v["last_died"]) >= HERO_COOLDOWN) then
				heroSpawnEntry = v
			end
		end

		-- Spawn hero
		if heroSpawnEntry then
			heroInfo = list.Get("NPC")[heroSpawnEntry["class_name"]]
			if !heroInfo then
				MsgN("Class name ", heroSpawnEntry["class_name"], " doesn't exist")
				return
			end
			local hero = ents.Create(heroInfo["Class"])
			if hero then
				print("Spawning hero ", hero)
				if heroSpawnEntry["weapon"] then
					hero:SetKeyValue("additionalequipment", heroSpawnEntry["weapon"])
				end
				hero:SetPos(pos)
				hero:SetAngles(Angle(0, math.random(0, 360), 0))
				hero:Spawn()

				spawnedZombies[hero:EntIndex()] = {
					damage_multiplier = 2,
					hero = true
				}

				heroSpawnEntry["instance"] = hero:EntIndex()

				if heroInfo["Model"] then
					hero:SetModel(heroInfo["Model"])
				end
				if heroSpawnEntry["model"] then
					hero:SetModel(heroSpawnEntry["model"])
				end
				hero:SetModelScale(1.3)
				if heroSpawnEntry["health"] and heroSpawnEntry["health"] > 0 then
					hero:SetHealth(heroSpawnEntry["health"])
					hero:SetMaxHealth(heroSpawnEntry["health"])
				end
				if heroInfo["SpawnFlags"] then
					hero:SetKeyValue("spawnflags", heroInfo["SpawnFlags"])
				end
				if heroSpawnEntry["overriding_spawn_flags"] and heroSpawnEntry["spawn_flags"] then
					hero:SetKeyValue("spawnflags", heroSpawnEntry["spawn_flags"])
				end
	   			if heroInfo["KeyValues"] then
	   				for k, v in pairs(heroInfo["KeyValues"]) do
	   					hero:SetKeyValue(k, v)
	   				end
	   			end
	   			if heroSpawnEntry["squad_name"] then
	   				hero:SetKeyValue("SquadName", heroSpawnEntry["squad_name"])
	   			end
				hero:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
	   			hero:Fire("StartPatrolling")
	   			hero:Fire("SetReadinessHigh")
	   			hero:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end

	if !heroSpawnEntry then
		local total = 0
		for k, v in pairs(npcList) do
			total = total + v["chance"]
			if total >= rnum then
				spawnListEntry = v
				break
			end
		end

		--Spawn NPC
		if spawnListEntry then
			npc_info = list.Get("NPC")[spawnListEntry["class_name"]]
			if !npc_info then
				MsgN("NPC list is ", list.Get("NPC"))
				MsgN("Class name is ", spawnListEntry["class_name"])
			end
			local zombie = ents.Create(npc_info["Class"])
			if zombie then
				if spawnListEntry["weapon"] then
	   				zombie:SetKeyValue("additionalequipment", spawnListEntry["weapon"])
	   			end
	   			zombie:SetPos(pos)
	   			zombie:SetAngles(Angle(0, math.random(0, 360), 0))
				zombie:Spawn()

				spawnedZombies[zombie:EntIndex()] = {
					damage_multiplier = spawnListEntry["damage_multiplier"],
					hero = false
				}
				
				if npc_info["Model"] then
					zombie:SetModel(npc_info["Model"])
				end
				if spawnListEntry["model"] then
					zombie:SetModel(spawnListEntry["model"])
				end
				if spawnListEntry["scale"] then
					zombie:SetModelScale(spawnListEntry["scale"], 0)
				end
				if spawnListEntry["health"] and spawnListEntry["health"] > 0 then
	   				zombie:SetHealth(spawnListEntry["health"])
	   				zombie:SetMaxHealth(spawnListEntry["health"])
	   			end
	   			if npc_info["SpawnFlags"] then
	   				zombie:SetKeyValue("spawnflags", npc_info["SpawnFlags"])
	   			end
	   			if spawnListEntry["overriding_spawn_flags"] and spawnListEntry["spawn_flags"] then
	   				zombie:SetKeyValue("spawnflags", spawnListEntry["spawn_flags"])
	   			end
	   			-- TODO: Possibly use bit.bxor here to combine multiple spawn flags
	   			if npc_info["KeyValues"] then
	   				for k, v in pairs(npc_info["KeyValues"]) do
	   					zombie:SetKeyValue(k, v)
	   				end
	   			end
	   			if spawnListEntry["squad_name"] then
	   				zombie:SetKeyValue("SquadName", spawnListEntry["squad_name"])
	   			end
	   			if spawnListEntry["weapon_proficiency"] then
	   				local weaponProficiency = -1
	   				if spawnListEntry["weapon_proficiency"] == "Poor" then
	   					weaponProficiency = WEAPON_PROFICIENCY_POOR
	   				elseif spawnListEntry["weapon_proficiency"] == "Average" then
	   					weaponProficiency = WEAPON_PROFICIENCY_AVERAGE
	   				elseif spawnListEntry["weapon_proficiency"] == "Good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Very good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_VERY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Perfect" then
	   					weaponProficiency = WEAPON_PROFICIENCY_PERFECT
	   				end
	   				if weaponProficiency ~= -1 then
	   					zombie:SetCurrentWeaponProficiency(weaponProficiency)
	   				end
	   			end
	   			zombie:Fire("StartPatrolling")
	   			zombie:Fire("SetReadinessHigh")
	   			zombie:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end
end

function loadNPCInfo(profileName)
	if !profileName then
		profileName = "default"
	end

	npcList = {}
	heroList = {}
	MsgN("Clearing spawn list")
	spawnedZombies = {}
	local f = file.Read("zinv/profile_"..profileName..".txt", "DATA")
	if f then
		Settings = util.JSONToTable(f)
		if !Settings then -- Support for legacy format
			Settings = util.KeyValuesToTable(f)
			MsgN("Converting legacy profile to new format...")
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		loadedNPCs = Settings["npcs"]
		loadedHeroes = Settings["heroes"]
		if !loadedNPCs or !loadedHeroes then -- Support for hero-less profiles
			MsgN("Adding missing fields to profile...")
			loadedNPCs = Settings
			loadedHeroes = {}
			Settings = {
				npcs = loadedNPCs,
				heroes = loadedHeroes
			}
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		for _, v in pairs(loadedNPCs) do
			table.insert(npcList, v)
		end
		for _, v in pairs(loadedHeroes) do
			table.insert(heroList, v)
		end
	else
		profileName = "default"
		if !file.IsDir("zinv", "DATA") then
			file.CreateDir("zinv")
		end
		Settings = util.JSONToTable(defaultSettings)
		file.Write("zinv/profile_default.txt", defaultSettings) 
		for _, v in pairs(Settings) do
			table.insert(npcList, v)
		end
		for _, v in pairs(Settings) do
			table.insert(heroList, v)
		end
		print("Initial File Created: data/zinv/profile_default.txt")
	end
	spawnedHeroes = {}
	for _, v in pairs(heroList) do
		local entry = table.Copy(v)
		entry["instance"] = -1
		table.insert(spawnedHeroes, entry)
	end

	print("Loading profile "..profileName.."...")
	file.Write("zinv/last_profile.txt", profileName)

	--Check validity
	for _, v in pairs(npcList) do
		if tonumber(v["health"]) == nil then
			v["health"] = -1
		end
		if tonumber(v["chance"]) == nil then
			v["chance"] = 100
		end
		if tonumber(v["scale"]) == nil then
			v["scale"] = 1
		end
		if !v["model"] then
			v["model"] = ""
		end
		if !v["weapon"] then
			v["weapon"] = ""
		end
		if !v["overriding_spawn_flags"] then
			v["overriding_spawn_flags"] = false
		end
		if !v["class_name"] then
			v["class_name"] = ""
		end
		if !v["spawn_flags"] then
			if v["overriding_spawn_flags"] then
				v["spawn_flags"] = 0
			else
				v["spawn_flags"] = "Default"
			end
		end
		if !v["squad_name"] then
			v["squad_name"] = ""
		end
		if !v["weapon_proficiency"] then
			v["weapon_proficiency"] = "Average"
		end
		if !v["damage_multiplier"] then
			v["damage_multiplier"] = 1
		end
		totalChance = totalChance + v["chance"]
	end

	print("Loaded "..profileName)
	print("NPCs:")
	PrintTable(npcList)
	print("Heroes:")
	PrintTable(heroList)

	--Notify players
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Broadcast()
end

function getZINVProfiles()
	profile_files, _ = file.Find("data/zinv/profile_*.txt", "MOD")
	profileNames = {}
	for k, v in pairs(profile_files) do
		profileNames[k] = string.StripExtension(string.sub(v, 9))
	end
	return profileNames
end

net.Receive("send_ztable_sr", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = net.ReadTable()
		heroList = net.ReadTable()
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true)) 
		print("NPC waves profile \""..profileName.."\"edited by: "..pl:Nick())
	end
end)

net.Receive("change_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		loadNPCInfo(profileName)
	end
end)

net.Receive("create_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = {}
		heroList = {}
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true))
		print("NPC waves profile \""..profileName.."\" created by: "..pl:Nick())
		loadNPCInfo(profileName)
	end
end)

net.Receive("remove_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		file.Delete("zinv/profile_"..profileName..".txt")
		print("NPC waves profile \""..profileName.."\" deleted by: "..pl:Nick())
		loadNPCInfo(getZINVProfiles()[1])
	end
end)

-- "lua\\autorun\\zinv_init.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
include( "zinv_shared.lua" )
AddCSLuaFile( "zinv_shared.lua" )

if CLIENT then return end

defaultSettings = [[
{
	"npcs": [
		{
			"health": -1,
			"chance": 100,
			"model": "",
			"scale": 1,
			"class_name": "npc_zombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 30,
			"model": "",
			"scale": 1,
			"class_name": "npc_fastzombie",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}, {
			"health": -1,
			"chance": 40,
			"model": "",
			"scale": 1,
			"class_name": "npc_headcrab_fast",
			"weapon": "",
			"overriding_spawn_flags": false,
			"spawn_flags": 0,
			"squad_name": "",
			"weapon_proficiency": "Average",
			"damage_multiplier": 1
		}
	],
	"heroes": [
	]
}
]]

HERO_COOLDOWN = 60

util.AddNetworkString("send_ztable_cl")
util.AddNetworkString("send_ztable_sr")
util.AddNetworkString("change_zinv_profile")
util.AddNetworkString("create_zinv_profile")
util.AddNetworkString("remove_zinv_profile")
util.AddNetworkString("zinv")
util.AddNetworkString("zinv_explode")
util.AddNetworkString("zinv_maxdist")
util.AddNetworkString("zinv_mindist")
util.AddNetworkString("zinv_maxspawn")
util.AddNetworkString("zinv_chaseplayers")
concommand.Add("zinv_reloadsettings", loadNPCInfo)


function removeHero(ent)
	if spawnedZombies[ent:EntIndex()]["hero"] == true then
		for _, spawnedHero in pairs(spawnedHeroes) do
			if spawnedHero["instance"] == ent:EntIndex() then
				spawnedHero["instance"] = -1
				spawnedHero["last_died"] = os.time()
			end
		end
	end
end

hook.Add("OnNPCKilled","NPC_Died_zinv", function(victim, killer, weapon)
	if spawnedZombies[victim:EntIndex()] then
		removeHero(victim)
		spawnedZombies[victim:EntIndex()] = nil
	end

	if GetConVarNumber("zinv_explode") == 0 then
		return
	end

	local explode = ents.Create("env_explosion")
	explode:SetPos(victim:GetPos())
	explode:Spawn()
	explode:SetKeyValue("iMagnitude", "35")
	explode:Fire("Explode", 0, 0)
	explode:EmitSound("weapon_AWP.Single", 400, 400)
end)

hook.Add("EntityRemoved", "Entity_Removed_zinv", function(ent)
	if spawnedZombies[ent:EntIndex()] then
		removeHero(ent)
		spawnedZombies[ent:EntIndex()] = nil
	end
end)

hook.Add("EntityTakeDamage", "Entity_Damage_zinv", function(target, dmg)
	for ent_index, data in pairs(spawnedZombies) do
		if ent_index == dmg:GetAttacker():EntIndex() and data["damage_multiplier"] and !dmg:IsExplosionDamage() then
			dmg:ScaleDamage(data["damage_multiplier"])
		end
	end
end)

hook.Add("Initialize", "initializing_zinv", function()
	Nodes = {}
	totalChance = 0
	lastProfile = file.Read("zinv/last_profile.txt", "DATA")
	if not lastProfile then
		lastProfile = "default"
	end
	profileName = lastProfile
	spawnedZombies = {}
	spawnedHeroes = {}
	loadNPCInfo(lastProfile)
	found_ain = false
	ParseFile()
end)

hook.Add("PlayerInitialSpawn", "pinitspawn_zinv", function(ply)
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(lastProfile)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Send(ply)
end)

hook.Add("EntityKeyValue", "newkeyval_zinv", function(ent)
	if ent:GetClass() == "info_player_teamspawn" then
		local valid = true
		for k,v in pairs(Nodes) do
			if v["pos"] == ent:GetPos() then
				valid = false
			end
		end

		if valid then
			local node = {
				pos = ent:GetPos(),
				yaw = 0,
				offset = 0,
				type = 0,
				info = 0,
				zone = 0,
				neighbor = {},
				numneighbors = 0,
				link = {},
				numlinks = 0
			}
			table.insert(Nodes, node)
		end
	end
end)

--Taken from nodegraph addon - thx
local SIZEOF_INT = 4
local SIZEOF_SHORT = 2
local AINET_VERSION_NUMBER = 37
local function toUShort(b)
	local i = {string.byte(b,1,SIZEOF_SHORT)}
	return i[1] +i[2] *256
end
local function toInt(b)
	local i = {string.byte(b,1,SIZEOF_INT)}
	i = i[1] +i[2] *256 +i[3] *65536 +i[4] *16777216
	if(i > 2147483647) then return i -4294967296 end
	return i
end
local function ReadInt(f) return toInt(f:Read(SIZEOF_INT)) end
local function ReadUShort(f) return toUShort(f:Read(SIZEOF_SHORT)) end

--Taken from nodegraph addon - thx
--Types:
--1 = ?
--2 = info_nodes
--3 = playerspawns
--4 = wall climbers
function ParseFile()
	if foundain then
		return
	end

	f = file.Open("maps/graphs/"..game.GetMap()..".ain","rb","GAME")
	if(!f) then
		return
	end

	found_ain = true
	local ainet_ver = ReadInt(f)
	local map_ver = ReadInt(f)
	if(ainet_ver != AINET_VERSION_NUMBER) then
		MsgN("Unknown graph file")
		return
	end

	local numNodes = ReadInt(f)
	if(numNodes < 0) then
		MsgN("Graph file has an unexpected amount of nodes")
		return
	end

	for i = 1,numNodes do
		local v = Vector(f:ReadFloat(),f:ReadFloat(),f:ReadFloat())
		local yaw = f:ReadFloat()
		local flOffsets = {}
		for i = 1,NUM_HULLS do
			flOffsets[i] = f:ReadFloat()
		end
		local nodetype = f:ReadByte()
		local nodeinfo = ReadUShort(f)
		local zone = f:ReadShort()

		if nodetype == 4 then
			continue
		end
		
		local node = {
			pos = v,
			yaw = yaw,
			offset = flOffsets,
			type = nodetype,
			info = nodeinfo,
			zone = zone,
			neighbor = {},
			numneighbors = 0,
			link = {},
			numlinks = 0
		}

		table.insert(Nodes,node)
	end
end

timer.Create("zombietimer_zinv", 5, 0, function()
	local status, err = pcall( function()
	local valid_nodes = {}
	local zombies = {}

	if GetConVarNumber("zinv") == 0 or table.Count(player.GetAll()) <= 0 then
		return
	end
	
	if !found_ain then
		ParseFile()
	end

	if (!npcList and !heroList) or !Nodes or table.Count(Nodes) < 1 then
		print("No info_node(s) in map! NPCs will not spawn.")
		return
	end

	if table.Count(Nodes) <= 35 then
		print("Zombies may not spawn well on this map, please try another.")
	end

	local zombies = {}
	for ent_index, _ in pairs(spawnedZombies) do
		if !IsValid(Entity(ent_index)) then
			removeHero(Entity(ent_index))
			spawnedZombies[ent_index] = nil
		else
			table.insert(zombies, Entity(ent_index))
		end
	end

	--Check zombie
	for k, v in pairs(zombies) do
		local closest = 99999
		local closest_plr = NULL
		local zombie_pos = v:GetPos()

		for k2, v2 in pairs(player.GetAll()) do
			local dist = zombie_pos:Distance(v2:GetPos())

			if dist < closest then
				closest_plr = v2
				closest = dist
			end
		end

		if closest > GetConVarNumber("zinv_maxdist")*1.25 then
			table.RemoveByValue(zombies, v)
			v:Remove()
		else
			if GetConVarNumber("zinv_chaseplayers") != 0 then
				v:SetLastPosition(closest_plr:GetPos())
				v:SetTarget(closest_plr)
				if !v:IsCurrentSchedule(SCHED_FORCED_GO_RUN) then
					v:SetSchedule(SCHED_FORCED_GO_RUN)
				end
			end
		end
	end

	if table.Count(zombies) >= GetConVarNumber("zinv_maxspawn") then
		return
	end

	--Get valid nodes
	for k, v in pairs(Nodes) do
		local valid = false

		for k2, v2 in pairs(player.GetAll()) do
			local dist = v["pos"]:Distance(v2:GetPos())

			if dist <= GetConVarNumber("zinv_mindist") then
				valid = false
				break
			elseif dist < GetConVarNumber("zinv_maxdist") then
				valid = true
			end
		end

		if !valid then
			continue
		end

		for k2, v2 in pairs(zombies) do
			local dist = v["pos"]:Distance(v2:GetPos())
			if dist <= 100 then
				valid = false
				break
			end
		end

		if valid then
			table.insert(valid_nodes, v["pos"])
		end
	end

	--Spawn zombies if not enough
	if table.Count(valid_nodes) > 0 then
		for i = 0, 5 do
			if table.Count(zombies)+i < GetConVarNumber("zinv_maxspawn") then
				local pos = table.Random(valid_nodes) 
				if pos != nil then
					table.RemoveByValue(valid_nodes, pos)
					spawnZombie(pos + Vector(0,0,30))
				end
			else
				break
			end
		end
	end
	end) 

	if !status then
		print(err)
	end
end)

function spawnZombie(pos)
	--Pick random NPC based on chance
	local rnum = math.random(0, totalChance)

	local heroChance = math.random(0, 100)
	heroSpawnEntry = nil
	if heroChance == 1 then
		for _, v in pairs(spawnedHeroes) do
			if v["instance"] == -1 and (!v["last_died"] or os.difftime(os.time(), v["last_died"]) >= HERO_COOLDOWN) then
				heroSpawnEntry = v
			end
		end

		-- Spawn hero
		if heroSpawnEntry then
			heroInfo = list.Get("NPC")[heroSpawnEntry["class_name"]]
			if !heroInfo then
				MsgN("Class name ", heroSpawnEntry["class_name"], " doesn't exist")
				return
			end
			local hero = ents.Create(heroInfo["Class"])
			if hero then
				print("Spawning hero ", hero)
				if heroSpawnEntry["weapon"] then
					hero:SetKeyValue("additionalequipment", heroSpawnEntry["weapon"])
				end
				hero:SetPos(pos)
				hero:SetAngles(Angle(0, math.random(0, 360), 0))
				hero:Spawn()

				spawnedZombies[hero:EntIndex()] = {
					damage_multiplier = 2,
					hero = true
				}

				heroSpawnEntry["instance"] = hero:EntIndex()

				if heroInfo["Model"] then
					hero:SetModel(heroInfo["Model"])
				end
				if heroSpawnEntry["model"] then
					hero:SetModel(heroSpawnEntry["model"])
				end
				hero:SetModelScale(1.3)
				if heroSpawnEntry["health"] and heroSpawnEntry["health"] > 0 then
					hero:SetHealth(heroSpawnEntry["health"])
					hero:SetMaxHealth(heroSpawnEntry["health"])
				end
				if heroInfo["SpawnFlags"] then
					hero:SetKeyValue("spawnflags", heroInfo["SpawnFlags"])
				end
				if heroSpawnEntry["overriding_spawn_flags"] and heroSpawnEntry["spawn_flags"] then
					hero:SetKeyValue("spawnflags", heroSpawnEntry["spawn_flags"])
				end
	   			if heroInfo["KeyValues"] then
	   				for k, v in pairs(heroInfo["KeyValues"]) do
	   					hero:SetKeyValue(k, v)
	   				end
	   			end
	   			if heroSpawnEntry["squad_name"] then
	   				hero:SetKeyValue("SquadName", heroSpawnEntry["squad_name"])
	   			end
				hero:SetCurrentWeaponProficiency(WEAPON_PROFICIENCY_VERY_GOOD)
	   			hero:Fire("StartPatrolling")
	   			hero:Fire("SetReadinessHigh")
	   			hero:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end

	if !heroSpawnEntry then
		local total = 0
		for k, v in pairs(npcList) do
			total = total + v["chance"]
			if total >= rnum then
				spawnListEntry = v
				break
			end
		end

		--Spawn NPC
		if spawnListEntry then
			npc_info = list.Get("NPC")[spawnListEntry["class_name"]]
			if !npc_info then
				MsgN("NPC list is ", list.Get("NPC"))
				MsgN("Class name is ", spawnListEntry["class_name"])
			end
			local zombie = ents.Create(npc_info["Class"])
			if zombie then
				if spawnListEntry["weapon"] then
	   				zombie:SetKeyValue("additionalequipment", spawnListEntry["weapon"])
	   			end
	   			zombie:SetPos(pos)
	   			zombie:SetAngles(Angle(0, math.random(0, 360), 0))
				zombie:Spawn()

				spawnedZombies[zombie:EntIndex()] = {
					damage_multiplier = spawnListEntry["damage_multiplier"],
					hero = false
				}
				
				if npc_info["Model"] then
					zombie:SetModel(npc_info["Model"])
				end
				if spawnListEntry["model"] then
					zombie:SetModel(spawnListEntry["model"])
				end
				if spawnListEntry["scale"] then
					zombie:SetModelScale(spawnListEntry["scale"], 0)
				end
				if spawnListEntry["health"] and spawnListEntry["health"] > 0 then
	   				zombie:SetHealth(spawnListEntry["health"])
	   				zombie:SetMaxHealth(spawnListEntry["health"])
	   			end
	   			if npc_info["SpawnFlags"] then
	   				zombie:SetKeyValue("spawnflags", npc_info["SpawnFlags"])
	   			end
	   			if spawnListEntry["overriding_spawn_flags"] and spawnListEntry["spawn_flags"] then
	   				zombie:SetKeyValue("spawnflags", spawnListEntry["spawn_flags"])
	   			end
	   			-- TODO: Possibly use bit.bxor here to combine multiple spawn flags
	   			if npc_info["KeyValues"] then
	   				for k, v in pairs(npc_info["KeyValues"]) do
	   					zombie:SetKeyValue(k, v)
	   				end
	   			end
	   			if spawnListEntry["squad_name"] then
	   				zombie:SetKeyValue("SquadName", spawnListEntry["squad_name"])
	   			end
	   			if spawnListEntry["weapon_proficiency"] then
	   				local weaponProficiency = -1
	   				if spawnListEntry["weapon_proficiency"] == "Poor" then
	   					weaponProficiency = WEAPON_PROFICIENCY_POOR
	   				elseif spawnListEntry["weapon_proficiency"] == "Average" then
	   					weaponProficiency = WEAPON_PROFICIENCY_AVERAGE
	   				elseif spawnListEntry["weapon_proficiency"] == "Good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Very good" then
	   					weaponProficiency = WEAPON_PROFICIENCY_VERY_GOOD
	   				elseif spawnListEntry["weapon_proficiency"] == "Perfect" then
	   					weaponProficiency = WEAPON_PROFICIENCY_PERFECT
	   				end
	   				if weaponProficiency ~= -1 then
	   					zombie:SetCurrentWeaponProficiency(weaponProficiency)
	   				end
	   			end
	   			zombie:Fire("StartPatrolling")
	   			zombie:Fire("SetReadinessHigh")
	   			zombie:SetNPCState(NPC_STATE_COMBAT)
			end
		end
	end
end

function loadNPCInfo(profileName)
	if !profileName then
		profileName = "default"
	end

	npcList = {}
	heroList = {}
	MsgN("Clearing spawn list")
	spawnedZombies = {}
	local f = file.Read("zinv/profile_"..profileName..".txt", "DATA")
	if f then
		Settings = util.JSONToTable(f)
		if !Settings then -- Support for legacy format
			Settings = util.KeyValuesToTable(f)
			MsgN("Converting legacy profile to new format...")
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		loadedNPCs = Settings["npcs"]
		loadedHeroes = Settings["heroes"]
		if !loadedNPCs or !loadedHeroes then -- Support for hero-less profiles
			MsgN("Adding missing fields to profile...")
			loadedNPCs = Settings
			loadedHeroes = {}
			Settings = {
				npcs = loadedNPCs,
				heroes = loadedHeroes
			}
			file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(Settings, true))
		end

		for _, v in pairs(loadedNPCs) do
			table.insert(npcList, v)
		end
		for _, v in pairs(loadedHeroes) do
			table.insert(heroList, v)
		end
	else
		profileName = "default"
		if !file.IsDir("zinv", "DATA") then
			file.CreateDir("zinv")
		end
		Settings = util.JSONToTable(defaultSettings)
		file.Write("zinv/profile_default.txt", defaultSettings) 
		for _, v in pairs(Settings) do
			table.insert(npcList, v)
		end
		for _, v in pairs(Settings) do
			table.insert(heroList, v)
		end
		print("Initial File Created: data/zinv/profile_default.txt")
	end
	spawnedHeroes = {}
	for _, v in pairs(heroList) do
		local entry = table.Copy(v)
		entry["instance"] = -1
		table.insert(spawnedHeroes, entry)
	end

	print("Loading profile "..profileName.."...")
	file.Write("zinv/last_profile.txt", profileName)

	--Check validity
	for _, v in pairs(npcList) do
		if tonumber(v["health"]) == nil then
			v["health"] = -1
		end
		if tonumber(v["chance"]) == nil then
			v["chance"] = 100
		end
		if tonumber(v["scale"]) == nil then
			v["scale"] = 1
		end
		if !v["model"] then
			v["model"] = ""
		end
		if !v["weapon"] then
			v["weapon"] = ""
		end
		if !v["overriding_spawn_flags"] then
			v["overriding_spawn_flags"] = false
		end
		if !v["class_name"] then
			v["class_name"] = ""
		end
		if !v["spawn_flags"] then
			if v["overriding_spawn_flags"] then
				v["spawn_flags"] = 0
			else
				v["spawn_flags"] = "Default"
			end
		end
		if !v["squad_name"] then
			v["squad_name"] = ""
		end
		if !v["weapon_proficiency"] then
			v["weapon_proficiency"] = "Average"
		end
		if !v["damage_multiplier"] then
			v["damage_multiplier"] = 1
		end
		totalChance = totalChance + v["chance"]
	end

	print("Loaded "..profileName)
	print("NPCs:")
	PrintTable(npcList)
	print("Heroes:")
	PrintTable(heroList)

	--Notify players
	net.Start("send_ztable_cl")
	net.WriteTable(getZINVProfiles())
	net.WriteString(profileName)
	net.WriteTable(npcList)
	net.WriteTable(heroList)
	net.Broadcast()
end

function getZINVProfiles()
	profile_files, _ = file.Find("data/zinv/profile_*.txt", "MOD")
	profileNames = {}
	for k, v in pairs(profile_files) do
		profileNames[k] = string.StripExtension(string.sub(v, 9))
	end
	return profileNames
end

net.Receive("send_ztable_sr", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = net.ReadTable()
		heroList = net.ReadTable()
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true)) 
		print("NPC waves profile \""..profileName.."\"edited by: "..pl:Nick())
	end
end)

net.Receive("change_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		loadNPCInfo(profileName)
	end
end)

net.Receive("create_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		npcList = {}
		heroList = {}
		local profile = {
			npcs = npcList,
			heroes = heroList
		}
		file.Write("zinv/profile_"..profileName..".txt", util.TableToJSON(profile, true))
		print("NPC waves profile \""..profileName.."\" created by: "..pl:Nick())
		loadNPCInfo(profileName)
	end
end)

net.Receive("remove_zinv_profile", function(len, pl)
	if pl:IsValid() and pl:IsPlayer() and pl:IsSuperAdmin() then
		profileName = net.ReadString()
		file.Delete("zinv/profile_"..profileName..".txt")
		print("NPC waves profile \""..profileName.."\" deleted by: "..pl:Nick())
		loadNPCInfo(getZINVProfiles()[1])
	end
end)

