local class = require 'middleclass'

local SmolObject = class('SmolObject')
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

function SmolObject:unsubscribe_all()
    for server, _ in pairs(self.subscriptions) do
        self:unsubscribe(server)
    end
end

return SmolObject