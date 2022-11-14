# lua-resty-ipdb-jit

## Installing

```sh

git clone https://github.com/killsen/lua-resty-ipdb-jit
cd lua-resty-ipdb-jit/nginx/resty
cp -R ipdb /usr/local/openresty/lualib/resty/

```

## Nginx.conf

```nginx

worker_processes  1;

events {
    worker_connections  1024;
}

http {
    server {
        location / {
            content_by_lua_block {

                local ipdb_free = require "resty.ipdb.free"
                local res, err = ipdb_free.find("14.20.91.122")
                if not res then return ngx.say(err) end

                ngx.say("country_name : ", res.country_name)
                ngx.say("region_name  : ", res.region_name )
                ngx.say("city_name    : ", res.city_name   )

                ngx.say "----------------------------------"

                local IPDB = require "resty.ipdb"
                local name = "/usr/local/openresty/lualib/resty/ipdb/free.ipdb"
                local ipdb, err = IPDB:new(name)

                local res, err = ipdb:find("111.59.6.110")
                if not res then return ngx.say(err) end

                ngx.say("country_name : ", res.country_name)
                ngx.say("region_name  : ", res.region_name )
                ngx.say("city_name    : ", res.city_name   )

            }
        }
    }
}

```
