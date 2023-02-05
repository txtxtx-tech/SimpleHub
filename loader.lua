--[[
    SimpleHub™ - 2023
    Loader for the hub.
]]

local safe_request = request or http_request or (http and http.request) or (syn and syn.request)
local repo = "immersion"