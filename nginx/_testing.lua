

local function echo(...)
    ngx.say(...)
    ngx.flush()
end

local ipdb_free = require "resty.ipdb.free"
local res, err = ipdb_free.find("14.20.91.122")
if not res then return echo(err) end

echo("country_name : ", res.country_name)
echo("region_name  : ", res.region_name )
echo("city_name    : ", res.city_name   )

echo "------------------------------------------"

ngx.update_time()
local t1 = ngx.now()

for _=1, 1000000 do
    local res, err = ipdb_free.find("14.20.91.122")
    if not res then return echo(err) end
end

ngx.update_time()
local t2 = ngx.now()

echo("运行一百万次耗时 : ", t2 - t1)

echo "------------------------------------------"

local IPDB = require "resty.ipdb"
local name = ngx.config.prefix() .. "/resty/ipdb/free.ipdb"
local ipdb, err = IPDB:new(name)

local res, err = ipdb:find("111.59.6.110")
if not res then return echo(err) end
echo("country_name : ", res.country_name)
echo("region_name  : ", res.region_name )
echo("city_name    : ", res.city_name   )

echo "------------------------------------------"

ngx.update_time()
local t3 = ngx.now()

for _=1, 1000000 do
    local res, err = ipdb:find("111.59.6.110")
    if not res then return echo(err) end
end

ngx.update_time()
local t4 = ngx.now()

echo("运行一百万次耗时 : ", t4 - t3)
