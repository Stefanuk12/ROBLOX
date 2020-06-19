-- Gui to Lua
-- Version: 3.2

-- Instances:

local ScriptCMDs = Instance.new("ScreenGui")
local Container = Instance.new("Frame")
local Header = Instance.new("Frame")
local Title = Instance.new("TextButton")
local Close = Instance.new("TextButton")
local Body = Instance.new("Frame")
local CMDFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local spamkillall = Instance.new("TextButton")
local stopspamkillall = Instance.new("TextButton")
local getmusic = Instance.new("TextButton")
local refreshmusic = Instance.new("TextButton")
local play1 = Instance.new("TextButton")
local xcmds = Instance.new("TextButton")
local intall = Instance.new("TextButton")
local intmusic = Instance.new("TextButton")
local intgeargiver = Instance.new("TextButton")
local intserveroof = Instance.new("TextButton")
local intsoundabuse = Instance.new("TextButton")
local intanti = Instance.new("TextButton")
local regen = Instance.new("TextButton")
local getadmin = Instance.new("TextButton")
local tpadmin = Instance.new("TextButton")
local antipunish = Instance.new("TextButton")
local antikill = Instance.new("TextButton")
local antiblind = Instance.new("TextButton")
local movebaseplate = Instance.new("TextButton")
local partspam = Instance.new("TextButton")
local respam = Instance.new("TextButton")
local pallsounds = Instance.new("TextButton")
local sallsounds = Instance.new("TextButton")
local pmusic = Instance.new("TextButton")
local smusic = Instance.new("TextButton")
local earrape = Instance.new("TextButton")
local blacklistphraseEpicGamer69killallresetall = Instance.new("TextButton")
local removeblacklistphraseEpicGamer69killall = Instance.new("TextButton")
local paintareaReallyredObbyBox = Instance.new("TextButton")
local rj = Instance.new("TextButton")
local antijail = Instance.new("TextButton")
local lagserverBindLeftShift = Instance.new("TextButton")
local ExamplePrompt = Instance.new("TextButton")

--Properties:

ScriptCMDs.Name = "ScriptCMDs"
ScriptCMDs.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScriptCMDs.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Container.Name = "Container"
Container.Parent = ScriptCMDs
Container.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Container.BackgroundTransparency = 1.000
Container.BorderSizePixel = 0
Container.Position = UDim2.new(0.399999976, 0, 0.200000033, 0)
Container.Size = UDim2.new(0, 400, 0, 50)

Header.Name = "Header"
Header.Parent = Container
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Header.BorderSizePixel = 0
Header.Size = UDim2.new(0, 400, 0, 50)

Title.Name = "Title"
Title.Parent = Header
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BackgroundTransparency = 1.000
Title.BorderSizePixel = 0
Title.Size = UDim2.new(0, 0, 0, 50)
Title.AutoButtonColor = false
Title.Font = Enum.Font.GothamBlack
Title.Text = "    | Epic Script CMDs"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14.000
Title.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
Title.TextXAlignment = Enum.TextXAlignment.Left

Close.Name = "Close"
Close.Parent = Header
Close.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Close.BorderSizePixel = 0
Close.Position = UDim2.new(0.88500005, 0, 0, 0)
Close.Size = UDim2.new(0, 45, 0, 50)
Close.AutoButtonColor = false
Close.Font = Enum.Font.GothamBold
Close.Text = "X"
Close.TextColor3 = Color3.fromRGB(255, 105, 97)
Close.TextSize = 14.000
Close.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)

Body.Name = "Body"
Body.Parent = Header
Body.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Body.BackgroundTransparency = 1.000
Body.BorderSizePixel = 0
Body.Position = UDim2.new(0, 0, 0.985000014, 0)
Body.Size = UDim2.new(0, 400, 0, 350)

CMDFrame.Name = "CMDFrame"
CMDFrame.Parent = Body
CMDFrame.Active = true
CMDFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CMDFrame.BorderSizePixel = 0
CMDFrame.Size = UDim2.new(0, 400, 0, 350)
CMDFrame.CanvasSize = UDim2.new(0, 0, 5, 0)

