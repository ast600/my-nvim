local module = {}

function module:setup()
    local cmp = require('cmp')
    cmp.setup({
        sources = {{name = 'nvim_lsp'}, {name = 'buffer'}},
        snippet = {expand = function(args) vim.snippet.expand(args.body) end},
        mapping = cmp.mapping.preset.insert({
            ['<CR>'] = cmp.mapping.confirm({select = false})
        }),
        completion = {autocomplete = false}
    })
end

return module
