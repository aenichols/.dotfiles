local home = os.getenv('HOME')
local dap = require('dap')

dap.adapters.coreclr = {
  type = 'executable',
  command = home .. '/netcoredbg/build/bin/netcoredbg',
  args = {'--interpreter=vscode'}
}

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll > ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end,
  },
}