UIListLayout.Parent = CMDFrame

spamkillall.Name = ":spam kill all"
spamkillall.Parent = CMDFrame
spamkillall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
spamkillall.BackgroundTransparency = 1.000
spamkillall.BorderSizePixel = 0
spamkillall.Size = UDim2.new(0, 400, 0, 50)
spamkillall.AutoButtonColor = false
spamkillall.Font = Enum.Font.Gotham
spamkillall.Text = "    > :spam <\"message\">"
spamkillall.TextColor3 = Color3.fromRGB(255, 255, 255)
spamkillall.TextSize = 14.000
spamkillall.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
spamkillall.TextXAlignment = Enum.TextXAlignment.Left

stopspamkillall.Name = ":stopspam kill all"
stopspamkillall.Parent = CMDFrame
stopspamkillall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
stopspamkillall.BackgroundTransparency = 1.000
stopspamkillall.BorderSizePixel = 0
stopspamkillall.Size = UDim2.new(0, 400, 0, 50)
stopspamkillall.AutoButtonColor = false
stopspamkillall.Font = Enum.Font.Gotham
stopspamkillall.Text = "    > :stopspam <\"message\">"
stopspamkillall.TextColor3 = Color3.fromRGB(255, 255, 255)
stopspamkillall.TextSize = 14.000
stopspamkillall.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
stopspamkillall.TextXAlignment = Enum.TextXAlignment.Left

getmusic.Name = ":getmusic"
getmusic.Parent = CMDFrame
getmusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
getmusic.BackgroundTransparency = 1.000
getmusic.BorderSizePixel = 0
getmusic.Size = UDim2.new(0, 400, 0, 50)
getmusic.AutoButtonColor = false
getmusic.Font = Enum.Font.Gotham
getmusic.Text = "    > :getmusic - returns all playable songs"
getmusic.TextColor3 = Color3.fromRGB(255, 255, 255)
getmusic.TextSize = 14.000
getmusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
getmusic.TextXAlignment = Enum.TextXAlignment.Left

refreshmusic.Name = ":refreshmusic"
refreshmusic.Parent = CMDFrame
refreshmusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
refreshmusic.BackgroundTransparency = 1.000
refreshmusic.BorderSizePixel = 0
refreshmusic.Size = UDim2.new(0, 400, 0, 50)
refreshmusic.AutoButtonColor = false
refreshmusic.Font = Enum.Font.Gotham
refreshmusic.Text = "    > :refreshmusic - refreshes musictable"
refreshmusic.TextColor3 = Color3.fromRGB(255, 255, 255)
refreshmusic.TextSize = 14.000
refreshmusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
refreshmusic.TextXAlignment = Enum.TextXAlignment.Left

play1.Name = ":play 1"
play1.Parent = CMDFrame
play1.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
play1.BackgroundTransparency = 1.000
play1.BorderSizePixel = 0
play1.Size = UDim2.new(0, 400, 0, 50)
play1.AutoButtonColor = false
play1.Font = Enum.Font.Gotham
play1.Text = "    > :play <\"number\">"
play1.TextColor3 = Color3.fromRGB(255, 255, 255)
play1.TextSize = 14.000
play1.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
play1.TextXAlignment = Enum.TextXAlignment.Left

xcmds.Name = ":xcmds"
xcmds.Parent = CMDFrame
xcmds.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
xcmds.BackgroundTransparency = 1.000
xcmds.BorderSizePixel = 0
xcmds.Size = UDim2.new(0, 400, 0, 50)
xcmds.AutoButtonColor = false
xcmds.Font = Enum.Font.Gotham
xcmds.Text = "    > :xcmds - shows this"
xcmds.TextColor3 = Color3.fromRGB(255, 255, 255)
xcmds.TextSize = 14.000
xcmds.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
xcmds.TextXAlignment = Enum.TextXAlignment.Left

