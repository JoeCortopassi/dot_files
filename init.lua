-- Packer setup
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print 'Installing packer close and reopen Neovim...'
  vim.cmd [[packadd packer.nvim]]
end

local packer = require('packer')

packer.startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- LSP Support
  use {'williamboman/mason.nvim'}
  use {'williamboman/mason-lspconfig.nvim'}
  use {'neovim/nvim-lspconfig'}
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      {'hrsh7th/cmp-nvim-lsp'},
      {'saadparwaiz1/cmp_luasnip'},
      {'L3MON4D3/LuaSnip'},
      {'hrsh7th/cmp-buffer'}, -- buffer completions
      {'hrsh7th/cmp-path'}, -- path completions
      {'hrsh7th/cmp-cmdline'}, -- cmdline completions
    }
  }

  -- Telescope (Ctrl+p fuzzy finder)
  use {'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} }}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- improve telescope performance

  -- Treesitter (Improved syntax highlighting)
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  -- Prettier
  use 'prettier/vim-prettier'

  -- Add gopls
  use {'golang/tools', run = 'go install golang.org/x/tools/gopls@latest'}

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

-- Set tab options (Place this block here)
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.cursorline = true

-- LSP Configuration
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "gopls" }, -- Ensure gopls and ts_ls are installed.
  automatic_installation = true,
})

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use ts_ls
lspconfig.ts_ls.setup { capabilities = capabilities }
lspconfig.gopls.setup { capabilities = capabilities }

-- Telescope Configuration
require('telescope').setup{
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
-- map ctrl+p
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>')

-- Treesitter Configuration
require'nvim-treesitter.configs'.setup {
  ensure_installed = {"javascript", "typescript", "tsx", "go"},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
}

-- Completion Configuration (nvim-cmp)
local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm { select = true },
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
})

-- Prettier Configuration
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.{js,jsx,ts,tsx}",
  callback = function()
    vim.cmd("Prettier")
  end,
})
