return {
  {
    "ThePrimeagen/harpoon",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      -- stylua: ignore
      { "<leader>a", function() require("harpoon.mark").add_file() end, desc = "Harpoon add", },
      { "<leader>A", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Harpoon add", },
      { "<a-h>", function() require("harpoon.ui").nav_file(1) end, desc = "Harpoon mark 1", },
      { "<a-j>", function() require("harpoon.ui").nav_file(2) end, desc = "Harpoon mark 2", },
      { "<a-k>", function() require("harpoon.ui").nav_file(3) end, desc = "Harpoon mark 3", },
      { "<a-l>", function() require("harpoon.ui").nav_file(4) end, desc = "Harpoon mark 4", },
    }
  }
}
