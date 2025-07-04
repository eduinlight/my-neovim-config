return {
  { "mfussenegger/nvim-dap" },
  { "nvim-telescope/telescope-dap.nvim" },
  { 'sakhnik/nvim-gdb' },
  { 
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      
      vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
      vim.fn.sign_define('DapStopped', { text = '>', texthl = '', linehl = '', numhl = '' })
      
      K('n', '<F5>', dap.continue)
      K('n', '<F6>', dap.step_over)
      K('n', '<F7>', dap.step_into)
      K('n', '<F8>', dap.step_out)
      K('n', '<F9>', dap.toggle_breakpoint)
      K('n', '<leader>dtv', ":Telescope dap variables previewer=false<CR>")
      K('n', '<leader>dtb', ":Telescope dap list_breakpoints<CR>")
      K('n', '<leader>dtc', ":Telescope dap commands<CR>")
      K('n', '<leader>dtg', ":Telescope dap frames<CR>")
      
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
      
      dap.adapters.node = {
        type = "server",
        host = "localhost",
        port = "9000",
      }
      dap.configurations.javascript = {
        {
          type = "node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
        },
      }
      
      dap.adapters.codelldb = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = "codelldb",
          args = { "--port", "${port}" },
        }
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          stopOnEntry = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp
    end
  },
}

