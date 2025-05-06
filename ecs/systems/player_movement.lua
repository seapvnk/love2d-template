local PlayerMovement = ECS.System({
    player = { "id", "position", "velocity" }
})

function PlayerMovement:update(dt)
    self:pool("player", function(e)
        local dx, dy = 0, 0

        if love.keyboard.isDown("a") then
            dx = dx - 1
        end

        if love.keyboard.isDown("d") then
            dx = dx + 1
        end

        if love.keyboard.isDown("w") then
            dy = dy - 1
        end

        if love.keyboard.isDown("s") then
            dy = dy + 1
        end

        if dx ~= 0 and dy ~= 0 then
            local length = math.sqrt(dx * dx + dy * dy)
            dx = dx / length
            dy = dy / length
        end

        e.velocity.x = dx
        e.velocity.y = dy

        e.position.x = e.position.x + e.velocity.x * e.velocity.value * dt
        e.position.y = e.position.y + e.velocity.y * e.velocity.value * dt
    end)
end

function PlayerMovement:draw()
    self:pool("player", function(e)
        GFX.setColor(GFX.hex("#4aa18f"))
        GFX.rectangle("fill", e.position.x, e.position.y, 30, 30)
    end)
end

return PlayerMovement