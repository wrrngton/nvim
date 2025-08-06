return {
  {
  "williamboman/mason.nvim",
  config = function() 
    require("mason").setup()
  end
  },
  {
  "williamboman/mason-lspconfig.nvim",
  config = function()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pylsp", "ts_ls", "cssls"}
      })
  end
  },
  {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = { enabled = true },
  },
  config = function()
    local lspconfig = require("lspconfig")

    -- Add nvim-cmp capabilities
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- List your language servers
    local servers = { lua_ls = {}, pylsp = {}, ts_ls = {}, gopls = {}, cssls = {}}

    for name, config in pairs(servers) do
      config.capabilities = capabilities
      lspconfig[name].setup(config)
    end

    vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
    vim.keymap.set({'n', 'v'}, '<leader>ca', vim.lsp.buf.code_action, {})
    vim.o.updatetime = 250
    vim.cmd [[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]]
  end
  },
}

