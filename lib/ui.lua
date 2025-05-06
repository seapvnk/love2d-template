-- from: https://suit.readthedocs.io/en

local UI = require("external.suit")

function UI.layout:setMiddle(width, height, rows)
    local w, h = GFX.getWidth(), GFX.getHeight()
    UI.layout:reset((w / 2) - (width / 2), (h / 2) - (height / 2))

    local rowSize = 30
    if rows then
        rowSize = ((h / 2) - height) / rows
    end

    UI.layout:row(width, rowSize)
end

return UI