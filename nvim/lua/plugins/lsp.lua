return {
    -- Completion
    {
        "hrsh7th/cmp-nvim-lsp",
        event = "VeryLazy",
    },
    {
        "L3MON4D3/LuaSnip",
        event = "VeryLazy",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
    {
        "hrsh7th/nvim-cmp",
        event = "VeryLazy",
        config = function()
            local cmp = require("cmp")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup({
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<tab>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<S-tab>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "codeium" },
                    { name = "tabnine" },
                    { name = "luasnip" }, -- For luasnip users.
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
        "folke/neodev.nvim",
        lazy = false,
        opts = {},
        config = function()
            require("neodev").setup()
        end,
    },
    {
        "williamboman/mason.nvim",
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
        },
        opts = {
            auto_install = true,
        },
        config = function()
            -- import mason
            local mason = require("mason")

            -- import mason-lspconfig
            local mason_lspconfig = require("mason-lspconfig")

            local mason_tool_installer = require("mason-tool-installer")

            -- enable mason and configure icons
            mason.setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })

            mason_lspconfig.setup({
                -- list of servers for mason to install
                ensure_installed = {
                    "tsserver",
                    "html",
                    "cssls",
                    "tailwindcss",
                    "lua_ls",
                    "ruff_lsp",
                    "pyright",
                },
                -- auto-install configured servers (with lspconfig)
                automatic_installation = true, -- not the same as ensure_installed
            })

            mason_tool_installer.setup({
                ensure_installed = {
                    "prettier",
                    "stylua",
                    "ruff",
                    "eslint_d",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        lazy = false,
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local ensure_installed = {
                "tsserver",
                "html",
                "cssls",
                "tailwindcss",
                "lua_ls",
                "ruff_lsp",
                "pyright",
            }
            local lspconfig = require("lspconfig")

            for _, lang in ipairs(ensure_installed) do
                lspconfig[lang].setup({
                    capabilities = capabilities,
                })
            end

            -- local lspconfig = require("lspconfig")
            -- lspconfig.tsserver.setup({
            -- 	capabilities = capabilities,
            -- })

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<leader>ws", vim.lsp.buf.workspace_symbol, {})
            vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, {})
            vim.keymap.set("n", "[d", vim.diagnostic.goto_next, {})
            vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, {})
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
            vim.keymap.set("n", "<leader>rr", vim.lsp.buf.references, {})
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {})
            vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, {})
        end,
    },
    {
        "supermaven-inc/supermaven-nvim",
        lazy = false,
        config = function()
            local config = require("supermaven-nvim").setup({})
        end,
    },
}
