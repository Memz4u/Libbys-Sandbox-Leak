-- "lua\\mediaplayer\\services\\resource\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SERVICE.Name 	= "Resource"
SERVICE.Id 		= "res"
SERVICE.Base 	= "browser"
SERVICE.Abstract = true

SERVICE.FileExtensions = {}

function SERVICE:Match( url )
	-- check supported file extensions
	for _, ext in pairs(self.FileExtensions) do
		if url:find("([^/]+%." .. ext .. ")$") then
			return true
		end
	end

	return false
end

function SERVICE:IsTimed()
	return false
end


-- "lua\\mediaplayer\\services\\resource\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SERVICE.Name 	= "Resource"
SERVICE.Id 		= "res"
SERVICE.Base 	= "browser"
SERVICE.Abstract = true

SERVICE.FileExtensions = {}

function SERVICE:Match( url )
	-- check supported file extensions
	for _, ext in pairs(self.FileExtensions) do
		if url:find("([^/]+%." .. ext .. ")$") then
			return true
		end
	end

	return false
end

function SERVICE:IsTimed()
	return false
end


-- "lua\\mediaplayer\\services\\resource\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SERVICE.Name 	= "Resource"
SERVICE.Id 		= "res"
SERVICE.Base 	= "browser"
SERVICE.Abstract = true

SERVICE.FileExtensions = {}

function SERVICE:Match( url )
	-- check supported file extensions
	for _, ext in pairs(self.FileExtensions) do
		if url:find("([^/]+%." .. ext .. ")$") then
			return true
		end
	end

	return false
end

function SERVICE:IsTimed()
	return false
end


-- "lua\\mediaplayer\\services\\resource\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SERVICE.Name 	= "Resource"
SERVICE.Id 		= "res"
SERVICE.Base 	= "browser"
SERVICE.Abstract = true

SERVICE.FileExtensions = {}

function SERVICE:Match( url )
	-- check supported file extensions
	for _, ext in pairs(self.FileExtensions) do
		if url:find("([^/]+%." .. ext .. ")$") then
			return true
		end
	end

	return false
end

function SERVICE:IsTimed()
	return false
end


-- "lua\\mediaplayer\\services\\resource\\shared.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
SERVICE.Name 	= "Resource"
SERVICE.Id 		= "res"
SERVICE.Base 	= "browser"
SERVICE.Abstract = true

SERVICE.FileExtensions = {}

function SERVICE:Match( url )
	-- check supported file extensions
	for _, ext in pairs(self.FileExtensions) do
		if url:find("([^/]+%." .. ext .. ")$") then
			return true
		end
	end

	return false
end

function SERVICE:IsTimed()
	return false
end


