using Random

include("roblox.jl")
include("anticaptcha.jl")
include("proxy.jl")

global results = open("cookies.txt", "a")
global count = 0

function createAccount()
    creation = nothing
    username = randstring(12)
    proxy = Proxy.get()

    try
        creation = Roblox.register(username, proxy)
    catch e
        blob_data = split(split(split(string(e), "\"fieldData\":\"")[2], "\"}],\"errors\":")[1], ",")
        taskId = Anticaptcha.createTask(String(blob_data[2]))
        result = ""
        while true
            sleep(2)
            result = Anticaptcha.getTaskResult(taskId)
            if result !== false
                break
            end
        end
    
        creation = Roblox.registerWithCaptcha(blob_data[1], result, username, proxy)
    end
    
    return String(split(split(string(creation.headers[8]), "-items.|_")[2], ";")[1])
end

function loopThis()
    println("Thread started")
    while true
        try
            cookie = createAccount()
            write(results, string(cookie, "\n"))
            global count = count + 1
        catch
            continue
        end
    end
end

for _ in 1:10
    @async loopThis()
end

global prevCount = -1
while true
    if prevCount != count
        println(count)
        global prevCount = count
    end
    sleep(1)
end
