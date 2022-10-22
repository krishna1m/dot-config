local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

-- Only required if you have packer configured as `opt`
cmd [[packadd packer.nvim]]

-- Autocommand that reloads neovim whenever you save the plugins.lua file
cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


-- Add your plugins here
return require('packer').startup(function(use)
  -- Packer can manage itself
  use({ "wbthomason/packer.nvim", opt = true })

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/vim-vsnip" },
    },
  })
  use({
    "scalameta/nvim-metals",
    requires = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
  })

  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  use {'nvim-treesitter/nvim-treesitter'}

  use {'ThePrimeagen/harpoon'}

  -- Automatically set up your config after cloning packer.vim
  -- Put this at the end of all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
