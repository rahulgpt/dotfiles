return {
	"tpope/vim-fugitive",
	event = "BufWinEnter",
	config = function()
		vim.keymap.set("n", "<leader>o", "<Cmd>Gvdiffsplit<CR>", { desc = "Toggle Git Diff" })
	end,
}
