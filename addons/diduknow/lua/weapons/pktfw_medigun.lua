-- "addons\\diduknow\\lua\\weapons\\pktfw_medigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Medi Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_medigun.mdl"

SWEP.Primary.ClipSize	= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"BeamActive")
end

function SWEP:Initialize()
	self:SetHoldType("ar2")
	
	self.sound_heal = CreateSound(self,"weapons/medigun_heal.wav")

	if SERVER then
		//Credit to http://steamcommunity.com/id/steemeyedee (Medi Gun beam poser)
		self.beam = ents.Create("info_particle_system")
		//self.beam:SetPos(self:GetPos())
		self.beam:SetAngles(self:GetAngles())
		self.beam:SetParent(self)
		self.beam:SetLocalPos(Vector(50,0,0))
		self.beam:SetKeyValue("effect_name","medicgun_beam_red")

		self.targetpoint = ents.Create("pill_target")
		self.targetpoint:Spawn()

		self.beam:SetKeyValue("cpoint1",self.targetpoint:GetName())

		self.beam:Spawn()
		self.beam:Activate()
	end
end

function SWEP:OnRemove()
	self.sound_heal:Stop()
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) then
			self.target = IsValid(self.target) and self.target or self.Owner:GetEyeTrace().Entity

			if !self:CheckTargetValid() then
				self.target = nil
			end
		else
			self.target=nil
		end

		if self.target then
			self.sound_heal:Play()
			if self.targetpoint:GetParent()!=self.target then
				self.targetpoint:SetParent(self.target)
				self.targetpoint:SetLocalPos(Vector(0,0,30))
			end
			if !self:GetBeamActive() then
				self.beam:Fire("Start")
				self:SetBeamActive(true)
			end
			local h = self.target:Health()
			local mh = self.target:GetMaxHealth()*1.5
			local dh= 24*FrameTime() + (self.storedhealth or 0)
			local fh= dh%1
			local ih = dh-fh
			if h<mh then
				self.storedhealth = fh
				self.target:SetHealth(h+ih)
			end
		else
			self.sound_heal:Stop()
			if self:GetBeamActive() then
				self.beam:Fire("Stop")
				self:SetBeamActive(false)
			end
		end


		self:NextThink(CurTime())
		return true
	else
		if self:GetBeamActive() then
			self.sound_heal:Play()
		else
			self.sound_heal:Stop()
		end
	end
end

function SWEP:CheckTargetValid()
	if !IsValid(self.target) then return false end

	if !(self.target:IsNPC() or self.target:IsPlayer()) then return false end

	if self.Owner:GetShootPos():Distance(self.target:GetShootPos())>500 then return false end

	local tr = util.TraceLine{start=self.Owner:GetShootPos(),endpos=self.target:GetShootPos(),mask=MASK_SOLID_BRUSHONLY }
	if tr.Hit then
		return false
	end
	return true
end

function SWEP:Holster()
	if SERVER then
		self.sound_heal:Stop()
	end
	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_medigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Medi Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_medigun.mdl"

SWEP.Primary.ClipSize	= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"BeamActive")
end

function SWEP:Initialize()
	self:SetHoldType("ar2")
	
	self.sound_heal = CreateSound(self,"weapons/medigun_heal.wav")

	if SERVER then
		//Credit to http://steamcommunity.com/id/steemeyedee (Medi Gun beam poser)
		self.beam = ents.Create("info_particle_system")
		//self.beam:SetPos(self:GetPos())
		self.beam:SetAngles(self:GetAngles())
		self.beam:SetParent(self)
		self.beam:SetLocalPos(Vector(50,0,0))
		self.beam:SetKeyValue("effect_name","medicgun_beam_red")

		self.targetpoint = ents.Create("pill_target")
		self.targetpoint:Spawn()

		self.beam:SetKeyValue("cpoint1",self.targetpoint:GetName())

		self.beam:Spawn()
		self.beam:Activate()
	end
end

function SWEP:OnRemove()
	self.sound_heal:Stop()
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) then
			self.target = IsValid(self.target) and self.target or self.Owner:GetEyeTrace().Entity

			if !self:CheckTargetValid() then
				self.target = nil
			end
		else
			self.target=nil
		end

		if self.target then
			self.sound_heal:Play()
			if self.targetpoint:GetParent()!=self.target then
				self.targetpoint:SetParent(self.target)
				self.targetpoint:SetLocalPos(Vector(0,0,30))
			end
			if !self:GetBeamActive() then
				self.beam:Fire("Start")
				self:SetBeamActive(true)
			end
			local h = self.target:Health()
			local mh = self.target:GetMaxHealth()*1.5
			local dh= 24*FrameTime() + (self.storedhealth or 0)
			local fh= dh%1
			local ih = dh-fh
			if h<mh then
				self.storedhealth = fh
				self.target:SetHealth(h+ih)
			end
		else
			self.sound_heal:Stop()
			if self:GetBeamActive() then
				self.beam:Fire("Stop")
				self:SetBeamActive(false)
			end
		end


		self:NextThink(CurTime())
		return true
	else
		if self:GetBeamActive() then
			self.sound_heal:Play()
		else
			self.sound_heal:Stop()
		end
	end
