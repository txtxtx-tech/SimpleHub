--[[
    SimpleHub™ - 2023
    Loader for the hub.
]]

local safe_request = request or http_request or (http and http.request) or (syn and syn.request)
local HttpService = game:GetService("HttpService")
local repo = "https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/%s"

safe_request({Url="https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/", Method = "GET"})

local function parseobject(item)
    if item.type == "dir" then
        local items = HttpService:JSONDecode(
            safe_request({Url=string.format(repo, ({item.path:gsub("Source/", "")})[1]), Method = "GET"}).Body
        )

        for _, itemInLoop in next, items do
            parseobject(itemInLoop)
        end
    elseif item.type == "file" then
        local content = safe_request({Url=item.download_url, Method = "GET"}).Body
        writefile("SimpleHub/" .. ({item.path:gsub("Source/", "")})[1], contents)
    end
end

for _, itemInLoop in next, HttpService:JSONDecode( safe_request({Url="https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/", Method = "GET"}).Body ) do
    parseobject(itemInLoop)
end