print("Configuring plugins...")

local install_path = ("%s/site/pack/packer-lib/opt/packer.nvim"):format(vim.fn.stdpath "data")

local function install_packer()
    vim.fn.termopen(("git clone https://github.com/wbthomason/packer.nvim %q"):format(install_path))
end

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    install_packer()
end

vim.cmd.packadd { "packer.nvim" }

function _G.packer_upgrade()
    vim.fn.delete(install_path, "rf")
    install_packer()
end

vim.cmd.command { "PackerUpgrade", ":call v:lua.packer_upgrade()", bang = true }

local function spec(use)

    use { "lewis6991/impatient.nvim" }

    -- Colorschemes
    use { 
        "folke/tokyonight.nvim",
        "shaunsingh/nord.nvim",
        "rmehri01/onenord.nvim",
        "jacoborus/tender.vim",
    }

    -- Things that enhance builtin behaviours or could easily be candidates for default behaviour
    use {
        "antoinemadec/FixCursorHold.nvim",
        "nvim-lualine/lualine.nvim",
        {
            "editorconfig/editorconfig-vim",
            setup = function()
                vim.g.EditorConfig_max_line_indicator = ""
                vim.g.EditorConfig_preserve_formatoptions = 1
            end,
        },
        "akinsho/toggleterm.nvim",
    }

    -- Autocompletion framework
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "neovim/nvim-lspconfig",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "saadparwaiz1/cmp_luasnip", 
            {
                "L3MON4D3/LuaSnip",
                requires = { "rafamadriz/friendly-snippets" },
            },
        },
    }

    -- Treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate",
        requires = {
            "nvim-treesitter/playground",
            "nvim-treesitter/nvim-treesitter-textobjects"
        }
    }

    -- Debugging and tests
    use {
        {
            "nvim-neotest/neotest",
            requires = {
                "haydenmeade/neotest-jest",
                "rouge8/neotest-rust",
                "nvim-neotest/neotest-plenary",
            },
        },
        "mfussenegger/nvim-dap",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
        { "williamboman/nvim-dap-vscode-js", branch = "feat/debug-cmd" },
        "jbyuki/one-small-step-for-vimkind",
    }

    -- Mason
    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    }

    -- LSP
    use {
        "simrat39/rust-tools.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jose-elias-alvarez/typescript.nvim"
    }

end

require("packer").startup {
    spec, 
    config = {
        display = {
            open_fn = require("packer.util").float,
        },
        max_jobs = vim.fn.has "win32" == 1 and 5 or nil,
    },
}

