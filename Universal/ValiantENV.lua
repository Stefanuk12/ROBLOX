-- // Valiant ENV
function valiantENV()
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
        "RbxAnalyticsService",
        "VirtualUser",
    }

    local exploitlist = {
        syn = "Synapse",
        PROTOSMASHER_LOADED = "ProtoSmasher",
        SENTINEL_LOADED = "Sentinel",
        Sirhurt = "Sirhurt",
    }
    -- // Valiant ENV: Func Index
    Valiant.ID = function(path, method, ...)
        local args = {...}
        return path[method](path, unpack(args))
    end

    -- // Valiant ENV: Services

    for i,v in pairs(Services) do
        Valiant.Services[v] = Valiant.ID(game, "GetService", v)
    end
    for i,v in pairs(Valiant.Services) do
        local ServiceName = tostring(v):gsub(" ","")
        getgenv()[ServiceName] = v
    end

    -- // Valiant ENV: Exploit Check
    for i,v in pairs(exploitlist) do 
        if getgenv()[i] then 
            Valiant.Exploit = v 
        end
    end

    --// Valiant ENV: Custom Exploit Funcs
    syn_websocket_send = syn_websocket_send
    queueonteleport = syn["queue_on_teleport"] or queue_on_teleport
    firesignal = firesignal
    makefolder = makefolder
    is_protosmasher_caller = is_protosmasher_caller
    clonefunction = clonefunction
    setrawmetatable = setrawmetatable 
    getrawmetatable = getrawmetatable
    getinstancefromstate = getinstancefromstate
    setfflag = setfflag
    getcallingscript = getcallingscript or get_calling_script
    getrenv = getrenv
    syn_crypt_b64_encode = syn_crypt_b64_encode
    newcclosure = newcclosure
    getspecialinfo = debug.getspecialinfo or getspecialinfo
    shared = shared
    decompile = decompile
    loadstring = loadstring
    getprotos = debug.getprotos or getprotos
    hookfunction = hookfunction or hookfunc
    isfile = isfile
    getproto = debug.getproto or getproto
    print = print
    isrbxactive = isrbxactive
    rconsoleinfo = rconsoleinfo
    make_readonly = make_readonly
    getstack = debug.getstack or getstack
    rconsolename = rconsolename
    unlockmodulescript = unlockmodulescript
    getupvalue = debug.getupvalue or getupvalue
    setproto = debug.setproto or setproto
    mouse1click = mouse1click
    setupvalue = debug.setupvalue or setupvalue
    getscripts = getscripts or get_scripts
    rconsoleerr = rconsoleerr
    dumpstring = dumpstring
    keypress = keypress
    syn_crypt_derive = syn_crypt_derive
    rconsoleclear = rconsoleclear
    is_redirection_enabled = is_redirection_enabled
    syn_context_set = syn_context_set
    isreadonly = isreadonly or function(tbl) return is_readonly; end;
    mouse2click = mouse2click
    getinfo = debug.getinfo or getinfo
    writefile = writefile
    loadfile = loadfile
    getconstant = debug.getconstant or getconstant
    is_synapse_function = is_synapse_function or issynapsefunction
    getconnections = getconnections
    checkcaller = checkcaller
    setreadonly = setreadonly or function(tbl, val) if val then make_readonly(tbl); else make_writeable(tbl); end; end;
    syn_crypt_encrypt = syn_crypt_encrypt
    warn = warn
    validfgwindow = validfgwindow
    saveinstance = saveinstance
    getinstances = getinstances or get_instances
    getconstants = debug.getconstants or getconstants
    getloadedmodules = getloadedmodules or get_loaded_modules
    require = require
    getnilinstances = getnilinstances or get_nil_instances
    setclipboard = setclipboard
    delfile = delfile
    firetouchinterest = firetouchinterest
    mouse1release = mouse1release
    syn_websocket_close = syn_websocket_close
    setnamecallmethod = setnamecallmethod
    rconsoleprint = rconsoleprint
    getsenv = getsenv
    messagebox = messagebox
    replaceclosure = replaceclosure
    delfolder = delfolder
    keyrelease = keyrelease
    isfolder = isfolder
    XPROTECT = XPROTECT or xprotect
    getcallstack = getcallstack
    appendfile = appendfile
    syn_crypt_hash = syn_crypt_hash
    syn_websocket_connect = syn_websocket_connect
    is_protosmasher_closure = is_protosmasher_closure or isprotosmasherclosure
    mousemoverel = mousemoverel
    printconsole = printconsole
    listfiles = listfiles or list_files
    islclosure = islclosure or is_lclosure
    rconsolewarn = rconsolewarn
    getstateenv = getstateenv
    syn_crypt_decrypt = syn_crypt_decrypt
    readfile = readfile
    mousescroll = mousescroll
    mousemoveabs = mousemoverel
    setconstant = debug.setconstant or setconstant
    getpropvalue = getpropvalue
    syn_crypt_b64_decode = syn_crypt_b64_decode
    mouse2release = mouse2release
    mouse2press = mouse2press
    getgc = getgc
    getstates = getstates
    getpointerfromstate = getpointerfromstate
    mouse1press = mouse1press
    getnamecallmethod = getnamecallmethod or get_namecall_method
    setpropvalue = setpropvalue
    rconsoleinputasync = rconsoleinputasync
    syn_crypt_random = syn_crypt_random
    fireclickdetector = fireclickdetector
    rconsoleinput = rconsoleinput
    getmenv = getmenv
    getreg = getreg or debug.getregistry or getregistry
    getgenv = getgenv
    messageboxasync = messageboxasync
    getupvalues = getupvalues or debug.getupvalues or getupvalues
    setstack = setstack or debug.setstack or setstack
    syn_context_get = syn_context_get
    syn_isactive = syn_isactive
    profilebegan = debug.profilebegin or profilebegin
    traceback = debug.traceback or traceback
    setmetatable = debug.setmetatable or setmetatable
    getmetatable = debug.getmetatable or getmetatable
    getfenv = debug.getfenv or getfenv
    setupvaluename = debug.setupvaluename or setupvaluename
    profileend = debug.profileend or profileend
    validlevel = debug.validlevel or validlevel
end

valiantENV()