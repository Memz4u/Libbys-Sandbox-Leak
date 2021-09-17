-- "lua\\autorun\\setbodygroupdata.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Tag = 'BodyGroupData'


FindMetaTable"Player".SetBodyGroupData = SERVER and function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	self:SetSaveValue("SetBodyGroup", n)
end or function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	if self ~= LocalPlayer() then return end
	self[Tag] = n
	net.Start(Tag)
		net.WriteUInt(n or 0, 32)
	net.SendToServer()
end

-- TODO
FindMetaTable"Player".GetBodyGroupData = function(self)
	return self[Tag]
end


-- "lua\\autorun\\setbodygroupdata.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Tag = 'BodyGroupData'


FindMetaTable"Player".SetBodyGroupData = SERVER and function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	self:SetSaveValue("SetBodyGroup", n)
end or function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	if self ~= LocalPlayer() then return end
	self[Tag] = n
	net.Start(Tag)
		net.WriteUInt(n or 0, 32)
	net.SendToServer()
end

-- TODO
FindMetaTable"Player".GetBodyGroupData = function(self)
	return self[Tag]
end


-- "lua\\autorun\\setbodygroupdata.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Tag = 'BodyGroupData'


FindMetaTable"Player".SetBodyGroupData = SERVER and function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	self:SetSaveValue("SetBodyGroup", n)
end or function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	if self ~= LocalPlayer() then return end
	self[Tag] = n
	net.Start(Tag)
		net.WriteUInt(n or 0, 32)
	net.SendToServer()
end

-- TODO
FindMetaTable"Player".GetBodyGroupData = function(self)
	return self[Tag]
end


-- "lua\\autorun\\setbodygroupdata.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Tag = 'BodyGroupData'


FindMetaTable"Player".SetBodyGroupData = SERVER and function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	self:SetSaveValue("SetBodyGroup", n)
end or function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	if self ~= LocalPlayer() then return end
	self[Tag] = n
	net.Start(Tag)
		net.WriteUInt(n or 0, 32)
	net.SendToServer()
end

-- TODO
FindMetaTable"Player".GetBodyGroupData = function(self)
	return self[Tag]
end


-- "lua\\autorun\\setbodygroupdata.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local Tag = 'BodyGroupData'


FindMetaTable"Player".SetBodyGroupData = SERVER and function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	self:SetSaveValue("SetBodyGroup", n)
end or function(self, n)
	n=n>2^32 and 2^32 or n<0 and 0 or n
	if self ~= LocalPlayer() then return end
	self[Tag] = n
	net.Start(Tag)
		net.WriteUInt(n or 0, 32)
	net.SendToServer()
end

-- TODO
FindMetaTable"Player".GetBodyGroupData = function(self)
	return self[Tag]
end


