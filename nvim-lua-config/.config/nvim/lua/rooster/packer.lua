return require("packer").startup(function()
    use("wbthomason/packer.nvim")
    use("sbdchd/neoformat")

    -- Simple plugins can be specified as strings
    use("TimUntersberger/neogit")

    -- TJ created lodash of neovim
    use("nvim-lua/plenary.nvim")
    use("nvim-lua/popup.nvim")
    use("nvim-telescope/telescope.nvim")

    -- All the things
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/nvim-cmp")
    use("onsails/lspkind-nvim")
    use("nvim-lua/lsp_extensions.nvim")
    use("glepnir/lspsaga.nvim")
    use("simrat39/symbols-outline.nvim")
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")

    -- Primeagen doesn"t create lodash
    use("ThePrimeagen/harpoon")

    use("mbbill/undotree")

    -- Colorscheme section
    use("gruvbox-community/gruvbox")
    use("luisiacc/gruvbox-baby")
    use("folke/tokyonight.nvim")
    use("flazz/vim-colorschemes")

    use("nvim-treesitter/nvim-treesitter", {
        run = ":TSUpdate"
    })

    use("nvim-treesitter/playground")
    use("romgrk/nvim-treesitter-context")

    use("mfussenegger/nvim-dap")
    use("rcarriga/nvim-dap-ui")
    use("theHamsta/nvim-dap-virtual-text")

    -- Airline
    use("vim-airline/vim-airline")
    use("vim-airline/vim-airline-themes")

    -- Maximizer
    use("szw/vim-maximizer")

    -- Zen Mode
    use("folke/zen-mode.nvim")

    -- Zen Bones
    use("rktjmp/lush.nvim")
    use("mcchrish/zenbones.nvim")

    -- Ale for stupid EsLints
    use("w0rp/ale")

    -- Csharp editorconfig
    -- use("editorconfig/editorconfig-vim'
    use("gpanders/editorconfig.nvim")

    -- Csharp lsp
    use {'neoclide/coc.nvim', branch = 'release'}

    -- Commenter
    use("numToStr/Comment.nvim")

    -- Copilot
    use("github/copilot.vim")
    use("hrsh7th/cmp-copilot")
end)
