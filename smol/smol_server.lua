local class = require 'middleclass'
local SmolObject = require 'smol_object'

SmolServer = SmolObject:subclass('SmolServer')
function SmolServer:initialize()
    SmolObject.initialize(self)
    self.subscribers = {}
end

function SmolServer:request_sub(object, callback)
    self.subscribers[object] = callback
end

function SmolServer:request_unsub(object)
    self.subscribers[object] = nil
end

function SmolServer:run(...)
    for object, callback in pairs(self.subscribers) do
        callback(...)
    end
end

return SmolServer