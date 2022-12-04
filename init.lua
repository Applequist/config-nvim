if not pcall(require, "impatient") then
    print "Failed to load impation."
end

vim.g.nvcode_termcolors = 256
vim.g.mapleader = " "
vim.o.termguicolors = true

require("applequist.plugins")
