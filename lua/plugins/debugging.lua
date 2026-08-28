return {
  { "mfussenegger/nvim-dap" },
  { "nvim-telescope/telescope-dap.nvim" },
  { 'sakhnik/nvim-gdb' },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      enabled = true,
      highlight_changed_variables = true,
      show_stop_reason = true,
      virt_text_pos = "eol",
    },
  },
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
      local function when_stopped(cmd)
        return function()
          local session = dap.session()
          if not session or not session.stopped_thread_id or not session.current_frame then
            vim.notify("No debug session stopped at a breakpoint", vim.log.levels.WARN)
            return
          end
          vim.cmd(cmd)
        end
      end

      K('n', '<leader>dtv', when_stopped("Telescope dap variables previewer=false"))
      K('n', '<leader>dtb', ":Telescope dap list_breakpoints<CR>")
      K('n', '<leader>dtc', ":Telescope dap commands<CR>")
      K('n', '<leader>dtg', when_stopped("Telescope dap frames"))
      local widgets = require("dap.ui.widgets")
      K({ 'n', 'v' }, '<leader>dh', widgets.hover)
      K('n', '<leader>ds', function()
        widgets.centered_float(widgets.scopes)
      end)
      K('n', '<leader>du', dapui.toggle)
      K('n', '<leader>dq', function()
        dap.terminate()
        dapui.close()
      end)
      
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      local collapsed_scopes = { Global = true }
      dap.listeners.before.scopes["dapui_expand_scopes"] = function(_, _, response)
        for _, scope in ipairs(response and response.scopes or {}) do
          if not collapsed_scopes[scope.name] then
            scope.expensive = false
          end
        end
      end
      
      local js_debug_adapter = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter"
      for _, adapter in ipairs({ "pwa-node", "pwa-chrome" }) do
        dap.adapters[adapter] = {
          type = "server",
          host = "localhost",
          port = "${port}",
          executable = {
            command = js_debug_adapter,
            args = { "${port}" },
          },
        }
      end

      local js_skip_files = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" }

      local js_configurations = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (node)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          protocol = "inspector",
          console = "integratedTerminal",
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (tsx)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeArgs = { "--import", "tsx" },
          sourceMaps = true,
          console = "integratedTerminal",
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch npm script",
          runtimeExecutable = "npm",
          runtimeArgs = function()
            return { "run", vim.fn.input("Script: ", "dev") }
          end,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          console = "integratedTerminal",
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug jest (current file)",
          runtimeExecutable = "node",
          runtimeArgs = { "./node_modules/jest/bin/jest.js", "--runInBand", "--no-coverage", "${file}" },
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Debug vitest (current file)",
          runtimeExecutable = "node",
          runtimeArgs = { "./node_modules/vitest/vitest.mjs", "run", "${file}" },
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to port",
          address = "localhost",
          port = function()
            return tonumber(vim.fn.input("Port: ", "9229"))
          end,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          skipFiles = js_skip_files,
        },
        {
          type = "pwa-chrome",
          request = "launch",
          name = "Launch chrome",
          url = function()
            return vim.fn.input("URL: ", "http://localhost:3000")
          end,
          webRoot = "${workspaceFolder}",
          sourceMaps = true,
          userDataDir = false,
        },
      }

      for _, language in ipairs({ "javascript", "typescript", "javascriptreact", "typescriptreact" }) do
        dap.configurations[language] = js_configurations
      end
      
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

