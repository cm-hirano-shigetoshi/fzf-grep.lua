local socket = require('socket')


function get_available_port()
    local server = assert(socket.bind('*', 0))
    local _, port = server:getsockname(); server:close()
    return port
end
