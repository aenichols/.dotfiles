-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\ANTHON~1.NIC\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?.lua;C:\\Users\\ANTHON~1.NIC\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\ANTHON~1.NIC\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\ANTHON~1.NIC\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\ANTHON~1.NIC\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.0-beta3\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ale = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\ale",
    url = "https://github.com/w0rp/ale"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n]\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\23alpha.themes.theta\nsetup\nalpha\frequire\0" },
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-copilot"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-copilot",
    url = "https://github.com/hrsh7th/cmp-copilot"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  cmp_luasnip = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["copilot.vim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\copilot.vim",
    url = "https://github.com/github/copilot.vim"
  },
  ["editorconfig.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\editorconfig.nvim",
    url = "https://github.com/gpanders/editorconfig.nvim"
  },
  ["floaterm.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\floaterm.nvim",
    url = "https://github.com/doums/floaterm.nvim"
  },
  gruvbox = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gruvbox",
    url = "https://github.com/gruvbox-community/gruvbox"
  },
  ["gruvbox-baby"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\gruvbox-baby",
    url = "https://github.com/luisiacc/gruvbox-baby"
  },
  harpoon = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\harpoon",
    url = "https://github.com/ThePrimeagen/harpoon"
  },
  ["iron.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\iron.nvim",
    url = "https://github.com/hkupty/iron.nvim"
  },
  ["jupyter_ascending.vim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\jupyter_ascending.vim",
    url = "https://github.com/untitled-ai/jupyter_ascending.vim"
  },
  ["jupytext.vim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\jupytext.vim",
    url = "https://github.com/GCBallesteros/jupytext.vim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lspsaga.nvim",
    url = "https://github.com/glepnir/lspsaga.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  neoformat = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\neoformat",
    url = "https://github.com/sbdchd/neoformat"
  },
  ["nvim-cmp"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-dap"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap",
    url = "https://github.com/mfussenegger/nvim-dap"
  },
  ["nvim-dap-ui"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap-ui",
    url = "https://github.com/rcarriga/nvim-dap-ui"
  },
  ["nvim-dap-virtual-text"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-dap-virtual-text",
    url = "https://github.com/theHamsta/nvim-dap-virtual-text"
  },
  ["nvim-ipy"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-ipy",
    url = "https://github.com/bfredl/nvim-ipy"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-treesitter-context"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter-context",
    url = "https://github.com/romgrk/nvim-treesitter-context"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["omnisharp-extended-lsp.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\omnisharp-extended-lsp.nvim",
    url = "https://github.com/hoffs/omnisharp-extended-lsp.nvim"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  playground = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\playground",
    url = "https://github.com/nvim-treesitter/playground"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["symbols-outline.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\symbols-outline.nvim",
    url = "https://github.com/simrat39/symbols-outline.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyonight.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  undotree = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-airline"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-airline",
    url = "https://github.com/vim-airline/vim-airline"
  },
  ["vim-airline-themes"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-airline-themes",
    url = "https://github.com/vim-airline/vim-airline-themes"
  },
  ["vim-colorschemes"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-colorschemes",
    url = "https://github.com/flazz/vim-colorschemes"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-maximizer"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-maximizer",
    url = "https://github.com/szw/vim-maximizer"
  },
  ["vim-textobj-hydrogen"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-hydrogen",
    url = "https://github.com/GCBallesteros/vim-textobj-hydrogen"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-textobj-user",
    url = "https://github.com/kana/vim-textobj-user"
  },
  ["zen-mode.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  },
  ["zenbones.nvim"] = {
    loaded = true,
    path = "C:\\Users\\anthony.nichols\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\zenbones.nvim",
    url = "https://github.com/mcchrish/zenbones.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n]\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\23alpha.themes.theta\nsetup\nalpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
