local Entrypoint = Scene()

function Entrypoint:def()
    self.name = {text = ""}
    self.age = {value = 0, min = 0, max = 100, step = 1}
    self.data = Storage.all()
end

function Entrypoint:beforeDraw()
    GFX.setColor(GFX.hex("#6c8391"))
    GFX.rectangle("fill", 0, 0, GFX.getWidth(), GFX.getHeight())
end

function Entrypoint:UI()
    UI.layout:setMiddle(250, 300, 2 + #Storage.all())

    UI.Label("Name", UI.layout:row(200, 20))
    UI.Input(self.name, UI.layout:row())
    UI.layout:row()

    UI.Label("Age: " .. tostring(self.age.value), UI.layout:row(200, 20))
    UI.Slider(self.age, UI.layout:row())
    UI.layout:row()

    if UI.Button("Save", UI.layout:row()).hit then
		Storage.save(self.name.text, {
            name = self.name.text,
            age = self.age.value,
        })
	end

    for _, file in pairs(Storage.all()) do
        if UI.Button(file, UI.layout:row()).hit then
            local data = Storage.load(file)
            print(data.name, data.age)
        end
    end

    UI.layout:row()

    if UI.Button("Go to ECS Demo", UI.layout:row()).hit then
		self.setScene("ecs_demo")
	end

    UI.layout:row()

    if UI.Button("Close", UI.layout:row()).hit then
		love.event.quit()
	end
end

return Entrypoint