return {
  { 'folke/which-key.nvim', config = true },
  {
    'nvim-telescope/telescope.nvim',
    -- tag = 'v0.1.9',
    tag = 'v0.2.1',
    -- branch = "master",
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-file-browser.nvim' }
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")
      local fb_utils = require("telescope._extensions.file_browser.utils")
      local Path = require("plenary.path")

      local cursor_by_dir = {}

      local function norm_path(path)
        path = vim.fn.fnamemodify(path, ":p")
        if path ~= "/" then
          path = path:gsub("/$", "")
        end
        return path
      end

      local function save_cursor(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        if picker.finder.path and entry and entry.value then
          cursor_by_dir[norm_path(picker.finder.path)] = entry.value
        end
      end

      local function restore_cursor(picker)
        local once = false
        picker:register_completion_callback(function(p)
          if once then
            return
          end
          once = true
          local saved = cursor_by_dir[norm_path(p.finder.path)]
          if not saved then
            return
          end
          local saved_n = fb_utils.sanitize_path_str(saved)
          for i, path_entry in ipairs(p.finder.results or {}) do
            if fb_utils.sanitize_path_str(path_entry.value) == saved_n then
              p:set_selection(p:get_row(i))
              return
            end
          end
        end)
      end

      local function cd(prompt_bufnr, new_path)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local finder = picker.finder
        save_cursor(prompt_bufnr)
        finder.files = true
        finder.path = new_path
        fb_utils.redraw_border_title(picker)
        restore_cursor(picker)
        picker:refresh(finder, {
          new_prefix = fb_utils.relative_path_prefix(finder),
          reset_prompt = true,
          multi = picker._multi,
        })
      end

      local function go_up(prompt_bufnr)
        local picker = action_state.get_current_picker(prompt_bufnr)
        local finder = picker.finder
        local parent = Path:new(finder.path):parent():absolute()
        if not cursor_by_dir[norm_path(parent)] then
          cursor_by_dir[norm_path(parent)] = finder.path
        end
        cd(prompt_bufnr, parent)
      end

      local function go_into(prompt_bufnr)
        local entry = action_state.get_selected_entry()
        if not (entry and fb_utils.is_dir(entry.Path)) then
          return actions.select_default(prompt_bufnr)
        end
        cd(prompt_bufnr, vim.loop.fs_realpath(entry.path) or entry.path)
      end

      telescope.setup({
        defaults = {
	  borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" }, -- this line was not on reference config.
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = { prompt_position = "top" },
          mappings = {
            i = {
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-j>"] = actions.move_selection_next,
            }
          }
        },
        extensions = {
          file_browser = {
            hijack_netrw = true,
            hidden = true,
            grouped = true,
            mappings = {
              i = {
                ["<Left>"] = go_up,
                ["<Right>"] = go_into,
                ["<CR>"] = go_into,
              },
              n = {
                ["<Left>"] = go_up,
                ["<Right>"] = go_into,
                ["<CR>"] = go_into,
              },
            },
          }
        }
      })

      telescope.load_extension("fzf")
      telescope.load_extension("file_browser")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "-", ":Telescope file_browser<CR>", { silent = true })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
      vim.keymap.set("n", "<leader>fF", function() builtin.find_files({	hidden = true,
	no_ignore = true }) end, { desc = "Find File Hidden" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find Grep" })
      vim.keymap.set("n", "<leader>fG", function() builtin.live_grep({ additional_args = function() return { "--hidden", "--no-ignore" } end }) end, { desc = "Find Grep Hidden" })
      vim.keymap.set("n", "<leader>fx", builtin.treesitter, { desc = "Find Symbols" })
      vim.keymap.set("n", "<leader>fs", builtin.spell_suggest, { desc = "Find Spell" })

end
  }
}

