-- "addons\\atags\\lua\\atags\\vgui\\customderma.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local BUTTON = {}

function BUTTON:Init()
	self:SetText("")
	
	self.iconColor = Color(255, 255, 255, 255)
	self.iconRotation = 0
end

function BUTTON:Paint(w, h)

	if self:IsDown() then
	
		surface.SetDrawColor(Color(230, 230, 230))
	
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	else
	
		if self:IsHovered() then
			surface.SetDrawColor(Color(220, 220, 220))
		else
			surface.SetDrawColor(Color(255, 255, 255))
		end
		
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	end
	
	-- Outline
	surface.SetDrawColor(Color(20, 20, 20))
	surface.DrawOutlinedRect(0, 0, w, h)
	
	-- Text
	surface.SetTextColor(60, 60, 60)
	surface.SetTextPos((w/2)-(self.text_w/2), (h/2)-(self.text_h/2))
	surface.DrawText(self:GetValue())
	
	-- Icon
	if self.icon then
		surface.SetDrawColor(self.iconColor)
		
		surface.SetMaterial(self.icon)
		
		if self.text_w and self.text_w > 0 then
			text_w = self.text_w + 20
		else
			text_w = self.text_w
		end
		
		surface.DrawTexturedRectRotated((w/2)-((text_w/2)), (h/2), 16, 16, self.iconRotation)
	end

	return true
end

function BUTTON:PerformLayout()
	surface.SetFont("DermaDefault")
	self.text_w, self.text_h = surface.GetTextSize(self:GetValue())
end

function BUTTON:SetIcon(icon)
	self.icon = Material(icon)
end

function BUTTON:SetIconColor(color)
	self.iconColor = color
end

function BUTTON:SetIconRotation(rotation)
	self.iconRotation = rotation
end

vgui.Register("ATAG_Button", BUTTON, "DButton")

-- "addons\\atags\\lua\\atags\\vgui\\customderma.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local BUTTON = {}

function BUTTON:Init()
	self:SetText("")
	
	self.iconColor = Color(255, 255, 255, 255)
	self.iconRotation = 0
end

function BUTTON:Paint(w, h)

	if self:IsDown() then
	
		surface.SetDrawColor(Color(230, 230, 230))
	
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	else
	
		if self:IsHovered() then
			surface.SetDrawColor(Color(220, 220, 220))
		else
			surface.SetDrawColor(Color(255, 255, 255))
		end
		
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	end
	
	-- Outline
	surface.SetDrawColor(Color(20, 20, 20))
	surface.DrawOutlinedRect(0, 0, w, h)
	
	-- Text
	surface.SetTextColor(60, 60, 60)
	surface.SetTextPos((w/2)-(self.text_w/2), (h/2)-(self.text_h/2))
	surface.DrawText(self:GetValue())
	
	-- Icon
	if self.icon then
		surface.SetDrawColor(self.iconColor)
		
		surface.SetMaterial(self.icon)
		
		if self.text_w and self.text_w > 0 then
			text_w = self.text_w + 20
		else
			text_w = self.text_w
		end
		
		surface.DrawTexturedRectRotated((w/2)-((text_w/2)), (h/2), 16, 16, self.iconRotation)
	end

	return true
end

function BUTTON:PerformLayout()
	surface.SetFont("DermaDefault")
	self.text_w, self.text_h = surface.GetTextSize(self:GetValue())
end

function BUTTON:SetIcon(icon)
	self.icon = Material(icon)
end

function BUTTON:SetIconColor(color)
	self.iconColor = color
end

function BUTTON:SetIconRotation(rotation)
	self.iconRotation = rotation
end

vgui.Register("ATAG_Button", BUTTON, "DButton")

-- "addons\\atags\\lua\\atags\\vgui\\customderma.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local BUTTON = {}

function BUTTON:Init()
	self:SetText("")
	
	self.iconColor = Color(255, 255, 255, 255)
	self.iconRotation = 0
end

function BUTTON:Paint(w, h)

	if self:IsDown() then
	
		surface.SetDrawColor(Color(230, 230, 230))
	
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	else
	
		if self:IsHovered() then
			surface.SetDrawColor(Color(220, 220, 220))
		else
			surface.SetDrawColor(Color(255, 255, 255))
		end
		
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	end
	
	-- Outline
	surface.SetDrawColor(Color(20, 20, 20))
	surface.DrawOutlinedRect(0, 0, w, h)
	
	-- Text
	surface.SetTextColor(60, 60, 60)
	surface.SetTextPos((w/2)-(self.text_w/2), (h/2)-(self.text_h/2))
	surface.DrawText(self:GetValue())
	
	-- Icon
	if self.icon then
		surface.SetDrawColor(self.iconColor)
		
		surface.SetMaterial(self.icon)
		
		if self.text_w and self.text_w > 0 then
			text_w = self.text_w + 20
		else
			text_w = self.text_w
		end
		
		surface.DrawTexturedRectRotated((w/2)-((text_w/2)), (h/2), 16, 16, self.iconRotation)
	end

	return true
