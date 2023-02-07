--[[
    SimpleHub™ - 2023
    Loader for the hub.
]]

local safe_request = request or http_request or (http and http.request) or (syn and syn.request)
local HttpService = game:GetService("HttpService")
local repo = "https://api.github.com/repos/RBXSimpleHub/SimpleHub/contents/Source/%s"

local function parseobject(item)
    if item.type == "dir" then
        local items = HttpService:JSONDecode(
            safe_request({ Url = item.path:gsub("Source/", ""), Method = "GET", Headers = { ["Content-Type"] = "application/json" } }).Body
        )

        for _, itemInLoop in next, items do
            parseobject(itemInLoop)
        end
    elseif item.type == "file" then
        local content = safe_request({ Url = item.download_url, Method = "GET", Headers = { ["Content-Type"] = "application/json" } }).Body
        writefile(string.format("SimpleHub/%s", item.path:gsub("Source/", "")):gsub(".lua", ""), contents)
    end
end

for _, itemInLoop in next, HttpService:JSONDecode( safe_request({ Url = repo:gsub("/%s", ""), Method = "GET", Headers = { ["Content-Type"] = "application/json" } }).Body ) do
    parseobject(itemInLoop)
end