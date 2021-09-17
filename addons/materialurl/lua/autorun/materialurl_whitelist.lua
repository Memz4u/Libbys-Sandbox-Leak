-- "addons\\materialurl\\lua\\autorun\\materialurl_whitelist.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
MatURL = {}
MatURL.whitelist = {}

-- GURL + Starfall URL Whitelist --

function MatURL.isWhitelisted(url)
    for _,v in ipairs(MatURL.whitelist) do
        if string.match(url,v) then
            return true
        end
    end
    return false
end

function MatURL.checkURL(url)
    if TypeID(url) != TYPE_STRING then return false end
    local protocol = string.match(url,"^(%w-)://")
    if not protocol then
        url = "http://"..url
    end

    local protocol,domain,path = string.match(url,"^(%w-)://([^/]*)/?(.*)")
    if not domain then return false end
    domain = domain.."/"..(data or "")
    return MatURL.isWhitelisted(domain)
end

local function pattern(txt)
    table.insert(MatURL.whitelist,"^"..txt.."$")
end

local function simple(txt)
    table.insert(MatURL.whitelist,"^"..string.PatternSafe(txt).."/.*")
end

simple [[dl.dropboxusercontent.com]]
pattern [[%w+%.dl%.dropboxusercontent%.com/(.+)]]
simple [[www.dropbox.com]]
simple [[dl.dropbox.com]]

simple [[onedrive.live.com/redir]]

simple [[docs.google.com/uc]]

simple [[i.imgur.com]]

simple [[pastebin.com]]

simple [[gitlab.com]]

simple [[bitbucket.org]]

simple [[raw.githubusercontent.com]]
simple [[gist.githubusercontent.com]]

simple [[u.teknik.io]]
simple [[p.teknik.io]]

pattern [[i([%w-_]+)%.tinypic%.com/(.+)]]

simple [[paste.ee]]

simple [[hastebin.com]]

simple [[puu.sh]]

simple [[images.akamai.steamusercontent.com]]
simple [[steamuserimages-a.akamaihd.net]]
simple [[steamcdn-a.akamaihd.net]]

pattern [[cdn[%w-_]*.discordapp%.com/(.+)]]
pattern [[images-([%w%-]+)%.discordapp%.net/external/(.+)]]

simple [[i.redditmedia.com]]
simple [[i.redd.it]]
simple [[preview.redd.it]]

--simple [[static1.e621.net]]

simple [[ipfs.io]]

pattern [[([%w-_]+)%.neocities%.org/(.+)]]

pattern [[(%w+)%.sndcdn%.com/(.+)]]

-- "addons\\materialurl\\lua\\autorun\\materialurl_whitelist.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
MatURL = {}
MatURL.whitelist = {}

-- GURL + Starfall URL Whitelist --

function MatURL.isWhitelisted(url)
    for _,v in ipairs(MatURL.whitelist) do
        if string.match(url,v) then
            return true
        end
    end
    return false
end

function MatURL.checkURL(url)
    if TypeID(url) != TYPE_STRING then return false end
    local protocol = string.match(url,"^(%w-)://")
    if not protocol then
        url = "http://"..url
    end

    local protocol,domain,path = string.match(url,"^(%w-)://([^/]*)/?(.*)")
    if not domain then return false end
    domain = domain.."/"..(data or "")
    return MatURL.isWhitelisted(domain)
end

local function pattern(txt)
    table.insert(MatURL.whitelist,"^"..txt.."$")
end

local function simple(txt)
    table.insert(MatURL.whitelist,"^"..string.PatternSafe(txt).."/.*")
end

simple [[dl.dropboxusercontent.com]]
pattern [[%w+%.dl%.dropboxusercontent%.com/(.+)]]
simple [[www.dropbox.com]]
simple [[dl.dropbox.com]]

simple [[onedrive.live.com/redir]]

simple [[docs.google.com/uc]]

simple [[i.imgur.com]]

simple [[pastebin.com]]

simple [[gitlab.com]]

simple [[bitbucket.org]]

simple [[raw.githubusercontent.com]]
simple [[gist.githubusercontent.com]]

