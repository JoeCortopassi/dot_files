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
  -- TODO: Pin this! Run `git -C <install_path> rev-parse HEAD`
  use {'wbthomason/packer.nvim', commit = '...'}

  -- Colorscheme (Treesitter-aware)

  -- Catppuccin
  -- use {
  --   'catppuccin/nvim',
  --   as = 'catppuccin',
  --   commit = '...' -- TODO: Pin this
  -- }

  use {
    'miikanissi/modus-themes.nvim',
    commit = '...' -- TODO: Pin this
  }


  -- LSP Support
  -- TODO: Pin all plugins below!
  use {'williamboman/mason.nvim', commit = '...'}
  use {'williamboman/mason-lspconfig.nvim', commit = '...'}
  use {'neovim/nvim-lspconfig', commit = '...'}
  use {
    'hrsh7th/nvim-cmp',
    commit = '...',
    requires = {
      {'hrsh7th/cmp-nvim-lsp', commit = '...'},
      {'saadparwaiz1/cmp_luasnip', commit = '...'},
      {'L3MON4D3/LuaSnip', commit = '...'},
      {'hrsh7th/cmp-buffer', commit = '...'},
      {'hrsh7th/cmp-path', commit = '...'},
      {'hrsh7th/cmp-cmdline', commit = '...'},
    }
  }

  -- Telescope (Ctrl+p fuzzy finder)
  use {'nvim-telescope/telescope.nvim', commit = '...', requires = { {'nvim-lua/plenary.nvim', commit = '...'} }}
  -- Pinning this is critical as it secures the `run = 'make'` hook
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit = '...'} 

  -- Treesitter (Improved syntax highlighting)
  -- Pinning this is critical as it secures the `run = ':TSUpdate'` hook
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', commit = '...'}

  -- Prettier
  --use 'prettier/vim-prettier'

  -- Add gopls
  -- NOTE: This is redundant. Mason (below) is already installing 'gopls'.
  -- use {'golang/tools', run = 'go install golang.org/x/tools/gopls@latest'}

  -- ========== Ruby/Rails Additions ==========
  -- TODO: Pin all plugins below!
  use {'tpope/vim-rails', commit = '...'}
  use {'vim-ruby/vim-ruby', commit = '...'}
  use {'tpope/vim-endwise', commit = '...'}
  use {'tpope/vim-commentary', commit = '...'}
  -- ==========================================

  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)

-- Set tab options
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.cmd("filetype plugin indent on")

-- Enable the colorscheme
-- This must go *after* packer setup but *before* other plugin configs
-- Catppuccin Configuration
-- require("catppuccin").setup({
--     flavour = "mocha", -- latte, frappe, macchiato, mocha
-- })
-- vim.cmd [[colorscheme catppuccin]]
-- Default options
require("modus-themes").setup({
	-- Theme comes in two styles `modus_operandi` and `modus_vivendi`
	-- `auto` will automatically set style based on background set with vim.o.background
	style = "auto",
	variant = "tritanopia", -- Theme comes in four variants `default`, `tinted`, `deuteranopia`, and `tritanopia`
	transparent = true, -- Transparent background (as supported by the terminal)
  on_colors = function(colors)
    colors.comment = "#656565" --colors.fg_dim
  end,
})
vim.cmd [[colorscheme modus_vivendi]]

-- LSP Configuration
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { 
    "ts_ls", 
    "gopls",
    -- "solargraph", -- Ruby LSP
    "ruby_lsp"    -- Newer Ruby LSP
  },
  -- SAFER: Disabled automatic installation.
  -- You must now run :MasonInstallAll or :MasonInstall <lsp> manually.
  automatic_installation = false,
})

local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Use ts_ls
lspconfig.ts_ls.setup { capabilities = capabilities }
-- Use gopls
lspconfig.gopls.setup { capabilities = capabilities }
-- Use solargraph (Ruby)
--lspconfig.solargraph.setup { capabilities = capabilities }
-- Use ruby-lsp (Newer Ruby LSP)
lspconfig.ruby_lsp.setup { capabilities = capabilities }


-- Telescope Configuration
require('telescope').setup{
  defaults = {
    file_ignore_patterns = { "node_modules", "vendor" }, -- Added vendor for Rails
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
  ensure_installed = {
    "javascript", 
    "typescript", 
    "tsx", 
    "go", 
    "lua",
    "vim",
    -- === Ruby/Rails Additions ===
    "ruby",
    "embedded_template", -- For ERB
    "yaml",              -- For config/database.yml, etc.
    "json",
    "css",
    "scss",              -- For assets
    "bash",              -- For scripts
    "sql",
    -- ============================
    "html",
  },
  sync_install = false,
  -- SAFER: Disabled automatic installation.
  -- You must now run :TSInstall <parser> manually when needed.
  auto_install = false, 
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = false},
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
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.{js,jsx,ts,tsx}",
--   callback
