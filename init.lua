vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.hlsearch = false
vim.o.mouse = ""
vim.o.guicursor = ""
vim.o.completeopt = "menu,menuone,popup,fuzzy,noinsert,noselect"

vim.g.netrw_banner = 0

vim.pack.add({
    "https://github.com/navarasu/onedark.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/nvim-telescope/telescope.nvim",
    "https://github.com/nvim-treesitter/nvim-treesitter",
    "https://github.com/neovim/nvim-lspconfig",
})

require("onedark").setup({ style = "dark" })
require("onedark").load()

require("telescope").setup({
    defaults = require("telescope.themes").get_ivy({
        layout_config = { height = 0.30 },
    }),
})

vim.keymap.set('n', '<C-p>', require('telescope.builtin').git_files, { noremap = true })

require("nvim-treesitter").install({ "odin", "cpp" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lua", "odin", "c", "cpp" },
    callback = function() vim.treesitter.start() end,
})

vim.lsp.enable("ols")
vim.lsp.enable("clangd")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { noremap = true })
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { noremap = true })

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end,
})
