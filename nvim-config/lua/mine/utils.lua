function goimports(timeoutms)
    local context = { source = { organizeImports = true } }
    vim.validate({ context = { context, "t", true } })

    local params = vim.lsp.util.make_range_params()
    params.context = context

    -- See the implementation of the textDocument/codeAction callback
    -- (lua/vim/lsp/handler.lua) for how to do this properly.
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
    if not result or next(result) == nil then
        return
    end
    local actions = result[1].result
    if not actions then
        return
    end
    local action = actions[1]

    -- get offset encoding from client

    local offset_encoding = "utf-8"
    for _, c in pairs(vim.lsp.buf_get_clients()) do
        if c["name"] == "gopls" then
            offset_encoding = c["offset_encoding"]
        end
    end
    -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
    -- is a CodeAction, it can have either an edit, a command or both. Edits
    -- should be executed first.
    if action.edit or type(action.command) == "table" then
        -- apply organise imports edits
        if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, offset_encoding)
        end
        --  skip fixes for now
        --  print(dump(action.command))
        --if action.command or type(action.command) == "table" then
        --  vim.lsp.buf.execute_command(action.command)
        --end
    else
        vim.lsp.buf.execute_command(action)
    end
end

function dump(o)
    if type(o) == "table" then
        local s = "{ "
        for k, v in pairs(o) do
            if type(k) ~= "number" then
                k = '"' .. k .. '"'
            end
            s = s .. "[" .. k .. "] = " .. dump(v) .. ","
        end
        return s .. "} "
    else
        return tostring(o)
    end
end

function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end
