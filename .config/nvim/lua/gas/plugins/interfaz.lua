local function drop_queued(keys)
  while true do
    local ch = vim.fn.getcharstr(0)
    if ch == "" then
      break
    end
    local key = vim.fn.keytrans(ch)
    if not keys[key] then
      vim.api.nvim_feedkeys(ch, "i", false)
      break
    end
  end
end

local scroll_keys = {}
for _, prefix in ipairs({ "", "2-", "3-", "4-" }) do
  scroll_keys["<" .. prefix .. "ScrollWheelUp>"] = true
  scroll_keys["<" .. prefix .. "ScrollWheelDown>"] = true
end

vim.keymap.set({ "n", "i", "v" }, "<MiddleMouse>", "<Nop>") -- turn off mouse middle button pasting randomly
vim.opt.clipboard = "unnamedplus"
vim.opt.mousescroll = "ver:1,hor:1"

for _, prefix in ipairs({ "", "2-", "3-", "4-" }) do
  vim.keymap.set({ "n", "v" }, "<" .. prefix .. "ScrollWheelUp>", "<C-y>", { silent = true })
  vim.keymap.set({ "n", "v" }, "<" .. prefix .. "ScrollWheelDown>", "<C-e>", { silent = true })
end

vim.keymap.set("n", "<leader>iu", function() vim.fn.append(vim.fn.line('.'), {"[Desktop Entry]", "Type=Link", "URL=" .. vim.fn.getreg("+"):gsub("%s+", "")}) end, { desc = "Insert .desktop" })
-- learder>iU

vim.cmd("colorscheme my_theme_1")
vim.opt.cmdheight = 0

