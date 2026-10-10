return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      renderer = {
        group_empty = true,
      },
    },
  },

  { "mfussenegger/nvim-dap" },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",

    config = function()
      local dap, dapui = require "dap", require "dapui"
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local function setup_jdtls()
        local jdtls = require "jdtls"
        local mason_registry = require "mason-registry"

        local jdtls_path = mason_registry.get_package("jdtls"):get_install_path()
        local launcher_jar = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")

        local java_debug_path = mason_registry.get_package("java-debug-adapter"):get_install_path()
        local java_test_path = mason_registry.get_package("java-test"):get_install_path()

        local bundles = {}
        vim.list_extend(
          bundles,
          vim.split(vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
        )
        vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/extension/server/*.jar"), "\n"))

        local root_dir = require("jdtls.setup").find_root { "pom.xml", "gradlew", ".git" }
        local workspace_dir = vim.fn.stdpath "data" .. "/jdtls-workspace/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

        jdtls.start_or_attach {
          cmd = {
            "java",
            "-jar",
            launcher_jar,
            "-configuration",
            jdtls_path .. "/config_linux",
            "-data",
            workspace_dir,
          },
          root_dir = root_dir,
          init_options = { bundles = bundles },
          on_attach = function(client, bufnr)
            jdtls.setup_dap { hotcodereplace = "auto" }
            require("jdtls.dap").setup_dap_main_class_configs()
          end,
        }
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = setup_jdtls,
      })
    end,
  },

  { "williamboman/mason.nvim", lazy = false },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
