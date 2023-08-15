local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP =
        vim.fn.system(
        {
            "git",
            "clone",
            "--depth",
            "1",
            "https://github.com/wbthomason/packer.nvim",
            install_path
        }
    )
end
vim.cmd([[packadd packer.nvim]])

local ok, packer = pcall(require, "packer")

if not ok then
    return
end

packer.init(
    {
        display = {
            open_fn = function()
                return require("packer.util").float({border = "single"})
            end,
            prompt_border = "single"
        },
        git = {
            clone_timeout = 600
        },
        auto_clean = true,
        compile_on_sync = false
    }
)

return packer.startup(
    function(use)
        use({"wbthomason/packer.nvim"})

        -- UI
        use({"rmehri01/onenord.nvim"})
        use({"kyazdani42/nvim-web-devicons", config = require("plugins.configs.icons")})
        use(
            {
                "nvim-lualine/lualine.nvim",
                config = require("plugins.configs.lualine"),
                requires = {"kyazdani42/nvim-web-devicons", opt = true}
            }
        )
        use(
            {
                "akinsho/bufferline.nvim",
                requires = {"kyazdani42/nvim-web-devicons"},
                config = require("plugins.configs.bufferline")
            }
        )
        use({"folke/which-key.nvim"})
        use(
            {
                "folke/noice.nvim",
                requires = {"MunifTanjim/nui.nvim"},
                config = require("plugins.configs.noice")
            }
        )

        use({"karb94/neoscroll.nvim", config = require("plugins.configs.neoscroll")})
        --	use({
        --		"startup-nvim/startup.nvim",
        --		requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        --		config = require("plugins.configs.startup"),
        --	})

        -- Syntax
        use(
            {
                "nvim-treesitter/nvim-treesitter",
                requires = {
                    "windwp/nvim-ts-autotag",
                    "p00f/nvim-ts-rainbow"
                },
                run = ":TSUpdate",
                config = require("plugins.configs.treesitter")
            }
        )

        -- Utilities
        use(
            {
                "kyazdani42/nvim-tree.lua",
                requires = {
                    "kyazdani42/nvim-web-devicons"
                },
                config = require("plugins.configs.nvimtree")
            }
        )
        use(
            {
                "nvim-telescope/telescope.nvim",
                requires = {
                    "nvim-lua/plenary.nvim"
                },
                config = require("plugins.configs.telescope")
            }
        )
        use({"nvim-telescope/telescope-fzf-native.nvim", run = "make"})
        use({"lukas-reineke/indent-blankline.nvim", config = require("plugins.configs.indent")})
        use({"windwp/nvim-autopairs", config = require("plugins.configs.autopairs")})
        use({"tpope/vim-surround"})
        use({"norcalli/nvim-colorizer.lua", config = require("plugins.configs.colorizer")})
        use({"wakatime/vim-wakatime"})
        use({"sbdchd/neoformat"})
        use(
            {
                "ThePrimeagen/harpoon",
                requires = {"nvim-lua/plenary.nvim"},
                config = require("plugins.configs.harpoon")
            }
        )

        -- LSP
        use(
            {
                "neovim/nvim-lspconfig",
                requires = {
                    "jose-elias-alvarez/typescript.nvim"
                }
            }
        )
        use(
            {
                "jose-elias-alvarez/null-ls.nvim",
                requires = {"nvim-lua/plenary.nvim"}
            }
        )

        -- -- Comment
        use({"numToStr/Comment.nvim", config = require("plugins.configs.comment")})
        use(
            {
                "folke/todo-comments.nvim",
                requires = "nvim-lua/plenary.nvim",
                config = require("plugins.configs.todo-comments")
            }
        )

        -- -- Completion
        use(
            {
                "hrsh7th/nvim-cmp",
                requires = {
                    "hrsh7th/cmp-nvim-lsp",
                    "hrsh7th/cmp-nvim-lua",
                    "hrsh7th/cmp-buffer",
                    "hrsh7th/cmp-path",
                    "hrsh7th/cmp-cmdline",
                    "hrsh7th/cmp-nvim-lsp-document-symbol",
                    "hrsh7th/cmp-vsnip",
                    "hrsh7th/vim-vsnip",
                    "hrsh7th/cmp-nvim-lsp-signature-help"
                },
                config = require("plugins.configs.cmp")
            }
        )
        use("rafamadriz/friendly-snippets")

        -- Tmux
        use({"aserowy/tmux.nvim", config = require("plugins.configs.tmux")})

        -- Git
        use(
            {
                "lewis6991/gitsigns.nvim",
                requires = {
                    "nvim-lua/plenary.nvim"
                },
                config = require("plugins.configs.gitsigns")
            }
        )

        -- Markdown
        use(
            {
                "davidgranstrom/nvim-markdown-preview",
                config = function()
                    vim.g.nvim_markdown_preview_format = "gfm"
                    vim.g.nvim_markdown_preview_theme = "github"
                end
            }
        )

        -- Presence
        --use("andweeb/presence.nvim")

        if PACKER_BOOTSTRAP then
            require("packer").sync()
        end
    end
)
