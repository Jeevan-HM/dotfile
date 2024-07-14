return {
    {
        "nvim-telescope/telescope-ui-select.nvim",
        event = "VeryLazy",
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        event = "VeryLazy",
        build = "make",
        cond = vim.fn.executable("make") == 1,
    },

    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        tag = "0.1.5",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-symbols.nvim" },
        config = function()
            require("telescope").setup({
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set(
                "n",
                "<leader>?",
                require("telescope.builtin").oldfiles,
                { desc = "[?] Find recently opened files" }
            )
            vim.keymap.set("n", "<leader>/", function()
                -- You can pass additional configuration to telescope to change theme, layout, etc.
                require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                    winblend = 10,
                    previewer = false,
                }))
            end, { desc = "[/] Fuzzily search in current buffer]" })

            vim.keymap.set(
                "n",
                "<leader>fa",
                "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>",
                { desc = "Find all" }
            )

            vim.keymap.set("n", "<leader>ss", function()
                require("telescope.builtin").spell_suggest(require("telescope.themes").get_dropdown({
                    previewer = false,
                }))
            end, { desc = "[S]earch [S]pelling suggestions" })
            vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
            vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
            vim.keymap.set(
                "n",
                "<leader>sw",
                require("telescope.builtin").grep_string,
                { desc = "[S]earch current [W]ord" }
            )

            vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
            vim.keymap.set(
                "n",
                "<leader>sd",
                require("telescope.builtin").diagnostics,
                { desc = "[S]earch [D]iagnostics" }
            )
            vim.keymap.set(
                "n",
                "<leader>sb",
                require("telescope.builtin").buffers,
                { desc = "[ ] Find existing buffers" }
            )
            vim.keymap.set("n", "<leader>sS", require("telescope.builtin").git_status, { desc = "" })
            vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", { desc = "Harpoon [M]arks" })
            vim.keymap.set(
                "n",
                "<Leader>sr",
                "<CMD>lua require('telescope').extensions.git_worktree.git_worktrees()<CR>",
                silent
            )
            vim.keymap.set(
                "n",
                "<Leader>sR",
                "<CMD>lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>",
                silent
            )
            vim.keymap.set("n", "<Leader>sn", "<CMD>lua require('telescope').extensions.notify.notify()<CR>", silent)

            require("telescope").load_extension("ui-select")
            require("git-worktree").setup()
        end,
    },
}
