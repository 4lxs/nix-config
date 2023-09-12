return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    -- stylua: ignore
    keys = {
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon add", },
      { "<leader>A", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon add", },
      { "<s-h>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon mark 1", },
      { "<s-l>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon mark 2", },
      { "<a-h>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon mark 3", },
      { "<a-j>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon mark 4", },
      { "<a-k>", function() require("harpoon.ui").nav_file(5) end, desc = "Harpoon mark 5", },
      { "<a-l>", function() require("harpoon.ui").nav_file(6) end, desc = "Harpoon mark 6", },
    },
  },
}
