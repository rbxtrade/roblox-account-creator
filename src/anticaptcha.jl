module Anticaptcha
    using HTTP, JSON

    function createTask(data::String)
        response = HTTP.request("POST", "https://api.anti-captcha.com/createTask", [
            "Content-Type" => "application/json"
        ], JSON.json(Dict(
            "clientKey" => "",
            "task" => Dict(
                "type" => "FunCaptchaTaskProxyless",
                "websiteURL" => "https://www.roblox.com/",
                "funcaptchaApiJSSubdomain" => "roblox-api.arkoselabs.com",
                "data" => string("{\"blob\":\"", data, "\"}"),
                "websitePublicKey" => "A2A14B1D-1AF3-C791-9BBC-EE33CC7A0A6F"
            )
        )))
        body = JSON.parse(String(response.body))
        return body["taskId"]
    end

    function getTaskResult(taskId)
        response = HTTP.request("POST", "https://api.anti-captcha.com/getTaskResult", [
            "Content-Type" => "application/json"
        ], JSON.json(Dict(
            "clientKey" => "",
            "taskId" => taskId
        )))
        body = JSON.parse(String(response.body))
        if body["errorId"] === 0 && body["status"] === "ready"
            return body["solution"]["token"]
        end
        return false
    end
end