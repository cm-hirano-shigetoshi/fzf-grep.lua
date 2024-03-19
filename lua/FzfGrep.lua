local M = {}
require("FzfExecute")
require("InternalServer")
require("MyUtils")

local function call(query)
    -- ポートを確定させる
    vim.cmd("let $FZF_PORT = " .. get_available_port())
    vim.cmd("let $SERVER_PORT = " .. get_available_port())

    -- serverインスタンスを作成
    local server = InternalServer.new()

    -- fzfのプロセスを開始
    local fzf = FzfExecute.new()
    fzf:start_async(server)

    -- serverを起動する
    server:start()
end

M.run = function(query)
    call(query)
end

return M