return {
  { 'nvim-tree/nvim-web-devicons' },

  -- {
  --   'nvim-lualine/lualine.nvim',
  --   dependencies = { 'nvim-tree/nvim-web-devicons' },
  --   config = function()
  --     require("lualine").setup({
  --       options = {
  --         theme = 'auto',
  --         icons_enabled = true,
  --         component_separators = { left = '|', right = '|' },
  --         section_separators = { left = '', right = '' },
  --       },
  --       sections = {
  --         lualine_a = { 'mode' },
  --         lualine_b = { 'branch', 'diff', 'diagnostics' },
  --         lualine_c = { 'filename' },
  --         lualine_x = { 'enconding', 'fileformat', 'filetype' },
  --         lualine_y = { 'progress' },
  --         lualine_z = { 'location'}
  --       }
  --     })
  --   end
  -- },
  { 'echasnovski/mini.statusline', version = '*', config = true },
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  {
    'wfxr/minimap.vim',
    lazy = false,
    build = "cargo install --locked code-minimap",
    init = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1
    end,
  },




  {
    "backdround/tabscope.nvim",
    config = function()
      require("tabscope").setup({})
    end,
  },
  { "tiagovla/scope.nvim",    config = true },

  -- TABLINE
  --{'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
  {
    'nvim-mini/mini.tabline',
    version = '',
    config = function()
      require('mini.tabline').setup({})
    end,
  },
  --[[
  {
    'romgrk/barbar.nvim',
    config = function()
      require("barbar").setup({
        clickable = true,
        tabpages = false,
        insert_at_end = true,
        icons = {
          preset = "default",
          button = "",
          buffer_index = true,
          filetype = { enabled = true },
          separator = { left = "",right = ""}, -- │
          inactive = { separator = { left = "", right = "     │" }, -- │
          separator_at_end = false}}
      })

      local map = vim.keymap.set
      local opts = { silent = true }

      map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
      map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)
      map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", opts)
      map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", opts)

      map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", opts)
      map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", opts)
      map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", opts)
      map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", opts)
      map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", opts)
      map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", opts)
      map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", opts)
      map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", opts)
      map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", opts)
      map("n", "<A-0>", "<Cmd>BufferLast<CR>", opts)

      map("n", "<A-p>", "<Cmd>BufferPin<CR>", opts)
      map("n", "<A-c>", "<Cmd>BufferClose<CR>", opts)
      map("n", "<A-C>", "<Cmd>BufferClose!<CR>", opts)
      map("n", "<A-b>", "<Cmd>BufferCloseAllButCurrent<CR>", opts)
    end
  },
]] --

  { 'numToStr/Comment.nvim',  config = true },
  { 'kylechui/nvim-surround', version = "*", config = true },

  {
    "uga-rosa/ccc.nvim",
    config = function()
      local ColorInput = require("ccc.input")
      local convert = require("ccc.utils.convert")

      local RgbHslCmykInput = setmetatable({
        name = "RGB/HSL/CMYK",
        max = { 1, 1, 1, 360, 1, 1, 1, 1, 1, 1 },
        min = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
        delta = { 1 / 255, 1 / 255, 1 / 255, 1, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005 },
        bar_name = { "R", "G", "B", "H", "S", "L", "C", "M", "Y", "K" },
      }, { __index = ColorInput })

      function RgbHslCmykInput.format(n, i)
        if i <= 3 then
          -- RGB
          n = n * 255
        elseif i == 5 or i == 6 then
          -- S or L of HSL
          n = n * 100
        elseif i >= 7 then
          -- CMYK
          return ("%5.1f%%"):format(math.floor(n * 200) / 2)
        end
        return ("%6d"):format(n)
      end

      function RgbHslCmykInput.from_rgb(RGB)
        local HSL = convert.rgb2hsl(RGB)
        local CMYK = convert.rgb2cmyk(RGB)
        local R, G, B = unpack(RGB)
        local H, S, L = unpack(HSL)
        local C, M, Y, K = unpack(CMYK)
        return { R, G, B, H, S, L, C, M, Y, K }
      end

      function RgbHslCmykInput.to_rgb(value)
        return { value[1], value[2], value[3] }
      end

      function RgbHslCmykInput:_set_rgb(RGB)
        self.value[1] = RGB[1]
        self.value[2] = RGB[2]
        self.value[3] = RGB[3]
      end

      function RgbHslCmykInput:_set_hsl(HSL)
        self.value[4] = HSL[1]
        self.value[5] = HSL[2]
        self.value[6] = HSL[3]
      end

      function RgbHslCmykInput:_set_cmyk(CMYK)
        self.value[7] = CMYK[1]
        self.value[8] = CMYK[2]
        self.value[9] = CMYK[3]
        self.value[10] = CMYK[4]
      end

      function RgbHslCmykInput:callback(index, new_value)
        self.value[index] = new_value
        local v = self.value
        if index <= 3 then
          local RGB = { v[1], v[2], v[3] }
          local HSL = convert.rgb2hsl(RGB)
          local CMYK = convert.rgb2cmyk(RGB)
          self:_set_hsl(HSL)
          self:_set_cmyk(CMYK)
        elseif index <= 6 then
          local HSL = { v[4], v[5], v[6] }
          local RGB = convert.hsl2rgb(HSL)
          local CMYK = convert.rgb2cmyk(RGB)
          self:_set_rgb(RGB)
          self:_set_cmyk(CMYK)
        else
          local CMYK = { v[7], v[8], v[9], v[10] }
          local RGB = convert.cmyk2rgb(CMYK)
          local HSL = convert.rgb2hsl(RGB)
          self:_set_rgb(RGB)
          self:_set_hsl(HSL)
        end
      end

      local ccc = require("ccc")
      local mapping = ccc.mapping
      -- local convert = require("ccc.utils.convert")
      local live_reload = false
      local theme_reload_queued = false
      local theme_name
      local source_buf

      local slider_keys = vim.tbl_extend("force", {
        h = true,
        l = true,
        d = true,
        s = true,
        m = true,
        [","] = true,
      }, scroll_keys)

      local function slider(fn)
        return function(core)
          fn(core)
          drop_queued(slider_keys)
        end
      end

      local core = ccc.setup({
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        inputs = {
          -- ccc.input.hsl,
          RgbHslCmykInput,
        },

        pickers = {
          ccc.picker.hex,
          ccc.picker.hex_long,
          ccc.picker.hex_short,
          ccc.picker.css_rgb,
          ccc.picker.css_hsl,
          ccc.picker.css_hwb,
          ccc.picker.css_lab,
          ccc.picker.css_lch,
          ccc.picker.css_oklab,
          ccc.picker.css_oklch,
          ccc.picker.css_name,
          ccc.picker.defaults,
        },

        outputs = {
          ccc.output.hex,
        },
        alpha_show = "hide",
        mappings = {
          l = slider(mapping.increase1),
          h = slider(mapping.decrease1),
          d = slider(mapping.increase5),
          s = slider(mapping.decrease5),
          [","] = slider(mapping.increase10),
          m = slider(mapping.decrease10),
          ["<ScrollWheelUp>"] = slider(mapping.increase1),
          ["<ScrollWheelDown>"] = slider(mapping.decrease1),
          ["<2-ScrollWheelUp>"] = slider(mapping.increase1),
          ["<2-ScrollWheelDown>"] = slider(mapping.decrease1),
          ["<3-ScrollWheelUp>"] = slider(mapping.increase1),
          ["<3-ScrollWheelDown>"] = slider(mapping.decrease1),
          ["<4-ScrollWheelUp>"] = slider(mapping.increase1),
          ["<4-ScrollWheelDown>"] = slider(mapping.decrease1),
        },

      })

      -- TODO convert this into
      -- reusable event
      -- subscribe to change color
      vim.api.nvim_create_autocmd("User", {
        pattern = "CccColorChanged",
        callback = function()
          if not live_reload then
            return
          end
          local color = vim.g.ccc_color
          local range = core.range
          if not color or color == "" or not range then
            return
          end
          vim.api.nvim_buf_set_text(
            source_buf,
            range[1],
            range[2],
            range[3],
            range[4],
            { color }
          )
          core.range[4] = range[2] + #color
          if theme_reload_queued then
            return
          end
          theme_reload_queued = true
          vim.schedule(function()
            theme_reload_queued = false
            vim.api.nvim_buf_call(source_buf, function()
              vim.cmd("silent update")
            end)
            if theme_name then
              vim.g.ccc_live_reload = true
              pcall(vim.cmd.colorscheme, theme_name)
              vim.g.ccc_live_reload = nil
            end
          end)
        end,
      })

      vim.keymap.set("n", "<leader>cp", "<cmd>CccPick<CR>", { desc = "Color Picker" })
      vim.keymap.set("n", "<leader>cP", function()
        source_buf = vim.api.nvim_get_current_buf()
        local filename = vim.api.nvim_buf_get_name(source_buf)
        theme_name = vim.fn.fnamemodify(filename, ":t:r")
        live_reload = false
        vim.cmd("CccPick")
        live_reload = true
      end, { desc = "Color Picker Live Reload" })
    end
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    opts = {},
  },
}