simple [[u.teknik.io]]
simple [[p.teknik.io]]

pattern [[i([%w-_]+)%.tinypic%.com/(.+)]]

simple [[paste.ee]]

simple [[hastebin.com]]

simple [[puu.sh]]

simple [[images.akamai.steamusercontent.com]]
simple [[steamuserimages-a.akamaihd.net]]
simple [[steamcdn-a.akamaihd.net]]

pattern [[cdn[%w-_]*.discordapp%.com/(.+)]]
pattern [[images-([%w%-]+)%.discordapp%.net/external/(.+)]]

simple [[i.redditmedia.com]]
simple [[i.redd.it]]
simple [[preview.redd.it]]

--simple [[static1.e621.net]]

simple [[ipfs.io]]

pattern [[([%w-_]+)%.neocities%.org/(.+)]]

pattern [[(%w+)%.sndcdn%.com/(.+)]]

-- "addons\\materialurl\\lua\\autorun\\materialurl_whitelist.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
MatURL = {}
MatURL.whitelist = {}

-- GURL + Starfall URL Whitelist --

function MatURL.isWhitelisted(url)
    for _,v in ipairs(MatURL.whitelist) do
        if string.match(url,v) then
            return true
        end
    end
    return false
end

function MatURL.checkURL(url)
    if TypeID(url) != TYPE_STRING then return false end
    local protocol = string.match(url,"^(%w-)://")
    if not protocol then
        url = "http://"..url
    end

    local protocol,domain,path = string.match(url,"^(%w-)://([^/]*)/?(.*)")
    if not domain then return false end
    domain = domain.."/"..(data or "")
    return MatURL.isWhitelisted(domain)
end

local function pattern(txt)
    table.insert(MatURL.whitelist,"^"..txt.."$")
end

local function simple(txt)
    table.insert(MatURL.whitelist,"^"..string.PatternSafe(txt).."/.*")
end

simple [[dl.dropboxusercontent.com]]
pattern [[%w+%.dl%.dropboxusercontent%.com/(.+)]]
simple [[www.dropbox.com]]
simple [[dl.dropbox.com]]

simple [[onedrive.live.com/redir]]

simple [[docs.google.com/uc]]

simple [[i.imgur.com]]

simple [[pastebin.com]]

simple [[gitlab.com]]

simple [[bitbucket.org]]

simple [[raw.githubusercontent.com]]
simple [[gist.githubusercontent.com]]

simple [[u.teknik.io]]
simple [[p.teknik.io]]

pattern [[i([%w-_]+)%.tinypic%.com/(.+)]]

simple [[paste.ee]]

simple [[hastebin.com]]

simple [[puu.sh]]

simple [[images.akamai.steamusercontent.com]]
simple [[steamuserimages-a.akamaihd.net]]
simple [[steamcdn-a.akamaihd.net]]

pattern [[cdn[%w-_]*.discordapp%.com/(.+)]]
pattern [[images-([%w%-]+)%.discordapp%.net/external/(.+)]]

simple [[i.redditmedia.com]]
simple [[i.redd.it]]
simple [[preview.redd.it]]

--simple [[static1.e621.net]]

simple [[ipfs.io]]

pattern [[([%w-_]+)%.neocities%.org/(.+)]]

pattern [[(%w+)%.sndcdn%.com/(.+)]]

-- "addons\\materialurl\\lua\\autorun\\materialurl_whitelist.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
MatURL = {}
MatURL.whitelist = {}

-- GURL + Starfall URL Whitelist --

function MatURL.isWhitelisted(url)
    for _,v in ipairs(MatURL.whitelist) do
        if string.match(url,v) then
            return true
        end
    end
    return false
end

function MatURL.checkURL(url)
    if TypeID(url) != TYPE_STRING then return false end
    local protocol = string.match(url,"^(%w-)://")
    if not protocol then
        url = "http://"..url
    end

    local protocol,domain,path = string.match(url,"^(%w-)://([^/]*)/?(.*)")
    if not domain then return false end
    domain = domain.."/"..(data or "")
    return MatURL.isWhitelisted(domain)
end

