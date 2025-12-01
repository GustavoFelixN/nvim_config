vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.api.nvim_set_hl(0, "IncSearch", { bg = "#3d1091", fg = "#ffffff" })

-- ========== Options ==========
local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.breakindent = true
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.updatetime = 250
opt.timeoutlen = 300
opt.splitright = true
opt.splitbelow = true
opt.list = true
opt.listchars = { tab = "» ", trail = ".", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.softtabstop = 4
