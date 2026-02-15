-- vim.o.softtabstop = 4
-- vim.o.shiftwidth = 4
-- vim.o.expandtab = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.hlsearch = false
vim.o.mouse = ""
vim.o.guicursor = ""
vim.o.completeopt = "menu,menuone,popup,fuzzy,noinsert,noselect"

vim.g.netrw_banner = 0

vim.api.nvim_create_autocmd("Colorscheme", {
	callback = function(ev)
		vim.api.nvim_set_hl(0, "Normal", {})
		vim.api.nvim_set_hl(0, "Comment", { fg = "forestgreen" })
		vim.api.nvim_set_hl(0, "Constant", { fg = "mediumblue" })
	end
})

vim.cmd.colorscheme("quiet")

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, { autotrigger = true })
    end,
})

vim.lsp.enable('ols')
