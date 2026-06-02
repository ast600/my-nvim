package.path = package.path .. ";./?.lua"

vim.opt.number = true

local Plug = vim.fn['plug#']

vim.call('plug#begin')
vim.o.exrc = true
vim.opt.mouse = ""

Plug('mfussenegger/nvim-dap', {['tag'] = '0.10.0'})
Plug('nvim-lua/plenary.nvim', {['tag'] = 'v0.1.4'})
Plug('nvim-telescope/telescope.nvim', {['branch'] = '0.1.x'})
Plug('scalameta/nvim-metals',
     {['branch'] = 'main', ['for'] = {'scala', 'sbt', 'java'}})
Plug('j-hui/fidget.nvim', {['tag'] = 'v1.6.1'})
Plug('hrsh7th/cmp-nvim-lsp',
     {['commit'] = '99290b3ec1322070bcfb9e846450a46f6efa50f0'})
Plug('hrsh7th/cmp-buffer',
     {['commit'] = '3022dbc9166796b644a841a02de8dd1cc1d311fa'})
Plug('hrsh7th/nvim-cmp', {['tag'] = 'v0.0.2'})
Plug('lewis6991/gitsigns.nvim', {['tag'] = 'v1.0.2'})
Plug('navarasu/onedark.nvim',
     {['commit'] = '0e5512d1bebd1f08954710086f87a5caa173a924'})

vim.call('plug#end')
vim.cmd('silent! colorscheme onedark')

vim.cmd([[
	function! CopyRelBufPath()
		let @+ = expand('%')
	endfunction
]])

vim.cmd([[
	function! CopyRelBufPathWLoc()
		let @+ = expand('%') . ':' . line('.')
	endfunction
]])

vim.cmd([[
	function! CopyQfItem(idx)
		let @+ = getqflist({'items': 0}).items[a:idx].text
	endfunction
]])

vim.cmd([[
	function! CopyLocItem(idx)
		let @+ = getloclist(0, {'items': 0}).items[a:idx].text
	endfunction
]])

require('mytelescope').setup_bindings()
require('mycmp').setup()
require('mydap').setup()
require('mylsp').setup()
require('myfidget').setup()
require('mygitsigns').setup()

vim.api.nvim_create_autocmd('TextYankPost', {
    pattern = '*',
    group = vim.api.nvim_create_augroup('highlight_yank', {clear = true}),
    desc = 'Highlight yanked block',
    callback = function() vim.highlight.on_yank({timeout = 100}) end
})

vim.opt.grepprg =
    "grep --recursive --with-filename --line-number --color=never --exclude-dir='.git' --exclude-dir='.metals' --exclude-dir='target'"
vim.opt.grepformat = '%f:%l:%m'

vim.keymap.set('n', '[b', ':bprev<CR>', {desc = 'Previous buffer'})
vim.keymap.set('n', ']b', ':bnext<CR>', {desc = 'Next buffer'})
vim.keymap.set('n', '[q', ':cprev<CR>', {desc = 'Previous quickfix item'})
vim.keymap.set('n', ']q', ':cnext<CR>', {desc = 'Next quickfix item'})
vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition,
               {desc = 'Go to definition'})
vim.keymap.set("n", "<leader>gi", vim.lsp.buf.implementation,
               {desc = 'Go to implementation'})
vim.keymap.set("n", "<leader>fr", vim.lsp.buf.references,
               {desc = 'Find references'})
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,
               {desc = 'Code action'})
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, {desc = 'Rename'})
vim.keymap.set("n", "<leader>bd", vim.diagnostic.setloclist,
               {desc = 'Buffer diagnostic'})
vim.keymap.set("n", "<leader>wd", function()
    vim.diagnostic.setqflist({severity = {min = vim.diagnostic.severity.WARN}})
end, {desc = 'Workspace diagnostic'})
vim.keymap.set("n", "<leader>h", vim.lsp.buf.hover, {desc = 'Hover'})
vim.opt.wildignore:append{'**/.git/**', '**/target/**', '**/.metals/**'}

