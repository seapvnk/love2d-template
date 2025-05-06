-- from: https://github.com/Keyslam-Group/Concord

local Concord = require("external.concord")
local uuid = require("external.uuid")

local ECS = {}

function ECS.World(...)
    local world = Concord.world()

    Concord.utils.loadNamespace("ecs/components")

    local systems = {}
    Concord.utils.loadNamespace("ecs/systems", systems)
    for _, system in pairs({...}) do
        world:addSystem(systems[system])
    end

    return world
end

local function split(pString, pPattern)
    local Table = {}
    local fpat = "(.-)" .. pPattern
    local last_end = 1
    local s, e, cap = pString:find(fpat, 1)
    while s do
       if s ~= 1 or cap ~= "" then
      table.insert(Table,cap)
       end
       last_end = e+1
       s, e, cap = pString:find(fpat, last_end)
    end
    if last_end <= #pString then
       cap = pString:sub(last_end)
       table.insert(Table, cap)
    end
    return Table
end
 
function ECS.Component(name, params, config)
    params = split(params, "|")
    return Concord.component(name, function(component, ...)
        local args = {...}
        for key, value in pairs(config) do
            if type(value) == "function" then
                value = value()
            end
            component[key] = value
        end

        for i, param in ipairs(params) do
            component[param] = args[i]
        end
    end)
end

function ECS.System(filters)
    local system = Concord.system(filters)
    function system:pool(pool, callback)
        for _, e in ipairs(self[pool]) do
            callback(e)
        end
    end
    return system
end

return ECS