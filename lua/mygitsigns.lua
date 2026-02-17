local module = {}

local gitsigns = require('gitsigns')

function module:setup()
    gitsigns.setup {
        on_attach = function(buf_no)
            vim.keymap.set('n', '<leader>bl',
                           function()
                gitsigns.blame_line({full = false})
            end, {desc = 'Blame line', buffer = buf_no})
            vim.keymap.set('n', '<leader>ph', gitsigns.preview_hunk,
                           {desc = 'Preview hunk', buffer = buf_no})
        end
    }
end

return module
