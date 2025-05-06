local binser = require("external.binser")

local Storage = {}
local STORAGE_FOLDER = "storage"

local is_windows = package.config:sub(1,1) == '\\'

function Storage.boot()
    local mkdir_cmd = is_windows and ('mkdir "%s" 2>nul') or ('mkdir -p "%s"')
    os.execute(mkdir_cmd:format(STORAGE_FOLDER))
end

function Storage.save(save, data)
    local filePath = STORAGE_FOLDER .. "/" .. save
    local serialized = binser.serialize(data)

    local file, err = io.open(filePath, "wb")
    if not file then
        print("Error saving file:", err)
        return
    end

    file:write(serialized)
    file:close()
end

function Storage.load(save)
    local filePath = STORAGE_FOLDER .. "/" .. save
    local file = io.open(filePath, "rb")
    if not file then
        return {}
    end

    local contents = file:read("*a")
    file:close()

    local results = binser.deserialize(contents)
    return results[1]
end

function Storage.all(filter)
    local cmd
    if is_windows then
        cmd = 'dir "' .. STORAGE_FOLDER .. '" /b /a-d'
    else
        cmd = 'ls -p "' .. STORAGE_FOLDER .. '" | grep -v /'
    end

    local p = io.popen(cmd)
    if not p then return {} end

    local files = {}
    for file in p:lines() do
        if not filter or file:find(filter) then
            table.insert(files, file)
        end
    end
    p:close()
    return files
end

return Storage