intall.Name = ":intall"
intall.Parent = CMDFrame
intall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
intall.BackgroundTransparency = 1.000
intall.BorderSizePixel = 0
intall.Size = UDim2.new(0, 400, 0, 50)
intall.AutoButtonColor = false
intall.Font = Enum.Font.Gotham
intall.Text = "    > :intall - activates all modules"
intall.TextColor3 = Color3.fromRGB(255, 255, 255)
intall.TextSize = 14.000
intall.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
intall.TextXAlignment = Enum.TextXAlignment.Left

intmusic.Name = ":intmusic"
intmusic.Parent = CMDFrame
intmusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
intmusic.BackgroundTransparency = 1.000
intmusic.BorderSizePixel = 0
intmusic.Size = UDim2.new(0, 400, 0, 50)
intmusic.AutoButtonColor = false
intmusic.Font = Enum.Font.Gotham
intmusic.Text = "    > :intmusic - activates music module"
intmusic.TextColor3 = Color3.fromRGB(255, 255, 255)
intmusic.TextSize = 14.000
intmusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
intmusic.TextXAlignment = Enum.TextXAlignment.Left

intgeargiver.Name = ":intgeargiver"
intgeargiver.Parent = CMDFrame
intgeargiver.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
intgeargiver.BackgroundTransparency = 1.000
intgeargiver.BorderSizePixel = 0
intgeargiver.Size = UDim2.new(0, 400, 0, 50)
intgeargiver.AutoButtonColor = false
intgeargiver.Font = Enum.Font.Gotham
intgeargiver.Text = "    > :intgeargiver - activates gear giver module"
intgeargiver.TextColor3 = Color3.fromRGB(255, 255, 255)
intgeargiver.TextSize = 14.000
intgeargiver.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
intgeargiver.TextXAlignment = Enum.TextXAlignment.Left

intserveroof.Name = ":intserveroof"
intserveroof.Parent = CMDFrame
intserveroof.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
intserveroof.BackgroundTransparency = 1.000
intserveroof.BorderSizePixel = 0
intserveroof.Size = UDim2.new(0, 400, 0, 50)
intserveroof.AutoButtonColor = false
intserveroof.Font = Enum.Font.Gotham
intserveroof.Text = "    > :intserveroof - activates server oof module"
intserveroof.TextColor3 = Color3.fromRGB(255, 255, 255)
intserveroof.TextSize = 14.000
intserveroof.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
intserveroof.TextXAlignment = Enum.TextXAlignment.Left

intsoundabuse.Name = ":intsoundabuse"
intsoundabuse.Parent = CMDFrame
intsoundabuse.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
intsoundabuse.BackgroundTransparency = 1.000
intsoundabuse.BorderSizePixel = 0
intsoundabuse.Position = UDim2.new(0, 0, -0.0114285713, 0)
intsoundabuse.Size = UDim2.new(0, 400, 0, 50)
intsoundabuse.AutoButtonColor = false
intsoundabuse.Font = Enum.Font.Gotham
intsoundabuse.Text = "    > :intsoundabuse - activates sound abuse module"
intsoundabuse.TextColor3 = Color3.fromRGB(255, 255, 255)
intsoundabuse.TextSize = 14.000
intsoundabuse.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
intsoundabuse.TextXAlignment = Enum.TextXAlignment.Left

intanti.Name = ":intanti"
intanti.Parent = CMDFrame
intanti.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
intanti.BackgroundTransparency = 1.000
intanti.BorderSizePixel = 0
intanti.Position = UDim2.new(0, 0, -0.0114285713, 0)
intanti.Size = UDim2.new(0, 400, 0, 50)
intanti.AutoButtonColor = false
intanti.Font = Enum.Font.Gotham
intanti.Text = "    > :intanti - activates anti module"
intanti.TextColor3 = Color3.fromRGB(255, 255, 255)
intanti.TextSize = 14.000
intanti.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
intanti.TextXAlignment = Enum.TextXAlignment.Left

