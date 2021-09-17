-- "lua\\autorun\\client\\perma_setnick.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function LibbersLibbysSetNick(ply, strCmd, tblArgs)
    local strName = tblArgs[1]:gsub("[%-]+", "")

    local strID = nil
    for k, v in pairs(player.GetAll()) do
        if string.find(v:Nick():gsub("[%-]+", ""), strName) then
            strID = v:SteamID()
            break
        end
    end

    net.Start("libbers_libbys_setnick")
        net.WriteString(strID)
        net.WriteString(tblArgs[2])
    net.SendToServer()
end

local function AutoComplete(strCmd, strArgs)
    strArgs = string.Trim(strArgs)
    strArgs = string.lower(strArgs)

    local tbl = {}

    for k, v in pairs(player.GetAll()) do
        local nick = v:Nick()
        if string.find(string.lower(nick), strArgs) then
            nick = "\""..nick.."\""
            nick = "libbers_libbys_setnick "..nick

            tbl[#tbl + 1] = nick
        end
    end

    return tbl
end

concommand.Add("libbers_libbys_setnick", LibbersLibbysSetNick, AutoComplete)


-- "lua\\autorun\\client\\perma_setnick.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function LibbersLibbysSetNick(ply, strCmd, tblArgs)
    local strName = tblArgs[1]:gsub("[%-]+", "")

    local strID = nil
    for k, v in pairs(player.GetAll()) do
        if string.find(v:Nick():gsub("[%-]+", ""), strName) then
            strID = v:SteamID()
            break
        end
    end

    net.Start("libbers_libbys_setnick")
        net.WriteString(strID)
        net.WriteString(tblArgs[2])
    net.SendToServer()
end

local function AutoComplete(strCmd, strArgs)
    strArgs = string.Trim(strArgs)
    strArgs = string.lower(strArgs)

    local tbl = {}

    for k, v in pairs(player.GetAll()) do
        local nick = v:Nick()
        if string.find(string.lower(nick), strArgs) then
            nick = "\""..nick.."\""
            nick = "libbers_libbys_setnick "..nick

            tbl[#tbl + 1] = nick
        end
    end

    return tbl
end

concommand.Add("libbers_libbys_setnick", LibbersLibbysSetNick, AutoComplete)


-- "lua\\autorun\\client\\perma_setnick.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function LibbersLibbysSetNick(ply, strCmd, tblArgs)
    local strName = tblArgs[1]:gsub("[%-]+", "")

    local strID = nil
    for k, v in pairs(player.GetAll()) do
        if string.find(v:Nick():gsub("[%-]+", ""), strName) then
            strID = v:SteamID()
            break
        end
    end

    net.Start("libbers_libbys_setnick")
        net.WriteString(strID)
        net.WriteString(tblArgs[2])
    net.SendToServer()
end

local function AutoComplete(strCmd, strArgs)
    strArgs = string.Trim(strArgs)
    strArgs = string.lower(strArgs)

    local tbl = {}

    for k, v in pairs(player.GetAll()) do
        local nick = v:Nick()
        if string.find(string.lower(nick), strArgs) then
            nick = "\""..nick.."\""
            nick = "libbers_libbys_setnick "..nick

            tbl[#tbl + 1] = nick
        end
    end

    return tbl
end

concommand.Add("libbers_libbys_setnick", LibbersLibbysSetNick, AutoComplete)


-- "lua\\autorun\\client\\perma_setnick.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function LibbersLibbysSetNick(ply, strCmd, tblArgs)
    local strName = tblArgs[1]:gsub("[%-]+", "")

    local strID = nil
    for k, v in pairs(player.GetAll()) do
        if string.find(v:Nick():gsub("[%-]+", ""), strName) then
            strID = v:SteamID()
            break
        end
    end

    net.Start("libbers_libbys_setnick")
        net.WriteString(strID)
        net.WriteString(tblArgs[2])
    net.SendToServer()
end

local function AutoComplete(strCmd, strArgs)
    strArgs = string.Trim(strArgs)
    strArgs = string.lower(strArgs)

    local tbl = {}

    for k, v in pairs(player.GetAll()) do
        local nick = v:Nick()
        if string.find(string.lower(nick), strArgs) then
            nick = "\""..nick.."\""
            nick = "libbers_libbys_setnick "..nick

            tbl[#tbl + 1] = nick
        end
    end

    return tbl
end

concommand.Add("libbers_libbys_setnick", LibbersLibbysSetNick, AutoComplete)


-- "lua\\autorun\\client\\perma_setnick.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
local function LibbersLibbysSetNick(ply, strCmd, tblArgs)
    local strName = tblArgs[1]:gsub("[%-]+", "")

    local strID = nil
    for k, v in pairs(player.GetAll()) do
        if string.find(v:Nick():gsub("[%-]+", ""), strName) then
            strID = v:SteamID()
            break
        end
    end

    net.Start("libbers_libbys_setnick")
        net.WriteString(strID)
        net.WriteString(tblArgs[2])
    net.SendToServer()
end

local function AutoComplete(strCmd, strArgs)
    strArgs = string.Trim(strArgs)
    strArgs = string.lower(strArgs)

    local tbl = {}

    for k, v in pairs(player.GetAll()) do
        local nick = v:Nick()
        if string.find(string.lower(nick), strArgs) then
            nick = "\""..nick.."\""
            nick = "libbers_libbys_setnick "..nick

            tbl[#tbl + 1] = nick
        end
    end

    return tbl
end

concommand.Add("libbers_libbys_setnick", LibbersLibbysSetNick, AutoComplete)


