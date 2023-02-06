local ll = {}

ll.component_expand = {
  linter_warnings = 'lightline#coc#warnings',
  linter_errors = 'lightline#coc#errors',
  linter_ok = 'lightline#coc#ok',
  status = 'lightline#coc#status',
}

ll.component_type = {
  linter_warnings = 'warning',
  linter_errors = 'error',
  linter_ok = 'left',
}

ll.active = {
  right = [[ 'coc_errors', 'coc_warnings', 'coc_ok' ]],
  left = [[ 'mode', 'paste' ], [ 'gitbranch', 'readonly', 'filename', 'modified' ]]
}
ll.component_function = {
  gitbranch = 'gitbranch#name',
  filename = 'LightlineFilename',
}

function LightlineFilename()
  return vim.fn.expand('%:p')
end

vim.g.lightline = ll