local function pattern(txt)
    table.insert(MatURL.whitelist,"^"..txt.."$")
end

local function simple(txt)
    table.insert(MatURL.whitelist,"^"..string.PatternSafe(txt).."/.*")
end

simple [[dl.dropboxusercontent.com]]
pattern [[%w+%.dl%.dropboxusercontent%.com/(.+)]]
simple [[www.dropbox.com]]
simple [[dl.dropbox.com]]

simple [[onedrive.live.com/redir]]

simple [[docs.google.com/uc]]

simple [[i.imgur.com]]

simple [[pastebin.com]]

simple [[gitlab.com]]

simple [[bitbucket.org]]

simple [[raw.githubusercontent.com]]
simple [[gist.githubusercontent.com]]

simple [[u.teknik.io]]
simple [[p.teknik.io]]

pattern [[i([%w-_]+)%.tinypic%.com/(.+)]]

simple [[paste.ee]]

simple [[hastebin.com]]

simple [[puu.sh]]

simple [[images.akamai.steamusercontent.com]]
simple [[steamuserimages-a.akamaihd.net]]
simple [[steamcdn-a.akamaihd.net]]

pattern [[cdn[%w-_]*.discordapp%.com/(.+)]]
pattern [[images-([%w%-]+)%.discordapp%.net/external/(.+)]]

simple [[i.redditmedia.com]]
simple [[i.redd.it]]
simple [[preview.redd.it]]

--simple [[static1.e621.net]]

simple [[ipfs.io]]

pattern [[([%w-_]+)%.neocities%.org/(.+)]]

pattern [[(%w+)%.sndcdn%.com/(.+)]]

-- "addons\\materialurl\\lua\\autorun\\materialurl_whitelist.lua"
-- Retrieved by https://github.com/c4fe/glua-steal
MatURL = {}
MatURL.whitelist = {}

-- GURL + Starfall URL Whitelist --

function MatURL.isWhitelisted(url)
    for _,v in ipairs(MatURL.whitelist) do
        if string.match(url,v) then
            return true
        end
    end
    return false
end

function MatURL.checkURL(url)
    if TypeID(url) != TYPE_STRING then return false end
    local protocol = string.match(url,"^(%w-)://")
    if not protocol then
        url = "http://"..url
    end

    local protocol,domain,path = string.match(url,"^(%w-)://([^/]*)/?(.*)")
    if not domain then return false end
    domain = domain.."/"..(data or "")
    return MatURL.isWhitelisted(domain)
end

local function pattern(txt)
    table.insert(MatURL.whitelist,"^"..txt.."$")
end

local function simple(txt)
    table.insert(MatURL.whitelist,"^"..string.PatternSafe(txt).."/.*")
end

simple [[dl.dropboxusercontent.com]]
pattern [[%w+%.dl%.dropboxusercontent%.com/(.+)]]
simple [[www.dropbox.com]]
simple [[dl.dropbox.com]]

simple [[onedrive.live.com/redir]]

simple [[docs.google.com/uc]]

simple [[i.imgur.com]]

simple [[pastebin.com]]

simple [[gitlab.com]]

simple [[bitbucket.org]]

simple [[raw.githubusercontent.com]]
simple [[gist.githubusercontent.com]]

simple [[u.teknik.io]]
simple [[p.teknik.io]]

pattern [[i([%w-_]+)%.tinypic%.com/(.+)]]

simple [[paste.ee]]

simple [[hastebin.com]]

simple [[puu.sh]]

simple [[images.akamai.steamusercontent.com]]
simple [[steamuserimages-a.akamaihd.net]]
simple [[steamcdn-a.akamaihd.net]]

pattern [[cdn[%w-_]*.discordapp%.com/(.+)]]
pattern [[images-([%w%-]+)%.discordapp%.net/external/(.+)]]

simple [[i.redditmedia.com]]
simple [[i.redd.it]]
simple [[preview.redd.it]]

--simple [[static1.e621.net]]

simple [[ipfs.io]]

pattern [[([%w-_]+)%.neocities%.org/(.+)]]

pattern [[(%w+)%.sndcdn%.com/(.+)]]

