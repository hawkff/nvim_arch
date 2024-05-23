local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

local plugins = {
    -- init.lua:
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        -- or                              , branch = '0.1.x',
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "folke/trouble.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {

        },
    },

    {
        "theprimeagen/harpoon",
    },

    {
        "tpope/vim-commentary",
    },

    {
        "tpope/vim-fugitive",
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
    },

    {
        "mbbill/undotree",
    },

    {
        "eandrju/cellular-automaton.nvim",
    },

    {
        "EdenEast/nightfox.nvim",
        config = function()
            vim.cmd("colorscheme carbonfox")
        end,
    },

    {
        "Mofiqul/dracula.nvim",
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "L3MON4D3/LuaSnip",
            "rafamadriz/friendly-snippets",
            --addition
            "onsails/lspkind.nvim", -- vs-code like pictograms
        },
    },

    {
        "VonHeikemen/lsp-zero.nvim",
        branch = "v3.x",
    },

    {
        "tpope/vim-surround",
    },

    {

        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },

    {
        "dense-analysis/ale",
    },

    {
        "stevearc/conform.nvim",
        opts = {},
    },

    {
        -- dependencies = { "MunifTanjim/nui.nvim" },
    },

    {
        "mfussenegger/nvim-dap",
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        lazy = true,
    },

    {
        -- "zbirenbaum/copilot.lua",
    },

    {
        "nvim-lualine/lualine.nvim",
    },

    {
        "kevinhwang91/nvim-ufo",
        dependencies = { "kevinhwang91/promise-async" },
    },

    {
        "NvChad/nvim-colorizer.lua",
    },

    {
        "j-hui/fidget.nvim",
        opts = {
            -- options
        },
    },
    {
        "AndreM222/copilot-lualine",
    },

    {
        "elkowar/yuck.vim",
    },

    {
         {"eraserhd/parinfer-rust", build = "cargo build --release"},
    },
}

require("lazy").setup(plugins, {})
