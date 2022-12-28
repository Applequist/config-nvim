require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "rust_analyzer", "tsserver", "ocamllsp" }
})

require("mason-lspconfig").setup_handlers({
    -- the first entry will be the default handler
    -- and will be called for each installed server  that doesn't have
    -- a dedicated handler.
    function (server_name)
        require("lspconfig")[server_name].setup {}
    end,
    ["rust_analyzer"] = function()
        require("rust-tools").setup {
            tools = {
                inlay_hints = { auto = false },
                executor = require("rust-tools/executors").toggleterm,
                hover_actions = { border = "solid" },
            },
            dap = {
                adapter = require("rust-tools.dap").get_codelldb_adapter(
                    "codelldb",
                    require("mason-registry").get_package("codelldb"):get_install_path()
                        .. "/extension/lldb/lib/liblldb.dylib"
                ),
            },
        }
    end,
    ["tsserver"] = function()
        require("typescript").setup {
            server = {
                settings = {
                    typescript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                    javascript = {
                        inlayHints = {
                            includeInlayParameterNameHints = "all",
                            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                            includeInlayFunctionParameterTypeHints = true,
                            includeInlayVariableTypeHints = true,
                            includeInlayPropertyDeclarationTypeHints = true,
                            includeInlayFunctionLikeReturnTypeHints = true,
                            includeInlayEnumMemberValueHints = true,
                        },
                    },
                },
            },
        }
    end,
})
