local GAME_DIR = "a_game"

local namespaces = {
    ECS = "lib.ecs",
    Scene = "lib.scene",
    GFX = "lib.graphics",
    UI = "lib.ui",
    Storage = "lib.storage",
    Util = "lib.util",
}

return function(args)
    args = args or {}

    -- Globals
    for className, path in pairs(namespaces) do
        _G[className] = require(path)
    end

    if args.plugins then
        for className, path in pairs(namespaces) do
            _G[className] = require("external." .. path)
        end
    end

    Storage.boot()

    -- Routes
    local SceneryInit = require("external.scenery")
    local scenery = SceneryInit(args.mainScene or "entrypoint", "scenes")
    scenery:hook(love)
end