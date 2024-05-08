-- Theme
vim.opt.termguicolors = true

require("onedark").setup {
  style = "darker",
  transparent = true,
  term_colors = false,
}
require("onedark").load()


-- Indent lines


-- Treesitter
require'nvim-treesitter.configs'.setup {
  auto_install = false,

  highlight = {
    enable = true,
  },
}


-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>s", builtin.find_files, {})
