print("after/plugin/options.lua")

-- Display line number
vim.opt.number = true
-- Use relative line number though
vim.opt.relativenumber = true

-- Minimal number of columns to use for the line number.
vim.opt.numberwidth = 5

-- When and how to draw the signcolumn
vim.opt.signcolumn = "yes"

-- Indentation
-- Number of spaces that a <Tab> in the file count for.
vim.opt.tabstop = 4
-- Number of spaces that a <Tab> counts for while performing editing operations.
vim.opt.softtabstop = 4
-- Effective value of 'shiftwidth'
vim.opt.shiftwidth = 4
-- In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
vim.opt.expandtab = true
-- Do smart indenting when starting a new line. 
-- Normally 'autoindent' (default on) should be on when using 'smartindent'
vim.opt.smartindent = true

-- Highlight the text line of the cursor with CursorLine hl-CursorLine.
vim.opt.cursorline = true
-- Comma-separated list of settings for how 'cursorline' is displayed.
-- Valid values:
-- "line"       Highlight the text line of the cursor with CursorLine hl-CursorLine
-- "screenline" Highlight only the screen line of the cursor with CursorLine hl-CursorLine
-- "number"     Highlight the line number of the cursor with CursorLineNr hl-CursorLineNr
-- Special values:
-- "both"       Alias for "line,number"
vim.opt.cursorlineopt = "both"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

-- Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there is only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not auto-select, nvim-cmp plugin will handle this for us.
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }

