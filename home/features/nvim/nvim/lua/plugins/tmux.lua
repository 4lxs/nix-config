vim.g.tmux_navigator_disable_when_zoomed = 1

return {
  {
    'christoomey/vim-tmux-navigator',
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>", desc = "Go to left window" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>", desc = "Go to lower window" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>", desc = "Go to upper window" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>", desc = "Go to right window" },
    },
  },
  {
    'vimpostor/vim-tpipeline',
    dependencies = {
      'nvim-lualine/lualine.nvim' -- lualine reenables laststatus
    },
    init = function()
      vim.g.tpipeline_autoembed = 0
      vim.opt.laststatus = 0
    end
  },
}
