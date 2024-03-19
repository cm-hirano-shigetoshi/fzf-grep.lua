InternalServer = {}
InternalServer.__index = InternalServer

PYTHON = "python"
PLUGIN_DIR = debug.getinfo(1).source:sub(2):match('^(.*)/lua/[^/]+$')


function InternalServer.new()
    local self = setmetatable({}, InternalServer)
    self.pid = nil
    return self
end

function InternalServer:start()
    _, self.pid = vim.loop.spawn(PYTHON, {
        args = { PLUGIN_DIR .. "/python/server.py" }
    }, function()
    end)
end

function InternalServer:stop()
    os.execute("kill " .. self.pid)
end
