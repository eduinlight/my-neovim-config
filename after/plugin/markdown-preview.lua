function OpenMarkdownPreview (url)
    os.execute('silent ! lacritty.exe')
    print('ok')
end
vim.g.mkdp_browserfunc = OpenMarkdownPreview
