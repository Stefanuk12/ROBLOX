--[[
    Information:

    This doesn't really work, automatically disconnects websocket for some reason. Also RPC is private idk

    To set this up yourself, make sure you add https://sereine.xyz/discordcode.php as a redirect in your OAuth2 redirects. The code for that page can be seen below

    <?php
    if ($_GET['code']) {
        echo htmlspecialchars($_GET['code']);
    } else {
        echo "An error has occured: code not provided.";
    }
]]

-- // Dependencies
local SignalManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Stefanuk12/Signal/main/Manager.lua"))()

-- // Services
local HttpService = game:GetService("HttpService")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")

-- //
local RPCManager = {}
RPCManager.__index = RPCManager
RPCManager.__type = "RPCManager"
do
    -- // Constructor
    function RPCManager.new(Data)
        -- // Create object
        local self = setmetatable({}, RPCManager)

        -- // Vars
        self.CLIENT_ID = Data.CLIENT_ID or "914621179766132767"
        self.CLIENT_SECRET = Data.CLIENT_SECRET or ""
        self.VERSION = Data.Version or 1
        self.PORT = Data.PORT or {6463, 6472}
        self.ENCODING = Data.ENCODING or "json"
        self.REDIRECT_URL = "https://sereine.xyz/discordcode.php"
        self.URLFormat = Data.URLFormat or "ws://127.0.0.1:%d/?v=%d&client_id=%s&encoding=%s"

        -- // Initialise signals
        self.Signals = SignalManager.new()
        self.Signals:Add("OnMessage")

        -- // Return object
        return self
    end

    -- //
    function RPCManager.InitialiseConnection(self)
        -- // Loop through all of the possible ports
        for i = self.PORT[1], self.PORT[2] do
            -- // Create the connection
            local success, event = syn.websocket.connect(self.URLFormat:format(i, self.VERSION, self.CLIENT_ID, self.ENCODING))

            -- // Make sure it was successful and set
            if (not event) then
                self.Connection = success
                break
            end
        end

        -- // Make sure connection is made
        assert(self.Connection, "websocket connection to Discord RPC has not been established yet")

        -- // Connections
        self.Connection.OnMessage:Connect(function(Message)
            print(Message)

            -- // Convert to json
            Message = HttpService:JSONDecode(Message)

            -- // Fire event
            self.Signals:Fire("OnMessage", Message)
        end)

        self.Connection.OnClose:Connect(function()
            rconsoleprint("Discord RPC connection closed.\n")
        end)
    end

    -- //
    function RPCManager.WaitForMessage(self, Nonce)
        -- // Make sure connection is made
        assert(self.Connection, "websocket connection to Discord RPC has not been established yet")

        -- //
        return self.Signals:Wait("OnMessage", 1/0, function(Message)
            return Message.nonce == Nonce
        end)
    end

    -- //
    function RPCManager.SendCommand(self, Command, Arguments, WaitForResponse)
        -- // Make sure connection is made
        assert(self.Connection, "websocket connection to Discord RPC has not been established yet")

        -- // Vars
        local Nonce = HttpService:GenerateGUID(false)

        -- // Send it
        local Payload = {
            nonce = Nonce,
            args = Arguments,
            cmd = Command
        }
        self.Connection:Send(HttpService:JSONEncode(Payload))

        -- // Wait for a response
        if (WaitForResponse) then
            return self:WaitForMessage(Nonce)
        end

        -- // Return
        return Nonce
    end

    -- //
    function RPCManager.ParseTableToURL(Table)
        local Output = ""

        for i = 1, #Table do
            local v = tostring(Table[i])

            if (i == 1) then
                Output = Output .. "?=" .. v
            else
                Output = Output .. "&=" .. v
            end
        end

        return HttpService:UrlEncode(Output)
    end

    -- //
    function RPCManager.AuthoriseCode(self, Code)
        -- // Grab the access token
        local Data = {
            client_id = self.CLIENT_ID,
            client_secret = self.CLIENT_SECRET,
            grant_type = "authorization_code",
            code = Code,
            redirect_uri = self.REDIRECT_URL
        }
        local Response = syn.request({
            Url = "https://discord.com/api/oauth2/token",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/x-www-form-urlencoded"
            },
            Body = self.ParseTableToURL(Data)
        })

        -- // Return
        return HttpService:JSONDecode(Response.Body)
    end

    -- //
    function RPCManager.Authorise(self)
        -- // Ask the user to get the code
        local URLFormat = "?client_id=%s&redirect_uri=%s&response_type=code&scope=rpc+identify"
        local Prompt = "Please go to this website and grab the code recieved. Then paste it into here. https://discord.com/api/oauth2/authorize" .. URLFormat:format(self.CLIENT_ID, self.REDIRECT_URL) .. "\n > "
        rconsoleprint(Prompt)
        local Code = rconsoleinput()

        -- //
        self.AccessData = self:AuthoriseCode(Code)
    end

    -- //
    function RPCManager.AuthoriseWS(self)
        -- //
        local Response = self:SendCommand("AUTHORIZE", {
            client_id = self.CLIENT_ID,
            scopes = {"rpc", "identify"}
        }, true)

        -- //
        self.AccessData = self:AuthoriseCode(Response.code)
    end

    -- //
    function RPCManager.Authenticate(self, AccessToken)
        self.Authenticated = true
        return self:SendCommand("AUTHENTICATE", {
            access_token = AccessToken
        })
    end

    -- //
    function RPCManager.SetRobloxActivity(self)
        -- // Make sure we are authenticated
        assert(self.Authenticated, "not authenticated")

        -- // Vars
        local success, GameName = pcall(MarketplaceService.GetProductInfo, MarketplaceService, game.PlaceId)
        assert(success, "unable to get game")

        -- //
        RPCManager:SendCommand("SET_ACTIVITY", {
            pid = 9999,
            activity = {
                name = "Roblox",
                type = 0,
                created_at = math.floor(tick() * 1000),
                details = GameName .. " | In game",
                party = {
                    size = {#Players:GetPlayers(), Players.MaxPlayers}
                }
            }
        }, true)
    end
end

-- // Return
return RPCManager