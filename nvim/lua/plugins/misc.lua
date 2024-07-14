return {
    { "onsails/lspkind.nvim", event = "VeryLazy" },
    { "tpope/vim-surround", event = "VeryLazy" },
    { "tpope/vim-fugitive", event = "VeryLazy" },
    { "christoomey/vim-tmux-navigator", event = "VeryLazy" },
    { "folke/twilight.nvim", event = "VeryLazy" },
    { "windwp/nvim-ts-autotag", event = "VeryLazy" },
    {
        "barrett-ruth/live-server.nvim",
        lazy = true,
        event = "VeryLazy",
        build = "pnpm add -g live-server",
        cmd = { "LiveServerStart", "LiveServerStop" },
        config = function()
            require("live-server").setup()
        end,
    },
    {
        "michaelrommel/nvim-silicon",
        lazy = true,
        cmd = "Silicon",
        config = function()
            require("silicon").setup({
                -- Configuration here, or leave empty to use defaults
                font = "Hack Nerd Font=34;Noto Emoji=34",
                theme = "Dracula",
                background = "#C6C6C6",
                output = function()
                    return "./" .. os.date("!%Y-%m-%dT%H-%M-%S") .. "_code.png"
                end,
            })
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = "VeryLazy",
        config = function()
            require("colorizer").setup()
        end,
    },
    {
        "catppuccin/nvim",
        config = function()
            require("catppuccin").setup({
                style = "mocha",
            })
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    --[[ {
        {
            "folke/tokyonight.nvim",
            lazy = false,
            priority = 1000,
            config = function()
                vim.cmd.colorscheme("tokyonight-night")
            end,
        },
    }, ]]
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
    },
    {
        "folke/trouble.nvim",
        event = "VeryLazy",
        lazy = true,
        dependencies = { "nvim-tree/nvim-web-devicons" },
        vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true }),
        vim.keymap.set(
            "n",
            "<leader>xw",
            "<cmd>TroubleToggle workspace_diagnostics<cr>",
            { silent = true, noremap = true }
        ),
        vim.keymap.set(
            "n",
            "<leader>xd",
            "<cmd>TroubleToggle document_diagnostics<cr>",
            { silent = true, noremap = true }
        ),
        vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true }),
        vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true }),
        vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true }),
        config = function()
            local signs = {
                Error = " ",
                Warning = " ",
                Hint = " ",
                Information = " ",
            }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end
        end,
    },
    {
        "mbbill/undotree",
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        end,
    },
    -- {
    --     "jackMort/ChatGPT.nvim",
    --     event = "VeryLazy",
    --     config = function()
    --         require("chatgpt").setup({ api_key_cmd = "pass show api/nvim-gpt" })
    --     end,
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --         "nvim-lua/plenary.nvim",
    --         "folke/trouble.nvim",
    --         "nvim-telescope/telescope.nvim",
    --     },
    -- },
    {
        "Exafunction/codeium.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "hrsh7th/nvim-cmp",
        },
        config = function()
            require("codeium").setup({})
        end,
    },
    {
        "codota/tabnine-nvim",
        event = "VeryLazy",
        config = function()
            require("tabnine").setup({
                disable_auto_comment = true,
                accept_keymap = "<C-y>",
                dismiss_keymap = "<C-]>",
                debounce_ms = 800,
                suggestion_color = { gui = "#808080", cterm = 244 },
                exclude_filetypes = { "TelescopePrompt", "NvimTree" },
                log_file_path = nil, -- absolute path to Tabnine log file
            })
        end,
        -- build = "./dl_binaries.sh",
    },
    -- { 'navarasu/onedark.nvim' },

    {
        "numToStr/Comment.nvim",
        lazy = true,
        event = { "BufEnter" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("ts_context_commentstring").setup({
                    enable_autocmd = false,
                })
            end,
        },
        config = function()
            -- Comment configuration object _can_ take a partial and is merged in
            ---@diagnostic disable-next-line: missing-fields
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })

            local ft = require("Comment.ft")
            ft.set("reason", { "//%s", "/*%s*/" })
        end,
    },
    {
        "ThePrimeagen/refactoring.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        -- config = function()
        --     require("refactoring").setup()
        -- end,
    },
    {
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "VeryLazy",
        opts = {
            symbol = "▏",

            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "│",
                tab_char = "│",
            },
            scope = { enabled = false },
            exclude = {
                filetypes = {
                    "help",
                    "alpha",
                    "dashboard",
                    "neo-tree",
                    "Trouble",
                    "trouble",
                    "lazy",
                    "mason",
                    "notify",
                    "toggleterm",
                    "lazyterm",
                },
            },
        },
        event = "VeryLazy",
    },
    {
        "ThePrimeagen/harpoon",
        event = "VeryLazy",
        config = function()
            local harpoon_ui = require("harpoon.ui")
            local harpoon_mark = require("harpoon.mark")

            vim.keymap.set("n", "<leader>ho", function()
                harpoon_ui.toggle_quick_menu()
            end)
            vim.keymap.set("n", "<leader><leader>s", ":SymbolsOutline<cr>")
            -- Add current file to harpoon
            vim.keymap.set("n", "<leader>a", function()
                harpoon_mark.add_file()
            end)
            vim.keymap.set("n", "<leader>X", "<cmd>bd<cr>", { desc = "Close buffer" })
            -- Remove current file from harpoon
            vim.keymap.set("n", "<leader>hr", function()
                harpoon_mark.rm_file()
            end)

            -- Remove all files from harpoon
            vim.keymap.set("n", "<leader>hc", function()
                harpoon_mark.clear_all()
            end)
            -- Quickly jump to harpooned files
            vim.keymap.set("n", "<leader>1", function()
                harpoon_ui.nav_file(1)
            end)

            vim.keymap.set("n", "<leader>2", function()
                harpoon_ui.nav_file(2)
            end)

            vim.keymap.set("n", "<leader>3", function()
                harpoon_ui.nav_file(3)
            end)

            vim.keymap.set("n", "<leader>4", function()
                harpoon_ui.nav_file(4)
            end)

            vim.keymap.set("n", "<leader>5", function()
                harpoon_ui.nav_file(5)
            end)
        end,
    },
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end,                desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't Save Current Session" },
    },
    },
    {
        "windwp/nvim-autopairs",
        event = "VeryLazy",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },
    {
        "laytan/cloak.nvim",
        event = "VeryLazy",
        config = function()
            require("cloak").setup({
                cloak_character = "*",
                highlight_group = "Comment",
                patterns = {
                    {
                        file_pattern = {
                            ".env*",
                            "wrangler.toml",
                            ".dev.vars",
                        },
                        cloak_pattern = "=.+",
                    },
                },
            })
        end,
    },
    {
        "iamcco/markdown-preview.nvim",
        lazy = true,
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        -- build = function()
        --   vim.fn["mkdp#util#install"]()
        -- end,
    },
    {
        "onsails/lspkind.nvim",
        event = "VeryLazy",
    },
    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
        event = "VeryLazy",
        config = function()
            vim.keymap.set("n", "zR", require("ufo").openAllFolds)
            vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
            require("ufo").setup({
                provider_selector = function(bufnr, filetype, buftype)
                    return { "lsp", "indent" }
                end,
            })
        end,
    },
    {
        "ThePrimeagen/git-worktree.nvim",
        event = "VeryLazy",
        config = function()
            require("git-worktree").setup()
            require("telescope").load_extension("git_worktree")
        end,
    },
    {
        "rmagatti/goto-preview",
        event = "VeryLazy",
        config = function()
            require("goto-preview").setup({
                width = 120, -- Width of the floating window
                height = 15, -- Height of the floating window
                border = { "↖", "─", "┐", "│", "┘", "─", "└", "│" }, -- Border characters of the floating window
                default_mappings = true,
                debug = false, -- Print debug information
                opacity = nil, -- 0-100 opacity level of the floating window where 100 is fully transparent.
                resizing_mappings = false, -- Binds arrow keys to resizing the floating window.
                post_open_hook = nil, -- A function taking two arguments, a buffer and a window to be ran as a hook.
                references = { -- Configure the telescope UI for slowing the references cycling window.
                    telescope = require("telescope.themes").get_dropdown({ hide_preview = false }),
                },
                -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
                focus_on_open = true, -- Focus the floating window when opening it.
                dismiss_on_move = false, -- Dismiss the floating window when moving the cursor.
                force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
                bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
                stack_floating_preview_windows = true, -- Whether to nest floating windows
                preview_window_title = { enable = true, position = "left" }, -- Whether
            })
        end,
    },
    {
        "simrat39/symbols-outline.nvim",
        lazy = true,
        cmd = { "SymbolsOutline", "SymbolsOutlineOpen", "SymbolsOutlineClose" },
        config = function()
            require("symbols-outline").setup({
                symbols = {
                    File = { icon = "", hl = "@text.uri" },
                    Module = { icon = "", hl = "@namespace" },
                    Namespace = { icon = "", hl = "@namespace" },
                    Package = { icon = "", hl = "@namespace" },
                    Class = { icon = "", hl = "@type" },
                    Method = { icon = "ƒ", hl = "@method" },
                    Property = { icon = "", hl = "@method" },
                    Field = { icon = "", hl = "@field" },
                    Constructor = { icon = "", hl = "@constructor" },
                    Enum = { icon = "", hl = "@type" },
                    Interface = { icon = "", hl = "@type" },
                    Function = { icon = "", hl = "@function" },
                    Variable = { icon = "", hl = "@constant" },
                    Constant = { icon = "", hl = "@constant" },
                    String = { icon = "", hl = "@string" },
                    Number = { icon = "#", hl = "@number" },
                    Boolean = { icon = "", hl = "@boolean" },
                    Array = { icon = "", hl = "@constant" },
                    Object = { icon = "", hl = "@type" },
                    Key = { icon = "", hl = "@type" },
                    Null = { icon = "", hl = "@type" },
                    EnumMember = { icon = "", hl = "@field" },
                    Struct = { icon = "", hl = "@type" },
                    Event = { icon = "", hl = "@type" },
                    Operator = { icon = "", hl = "@operator" },
                    TypeParameter = { icon = "", hl = "@parameter" },
                    Component = { icon = "", hl = "@function" },
                    Fragment = { icon = "", hl = "@constant" },
                },
            })
        end,
    },
    {
        "nvim-pack/nvim-spectre",
        event = "VeryLazy",
        lazy = true,
        cmd = { "Spectre" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "catppuccin/nvim",
        },
        config = function()
            local theme = require("catppuccin.palettes").get_palette("mocha")

            vim.api.nvim_set_hl(0, "SpectreSearch", { bg = theme.red, fg = theme.base })
            vim.api.nvim_set_hl(0, "SpectreReplace", { bg = theme.green, fg = theme.base })

            require("spectre").setup({
                highlight = {
                    search = "SpectreSearch",
                    replace = "SpectreReplace",
                },
                mapping = {
                    ["send_to_qf"] = {
                        map = "<C-q>",
                        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
                        desc = "send all items to quickfix",
                    },
                },
            })
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup({
                signs = {
                    add = { text = "+" },
                    change = { text = "~" },
                    delete = { text = "_" },
                    topdelete = { text = "‾" },
                    changedelete = { text = "~" },
                },
                current_line_blame = false,
                on_attach = function(bufnr)
                    local gs = package.loaded.gitsigns

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map("n", "]c", function()
                        if vim.wo.diff then
                            return "]c"
                        end
                        vim.schedule(function()
                            gs.next_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    map("n", "[c", function()
                        if vim.wo.diff then
                            return "[c"
                        end
                        vim.schedule(function()
                            gs.prev_hunk()
                        end)
                        return "<Ignore>"
                    end, { expr = true })

                    -- Actions
                    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
                    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
                    map("n", "<leader>hS", gs.stage_buffer)
                    map("n", "<leader>ha", gs.stage_hunk)
                    map("n", "<leader>hu", gs.undo_stage_hunk)
                    map("n", "<leader>hR", gs.reset_buffer)
                    map("n", "<leader>hp", gs.preview_hunk)
                    map("n", "<leader>hb", function()
                        gs.blame_line({ full = true })
                    end)
                    map("n", "<leader>tb", gs.toggle_current_line_blame)
                    map("n", "<leader>hd", gs.diffthis)
                    map("n", "<leader>hD", function()
                        gs.diffthis("~")
                    end)
                    map("n", "<leader>td", gs.toggle_deleted)

                    -- Text object
                    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
                end,
            })
        end,
    },
}
