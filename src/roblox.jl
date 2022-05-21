module Roblox
    import HTTP, JSON

    function getToken(proxy)
        response = HTTP.request("GET", "https://www.roblox.com/"; proxy=string("http://", proxy))
        body = String(response.body)
        return split(split(body, "data-token=\"")[2], "\"")[1]
    end

    function generateBirthday()
        # I'm lazy asf
        return "10 Aug 2004"
    end

    function register(username, proxy)
        response = HTTP.request("POST", "https://auth.roblox.com/v2/signup", [
            "user-agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36",
            "x-csrf-token" => getToken(proxy),
            "Content-Type" => "application/json",
            "origin" => "http://www.roblox.com",
            "referer" => "http://www.roblox.com/"
        ], JSON.json(Dict(
            "agreementIds" => ["848d8d8f-0e33-4176-bcd9-aa4e22ae7905", "54d8a8f0-d9c8-4cf3-bd26-0cbf8af0bba3"],
            "birthday" => generateBirthday(),
            "context" => "MultiverseSignupForm",
            "gender" => 2,
            "isTosAgreementBoxChecked" => true,
            "password" => "jdhgkjshgdfg",
            "referralData" => nothing,
            "username" => username
        )); proxy=string("http://", proxy))
        return response
    end

    function registerWithCaptcha(captchaId, token, username, proxy)
        response = HTTP.request("POST", "https://auth.roblox.com/v2/signup", [
            "user-agent" => "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36",
            "x-csrf-token" => getToken(proxy),
            "Content-Type" => "application/json",
            "origin" => "http://www.roblox.com",
            "referer" => "http://www.roblox.com/"
        ], JSON.json(Dict(
            "agreementIds" => ["848d8d8f-0e33-4176-bcd9-aa4e22ae7905", "54d8a8f0-d9c8-4cf3-bd26-0cbf8af0bba3"],
            "birthday" => generateBirthday(),
            "captchaId" => captchaId,
            "captchaToken" => token,
            "context" => "MultiverseSignupForm",
            "gender" => 2,
            "isTosAgreementBoxChecked" => true,
            "password" => "jdhgkjshgdfg",
            "referralData" => nothing,
            "username" => username
        )); proxy=string("http://", proxy))
        return response
    end
end