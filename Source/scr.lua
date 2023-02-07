--[[
    SimpleHub™ - 2023
]]

-- simple function  for loading dependencies
local function LoadDependency(name)
    local DependencyBody = readfile(string.format("SimpleHub/Dependencies/%s.lua", name))
    local Dependency = loadstring(DependencyBody)

    return Dependency()
end

-- remove any original simplehub processes that might exist
local process = getgenv().SimpleHub do
    if process then end
end

getgenv().SimpleHub = {
    ["LoadDependency"] = LoadDependency -- shared function
}

-- main hub
local Promise = LoadDependency("Promise")
local Webserver = LoadDependency("Webserver")
local Maid = LoadDependency("Maid")

-- values ig
local build = 1

Webserver:KeyIsValid("key_goes_here"):andThen(function(result)
    print(result)
end)