regen.Name = ":regen"
regen.Parent = CMDFrame
regen.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
regen.BackgroundTransparency = 1.000
regen.BorderSizePixel = 0
regen.Position = UDim2.new(0, 0, -0.0114285713, 0)
regen.Size = UDim2.new(0, 400, 0, 50)
regen.AutoButtonColor = false
regen.Font = Enum.Font.Gotham
regen.Text = "    > :regen - regens admin"
regen.TextColor3 = Color3.fromRGB(255, 255, 255)
regen.TextSize = 14.000
regen.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
regen.TextXAlignment = Enum.TextXAlignment.Left

getadmin.Name = ":getadmin"
getadmin.Parent = CMDFrame
getadmin.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
getadmin.BackgroundTransparency = 1.000
getadmin.BorderSizePixel = 0
getadmin.Position = UDim2.new(0, 0, -0.0114285713, 0)
getadmin.Size = UDim2.new(0, 400, 0, 50)
getadmin.AutoButtonColor = false
getadmin.Font = Enum.Font.Gotham
getadmin.Text = "    > :getadmin - gets admin"
getadmin.TextColor3 = Color3.fromRGB(255, 255, 255)
getadmin.TextSize = 14.000
getadmin.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
getadmin.TextXAlignment = Enum.TextXAlignment.Left

tpadmin.Name = ":tpadmin"
tpadmin.Parent = CMDFrame
tpadmin.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
tpadmin.BackgroundTransparency = 1.000
tpadmin.BorderSizePixel = 0
tpadmin.Position = UDim2.new(0, 0, -0.0114285713, 0)
tpadmin.Size = UDim2.new(0, 400, 0, 50)
tpadmin.AutoButtonColor = false
tpadmin.Font = Enum.Font.Gotham
tpadmin.Text = "    > :tpadmin - toggles persistant admin"
tpadmin.TextColor3 = Color3.fromRGB(255, 255, 255)
tpadmin.TextSize = 14.000
tpadmin.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
tpadmin.TextXAlignment = Enum.TextXAlignment.Left

antipunish.Name = ":antipunish"
antipunish.Parent = CMDFrame
antipunish.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
antipunish.BackgroundTransparency = 1.000
antipunish.BorderSizePixel = 0
antipunish.Position = UDim2.new(0, 0, -0.0114285713, 0)
antipunish.Size = UDim2.new(0, 400, 0, 50)
antipunish.AutoButtonColor = false
antipunish.Font = Enum.Font.Gotham
antipunish.Text = "    > :antipunish - toggles anti punish"
antipunish.TextColor3 = Color3.fromRGB(255, 255, 255)
antipunish.TextSize = 14.000
antipunish.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
antipunish.TextXAlignment = Enum.TextXAlignment.Left

antikill.Name = ":antikill"
antikill.Parent = CMDFrame
antikill.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
antikill.BackgroundTransparency = 1.000
antikill.BorderSizePixel = 0
antikill.Position = UDim2.new(0, 0, -0.0114285713, 0)
antikill.Size = UDim2.new(0, 400, 0, 50)
antikill.AutoButtonColor = false
antikill.Font = Enum.Font.Gotham
antikill.Text = "    > :antikill - toggles anti kill"
antikill.TextColor3 = Color3.fromRGB(255, 255, 255)
antikill.TextSize = 14.000
antikill.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
antikill.TextXAlignment = Enum.TextXAlignment.Left

antiblind.Name = ":antiblind"
antiblind.Parent = CMDFrame
antiblind.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
antiblind.BackgroundTransparency = 1.000
antiblind.BorderSizePixel = 0
antiblind.Position = UDim2.new(0, 0, -0.0114285713, 0)
antiblind.Size = UDim2.new(0, 400, 0, 50)
antiblind.AutoButtonColor = false
antiblind.Font = Enum.Font.Gotham
antiblind.Text = "    > :antiblind - toggles anti blind"
antiblind.TextColor3 = Color3.fromRGB(255, 255, 255)
antiblind.TextSize = 14.000
antiblind.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
antiblind.TextXAlignment = Enum.TextXAlignment.Left

