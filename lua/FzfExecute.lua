local fzf = require("fzf")
FzfExecute = {}
FzfExecute.__index = FzfExecute

require("fzf").default_options = {
    window_on_create = function()
        vim.cmd("set winhl=Normal:Normal")
    end
}

BIND_KEYS = { "alt-u" }

local function get_initial_fzf_options(fzf_port)
    return {
        "--listen", fzf_port,
        "--ansi",
        "--multi",
        "--delimiter", ":",
        "--bind", "'enter:become(echo +{2} {1})'",
        "--reverse",
    }
end

local function get_bind_options(server_port, bind_keys)
    local options = {}
    for _, key in ipairs(bind_keys) do
        table.insert(options, "--bind")
        table.insert(options, string.format("'%s:execute-silent:curl \"localhost:%d?bind=%s\"'", key, server_port, key))
    end
    return options
end

function FzfExecute.new()
    local self = setmetatable({}, FzfExecute)
    return self
end

function FzfExecute:start_async(server)
    local base_options = get_initial_fzf_options(os.getenv("FZF_PORT"))
    local bind_options = get_bind_options(os.getenv("SERVER_PORT"), BIND_KEYS)
    local option = table.concat(base_options, " ") .. " " .. table.concat(bind_options, " ")
    coroutine.wrap(function(server_, option_)
        local results = fzf.fzf(":", option_)
        for _, result in ipairs(results) do
            vim.cmd("e " .. result)
        end
        server_:stop()
    end)(server, option)
end
