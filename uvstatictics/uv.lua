local shared_data = ngx.shared.uv_statistics
local seed = shared_data:get("seed")
local seed_round = 9999
if (not seed or seed >= seed_round) then
    seed = 0
    shared_data:set("seed",seed)
end
expire_time = ngx.cookie_time(ngx.time()+1)
if not ngx.var.cookie_uvid then
    seed = string.format("%04d", shared_data:incr("seed",1))
    uvid = ngx.time()..seed
    ngx.header["Set-Cookie"] = "uvid="..uvid..";expires="..expire_time
    ngx.var.uvid = uvid
else
    ngx.var.uvid = ngx.var.cookie_uvid
end
