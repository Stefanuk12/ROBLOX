-- // Create a Client
local Client = GitHubClient.new()

-- // Get a User
local Stefanuk12 = GitHubClient.User.new(Client, "Stefanuk12")

-- // Get a User's Repository
local ROBLOX = GitHubClient.Repository.new(Stefanuk12, "ROBLOX")

-- // Get this file
local ExampleFile = ROBLOX:GetFile("master", "Other", "GitHubAPI", "Example.lua")

-- // Print it out
print(ExampleFile)