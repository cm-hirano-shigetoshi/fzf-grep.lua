local socket = require('socket')


function get_available_port()
    local server = assert(socket.bind('*', 0))
    local _, port = server:getsockname(); server:close()
    return port
end

function split(str, sep)
    local result = {}
    local start = 1
    local seplen = string.len(sep)

    while true do
        local endpos = string.find(str, sep, start, true) -- 区切り文字の位置を探す
        if not endpos then                                -- 区切り文字がない場合
            table.insert(result, string.sub(str, start))  -- 残りの文字列を追加
            break
        end
        local part = string.sub(str, start, endpos - 1) -- 区切り文字の前の部分文字列
        table.insert(result, part)                      -- テーブルに追加
        start = endpos + seplen                         -- 次の検索開始位置を更新
    end

    return result
end
