

local configure = function ()

   require('mason').setup()
   require('mason-lspconfig').setup()
   local utils = require("custom.utils")

   local servers = {
      pyright = {},
      rust_analyzer = {},
      nil_ls = {},
      clangd = {},

      lua_ls = {
	 Lua = {
	    workspace = { checkThirdParty = false },
	    telemetry = { enable = false },
	 },
      },
   }

   local on_attach = function(_, bufnr)

      local nmap = function(keys, func, desc)
	 if desc then
	    desc = 'LSP: ' .. desc
	 end

	 vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>lR', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>la', function()
	 vim.lsp.buf.code_action { context = { only = { 'quickfix', 'refactor', 'source' } } }
      end, '[C]ode [A]ction')

      nmap('<leader>ld', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('<leader>lr', utils.make_ivy_function("lsp_references"), '[G]oto [R]eferences')
      nmap('<leader>li', utils.make_ivy_function("lsp_implementations"), '[G]oto [I]mplementation')
      nmap('<leader>D', utils.make_ivy_function("lsp_type_definitions"), 'Type [D]efinition')
      nmap('<leader>ds', utils.make_ivy_function("lsp_document_symbols"), '[D]ocument [S]ymbols')

      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
	 vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

   end

-- Setup neovim lua configuration
   require('neodev').setup()

   local capabilities = vim.lsp.protocol.make_client_capabilities()
   capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

   local mason_lspconfig = require 'mason-lspconfig'

   -- mason_lspconfig.setup {
   --    ensure_installed = vim.tbl_keys(servers),
   -- }

   mason_lspconfig.setup_handlers {
      function(server_name)
	 require('lspconfig')[server_name].setup {
	    capabilities = capabilities,
	    on_attach = on_attach,
	    settings = servers[server_name],
	    filetypes = (servers[server_name] or {}).filetypes,
	 }
      end,
   }

   vim.keymap.set('n', '<leader>lp', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
   vim.keymap.set('n', '<leader>ln', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
   vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
   vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
end

return {
   -- LSP Configuration & Plugins
   'neovim/nvim-lspconfig',
   dependencies = {
     -- Automatically install LSPs to stdpath for neovim
     { 'williamboman/mason.nvim', config = true },
     'williamboman/mason-lspconfig.nvim',

     -- Useful status updates for LSP
     -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
     { 'j-hui/fidget.nvim', opts = {} },

     -- Additional lua configuration, makes nvim stuff amazing!
     'folke/neodev.nvim',
   },
   config = configure
}
