local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    -- remotes = { -- easily add new remotes to track
    --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
    --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
    --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    -- },
  },

  -- Set colorscheme
  colorscheme = "default_theme",

  -- Override highlight groups in any theme
  highlights = {
    -- duskfox = { -- a table of overrides
    --   Normal = { bg = "#000000" },
    -- },
    default_theme = function(highlights) -- or a function that returns one
      local C = require "default_theme.colors"

      highlights.Normal = { fg = C.fg, bg = C.bg }
      return highlights
    end,
  },
  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = true, -- sets vim.opt.relativenumber
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
      bg = "#000000",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },

  -- Disable AstroNvim ui features
  ui = {
    nui_input = true,
    telescope_select = true,
  },

  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },
      ["declancm/cinnamon.nvim"] = { disable = true },
      -- "mfussenegger/nvim-dap",
      -- "rcarriga/nvim-dap-ui",
      -- "Pocco81/dap-buddy.nvim",
      "rhysd/rust-doc.vim",
      "gpanders/editorconfig.nvim",
      {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
          require("todo-comments").setup {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            --
            keywords = {
              FIX = {
                alt = { "FIXME", "ISSUE", "BUG" },
              },
            },
          }
        end,
      },
      -- {
      -- "folke/trouble.nvim",
      -- requires = "kyazdani42/nvim-web-devicons",
      -- config = function()
      --   require("trouble").setup {
      --     -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      -- }
      -- end,
      -- },
      "dense-analysis/ale",
      "brooth/far.vim",
      "https://github.com/kylechui/nvim-surround",
      -- "iamcco/markdown-preview.nvim",
      "folke/lsp-colors.nvim",
      "vim-autoformat/vim-autoformat",
      -- DAP:
      { "mfussenegger/nvim-dap" },
      {
        "rcarriga/nvim-dap-ui",
        requires = { "nvim-dap", "rust-tools.nvim" },
        config = function()
          local dapui = require "dapui"
          dapui.setup {}

          local dap = require "dap"
          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
          dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
          dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

          -- DAP mappings:
          local map = vim.api.nvim_set_keymap
          map("n", "<F5>", ":lua require('dap').continue()<cr>", { desc = "Continue" })
          map("n", "<F10>", ":lua require('dap').step_over()<cr>", { desc = "Step over" })
          map("n", "<F11>", ":lua require('dap').step_into()<cr>", { desc = "Step into" })
          map("n", "<F12>", ":lua require('dap').step_out()<cr>", { desc = "Step out" })
          map("n", "<leader>bp", ":lua require('dap').toggle_breakpoint()<cr>", { desc = "Toggle breakpoint" })
          map(
            "n",
            "<leader>Bp",
            ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
            { desc = "Set conditional breakpoint" }
          )
          map(
            "n",
            "<leader>lp",
            ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Logpoint message: '))<cr>",
            { desc = "Set logpoint" }
          )
          map("n", "<leader>rp", ":lua require('dap').repl.open()<cr>", { desc = "Open REPL" })
          map("n", "<leader>RR", ":lua require('dap').run_last()<cr>", { desc = "Run last debugged program" })
          map("n", "<leader>XX", ":lua require('dap').terminate()<cr>", { desc = "Terminate program being debugged" })
          map("n", "<leader>du", ":lua require('dap').up()<cr>", { desc = "Up one frame" })
          map("n", "<leader>dd", ":lua require('dap').down()<cr>", { desc = "Down one frame" })
        end,
      },
      {
        "mfussenegger/nvim-dap-python",
      },
      -- Rust support
      {
        "simrat39/rust-tools.nvim",
        after = { "mason-lspconfig.nvim" },
        -- Is configured via the server_registration_override installed below!
        config = function()
          require("rust-tools").setup {
            server = astronvim.lsp.server_settings "rust_analyzer",
            tools = {
              inlay_hints = {
                parameter_hints_prefix = "  ",
                other_hints_prefix = "  ",
              },
            },
          }
        end,
      },
      {
        "Saecki/crates.nvim",
        after = "nvim-cmp",
        config = function()
          require("crates").setup()

          local cmp = require "cmp"
          local config = cmp.get_config()
          table.insert(config.sources, { name = "crates", priority = 1100 })
          cmp.setup(config)

          -- Crates mappings:
          local map = vim.api.nvim_set_keymap
          map("n", "<leader>Ct", ":lua require('crates').toggle()<cr>", { desc = "Toggle extra crates.io information" })
          map("n", "<leader>Cr", ":lua require('crates').reload()<cr>", { desc = "Reload information from crates.io" })
          map("n", "<leader>CU", ":lua require('crates').upgrade_crate()<cr>", { desc = "Upgrade a crate" })
          map("v", "<leader>CU", ":lua require('crates').upgrade_crates()<cr>", { desc = "Upgrade selected crates" })
          map("n", "<leader>CA", ":lua require('crates').upgrade_all_crates()<cr>", { desc = "Upgrade all crates" })
          map("n", "<leader>Cd", ":lua require('crates').open_documentation()<cr>", { desc = "Open docs.rs" })
        end,
      },
    },
    -- All other entries override the setup() call for default plugins
    ["null-ls"] = function(config)
      local null_ls = require "null-ls"
      -- Check supported formatters and linters
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      config.sources = {
        -- Set a formatter
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettier,
      }
      -- set up null-ls's on_attach function
      config.on_attach = function(client)
        -- NOTE: You can remove this on attach function to disable format on save
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {
            desc = "Auto format before save",
            pattern = "<buffer>",
            callback = vim.lsp.buf.formatting_sync,
          })
        end
      end
      return config -- return final config table
    end,
    treesitter = {
      ensure_installed = { "lua" },
    },
    -- use mason-lspconfig to configure LSP installations
    ["mason-lspconfig"] = {
      ensure_installed = { "sumneko_lua" },
    },
    -- use mason-tool-installer to configure DAP/Formatters/Linter installation
    ["mason-tool-installer"] = {
      ensure_installed = { "prettier", "stylua" },
    },
    ["rust-tools"] = {
      inlay_hints = true,
    },
    packer = {
      compile_path = vim.fn.stdpath "data" .. "/packer_compiled.lua",
    },
  },

  -- LuaSnip Options
  luasnip = {
    -- Add paths for including more VS Code style snippets in luasnip
    vscode_snippet_paths = {},
    -- Extend filetypes
    filetype_extend = {
      javascript = { "javascriptreact" },
    },
  },

  -- CMP Source Priorities
  -- modify here the priorities of default cmp sources
  -- higher value == higher priority
  -- The value can also be set to a boolean for disabling default sources:
  -- false == disabled
  -- true == 1000
  cmp = {
    source_priority = {
      nvim_lsp = 1000,
      luasnip = 750,
      buffer = 500,
      path = 250,
    },
  },

  -- Extend LSP configuration
  lsp = {
    skip_setup = { "rust_analyzer" },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
    -- easily add or disable built in mappings added during LSP attaching
    mappings = {
      n = {
        -- ["<leader>lf"] = false -- disable formatting keymap
      },
    },
    -- add to the server on_attach function
    -- on_attach = function(client, bufnr)
    -- end,

    -- override the lsp installer server-registration function
    -- server_registration = function(server, opts)
    --   require("lspconfig")[server].setup(opts)
    -- end,

    -- Add overrides for LSP server settings, the keys are the name of the server
    ["server-settings"] = {
      -- example for addings schemas to yamlls
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
      --         ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
      --         ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
      --       },
      --     },
      --   },
      -- },
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({}))
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  -- Mapping data with "desc" stored directly by vim.keymap.set().
  --
  -- Please use this mappings table to set keyboard mapping since this is the
  -- lower level configuration and more robust one. (which-key will
  -- automatically pick-up stored data by this setting.)
  mappings = {
    -- first key is the mode
    n = {
      -- second key is the lefthand side of the map
      -- mappings seen under group name "Buffer"
      -- ["<leader>bb"] = { "<cmd>tabnew<cr>", desc = "New tab" },
      -- ["<leader>bc"] = { "<cmd>BufferLinePickClose<cr>", desc = "Pick to close" },
      -- ["<leader>bj"] = { "<cmd>BufferLinePick<cr>", desc = "Pick to jump" },
      -- ["<leader>bT"] = { "<cmd>BufferLineSortByTabs<cr>", desc = "Sort by tabs" },
      -- quick save
      -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
      ["<leader>lt"] = { "<cmd>TodoTelescope<cr>", desc = "Show todos in Telescope" },
    },
    t = {
      -- setting a mapping to false will disable it
      -- ["<esc>"] = false,
    },
  },

  -- Modify which-key registration (Use this with mappings table in the above.)
  ["which-key"] = {
    -- Add bindings which show up as group name
    register_mappings = {
      -- first key is the mode, n == normal mode
      n = {
        -- second key is the prefix, <leader> prefixes
        ["<leader>"] = {
          -- third key is the key to bring up next level and its displayed
          -- group name in which-key top level menu
          ["b"] = { name = "Buffer" },
          ["h"] = { name = "Git gutter" },
        },
      },
    },
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()
    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup("packer_conf", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Sync packer after modifying plugins.lua",
      group = "packer_conf",
      pattern = "plugins.lua",
      command = "source <afile> | PackerSync",
    })
    vim.api.nvim_create_augroup("rust", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePost", {
      desc = "Run AutoFormat on save",
      group = "rust",
      pattern = "*.rs",
      command = "Autoformat",
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    --
  end,

  require("lspconfig").rust_analyzer.setup {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          allFeatures = true,
          overrideCommand = {
            "cargo",
            "clippy",
            "--workspace",
            "--message-format=json",
            "--all-targets",
            "--all-features",
          },
        },
      },
    },
  },
}

return config
