
local IPDB              = require "resty.ipdb"
local lrucache          = require "resty.lrucache"

local __ = { _VERSION = '0.1.2' }

local cache = lrucache.new(1000)

-- 试用版IP地址数据库下载
-- https://www.ipip.net/download.html

-- 使用同目录下的 free.ipdb
local function get_free_ipdb()

    local info = debug.getinfo(1, "S")
    local path = string.sub(info.source, 2)

    return string.gsub(path, "free.lua", "free.ipdb")

end

local ipdb, ipdb_err

__.types = IPDB.types

__.find = function (ips, language)
-- @ips         : string    //IP地址
-- @language    : string    //语言(默认CN)
-- @return      : @IpInfo   //IP信息

    if ipdb_err then return nil, ipdb_err end

    if ipdb == nil then
        local name = get_free_ipdb()
        ipdb, ipdb_err = IPDB:new(name)
        if not ipdb then
            ipdb_err = ipdb_err or "unknown error"
            return nil, ipdb_err
        end
    end

    if type(ips) ~= "string" or ips == "" then
        return nil, "ips is null"
    end

    if type(language) ~= "string" or language == "" then
        language = "CN"
    end

    local key = ips .. ":" .. language
    local res = cache:get(key)
    if res then return res end

    local res, err = ipdb:find(ips, language)
    if not res then return nil, err end

    cache:set(key, res)

    return res

end

return __
