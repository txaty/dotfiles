return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
    },
    config = function()
      local mason_registry = require "mason-registry"
      local codelldb = mason_registry.get_package "codelldb"
      local extension_path = codelldb:get_install_path() .. "/extension/"
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.dylib"
      local cfg = require "rustaceanvim.config"

      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
        server = {
          on_attach = require("nvchad.configs.lspconfig").on_attach,
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
            },
          },
        },
      }
    end,
  },
  {
    "saecki/crates.nvim",
    ft = { "toml" },
    config = function()
      require("crates").setup {
        completion = { cmp = { enabled = true } },
      }
      require("cmp").setup.buffer { sources = { { name = "crates" } } }
    end,
  },
}
