local key_base = KEYS[1]
local epoch = tonumber(ARGV[1])

local DEFAULT_NUMBER = "0"

local hour = math.floor(epoch / 3600)
local hour_rem = epoch % 3600
local min = math.floor(hour_rem / 60)

local fetch_from = key_base .. "_" .. min
local previous_fetch_from_metakey = key_base .. "_previous"

local latest_values = redis.call("LRANGE", fetch_from, 0, 2)
local previous_fetch_from = redis.call("GET", previous_fetch_from_metakey)
local previous_values = redis.call("LRANGE", previous_fetch_from, 0, 2)

local concatenated = latest_values
for _, v in ipairs(previous_values) do
    table.insert(concatenated, v)
end
for _, v in ipairs({DEFAULT_NUMBER, DEFAULT_NUMBER, DEFAULT_NUMBER}) do
    table.insert(concatenated, v)
end

local ret = {}
for i = 1, 3 do
    table.insert(ret, tonumber(concatenated[i]))
end

return ret
