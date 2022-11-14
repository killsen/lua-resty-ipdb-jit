
local ipdb_free = require "resty.ipdb.free"
local res, err = ipdb_free.find("14.20.91.122")
if not res then return ngx.say(err) end

ngx.say("country_name : ", res.country_name)
ngx.say("region_name  : ", res.region_name )
ngx.say("city_name    : ", res.city_name   )

ngx.say "----------------------------------"

local IPDB = require "resty.ipdb"
local name = ngx.config.prefix() .. "/resty/ipdb/free.ipdb"
local ipdb, err = IPDB:new(name)

local res, err = ipdb:find("111.59.6.110")
if not res then return ngx.say(err) end

ngx.say("country_name : ", res.country_name)
ngx.say("region_name  : ", res.region_name )
ngx.say("city_name    : ", res.city_name   )