end

function BUTTON:PerformLayout()
	surface.SetFont("DermaDefault")
	self.text_w, self.text_h = surface.GetTextSize(self:GetValue())
end

function BUTTON:SetIcon(icon)
	self.icon = Material(icon)
end

function BUTTON:SetIconColor(color)
	self.iconColor = color
end

function BUTTON:SetIconRotation(rotation)
	self.iconRotation = rotation
end

vgui.Register("ATAG_Button", BUTTON, "DButton")

-- "addons\\atags\\lua\\atags\\vgui\\customderma.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local BUTTON = {}

function BUTTON:Init()
	self:SetText("")
	
	self.iconColor = Color(255, 255, 255, 255)
	self.iconRotation = 0
end

function BUTTON:Paint(w, h)

	if self:IsDown() then
	
		surface.SetDrawColor(Color(230, 230, 230))
	
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	else
	
		if self:IsHovered() then
			surface.SetDrawColor(Color(220, 220, 220))
		else
			surface.SetDrawColor(Color(255, 255, 255))
		end
		
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	end
	
	-- Outline
	surface.SetDrawColor(Color(20, 20, 20))
	surface.DrawOutlinedRect(0, 0, w, h)
	
	-- Text
	surface.SetTextColor(60, 60, 60)
	surface.SetTextPos((w/2)-(self.text_w/2), (h/2)-(self.text_h/2))
	surface.DrawText(self:GetValue())
	
	-- Icon
	if self.icon then
		surface.SetDrawColor(self.iconColor)
		
		surface.SetMaterial(self.icon)
		
		if self.text_w and self.text_w > 0 then
			text_w = self.text_w + 20
		else
			text_w = self.text_w
		end
		
		surface.DrawTexturedRectRotated((w/2)-((text_w/2)), (h/2), 16, 16, self.iconRotation)
	end

	return true
end

function BUTTON:PerformLayout()
	surface.SetFont("DermaDefault")
	self.text_w, self.text_h = surface.GetTextSize(self:GetValue())
end

function BUTTON:SetIcon(icon)
	self.icon = Material(icon)
end

function BUTTON:SetIconColor(color)
	self.iconColor = color
end

function BUTTON:SetIconRotation(rotation)
	self.iconRotation = rotation
end

vgui.Register("ATAG_Button", BUTTON, "DButton")

-- "addons\\atags\\lua\\atags\\vgui\\customderma.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local BUTTON = {}

function BUTTON:Init()
	self:SetText("")
	
	self.iconColor = Color(255, 255, 255, 255)
	self.iconRotation = 0
end

function BUTTON:Paint(w, h)

	if self:IsDown() then
	
		surface.SetDrawColor(Color(230, 230, 230))
	
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	else
	
		if self:IsHovered() then
			surface.SetDrawColor(Color(220, 220, 220))
		else
			surface.SetDrawColor(Color(255, 255, 255))
		end
		
		surface.DrawRect(0, 0, w, h)
	
		surface.SetDrawColor(Color(220, 220, 220))
		surface.DrawOutlinedRect(1, 1, w, h)
		
		surface.SetDrawColor(Color(180, 180, 180))
		surface.DrawOutlinedRect(0, 0, w-1, h-1)
	
	end
	
	-- Outline
	surface.SetDrawColor(Color(20, 20, 20))
	surface.DrawOutlinedRect(0, 0, w, h)
	
	-- Text
	surface.SetTextColor(60, 60, 60)
	surface.SetTextPos((w/2)-(self.text_w/2), (h/2)-(self.text_h/2))
	surface.DrawText(self:GetValue())
	
	-- Icon
	if self.icon then
		surface.SetDrawColor(self.iconColor)
		
		surface.SetMaterial(self.icon)
		
		if self.text_w and self.text_w > 0 then
			text_w = self.text_w + 20
		else
			text_w = self.text_w
		end
		
		surface.DrawTexturedRectRotated((w/2)-((text_w/2)), (h/2), 16, 16, self.iconRotation)
	end

	return true
end

function BUTTON:PerformLayout()
	surface.SetFont("DermaDefault")
	self.text_w, self.text_h = surface.GetTextSize(self:GetValue())
end

function BUTTON:SetIcon(icon)
	self.icon = Material(icon)
end

function BUTTON:SetIconColor(color)
	self.iconColor = color
end

function BUTTON:SetIconRotation(rotation)
	self.iconRotation = rotation
end

vgui.Register("ATAG_Button", BUTTON, "DButton")

