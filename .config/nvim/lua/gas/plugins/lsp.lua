return {
  { 'williamboman/mason.nvim',           config = true },
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason-lspconfig.nvim', config = true },
  -- {
  --   'neovim/nvim-lspconfig',
  --   dependencies = { "hrsh7th/cmp-nvim-lsp" }
  -- },

  {
    'ray-x/lsp_signature.nvim', -- default was: config = true },
    config = function()
      require("lsp_signature").setup({
        bind = true,
        handler_opts = { border = "shadow" }, -- aesthetic only
        floating_window = false,       -- starts shut down
      })
      vim.keymap.set('i', '<C-s>', function() require('lsp_signature').toggle_float_win() end,
        { desc = 'Toggle Signature' })
    end
  },
  { 'onsails/lspkind-nvim' },
  {
    'cordx56/rustowl',
    version = '*',
    build = 'cargo install rustowl',
    lazy = false,
    dependencies = { "neovim/nvim-lspconfig" },
    opts = {
      cmd = { vim.fn.expand("$HOME") .. "/.cargo/bin/rustowl" }
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end
      },
      "saadparwaiz1/cmp_luasnip"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      luasnip.config.setup({
        ext_opts = {
          [require("luasnip.util.types").choiceNode] = {
            active = { virt_text = { { "⇥", "DiagnosticWarn" } } }
          },
          [require("luasnip.util.types").insertNode] = {
            active = { virt_text = { { "⇥", "DiagnosticInfo" } } }
          }
        }
      })

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end
        },
        window = {
          completion = cmp.config.window.bordered({ border = "shadow" }),
          documentation = cmp.config.window.bordered({ border = "shadow" })
          -- added { border = 'square' } as an argument. default is no arguments.
        },
        --  completion = {
        --   autocomplete = false, -- auto autocomplete
        -- },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- open autocomplete
          -- ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
          -- ["<C-Space>"] = cmp.mapping.complete(), -- open autocomplete
          -- ["<C-Space>"] = cmp.mapping(function()
          --   if cmp.visible() then
          --     cmp.abort()
          --   else
          --     cmp.complete()
          --   end
          -- end, { "i", "c" }),
          -- ["<C-Space>"] = cmp.mapping.complete({
          --   reason = cmp.ContextReason.Manual,
          -- }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" })
        }),
        sources = cmp.config.sources({
          -- { name = "nvim_lsp" },
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" }
        }),
        -- sources = cmp.config.sources({
        --   { name = "nvim_lsp", keyword_length = 1 },
        --   { name = "luasnip" },
        --   { name = "buffer", keyword_length = 3 }
        -- }),
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 70,
            show_labelDetails = true
          })
        }
      })

      --   vim.keymap.set('n', '<leader>rz', function()
      --       local word = vim.fn.expand("<cword>")
      --       vim.fn.jobstart({
      --     "env",
      --     "QT_OPENGL=software",
      --     "QTWEBENGINE_CHROMIUM_FLAGS=--disable-gpu",
      --     "zeal",
      --     "--query",
      --     word
      --   })
      -- end, { desc = "Zeal Lookup" })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = ev.buf, desc = "Go To Definition" })
          vim.keymap.set('n', 'K', function()
            vim.lsp.buf.hover({ border = "shadow" })
          end, { buffer = ev.buf, desc = "Hover Docs" })
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = ev.buf, desc = "Go To Reference" })
          vim.keymap.set('n', 'gK', function() vim.cmd('normal! ' .. vim.v.count1 .. 'K') end,
            { buffer = ev.buf, desc = "Man Pages" })                                                                                   -- requiered: man-db man-pages
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { buffer = ev.buf, desc = "Rename" })
          vim.keymap.set({ 'n', 'v' }, '<leader>rc', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>rd', function() vim.diagnostic.open_float({ border = "shadow" }) end,
            { buffer = ev.buf, desc = "Diagnostic" })
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { buffer = ev.buf, desc = "Prev Diagnostic" })
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { buffer = ev.buf, desc = "Next Diagnostic" })
          vim.keymap.set('n', '<leader>rf', function() vim.lsp.buf.format { async = true } end,
            { buffer = ev.buf, desc = "Format" })
          vim.keymap.set('n', '<leader>rh',
            function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf }),
                { bufnr = ev.buf }) end, { buffer = ev.buf, desc = "Inlay Hints" })

          local client = vim.lsp.get_client_by_id(ev.data.client_id)
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(false, { bufnr = ev.buf })
          end
        end,

      })

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

      vim.lsp.config('*', { capabilities = capabilities })
      vim.filetype.add({
        extension = {
          hylo = "hylo",
        },
      })
      vim.lsp.config('hylo_ls', {
        cmd = { vim.fn.expand('~/.local/share/nvim/mason/bin/hylo-language-server'), '--stdio' },
        filetypes = { 'hylo' },
        root_markers = { 'README.md', 'Package.swift', '.hylo' },
      })

      vim.lsp.enable({ 'rust_analyzer', 'clangd', 'slangd', 'lua_ls', 'zls', 'omnisharp', 'asm_lsp', 'hylo_ls', 'bashl' })

      -- vim.lsp.config('clangd', {
      --   capabilities = capabilities,
      --   -- single_file_support = true,
      --   -- root_dir = function() return vim.fn.getcwd() end,
      --   cmd = {
      --     "clangd",
      --     "--background-index",
      --     "--clang-tidy",
      --     "--header-insertion=never",
      --     "--completion-style=detailed",
      --     "--fallback-style=llvm",
      --     -- "--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++"
      --   }
      -- })
      -- vim.lsp.enable('clangd')

      -- vim.lsp.config('omnisharp', {
      --   capabilities = capabilities,
      --   -- cmd = { "dotnet", vim.fn.stdpath("data") .. "/mason/packages/omnisharp/libexec/OmniSharp.dll" },
      --   cmd = { "omnisharp" }, -- test
      --   -- cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" }, -- test
      --   filetypes = { "cs", "vb" }, -- test
      --   enable_import_completion = true,
      --   organize_imports_on_format = true,
      --   enable_roslyn_analyzers = true,
      --   root_markers = { "*.sln", "*.csproj", "OmniSharp.csproj", ".git" }, -- test
      --   settings = {
      --     FormattingOptions = {
      --       EnableEditorConfigSupport = true,
      --       OrganizeImports = true,
      --     },
      --     MsBuild = {
      --       LoadProjectsOnDemand = false,
      --     },
      --     RoslynExtensionsOptions = { -- test
      --       EnableAnalyzersSupport = true,
      --       EnableImportCompletion = true,
      --     },
      --   },
      -- })
      -- vim.lsp.enable('omnisharp')
    end
  }
}
