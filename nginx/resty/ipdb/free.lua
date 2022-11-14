
local IPDB = require("resty.ipdb")

local __ = { _VERSION = '0.1.1' }

-- 试用版IP地址数据库下载
-- https://www.ipip.net/download.html

-- 使用同目录下的 free.ipdb
local function get_free_ipdb()

    local info = debug.getinfo(1, "S")
    local path = string.sub(info.source, 2)

    return string.gsub(path, "free.lua", "free.ipdb")

end

local ipdb, err

__.types = IPDB.types

__.find = function (ips, language)
-- @ips         : string    //IP地址
-- @language    : string    //语言(默认CN)
-- @return      : @IpInfo   //IP信息

    if err then return nil, err end

    if ipdb == nil then
        local name = get_free_ipdb()
        ipdb, err = IPDB:new(name)
        if not ipdb then
            err = err or "unknown error"
            return nil, err
        end
    end

    return ipdb:find(ips, language)

end

return __
