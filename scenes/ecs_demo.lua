local EcsDemo = Scene("player_movement")

function EcsDemo:afterLoad()
    self.world:newEntity()
        :give("id")
        :give("position", 20, 20)
        :give("velocity", 200, 0, 0)
end

function EcsDemo:beforeDraw()
    GFX.setColor(GFX.hex("#ba9bd4"))
    GFX.rectangle("fill", 0, 0, GFX.getWidth(), GFX.getHeight())
end

function EcsDemo:UI()
    if self.world.isPaused then
        UI.layout:setMiddle(250, 100, 2)
        if UI.Button("Back", UI.layout:row()).hit then
            self.setScene("entrypoint")
        end
    end
end

function EcsDemo:keypress(key)
    if key == "p" then
        self.world.isPaused = not self.world.isPaused
    end
end

return EcsDemo
