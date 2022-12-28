local function buf_set_keymaps(bufnr)
    local function buf_set_keymap(mode, lhs, rhs)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true})
    end

    local function format(client)
        vim.api.nvim_echo({ { ("Formatting with %s..."):format(client.name) } }, false, {})
        vim.lsp.buf.format { id = client.id }
    end

    buf_set_keymap("n", "<leader>p", function()
        local candidates = vim.tbl_filter(function(client)
            return client.name ~= "sumneko_lua" and client.supports_method "textDocument/formatting"
        end, vim.lsp.get_active_clients { bufnr = vim.api.nvim_get_current_buf() })

        if #candidates > 1 then
            vim.ui.select(candidates, {
                prompt = "Client",
                format_item = function(client)
                    return client.name
                end,
            }, function(client)
                if client then
                    format(client)
                end
            end)
        elseif #candidates == 1 then
            format(candidates[1])
        else
            vim.api.nvim_echo(
                { { "No clients that support textDocument/formatting are attached.", "WarningMsg" } },
                false,
                {}
            )
        end
    end)

    -- Code actions
    buf_set_keymap("n", "<leader>r", vim.lsp.buf.rename)
    buf_set_keymap("n", "<leader>f", format)
    buf_set_keymap("n", "<space>f", vim.lsp.buf.code_action)

    -- Movement
    buf_set_keymap("n", "gD", vim.lsp.buf.type_definition)
    buf_set_keymap("n", "gd", vim.lsp.buf.definition)
    buf_set_keymap("n", "gr", vim.lsp.buf.references)
    buf_set_keymap("n", "gi", vim.lsp.buf.implementation)

    -- Docs
    buf_set_keymap("n", "K", vim.lsp.buf.hover)
    buf_set_keymap("n", "<C-k>", vim.lsp.buf.signature_help)

end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)

        if client.server_capabilities.completionProvider then
            vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"
        end
        if client.server_capabilities.definitionProvider then
            vim.bo[bufnr].tagfunc = "v:lua.vim.lsp.tagfunc"
        end

        buf_set_keymaps(bufnr)
    end,
})
