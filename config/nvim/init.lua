

-- Opciones básicas (equivalente a tu init.vim)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.syntax = "enable"
vim.opt.showcmd = true
vim.opt.encoding = "utf-8"
vim.opt.showmatch = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.autoindent = true
vim.opt.smarttab = true

-- =============================================
-- Plugins con Lazy.nvim
-- =============================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Plugins
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" } },
  { "navarasu/onedark.nvim" },
  { "catppuccin/nvim", name = "catppuccin" },
})

-- =============================================
-- Configuración de plugins
-- =============================================

-- Onedark (tema principal que tenías)
require('onedark').setup {
  style = "dark",
  transparent = true,
}
require('onedark').load()

-- Lualine
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',        -- mejor que 'material' para combinar con onedark
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
  }
}

-- Opcional: también puedes usar Catppuccin si prefieres
-- vim.cmd.colorscheme "catppuccin"

