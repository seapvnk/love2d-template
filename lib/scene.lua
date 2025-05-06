-- from: https://github.com/paltze/scenery/tree/main

local Object = require("external.classic")
local ECS = require("lib.ecs")
local UI = require("lib.ui")

local Scene = Object:extend()

function Scene:new(...)
    self.world = nil
    self.pipeline = {...}
end

-- Custom hooks: def
function Scene:def() end

-- Custom hooks: load
function Scene:beforeLoad() end
function Scene:afterLoad() end

-- Custom hooks: draw
function Scene:beforeDraw() end
function Scene:afterDraw() end

-- Custom hooks: UI
function Scene:UI() end

-- Love2D hooks
function Scene:load(params)
    self.params = params
    self:def()
    self:beforeLoad()

    self.world = ECS.World(unpack(self.pipeline))
    self.world.scene = self
    self.world.isPaused = false

    self:afterLoad()
end

function Scene:update(dt)
    if not self.world.isPaused then
        self.world:emit("update", dt)
    end

    self:UI()
end

function Scene:draw()
    self:beforeDraw()
    self.world:emit("draw")
    self:afterDraw()
    UI.draw()
end

function Scene:textedited(text, start, length)
    UI.textedited(text, start, length)
end

function Scene:textinput(t)
	UI.textinput(t)
end

function Scene:keypress(key) end

function Scene:keypressed(key)
	UI.keypressed(key)
    Scene:keypress(key)
end

return Scene