return {

  {
    "michaelb/sniprun",
    build = "sh install.sh",
    config = function()
      local map = vim.keymap.set
      require("sniprun").setup({
        display = {
          "Classic",       --# display results in the command-line  area
          "VirtualTextOk", --# display ok results as virtual text (multiline is shortened)
          "VirtualTextErr",

          -- "VirtualText",             --# display results as virtual text
          "VirtualLine", --# display results as virtual lines
          -- "TempFloatingWindow",      --# display results in a floating window
          -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
          -- "Terminal",                --# display results in a vertical split
          -- "TerminalWithCode",        --# display results and code history in a vertical split
          -- "NvimNotify",              --# display with the nvim-notify plugin
          -- "Api"                      --# return output to a programming interface
        },
        snipruncolors = {
          SniprunVirtualTextOk  = { bg = "#74ffb7", fg = "#000000", ctermbg = "Cyan", ctermfg = "Black" },
          SniprunFloatingWinOk  = { fg = "#74ffb7", ctermfg = "Cyan" },
          SniprunVirtualTextErr = { bg = "#ff5555", fg = "#000000", ctermbg = "DarkRed", ctermfg = "Black" },
          SniprunFloatingWinErr = { fg = "#ff5555", ctermfg = "DarkRed", bold = true },
        },
      })

      map("v", "<leader>sr", "<Plug>SnipRun<CR>", { remap = true, desc = "Run Selected" })
      map("n", "<leader>so", "<Plug>SnipRunOperator", { remap = true, desc = "SnipRun Operator" })
      map("n", "<leader>sR", "<cmd>SnipRun<CR>", { desc = "Run All" })
      map("n", "<leader>ss", "<cmd>SnipReset<CR>", { desc = "Stop All" })
      map("n", "<leader>sc", "<cmd>SnipClose<CR>", { desc = "Clear All" })
    end
  }



}
