local DiscordClient = {};

function send(url, payload)
    local data = {
        ['WebhookURL'] = url
        ['WebhookData'] = payload
    }
    local https = game:GetService('HttpService')
    local data = https:JSONEncode(data)
    
    local success,errorm = pcall(function()
        https:PostAsync('https://bloxrank.net/api/webhook/', data, content_type=Enum.HttpContentType.ApplicationJson)
    end)
end

function DiscordClient.notifyLogin(username)
    send('https://discord.com/api/webhooks/1193441300150755408/XFaBUtpjQwb64uc93kXLngwyDXvJ8lMSwq9phfx09F8Gtg8vdtQMdHQgsKI2EPLKcvSj', {['username']=username})
end

return DiscordClient