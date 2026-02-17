local module = {}

function module:setup_bindings()
    require('telescope').setup({
        defaults = {
            file_ignore_patterns = {"^%.git/"},
            vimgrep_arguments = {
                "rg", "--color=never", "--no-heading", "--with-filename",
                "--line-number", "--column", "--smart-case", "--hidden"
            }
        },
        pickers = {find_files = {hidden = true}}
    })
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files,
                   {desc = 'Telescope find files'})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep,
                   {desc = 'Telescope live grep'})
    vim.keymap.set('n', '<leader>fs', builtin.git_status,
                   {desc = 'Telescope git status'})
end

return module
