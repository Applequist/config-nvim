print("after/plugin/globals.lua")

-- Set the <Leader> to <Space>
vim.g.mapleader = " "

-- SEARCH OPTIONS

-- When there is a previous search patterns, highlight all
-- its matches (if true).
-- When you get bored looking at the highlighted matches
-- you can turn them off with ':nohlsearch'
-- Default: on
vim.g.hlsearch = false


-- Ignore case in search patterns.
-- Default: off
vim.g.ignorecase = true

-- Override 'ignorecase' option if search pattern contains
-- uppercase characters
-- Default: off
vim.g.smartcase = true

-- How case is handled when searching the tags
-- Values:
-- "followic"   Follow 'ignorecase' option
-- "followscs"  Follow 'smartcase' and 'ignorecase'
-- "ignore"
-- "match"
-- "smart" Ignore unless an upper case letter is used
-- Default: "followic"
vim.g.tagcase = "followscs"

-- Scrolloff
-- Minimal number of screen lines to keep above or
-- below the cursor. Eg keep some context around cursor line.
vim.g.scrolloff = 8

