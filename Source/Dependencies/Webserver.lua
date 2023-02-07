--[[
    SimpleHub Nitron Key System™ - 2023
    Simple implementation of the key system.
]]

local Nitron = { }
local WEBSERVER = "https://im-so-silly-im-so-goofy.trixxertrix.repl.co"

local LoadDependency = getgenv().SimpleHub.LoadDependency
local HttpService = game:GetService("HttpService")
local Promise = LoadDependency("Promise")

Nitron.WebsiteLink = WEBSERVER
Nitron.request = request or http_request or (http and http.request) or (syn and syn.request)

function Nitron:KeyIsValid(key)
    return Promise.new(function(resolve)
        resolve(HttpService:JSONDecode(self.request({
            Url = string.format(WEBSERVER .. "/validcode?key=%s", HttpService:UrlEncode(key)),
            Method = "GET",
            Headers = { ["Content-Type"] = "application/json" }
        }).Body).isvalid)
    end)
end

return Nitron