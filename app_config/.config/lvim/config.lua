-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.number = true
lvim.colorscheme = "onedarker"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3
-- Default splitting will cause your main splits to jump when opening an edgebar.
-- To prevent this, set `splitkeep` to either `screen` or `topline`.
vim.opt.splitkeep = "screen"

-- vim.diagnostic.config({
--     virtual_text = false
-- })

-- install Python-specific plugins
lvim.plugins = {
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "0a8d0cf8e09caba22ed0d8439f7fa1e3d8453800038e43ccad1f34ef29537da1"
  },
  "neovim/nvim-lspconfig",
  {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
    config = function()
      require('distant'):setup()
    end
  },
  {
    "danymat/neogen",
    lazy = true,
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  "lunarvim/onedarker.nvim",
  "ChristianChiarulli/swenv.nvim",
  "stevearc/dressing.nvim",
  "mfussenegger/nvim-dap-python",
  "nvim-neotest/nvim-nio",
  "nvim-neotest/neotest",
  "nvim-neotest/neotest-python",
  "nvim-neotest/neotest-jest",
  {
    "zbirenbaum/copilot-cmp",
    cmd = "Copilot",
    event = "InsertEnter",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      vim.defer_fn(function()
        require("copilot").setup() -- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
        require("copilot_cmp").setup() -- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
      end, 100)
    end,
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
    },
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit"
    },
    ft = {"fugitive"}
  },
  {
    'stevearc/aerial.nvim',
    opts = {
      filter_kind = false
    },
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
  },
  { "heavenshell/vim-pydocstring", build = "make install" },
  {
    "nekowasabi/aider.vim",
    dependencies = "vim-denops/denops.vim"
  }
}

require('lspconfig').tsserver.setup({})
require('copilot').setup({})
vim.g.aider_command = 'aider --no-auto-commits'
vim.g.aider_buffer_open_type = 'floating'
vim.g.aider_floatwin_width = 100
vim.g.aider_floatwin_height = 20

vim.api.nvim_create_autocmd('User',
  {
    pattern = 'AiderOpen',
    callback =
      function(args)
        vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { buffer = args.buf })
        vim.keymap.set('n', '<Esc>', '<cmd>AiderHide<CR>', { buffer = args.buf })
      end
  })
lvim.builtin.which_key.mappings['at'] = {':AiderRun<CR>', "Aider Run" }
lvim.builtin.which_key.mappings['ac'] = {':AiderAddCurrentFile<CR>', "Aider Add Current File" }
lvim.builtin.which_key.mappings['ab'] = {':AiderAddBuffers<CR>', "Aider Add Current Buffers" }
lvim.builtin.which_key.mappings['ar'] = {':AiderAddCurrentFileReadOnly<CR>', "Aider Add Current File Read Only" }
lvim.builtin.which_key.mappings['aw'] = {':AiderAddWeb<CR>', "Aider Add Web" }
lvim.builtin.which_key.mappings['ax'] = {':AiderExit<CR>', "Aider Exit" }
lvim.builtin.which_key.mappings['ai'] = {':AiderAddIgnoreCurrentFile<CR>', "Aider Add Ingore Current File" }
lvim.builtin.which_key.mappings['aI'] = {':AiderOpenIgnore<CR>', "Aider Open Ignore" }
lvim.builtin.which_key.mappings['aI'] = {':AiderPaste<CR>', "Aider Paste" }
lvim.builtin.which_key.mappings['ah'] = {':AiderHide<CR>', "Aider Hide" }
lvim.builtin.which_key.mappings['av'] = {':AiderVisualTextWithPrompt<CR>', "Aider Visual Text With Propmt" }
lvim.builtin.which_key.mappings['t'] =  {":lua vim.diagnostic.open_float()<CR>", "Toggle Diagnostic"}

-- Aerial setup to show functinos within a file
require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  default_direction = "prefer_left",
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', {buffer = bufnr})
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', {buffer = bufnr})
  end
})
lvim.builtin.which_key.mappings["m"] = { '<cmd>AerialToggle!<CR>', "Aerial" }

