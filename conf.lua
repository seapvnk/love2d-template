-- from: https://love2d.org/wiki/Config_Files

function love.conf(t)
    t.title = "A game"
    t.author = "seapvnk"
    t.window.width = 640
    t.window.height = 480
    t.window.vsync = false
    t.window.msaa = 0
    t.identity = "AGAME"
    t.appendidentity = true
end