end

function SWEP:CheckTargetValid()
	if !IsValid(self.target) then return false end

	if !(self.target:IsNPC() or self.target:IsPlayer()) then return false end

	if self.Owner:GetShootPos():Distance(self.target:GetShootPos())>500 then return false end

	local tr = util.TraceLine{start=self.Owner:GetShootPos(),endpos=self.target:GetShootPos(),mask=MASK_SOLID_BRUSHONLY }
	if tr.Hit then
		return false
	end
	return true
end

function SWEP:Holster()
	if SERVER then
		self.sound_heal:Stop()
	end
	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_medigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Medi Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_medigun.mdl"

SWEP.Primary.ClipSize	= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"BeamActive")
end

function SWEP:Initialize()
	self:SetHoldType("ar2")
	
	self.sound_heal = CreateSound(self,"weapons/medigun_heal.wav")

	if SERVER then
		//Credit to http://steamcommunity.com/id/steemeyedee (Medi Gun beam poser)
		self.beam = ents.Create("info_particle_system")
		//self.beam:SetPos(self:GetPos())
		self.beam:SetAngles(self:GetAngles())
		self.beam:SetParent(self)
		self.beam:SetLocalPos(Vector(50,0,0))
		self.beam:SetKeyValue("effect_name","medicgun_beam_red")

		self.targetpoint = ents.Create("pill_target")
		self.targetpoint:Spawn()

		self.beam:SetKeyValue("cpoint1",self.targetpoint:GetName())

		self.beam:Spawn()
		self.beam:Activate()
	end
end

function SWEP:OnRemove()
	self.sound_heal:Stop()
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) then
			self.target = IsValid(self.target) and self.target or self.Owner:GetEyeTrace().Entity

			if !self:CheckTargetValid() then
				self.target = nil
			end
		else
			self.target=nil
		end

		if self.target then
			self.sound_heal:Play()
			if self.targetpoint:GetParent()!=self.target then
				self.targetpoint:SetParent(self.target)
				self.targetpoint:SetLocalPos(Vector(0,0,30))
			end
			if !self:GetBeamActive() then
				self.beam:Fire("Start")
				self:SetBeamActive(true)
			end
			local h = self.target:Health()
			local mh = self.target:GetMaxHealth()*1.5
			local dh= 24*FrameTime() + (self.storedhealth or 0)
			local fh= dh%1
			local ih = dh-fh
			if h<mh then
				self.storedhealth = fh
				self.target:SetHealth(h+ih)
			end
		else
			self.sound_heal:Stop()
			if self:GetBeamActive() then
				self.beam:Fire("Stop")
				self:SetBeamActive(false)
			end
		end


		self:NextThink(CurTime())
		return true
	else
		if self:GetBeamActive() then
			self.sound_heal:Play()
		else
			self.sound_heal:Stop()
		end
	end
end

function SWEP:CheckTargetValid()
	if !IsValid(self.target) then return false end

	if !(self.target:IsNPC() or self.target:IsPlayer()) then return false end

	if self.Owner:GetShootPos():Distance(self.target:GetShootPos())>500 then return false end

	local tr = util.TraceLine{start=self.Owner:GetShootPos(),endpos=self.target:GetShootPos(),mask=MASK_SOLID_BRUSHONLY }
	if tr.Hit then
		return false
	end
	return true
end

function SWEP:Holster()
	if SERVER then
		self.sound_heal:Stop()
	end
	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_medigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Medi Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_medigun.mdl"

SWEP.Primary.ClipSize	= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"BeamActive")
end

function SWEP:Initialize()
	self:SetHoldType("ar2")
	
	self.sound_heal = CreateSound(self,"weapons/medigun_heal.wav")

	if SERVER then
		//Credit to http://steamcommunity.com/id/steemeyedee (Medi Gun beam poser)
		self.beam = ents.Create("info_particle_system")
		//self.beam:SetPos(self:GetPos())
		self.beam:SetAngles(self:GetAngles())
		self.beam:SetParent(self)
		self.beam:SetLocalPos(Vector(50,0,0))
		self.beam:SetKeyValue("effect_name","medicgun_beam_red")

		self.targetpoint = ents.Create("pill_target")
		self.targetpoint:Spawn()

		self.beam:SetKeyValue("cpoint1",self.targetpoint:GetName())

		self.beam:Spawn()
		self.beam:Activate()
	end
end

