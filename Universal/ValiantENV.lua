-- // Valiant ENV
getgenv().Valiant = {}
Valiant.Services = {}
Valiant.Exploit = "Could Not Find Exploit!"

-- // Valiant ENV: Vars
local Services = {
    "Workspace",
    "RunService",
    "GuiService",
    "Stats",
    "SoundService",
    "LogService",
    "ContentProvider",
    "Chat",
    "MarketplaceService",
    "Players",
    "PointsService",
    "ReplicatedFirst",
    "StudioData",
    "StarterPlayer",
    "StarterPack",
    "StarterGui",
    "CoreGui",
    "LocalizationService",
    "JointsService",
    "InsertService",
    "Debris",
    "Instance",
    "Selection",
    "Lighting",
    "CorePackages",
    "ABTestService",
    "NetworkClient",
    "HttpService",
    "Teams",
    "ReplicatedStorage",
    "TestService",
    "PolicyService",
    "RbxAnalyticsService"
}

local exploitlist = {
    syn = "Synapse",
    PROTOSMASHER_LOADED = "ProtoSmasher",
    SENTINEL_LOADED = "Sentinel",
    Sirhurt = "Sirhurt"
}
-- // Valiant ENV: Func Index
Valiant.ID = function(path, method, ...)
    local args = {...}
    return path[method](path, unpack(args))
end

-- // Valiant ENV: Services
for i, v in pairs(Services) do
    Valiant.Services[v] = Valiant.ID(game, "GetService", v)
end
for i, v in pairs(Valiant.Services) do
    local ServiceName = tostring(v.ClassName):gsub(" ", "")
    getgenv()[ServiceName] = v
end

-- // Valiant ENV: Exploit Check
for i, v in pairs(exploitlist) do
    if getgenv()[i] then
        Valiant.Exploit = v
    end
end

--// Valiant ENV: Custom Exploit Funcs
syn_websocket_send = syn_websocket_send or nil
queueonteleport = queue_on_teleport or queueonteleport or nil
if syn then
    queueonteleport = syn.queue_on_teleport
end
firesignal = firesignal or nil
makefolder = makefolder or nil
is_protosmasher_caller = is_protosmasher_caller or nil
clonefunction = clonefunction or nil
setrawmetatable = setrawmetatable or nil
getrawmetatable = getrawmetatable or nil
getinstancefromstate = getinstancefromstate or nil
setfflag = setfflag or nil
getcallingscript = getcallingscript or get_calling_script or nil
getrenv = getrenv or nil
syn_crypt_b64_encode = syn_crypt_b64_encode or nil
newcclosure = newcclosure or nil
getspecialinfo = debug.getspecialinfo or getspecialinfo or nil
shared = shared or nil
decompile = decompile or nil
loadstring = loadstring or nil
getprotos = debug.getprotos or getprotos or nil
hookfunction = hookfunction or hookfunc or nil
isfile = isfile or nil
getproto = debug.getproto or getproto or nil
print = print or nil
isrbxactive = isrbxactive or nil
rconsoleinfo = rconsoleinfo or nil
make_readonly = make_readonly or nil
getstack = debug.getstack or getstack or nil
rconsolename = rconsolename or nil
unlockmodulescript = unlockmodulescript or nil
getupvalue = debug.getupvalue or getupvalue or nil
setproto = debug.setproto or setproto or nil
mouse1click = mouse1click or nil
setupvalue = debug.setupvalue or setupvalue or nil
getscripts = getscripts or get_scripts or nil
rconsoleerr = rconsoleerr or nil
dumpstring = dumpstring or nil
keypress = keypress or nil
syn_crypt_derive = syn_crypt_derive or nil
rconsoleclear = rconsoleclear or nil
is_redirection_enabled = is_redirection_enabled or nil
syn_context_set = syn_context_set or nil
isreadonly = isreadonly or nil
mouse2click = mouse2click or nil
getinfo = debug.getinfo or getinfo or nil
writefile = writefile or nil
loadfile = loadfile or nil
getconstant = debug.getconstant or getconstant or nil
is_synapse_function = is_synapse_function or issynapsefunction or nil
getconnections = getconnections or nil
checkcaller = checkcaller or nil
setreadonly = setreadonly or function(tbl, val)
    if val then
        make_readonly(tbl)
    else
        make_writeable(tbl)
    end
end or nil
syn_crypt_encrypt = syn_crypt_encrypt or nil
warn = warn or nil
validfgwindow = validfgwindow or nil
saveinstance = saveinstance or nil
getinstances = getinstances or get_instances or nil
getconstants = debug.getconstants or getconstants or nil
getloadedmodules = getloadedmodules or get_loaded_modules or nil
require = require or nil
getnilinstances = getnilinstances or get_nil_instances or nil
setclipboard = setclipboard or nil
delfile = delfile or nil
firetouchinterest = firetouchinterest or nil
mouse1release = mouse1release or nil
syn_websocket_close = syn_websocket_close or nil
setnamecallmethod = setnamecallmethod or nil
rconsoleprint = rconsoleprint or nil
getsenv = getsenv or nil
messagebox = messagebox or nil
replaceclosure = replaceclosure or nil
delfolder = delfolder or nil
keyrelease = keyrelease or nil
isfolder = isfolder or nil
XPROTECT = XPROTECT or xprotect or nil
getcallstack = getcallstack or nil
appendfile = appendfile or nil
syn_crypt_hash = syn_crypt_hash or nil
syn_websocket_connect = syn_websocket_connect or nil
is_protosmasher_closure = is_protosmasher_closure or isprotosmasherclosure or nil
mousemoverel = mousemoverel or nil
printconsole = printconsole
listfiles = listfiles or list_files or nil
islclosure = islclosure or is_lclosure or nil
rconsolewarn = rconsolewarn or nil
getstateenv = getstateenv or nil
syn_crypt_decrypt = syn_crypt_decrypt or nil
readfile = readfile or nil
mousescroll = mousescroll or nil
mousemoveabs = mousemoverel or nil
setconstant = debug.setconstant or setconstant or nil
getpropvalue = getpropvalue or nil
syn_crypt_b64_decode = syn_crypt_b64_decode or nil
mouse2release = mouse2release or nil
mouse2press = mouse2press or nil
getgc = getgc or nil
getstates = getstates
getpointerfromstate = getpointerfromstate or nil
mouse1press = mouse1press or nil
getnamecallmethod = getnamecallmethod or get_namecall_method or nil
setpropvalue = setpropvalue or nil
rconsoleinputasync = rconsoleinputasync or nil
syn_crypt_random = syn_crypt_random or nil
fireclickdetector = fireclickdetector or nil
rconsoleinput = rconsoleinput or nil
getmenv = getmenv or nil
getreg = getreg or debug.getregistry or getregistry or nil
getgenv = getgenv or nil
messageboxasync = messageboxasync or nil
getupvalues = getupvalues or debug.getupvalues or getupvalues or nil
setstack = setstack or debug.setstack or setstack or nil
syn_context_get = syn_context_get or nil
syn_isactive = syn_isactive or nil
getfenv = debug.getfenv or getfenv or nil
setupvaluename = debug.setupvaluename or setupvaluename or nil