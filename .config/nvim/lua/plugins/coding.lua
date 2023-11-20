--
--░█▀▀░█▀█░█▀▄░▀█▀░█▀█░█▀▀░░░░█░░░█░█░█▀█
--░█░░░█░█░█░█░░█░░█░█░█░█░░░░█░░░█░█░█▀█
--░▀▀▀░▀▀▀░▀▀░░▀▀▀░▀░▀░▀▀▀░▀░░▀▀▀░▀▀▀░▀░▀
--
return {

	{
		-- A completion engine plugin for neovim written in Lua
		"hrsh7th/nvim-cmp",
		opts = function()
			local cmp = require("cmp")
			local cmp_window = require("cmp.config.window")
			cmp.setup({
				window = {
					completion = cmp_window.bordered(),
					documentation = cmp_window.bordered(),
				},
			})

			vim.opt.pumblend = 0 -- Transparence on nvim-cmp windows
		end,
		dependencies = {
			{ "onsails/lspkind.nvim" }, -- Fancy icons to cmp
		},
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = { "hrsh7th/cmp-emoji" },
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			table.insert(opts.sources, { name = "emoji" })
		end,
	},
	-- Use <tab> for completion and snippets (supertab)
	-- first: disable default <tab> and <s-tab> behavior in LuaSnip
	{
		"L3MON4D3/LuaSnip",
		keys = function()
			return {}
		end,
	},
	-- then: setup supertab in cmp
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-emoji",
		},
		---@param opts cmp.ConfigSchema
		opts = function(_, opts)
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")

			opts.mapping = vim.tbl_extend("force", opts.mapping, {
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					-- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
					-- this way you will only jump inside the snippet region
					elseif luasnip.expand_or_jumpable() then
						luasnip.expand_or_jump()
					elseif has_words_before() then
						cmp.complete()
					else
						fallback()
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			})
		end,
	},

	{
		-- Treesitter configurations and abstraction layer for Neovim.
		"nvim-treesitter/nvim-treesitter",
		keys = {
			{ "<C-Space>", false, mode = { "n" } },
		},
		opts = {
			ensure_installed = {
				"bash",
				"c",
				"html",
				"org",
				"latex",
				"javascript",
				"json",
				"lua",
				"markdown",
				"markdown_inline",
				"python",
				"query",
				"regex",
				"tsx",
				"typescript",
				"vim",
				"yaml",
			},
			incremental_selection = {
				enable = false,
			},
		},
	},
}
