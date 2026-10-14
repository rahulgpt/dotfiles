return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = "cd app && npm install",
	config = function()
		-- Set configuration options
		vim.g.mkdp_auto_start = 0 -- Don't auto-start preview when opening markdown files
		vim.g.mkdp_auto_close = 1 -- Auto-close preview when switching away from markdown buffer
		vim.g.mkdp_refresh_slow = 0 -- Auto refresh on save or leave insert mode
		vim.g.mkdp_command_for_global = 0 -- Only available for markdown files
		vim.g.mkdp_open_to_the_world = 0 -- Only accessible from localhost
		vim.g.mkdp_browser = "" -- Use default browser
		vim.g.mkdp_preview_options = {
			mkit = {},
			katex = {},
			uml = {},
			maid = {},
			disable_sync_scroll = 0,
			sync_scroll_type = "middle",
			hide_yaml_meta = 1,
			sequence_diagrams = {},
			flowchart_diagrams = {},
			content_editable = false,
			disable_filename = 0,
			toc = {},
		}

		-- Set keymaps for markdown preview
		vim.keymap.set("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", {
			desc = "Toggle Markdown Preview",
			silent = true,
		})
	end,
}