movebaseplate.Name = ":movebaseplate"
movebaseplate.Parent = CMDFrame
movebaseplate.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
movebaseplate.BackgroundTransparency = 1.000
movebaseplate.BorderSizePixel = 0
movebaseplate.Position = UDim2.new(0, 0, -0.0114285713, 0)
movebaseplate.Size = UDim2.new(0, 400, 0, 50)
movebaseplate.AutoButtonColor = false
movebaseplate.Font = Enum.Font.Gotham
movebaseplate.Text = "    > :movebaseplate - moves baseplate"
movebaseplate.TextColor3 = Color3.fromRGB(255, 255, 255)
movebaseplate.TextSize = 14.000
movebaseplate.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
movebaseplate.TextXAlignment = Enum.TextXAlignment.Left

partspam.Name = ":partspam"
partspam.Parent = CMDFrame
partspam.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
partspam.BackgroundTransparency = 1.000
partspam.BorderSizePixel = 0
partspam.Position = UDim2.new(0, 0, -0.0114285713, 0)
partspam.Size = UDim2.new(0, 400, 0, 50)
partspam.AutoButtonColor = false
partspam.Font = Enum.Font.Gotham
partspam.Text = "    > :partspam - toggles partspam"
partspam.TextColor3 = Color3.fromRGB(255, 255, 255)
partspam.TextSize = 14.000
partspam.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
partspam.TextXAlignment = Enum.TextXAlignment.Left

respam.Name = ":respam"
respam.Parent = CMDFrame
respam.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
respam.BackgroundTransparency = 1.000
respam.BorderSizePixel = 0
respam.Position = UDim2.new(0, 0, -0.0114285713, 0)
respam.Size = UDim2.new(0, 400, 0, 50)
respam.AutoButtonColor = false
respam.Font = Enum.Font.Gotham
respam.Text = "    > :respam - toggles respawn-explode spam"
respam.TextColor3 = Color3.fromRGB(255, 255, 255)
respam.TextSize = 14.000
respam.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
respam.TextXAlignment = Enum.TextXAlignment.Left

pallsounds.Name = ":pallsounds"
pallsounds.Parent = CMDFrame
pallsounds.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
pallsounds.BackgroundTransparency = 1.000
pallsounds.BorderSizePixel = 0
pallsounds.Position = UDim2.new(0, 0, -0.0114285713, 0)
pallsounds.Size = UDim2.new(0, 400, 0, 50)
pallsounds.AutoButtonColor = false
pallsounds.Font = Enum.Font.Gotham
pallsounds.Text = "    > :pallsounds - plays all sounds"
pallsounds.TextColor3 = Color3.fromRGB(255, 255, 255)
pallsounds.TextSize = 14.000
pallsounds.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
pallsounds.TextXAlignment = Enum.TextXAlignment.Left

sallsounds.Name = ":sallsounds"
sallsounds.Parent = CMDFrame
sallsounds.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
sallsounds.BackgroundTransparency = 1.000
sallsounds.BorderSizePixel = 0
sallsounds.Position = UDim2.new(0, 0, -0.0114285713, 0)
sallsounds.Size = UDim2.new(0, 400, 0, 50)
sallsounds.AutoButtonColor = false
sallsounds.Font = Enum.Font.Gotham
sallsounds.Text = "    > :sallsounds - stops all sounds"
sallsounds.TextColor3 = Color3.fromRGB(255, 255, 255)
sallsounds.TextSize = 14.000
sallsounds.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
sallsounds.TextXAlignment = Enum.TextXAlignment.Left

