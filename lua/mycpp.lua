local module = {}

function module:setup()
    vim.lsp.config('clangd', {
        cmd = {
            "clangd", "--background-index", "--clang-tidy",
            "--header-insertion=iwyu", "--completion-style=detailed",
            "--function-arg-placeholders", "--fallback-style=llvm"
        },
        filetypes = {'c', 'cpp', 'h', 'hpp'},
        root_markers = {'compile_commands.json'},
        capabilities = {
            textDocument = {
                completion = {completionItem = {snippetSupport = false}}
            }
        }
    })
    vim.lsp.enable('clangd')
end

return module
