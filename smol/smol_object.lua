local class = require 'middleclass'

SmolObject = class('SmolObject')
function SmolObject:initialize()
  self.subscriptions = {}
end

function SmolObject:subscribe(server, callback)
    server:request_sub(self, function(...) callback(...) end)
    self.subscriptions[server] = true
end

function SmolObject:unsubscribe(server)
    server:request_unsub(self)
    self.subscriptions[server] = nil
end

return SmolObject