pmusic.Name = ":pmusic"
pmusic.Parent = CMDFrame
pmusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
pmusic.BackgroundTransparency = 1.000
pmusic.BorderSizePixel = 0
pmusic.Position = UDim2.new(0, 0, -0.0114285713, 0)
pmusic.Size = UDim2.new(0, 400, 0, 50)
pmusic.AutoButtonColor = false
pmusic.Font = Enum.Font.Gotham
pmusic.Text = "    > :pmusic - plays music"
pmusic.TextColor3 = Color3.fromRGB(255, 255, 255)
pmusic.TextSize = 14.000
pmusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
pmusic.TextXAlignment = Enum.TextXAlignment.Left

smusic.Name = ":smusic"
smusic.Parent = CMDFrame
smusic.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
smusic.BackgroundTransparency = 1.000
smusic.BorderSizePixel = 0
smusic.Position = UDim2.new(0, 0, -0.0114285713, 0)
smusic.Size = UDim2.new(0, 400, 0, 50)
smusic.AutoButtonColor = false
smusic.Font = Enum.Font.Gotham
smusic.Text = "    > :smusic - stops music"
smusic.TextColor3 = Color3.fromRGB(255, 255, 255)
smusic.TextSize = 14.000
smusic.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
smusic.TextXAlignment = Enum.TextXAlignment.Left

earrape.Name = ":earrape"
earrape.Parent = CMDFrame
earrape.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
earrape.BackgroundTransparency = 1.000
earrape.BorderSizePixel = 0
earrape.Position = UDim2.new(0, 0, -0.0114285713, 0)
earrape.Size = UDim2.new(0, 400, 0, 50)
earrape.AutoButtonColor = false
earrape.Font = Enum.Font.Gotham
earrape.Text = "    > :earrape - toggles earrape"
earrape.TextColor3 = Color3.fromRGB(255, 255, 255)
earrape.TextSize = 14.000
earrape.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
earrape.TextXAlignment = Enum.TextXAlignment.Left

blacklistphraseEpicGamer69killallresetall.Name = ":blacklistphrase | EpicGamer69 | kill all | reset all"
blacklistphraseEpicGamer69killallresetall.Parent = CMDFrame
blacklistphraseEpicGamer69killallresetall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
blacklistphraseEpicGamer69killallresetall.BackgroundTransparency = 1.000
blacklistphraseEpicGamer69killallresetall.BorderSizePixel = 0
blacklistphraseEpicGamer69killallresetall.Position = UDim2.new(0, 0, -0.0114285713, 0)
blacklistphraseEpicGamer69killallresetall.Size = UDim2.new(0, 400, 0, 50)
blacklistphraseEpicGamer69killallresetall.AutoButtonColor = false
blacklistphraseEpicGamer69killallresetall.Font = Enum.Font.Gotham
blacklistphraseEpicGamer69killallresetall.Text = "    > :blacklistphrase | PLAYERNAME | PHRASE | PUNISHMENT  "
blacklistphraseEpicGamer69killallresetall.TextColor3 = Color3.fromRGB(255, 255, 255)
blacklistphraseEpicGamer69killallresetall.TextSize = 14.000
blacklistphraseEpicGamer69killallresetall.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
blacklistphraseEpicGamer69killallresetall.TextXAlignment = Enum.TextXAlignment.Left

removeblacklistphraseEpicGamer69killall.Name = ":removeblacklistphrase | EpicGamer69 | kill all"
removeblacklistphraseEpicGamer69killall.Parent = CMDFrame
removeblacklistphraseEpicGamer69killall.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
removeblacklistphraseEpicGamer69killall.BackgroundTransparency = 1.000
removeblacklistphraseEpicGamer69killall.BorderSizePixel = 0
removeblacklistphraseEpicGamer69killall.Position = UDim2.new(0, 0, -0.0114285713, 0)
removeblacklistphraseEpicGamer69killall.Size = UDim2.new(0, 400, 0, 50)
removeblacklistphraseEpicGamer69killall.AutoButtonColor = false
removeblacklistphraseEpicGamer69killall.Font = Enum.Font.Gotham
removeblacklistphraseEpicGamer69killall.Text = "    > :removeblacklistphrase | PLAYERNAME | PHRASE"
removeblacklistphraseEpicGamer69killall.TextColor3 = Color3.fromRGB(255, 255, 255)
removeblacklistphraseEpicGamer69killall.TextSize = 14.000
removeblacklistphraseEpicGamer69killall.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
removeblacklistphraseEpicGamer69killall.TextXAlignment = Enum.TextXAlignment.Left

