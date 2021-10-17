-- // Services
local HttpService = game:GetService("HttpService")

-- // Failsafer / Type Check
local function TypeCheck(FunctionName, Data)
    -- // Loop through all the data
    for i, Argument in ipairs(Data) do
        -- // Vars
        local AllowedTypes = Argument[1]
        local typeofArgument = typeof(Argument[2])
        local isOptional = Argument[3]
        local PossibleArguments = table.concat(AllowedTypes, "|")

        -- // Bypass optional arguments
        if (isOptional and Argument[2] == nil) then
            continue
        end

        -- // Raise an error if not allowed type
        local isAllowed = table.find(AllowedTypes, typeofArgument)
        assert(isAllowed, "bad argument #" .. i .. " to '" .. FunctionName .. "' (" .. PossibleArguments .. "expected, got " .. typeofArgument .. ")")
    end
end

-- // Sends a HTTP Request
local function HttpSend(Data)
    -- // Check the inputs
    TypeCheck("new", {
        {{"table"}, Data},
    })

    -- // Make sure Url and Method were specified
    assert(typeof(Data.Url) == "string", "Missing URL")
    assert(typeof(Data.Method) == "string", "Missing HTTP Method")

    -- // Send the request
    local Response = syn.request(Data)

    -- // Throw error (if there were any)
    assert(Response.Success, Response.Body)

    -- // Return
    return Response
end

-- // Client Class
local GitHubClient = {}
GitHubClient.__index = GitHubClient

-- // Create a Client
function GitHubClient.new(Username, Token)
    -- // Check the inputs
    TypeCheck("new", {
        {{"string"}, Username, true},
        {{"string"}, Token, true},
    })

    -- // Initialise Class and Properties
    local self = setmetatable({}, GitHubClient)
    self.Auth = (Username and Token) and "Basic " .. syn.crypt.base64.encode(Username .. ":" .. Token) or ""
    self.APIBase = "https://api.github.com"

    -- // Return Object
    return self
end

-- // User Class
do
    -- // Set
    GitHubClient.User = {}
    local User = GitHubClient.User
    User.__index = User

    -- // Create a User
    function User.new(Client, Name)
        -- // Check the inputs
        TypeCheck("new", {
            {{"table"}, Client},
            {{"string"}, Name}
        })

        -- // Initialise Class and Properties
        local self = setmetatable({}, User)
        self.Name = Name
        self.Data = {}
        self.Client = Client

        -- // Get the data
        local Response = HttpSend({
            Url = (Client.APIBase .. "/users/%s"):format(Name),
            Method = "GET",
            Headers = {
                Authorization = Client.Auth
            }
        })
        self.Data = HttpService:JSONDecode(Response.Body)

        -- // Return Object
        return self
    end
end

-- // Repository Class
do
    -- // Set
    GitHubClient.Repository = {}
    local Repository = GitHubClient.Repository
    Repository.__index = Repository

    -- // Create a Repository
    function Repository.new(Owner, Name)
        -- // Check the inputs
        TypeCheck("new", {
            {{"table"}, Owner},
            {{"string"}, Name},
        })

        -- // Initialise Class and Properties
        local self = setmetatable({}, Repository)
        local Client = Owner.Client
        self.Client = Client
        self.Owner = Owner
        self.Name = Name
        self.Data = {}

        -- // Get the data
        local Response = HttpSend({
            Url = (Client.APIBase .. "/repos/%s/%s"):format(Owner.Name, Name),
            Method = "GET",
            Headers = {
                Authorization = Client.Auth
            }
        })
        self.Data = HttpService:JSONDecode(Response.Body)

        -- // Return Object
        return self
    end

    -- // Get a file
    function Repository.GetFile(Repository, Fork, ...)
        -- // Check the inputs
        TypeCheck("GetFile", {
            {{"table"}, Repository},
            {{"string"}, Fork}
        })

        -- // Vars
        local Client = Repository.Client
        local Owner = Repository.Owner
    
        -- // URL Encode each "segment"
        local PathSegments = {...}
        for i, v in ipairs(PathSegments) do
            PathSegments[i] = HttpService:UrlEncode(v)
        end

        -- // Get URL
        local Path = table.concat(PathSegments, "/")
        local Url = (Client.APIBase .. "/repos/%s/%s/contents/%s"):format(Owner.Name, Repository.Name, Path)

        -- // Send the request to get the download url
        local ResponseContent = HttpSend({
            Url = Url,
            Method = "GET",
            Headers = {
                Authorization = Client.Auth
            }
        })
        local ResponseContentBody = HttpService:JSONDecode(ResponseContent.Body)
        local Content = syn.crypt.base64.decode(ResponseContentBody.content)

        -- // Return
        return Content
    end
end

-- // Export
getgenv().GitHubClient = GitHubClient
