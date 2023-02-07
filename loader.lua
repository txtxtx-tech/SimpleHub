--[[
    SimpleHub™ - 2023
    Loader for the hub.
]]

local HttpService = game:GetService("HttpService")
local repo = "https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/%s"

if isfolder("SimpleHub") then
    delfolder("SimpleHub")
end

makefolder("SimpleHub")

local function parseobject(item)
    if item.type == "dir" then
        local items = HttpService:JSONDecode(
            game:HttpGet("https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/" .. ({item.path:gsub("Source/", "")})[1])
        )

        makefolder("SimpleHub/" .. ({item.path:gsub("Source/", ""):gsub(item.name, "")})[1] .. "/" .. item.name)

        for _, itemInLoop in next, items do
            parseobject(itemInLoop)
        end
    elseif item.type == "file" then
        local content = game:HttpGet(item.download_url)
        writefile("SimpleHub/" .. ({item.path:gsub("Source/", "")})[1], tostring(content))

    end
end

for _, itemInLoop in next, HttpService:JSONDecode( game:HttpGet("https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/") ) do
    parseobject(itemInLoop)
end