paintareaReallyredObbyBox.Name = ":paintarea | Really red | Obby Box"
paintareaReallyredObbyBox.Parent = CMDFrame
paintareaReallyredObbyBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
paintareaReallyredObbyBox.BackgroundTransparency = 1.000
paintareaReallyredObbyBox.BorderSizePixel = 0
paintareaReallyredObbyBox.Position = UDim2.new(0, 0, -0.0114285713, 0)
paintareaReallyredObbyBox.Size = UDim2.new(0, 400, 0, 50)
paintareaReallyredObbyBox.AutoButtonColor = false
paintareaReallyredObbyBox.Font = Enum.Font.Gotham
paintareaReallyredObbyBox.Text = "    > :paintarea | COLOUR | SECTION"
paintareaReallyredObbyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
paintareaReallyredObbyBox.TextSize = 14.000
paintareaReallyredObbyBox.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
paintareaReallyredObbyBox.TextXAlignment = Enum.TextXAlignment.Left

rj.Name = ":rj"
rj.Parent = CMDFrame
rj.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
rj.BackgroundTransparency = 1.000
rj.BorderSizePixel = 0
rj.Position = UDim2.new(0, 0, -0.0114285713, 0)
rj.Size = UDim2.new(0, 400, 0, 50)
rj.AutoButtonColor = false
rj.Font = Enum.Font.Gotham
rj.Text = "    > :rj - rejoins the server"
rj.TextColor3 = Color3.fromRGB(255, 255, 255)
rj.TextSize = 14.000
rj.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
rj.TextXAlignment = Enum.TextXAlignment.Left

antijail.Name = ":antijail"
antijail.Parent = CMDFrame
antijail.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
antijail.BackgroundTransparency = 1.000
antijail.BorderSizePixel = 0
antijail.Position = UDim2.new(0, 0, -0.0114285713, 0)
antijail.Size = UDim2.new(0, 400, 0, 50)
antijail.AutoButtonColor = false
antijail.Font = Enum.Font.Gotham
antijail.Text = "    > :antijail - toggles antijail"
antijail.TextColor3 = Color3.fromRGB(255, 255, 255)
antijail.TextSize = 14.000
antijail.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
antijail.TextXAlignment = Enum.TextXAlignment.Left

lagserverBindLeftShift.Name = ":lagserver - Bind: Right Shift"
lagserverBindLeftShift.Parent = CMDFrame
lagserverBindLeftShift.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
lagserverBindLeftShift.BackgroundTransparency = 1.000
lagserverBindLeftShift.BorderSizePixel = 0
lagserverBindLeftShift.Position = UDim2.new(0, 0, -0.0114285713, 0)
lagserverBindLeftShift.Size = UDim2.new(0, 400, 0, 50)
lagserverBindLeftShift.AutoButtonColor = false
lagserverBindLeftShift.Font = Enum.Font.Gotham
lagserverBindLeftShift.Text = "    > :lagserver - Bind: Right Shift"
lagserverBindLeftShift.TextColor3 = Color3.fromRGB(255, 255, 255)
lagserverBindLeftShift.TextSize = 14.000
lagserverBindLeftShift.TextStrokeColor3 = Color3.fromRGB(200, 200, 200)
lagserverBindLeftShift.TextXAlignment = Enum.TextXAlignment.Left

ExamplePrompt.Name = "Example Prompt"
ExamplePrompt.Parent = Header
ExamplePrompt.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ExamplePrompt.BackgroundTransparency = 1.000
ExamplePrompt.BorderSizePixel = 0
ExamplePrompt.Position = UDim2.new(0.38499999, 0, 0, 0)
ExamplePrompt.Size = UDim2.new(0, 200, 0, 50)
ExamplePrompt.AutoButtonColor = false
ExamplePrompt.Font = Enum.Font.Gotham
ExamplePrompt.Text = " click cmds 4 example print"
ExamplePrompt.TextColor3 = Color3.fromRGB(255, 255, 255)
ExamplePrompt.TextSize = 14.000