require('telescope').load_extension('aerial')
require('telescope').setup({
  extensions = {
    aerial = {
      -- Display symbols as <root>.<parent>.<symbol>
      show_nesting = {
        ['_'] = false, -- This key will be the default
        json = true,   -- You can set the option for specific filetypes
        yaml = true,
      }
    }
  }
})
lvim.builtin.which_key.mappings["sn"] = { '<cmd>Telescope aerial<CR>', 'Function' }
lvim.builtin.which_key.mappings["f"] = {
  require("lvim.core.telescope.custom-finders").find_project_files,
  "Project files"
}

lvim.builtin.which_key.mappings.b.f = {
  "<cmd>Telescope buffers<cr>",
  "Buffers"
}

-- Set the gitsigns diff_opt.split to be "botright"
lvim.builtin.gitsigns.opts.diff_opts = { "vertical", "botright" }
lvim.builtin.gitsigns.opts.numhl = true
lvim.builtin.gitsigns.opts.linehl = true
lvim.builtin.gitsigns.opts.current_line_blame = true

-- automatically install python syntax highlighting
lvim.builtin.treesitter.ensure_installed = {
  "cpp",
  "python",
  "typescript",
  "tsx",
}

-- setup formatting
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "jq" },
  { name = "prettier"}
}
lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.py", "*.tsx", "*.json" }

-- setup linting
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "ruff", args = { "--line-length 120" }, filetypes = { "python" } },
  { command = "eslint_d", filetypes = { "typescript", "typescriptreact" } }
}

-- setup debug adapter
lvim.builtin.dap.active = true
local mason_path = vim.fn.glob(vim.fn.stdpath "data" .. "/mason/")
pcall(function()
  require("dap-python").setup(mason_path .. "packages/debugpy/venv/bin/python")
end)

-- setup testing
require("neotest").setup({
  adapters = {
    require("neotest-python")({
      -- Extra arguments for nvim-dap configuration
      -- See https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for values
      dap = {
        redirectOutput = true,
      },
      args = { "--log-level", "DEBUG", "--quiet", "--capture=no" },
      runner = "pytest",
    }),
    require('neotest-jest')({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function()
        return vim.fn.getcwd()
      end,
    }),
  }
})

--[[
<space>dq - Quit
<space>ds - Start
<space>dp - Pause
<space>dc - Continue
<space>du - Step out
<space>dU - Toggle UI
<spacE>di - Step into
<spacE>db - Step back
<space>do - Step over
<space>dd - Disconnect
<space>dr - Toggle Repl
<space>dg - Get session
<space>dC - Run to cursor
<space>dt - Toggle breakpoint
]]
lvim.builtin.which_key.mappings["dm"] = { "<cmd>lua require('neotest').run.run()<cr>", "Test Method" }
lvim.builtin.which_key.mappings["dM"] = { "<cmd>lua require('neotest').run.run({strategy = 'dap'})<cr>", "Test Method DAP" }
lvim.builtin.which_key.mappings["df"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%')})<cr>", "Test Class" }
lvim.builtin.which_key.mappings["dF"] = { "<cmd>lua require('neotest').run.run({vim.fn.expand('%'), strategy = 'dap'})<cr>", "Test Class DAP" }
lvim.builtin.which_key.mappings["dS"] = { "<cmd>lua require('neotest').summary.toggle()<cr>", "Test Summary" }
lvim.builtin.which_key.mappings["bd"] = { "<cmd>bp|bd #<cr>", "Delete buffer" }

lvim.builtin.which_key.mappings["n"] = {
  name = " Neogen",
  c = { "<cmd>lua require('neogen').generate({ type = 'class'})<CR>", "Class Documentation" },
  f = { "<cmd>lua require('neogen').generate({ type = 'func'})<CR>", "Function Documentation" },
  t = { "<cmd>lua require('neogen').generate({ type = 'type'})<CR>", "Type Documentation" },
  F = { "<cmd>lua require('neogen').generate({ type = 'file'})<CR>", "File Documentation" },
}

-- binding for switching
lvim.builtin.which_key.mappings["C"] = {
  name = "Python",
  c = { "<cmd>lua require('swenv.api').pick_venv()<cr>", "Choose Env" },
}

lvim.builtin.which_key.mappings["yd"] = { "<cmd>Pydocstring<cr>", "Pydocstring" }
