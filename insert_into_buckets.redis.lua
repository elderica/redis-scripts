local key_base = KEYS[1]
local epoch = tonumber(ARGV[1])
local value = tonumber(ARGV[2])

local expire_second = 240

local hour = math.floor(epoch / 3600)
local hour_rem = epoch % 3600
local min = math.floor(hour_rem / 60)

local insert_to = key_base .. "_" .. min
local previous_insert_to_metakey = key_base .. "_previous"

redis.call("LPUSH", insert_to, value)

local ret = { ok = "SAME" }
local previous_insert_to = redis.call("GET", previous_insert_to_metakey)
if (previous_insert_to == nil) or (previous_insert_to ~= insert_to) then
    redis.call("EXPIRE", insert_to, expire_second)
    ret.ok = "DIFFERENT"
end
redis.call("SET", previous_insert_to_metakey, insert_to)

return ret