function SWEP:OnRemove()
	self.sound_heal:Stop()
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) then
			self.target = IsValid(self.target) and self.target or self.Owner:GetEyeTrace().Entity

			if !self:CheckTargetValid() then
				self.target = nil
			end
		else
			self.target=nil
		end

		if self.target then
			self.sound_heal:Play()
			if self.targetpoint:GetParent()!=self.target then
				self.targetpoint:SetParent(self.target)
				self.targetpoint:SetLocalPos(Vector(0,0,30))
			end
			if !self:GetBeamActive() then
				self.beam:Fire("Start")
				self:SetBeamActive(true)
			end
			local h = self.target:Health()
			local mh = self.target:GetMaxHealth()*1.5
			local dh= 24*FrameTime() + (self.storedhealth or 0)
			local fh= dh%1
			local ih = dh-fh
			if h<mh then
				self.storedhealth = fh
				self.target:SetHealth(h+ih)
			end
		else
			self.sound_heal:Stop()
			if self:GetBeamActive() then
				self.beam:Fire("Stop")
				self:SetBeamActive(false)
			end
		end


		self:NextThink(CurTime())
		return true
	else
		if self:GetBeamActive() then
			self.sound_heal:Play()
		else
			self.sound_heal:Stop()
		end
	end
end

function SWEP:CheckTargetValid()
	if !IsValid(self.target) then return false end

	if !(self.target:IsNPC() or self.target:IsPlayer()) then return false end

	if self.Owner:GetShootPos():Distance(self.target:GetShootPos())>500 then return false end

	local tr = util.TraceLine{start=self.Owner:GetShootPos(),endpos=self.target:GetShootPos(),mask=MASK_SOLID_BRUSHONLY }
	if tr.Hit then
		return false
	end
	return true
end

function SWEP:Holster()
	if SERVER then
		self.sound_heal:Stop()
	end
	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

-- "addons\\diduknow\\lua\\weapons\\pktfw_medigun.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
AddCSLuaFile()

SWEP.Category = "Pill Pack Weapons - TF2"
SWEP.Spawnable=true
SWEP.AdminSpawnable=true

SWEP.PrintName="Medi Gun"

SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = "models/weapons/w_models/w_medigun.mdl"

SWEP.Primary.ClipSize	= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"
 
SWEP.Secondary.ClipSize	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Slot=1

function SWEP:SetupDataTables()
	self:NetworkVar("Bool",0,"BeamActive")
end

function SWEP:Initialize()
	self:SetHoldType("ar2")
	
	self.sound_heal = CreateSound(self,"weapons/medigun_heal.wav")

	if SERVER then
		//Credit to http://steamcommunity.com/id/steemeyedee (Medi Gun beam poser)
		self.beam = ents.Create("info_particle_system")
		//self.beam:SetPos(self:GetPos())
		self.beam:SetAngles(self:GetAngles())
		self.beam:SetParent(self)
		self.beam:SetLocalPos(Vector(50,0,0))
		self.beam:SetKeyValue("effect_name","medicgun_beam_red")

		self.targetpoint = ents.Create("pill_target")
		self.targetpoint:Spawn()

		self.beam:SetKeyValue("cpoint1",self.targetpoint:GetName())

		self.beam:Spawn()
		self.beam:Activate()
	end
end

function SWEP:OnRemove()
	self.sound_heal:Stop()
end

function SWEP:Think()
	if SERVER then
		if self.Owner:KeyDown(IN_ATTACK) then
			self.target = IsValid(self.target) and self.target or self.Owner:GetEyeTrace().Entity

			if !self:CheckTargetValid() then
				self.target = nil
			end
		else
			self.target=nil
		end

		if self.target then
			self.sound_heal:Play()
			if self.targetpoint:GetParent()!=self.target then
				self.targetpoint:SetParent(self.target)
				self.targetpoint:SetLocalPos(Vector(0,0,30))
			end
			if !self:GetBeamActive() then
				self.beam:Fire("Start")
				self:SetBeamActive(true)
			end
			local h = self.target:Health()
			local mh = self.target:GetMaxHealth()*1.5
			local dh= 24*FrameTime() + (self.storedhealth or 0)
			local fh= dh%1
			local ih = dh-fh
			if h<mh then
				self.storedhealth = fh
				self.target:SetHealth(h+ih)
			end
		else
			self.sound_heal:Stop()
			if self:GetBeamActive() then
				self.beam:Fire("Stop")
				self:SetBeamActive(false)
			end
		end


		self:NextThink(CurTime())
		return true
	else
		if self:GetBeamActive() then
			self.sound_heal:Play()
		else
			self.sound_heal:Stop()
		end
	end
end

function SWEP:CheckTargetValid()
	if !IsValid(self.target) then return false end

	if !(self.target:IsNPC() or self.target:IsPlayer()) then return false end

	if self.Owner:GetShootPos():Distance(self.target:GetShootPos())>500 then return false end

	local tr = util.TraceLine{start=self.Owner:GetShootPos(),endpos=self.target:GetShootPos(),mask=MASK_SOLID_BRUSHONLY }
	if tr.Hit then
		return false
	end
	return true
end

function SWEP:Holster()
	if SERVER then
		self.sound_heal:Stop()
	end
	return true
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

