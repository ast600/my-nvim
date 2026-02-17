local module = {}

function module:setup()
    vim.lsp.config('gopls', {
        cmd = {'gopls', 'serve'},
        filetypes = {'go'},
        root_markers = {'go.work', 'go.mod', '.git'},
        capabilities = {
            textDocument = {
                completion = {completionItem = {snippetSupport = false}}
            }
        },
        settings = {
            gopls = {analyses = {unusedparams = true}, staticcheck = true}
        }
    })
    vim.lsp.enable('gopls')
end

return module
