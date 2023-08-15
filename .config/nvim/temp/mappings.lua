local ok, wk = pcall(require, "which-key")

if not ok then
    return
end

local opts = {
    mode = "n",
    prefix = "",
    silent = true,
    noremap = true,
    nowait = true
}

wk.register(
    {
        ["ga"] = {"g<c-a>", "Create number sequence"}
    },
    {
        mode = "v",
        prefix = "",
        silent = true,
        noremap = true,
        nowait = true
    }
)

wk.register(
    {
        ["<c-q>"] = {"<cmd>q<cr>", "[BUFFER] Quit"},
        ["<S-Right>"] = {"<cmd>bn<cr>", "[BUFFER] Go next buffer"},
        ["<S-Left>"] = {"<cmd>bp<cr>", "[BUFFER] Go previous buffer"},
        ["<c-s>"] = {"<cmd>w<cr>", "[BUFFER] Save current buffer"},
        ["<leader>q"] = {"<cmd>bd<cr>", "[BUFFER] Close current buffer"},
        ["<leader>f"] = {"za", "[FOLD] Toggle Fold"},
        ["<leader>n"] = {
            name = "[NVIMTREE]",
            t = {"<cmd>NvimTreeToggle<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Toggle"},
            f = {"<cmd>NvimTreeFocus<cr> <cmd>NvimTreeRefresh<cr>", "[NVIMTREE] Focus"}
        },
        ["<leader>t"] = {
            name = "[TELESCOPE]",
            f = {"<cmd>Telescope find_files hidden=true no_ignore=true<cr>", "[TELESCOPE] Find File"},
            g = {"<cmd>Telescope live_grep<cr>", "[TELESCOPE] Find File by grep"},
            b = {"<cmd>Telescope buffers<cr>", "[TELESCOPE] Find buffers"},
            h = {"<cmd>Telescope help_tags<cr>", "[TELESCOPE] Help tags"},
            m = {"<cmd>Telescope marks<cr>", "[TELESCOPE] Marks"}
        },
        ["<leader>g"] = {
            name = "[GITSIGNS]",
            s = {"<cmd>Gitsigns toggle_signs<cr>", "[GITSIGNS] Toggle signs"},
            h = {"<cmd>Gitsigns preview_hunk<cr>", "[GITSIGNS] Preview hunk"},
            d = {"<cmd>Gitsigns diffthis<cr>", "[GITSIGNS] Show diff"}
        },
        ["<leader>h"] = {
            name = "[HARPOON]",
            a = {"<cmd>lua require('harpoon.ui').nav_file(1)<cr>", "[HARPOON] Nav file 1"},
            s = {"<cmd>lua require('harpoon.ui').nav_file(2)<cr>", "[HARPOON] Nav file 2"},
            d = {"<cmd>lua require('harpoon.ui').nav_file(3)<cr>", "[HARPOON] Nav file 3"},
            f = {"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", "[HARPOON] Toggle quick menu"},
            h = {"<cmd>lua require('harpoon.mark').add_file()<cr>", "[HARPOON] Add file"}
        }
    },
    opts
)

wk.setup({})
