vim.lsp.config('nixd', {
	cmd = { 'nixd' },
	filetypes = { 'nix' },
	root_markers = { 'flake.nix', '.git' },
	settings = {
		nixd = {
			nixpkgs = {
				expr = 'import (builtins.getFlake "/home/mtugb/.config/home-manager").inputs.nixpkgs { }',
			},
			options = {
				['home-manager'] = {
					expr =
					'(builtins.getFlake "/home/mtugb/.config/home-manager").homeConfigurations."mtugb".options',
				},
			},
			formatting = { command = { 'nixfmt' } },
		},
	},
})
vim.lsp.enable('nixd')

vim.lsp.config('lua_ls', {
	cmd = { 'lua-language-server' },
	filetypes = { 'lua' },
	root_markers = { '.luarc.json', '.git' },
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT' },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
			format = {
				enable = true,
				defaultConfig = {
					indent_style = 'space',
					indent_size = '2', -- 数値ではなく文字列で書く
				},
			},
		},
	},
})
vim.lsp.enable('lua_ls')


-- エラーや警告を行末に表示する（0.11から既定でオフになった）
vim.diagnostic.config({ virtual_text = true })

-- LSPが繋がったバッファで、入力中に自動で補完候補を出す
vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client and client:supports_method('textDocument/completion') then
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

-- 自分用キーバインド設定
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { desc = 'LSPで整形' })
