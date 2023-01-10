-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd.packadd('packer.nvim')

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use { -- Gruvbox Theme
        'luisiacc/gruvbox-baby',
        as = 'gruvbox-baby',
        config = function()
            vim.cmd('colorscheme gruvbox-baby')
        end
    }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use { -- Additional text objects via treesitter
        'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }
    use('nvim-treesitter/playground')

    use('aenichols/harpoon')
    use('mbbill/undotree')
    use('tpope/vim-fugitive')

    use { -- LSP Configuration & Plugins
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },

            -- Useful status updates for LSP
            { 'j-hui/fidget.nvim' },
        }
    }

    use 'folke/zen-mode.nvim'
    use 'github/copilot.vim'

    -- ADDITIONAL ###############################################################
    -- Fancier statusline
    use 'nvim-lualine/lualine.nvim'
    -- Comment
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }
    -- Floating terminal
    use { 'akinsho/toggleterm.nvim', tag = '*', config = function()
        require('toggleterm').setup()
    end }
    -- Maximizer
    use 'szw/vim-maximizer'
    -- Vim be good
    use 'theprimeagen/vim-be-good'

end)
