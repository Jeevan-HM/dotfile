return {
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        config = function()
            vim.keymap.set("n", "<leader>e", ":Neotree toggle filesystem reveal left<CR>", {})
            vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {})
            require("neo-tree").setup({
                filesystem = {
                    filtered_items = {
                        visible = true,
                        show_hidden_count = true,
                        hide_dotfiles = false,
                        hide_gitignored = false,
                        hide_by_name = {
                            -- '.git',
                            -- '.DS_Store',
                            -- 'thumbs.db',
                        },
                        never_show = {},

                        bind_to_cwd = false,
                        follow_current_file = { enabled = true },
                        use_libuv_file_watcher = true,
                    },
                },
                sources = { "filesystem", "buffers", "git_status", "document_symbols" },
                open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
                window = {
                    width = 30,
                    mappings = {
                        ["<leader>"] = "none",
                        ["Y"] = function(state)
                            local node = state.tree:get_node()
                            local path = node:get_id()
                            vim.fn.setreg("+", path, "c")
                        end,
                    },
                },
                default_component_configs = {
                    indent = {
                        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                },
                icon = {
                    folder_closed = "",
                    folder_open = "",
                    folder_empty = "󰜌",
                    -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
                    -- then these will never be used.
                    default = "*",
                    highlight = "NeoTreeFileIcon",
                },
                modified = {
                    symbol = "[+]",
                    highlight = "NeoTreeModified",
                },
                name = {
                    trailing_slash = false,
                    use_git_status_colors = true,
                    highlight = "NeoTreeFileName",
                },
                git_status = {
                    symbols = {
                        -- Change type
                        added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
                        modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
                        deleted = "✖", -- this can only be used in the git_status source
                        renamed = "󰁕", -- this can only be used in the git_status source
                        -- Status type
                        untracked = "",
                        ignored = "",
                        unstaged = "󰄱",
                        staged = "",
                        conflict = "",
                    },
                },
            })
        end,
    },
}
