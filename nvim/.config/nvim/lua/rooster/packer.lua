local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end


return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.x',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "ellisonleao/gruvbox.nvim",
        as = 'gruvbox',
        config = function()
            vim.cmd('colorscheme gruvbox')
        end
    }

    use({
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup {
                icons = false,
            }
        end
    })

   use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end
    }
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context');

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
            {
                'j-hui/fidget.nvim',
            },
        }
    }

    use 'folke/zen-mode.nvim'
    use 'github/copilot.vim'
    use 'eandrju/cellular-automaton.nvim'
    use 'laytan/cloak.nvim'

    -- use('aenichols/harpoon')
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { {"nvim-lua/plenary.nvim"} }
    }

    -- ADDITIONAL #############################################################

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
    -- Magma for jupyter
    -- use { 'dccsillag/magma-nvim', run = ':UpdateRemotePlugins' }

    use 'airblade/vim-gitgutter'

    if PACKER_BOOTSTRAP then
	    require("packer").sync()
    end
end)
