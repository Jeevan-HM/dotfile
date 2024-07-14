vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>p", [["+P]])
vim.keymap.set("n", "<leader>P", [["+P_d]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<leader>E", vim.cmd.Ex)

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "Q", "<nop>")

-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- -- Move to window using the <ctrl> hjkl keys in NeoVim
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Move to window using the <ctrl> hjkl keys in Tmux
--[[ vim.keymap.set("n", "<C-h>", "<cmd> TmuxNavigateLeft <CR>", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<cmd> TmuxNavigateDown <CR>", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<cmd> TmuxNavigateUp <CR>", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<cmd> TmuxNavigateRight <CR>", { desc = "Go to right window", remap = true }) ]]

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-S-Up>", "<cmd>resize +4<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-S-Down>", "<cmd>resize -4<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-S-Left>", "<cmd>vertical resize +4<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-S-Right>", "<cmd>vertical resize -4<cr>", { desc = "Increase window width" })

vim.keymap.set("n", "<C-;>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-'>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Map MaximizerToggle (szw/vim-maximizer) to leader-m
vim.keymap.set("n", "<leader>m", ":MaximizerToggle<cr>")

-- Swap between last two buffers
vim.keymap.set("n", "<C-=", "<C-^>", { desc = "Switch to last buffer" })
vim.keymap.set("n", "]d", function()
    vim.diagnostic.goto_next({})
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Goto previous diagnostic of any severity
vim.keymap.set("n", "[d", function()
    vim.diagnostic.goto_prev({})
    vim.api.nvim_feedkeys("zz", "n", false)
end)

-- Place all dignostics into a qflist
vim.keymap.set("n", "<leader>ld", vim.diagnostic.setqflist, { desc = "Quickfix [L]ist [D]iagnostics" })

-- Navigate to previos qflist item
vim.keymap.set("n", "<leader>cp", ":cprevious<cr>zz")

-- Open the qflist
vim.keymap.set("n", "<leader>co", ":copen<cr>zz")

-- Close the qflist
vim.keymap.set("n", "<leader>cc", ":cclose<cr>zz")

-- Press gx to open the link under the cursor
vim.keymap.set({ "n", "v" }, "gx", ":sil !open <cWORD><cr>", { silent = true })
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

-- Press leader rw to rotate open windows
vim.keymap.set("n", "<leader>rw", ":RotateWindows<cr>", { desc = "[R]otate [W]indows" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })

-- new file
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- quit
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- SymbolsOutline
vim.keymap.set("n", "<leader>so", ":SymbolsOutline<cr>")
