return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	ft = { "markdown", "mdx" },
	init = function()
		-- nvim doesn't detect .mdx out of the box
		vim.filetype.add({ extension = { mdx = "mdx" } })
	end,
	config = function()
		-- .mdx has no parser of its own, so parse it as markdown
		vim.treesitter.language.register("markdown", "mdx")

		require("render-markdown").setup({
			file_types = { "markdown", "mdx" },
			-- show raw markdown on the cursor line so editing still works
			anti_conceal = { enabled = true },
			latex = { enabled = false },
		})

		vim.keymap.set("n", "<leader>mr", "<cmd>RenderMarkdown toggle<CR>", {
			desc = "Toggle Markdown Render",
			silent = true,
		})
	end,
}
