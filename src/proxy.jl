module Proxy
    global proxies = String[]
    global proxyCount = 0

    for line in eachline(open("./proxies.txt"))
        push!(proxies, line)
    end

    function get()
        if proxyCount <= length(proxies) - 1
            proxyCount += 1
            return proxies[proxyCount]
        end

        global proxyCount = 1
        return proxies[proxyCount]
    end
end