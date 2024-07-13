return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  keys = {
    {
      "<leader>t",
      "<cmd>Trouble diagnostics toggle<cr>",
      desc = "[T]rouble diagnostics",
    },
    {
      "<leader>tb",
      "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      desc = "[T]rouble current [B]uffer diagnostics",
    },
    {
      "<leader>tqf",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "[T]rouble [Q]uick [F]ix list",
    },
  },
  config = function()
    require('trouble').setup()
    vim.keymap.set("n", "]t", function()
        require('trouble').next({ skip_groups = true, jump = true })
      end,
      { desc = "[T]rouble next selection" }
    )
    vim.keymap.set("n", "[t", function()
        require('trouble').prev({ skip_groups = true, jump = true })
      end,
      { desc = "[T]rouble previous selection" }
    )
  end,
}