-- // Script
local Dragger = {}; do
    local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
    local UIS = game:GetService("UserInputService")
    local Heartbeat = game:GetService("RunService").Heartbeat
    function Dragger.new(Frame)
        local success, response = pcall(function()
            return Frame.MouseEnter
        end)
        if success then
            Frame.Active = true
            response:Connect(function()
                local Input = Frame.InputBegan:Connect(function(Key)
                    if Key.UserInputType == Enum.UserInputType.MouseButton1 then
                        local objectPosition = Vector2.new(Mouse.X - Frame.AbsolutePosition.X, Mouse.Y - Frame.AbsolutePosition.Y)
                        while Heartbeat:Wait() and UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) do
                            pcall(function()
                                Frame:TweenPosition(UDim2.new(0, Mouse.X - objectPosition.X + (Frame.Size.X.Offset * Frame.AnchorPoint.X), 0, Mouse.Y - objectPosition.Y + (Frame.Size.Y.Offset * Frame.AnchorPoint.Y)), 'Out', 'Linear', 0.1, true)
                            end)
                        end
                    end
                end)

                local Leave
                Leave = Frame.MouseLeave:Connect(function()
                    Input:Disconnect()
                    Leave:Disconnect()
                end)
            end)
        end
    end

end
Dragger.new(Container)

local Connections = {}
function hoverGlow(hoverPart, affectedPart)
	local TweenService = game:GetService("TweenService")
	local hPartMouseEnter = hoverPart.MouseEnter:Connect(function()
		TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.8}):Play()
	end)
   	local hPartMouseLeave = hoverPart.MouseLeave:Connect(function()
		TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
	end)      
    local hPartMouseDown = hoverPart.MouseButton1Down:Connect(function()
        TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 0.5}):Play()
    end)         
    local hPartMouseUp = hoverPart.MouseButton1Up:Connect(function()
        TweenService:Create(affectedPart, TweenInfo.new(0.2), {TextStrokeTransparency = 1}):Play()
    end)
	table.insert(Connections, {Connection = hPartMouseEnter})
	table.insert(Connections, {Connection = hPartMouseLeave})
	table.insert(Connections, {Connection = hPartMouseDown})
	table.insert(Connections, {Connection = hPartMouseUp})
end

hoverGlow(Close, Close)
local CloseConnection = Close.MouseButton1Click:Connect(function()
	for i,v in pairs(Connections) do
		v.Connection:Disconnect()
	end
	for i,v in pairs(ScriptCMDs:GetDescendants()) do
		if string.match(v.ClassName, "Frame") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
		end
		if string.match(v.ClassName, "Text") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {BackgroundTransparency = 1}):Play()
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {TextTransparency = 1}):Play()
			v.TextStrokeTransparency = 1
		end
		if string.match(v.ClassName, "ScrollingFrame") then
			game:GetService("TweenService"):Create(v, TweenInfo.new(1), {ScrollBarImageTransparency = 1}):Play()
		end
	end
	wait(2)
	ScriptCMDs:Destroy()
end)

hoverGlow(Title, Title)
local TitleClickConnection = Title.MouseButton1Click:Connect(function()
	print("hi epic scirpt comandsa")
end)

for i,v in pairs(CMDFrame:GetChildren()) do
	if v:IsA("TextButton") then
		hoverGlow(v, v)
		local ButtonClickConnection = v.MouseButton1Click:Connect(function()
			print('Command Example - '..v.Name)
		end)
		table.insert(Connections, {Connection = ButtonClickConnection})
	end
end
table.insert(Connections, {Connection = CloseConnection})
table.insert(Connections, {Connection = TitleClickConnection})