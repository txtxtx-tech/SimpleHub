--[[
    SimpleHub™ - 2023
]]

-- remove any original simplehub processes that might exist
local process = getgenv().SimpleHub do
    if process then end
end

getgenv().SimpleHub = {
    ["LoadDependency"] = function(name) -- shared function
        local DependencyBody = readfile(string.format("SimpleHub/Dependencies/%s.lua", name))
        local Dependency = loadstring(DependencyBody)
    
        return Dependency()
    end
}

-- main hub
local LoadDependency = getgenv().SimpleHub.LoadDependency
local Promise = LoadDependency("Promise")
local Webserver = LoadDependency("Webserver")
local Maid = LoadDependency("Maid")

-- values ig
local build = 1

Webserver:KeyIsValid("key_goes_here"):andThen(function(result)
    print(result)
end)