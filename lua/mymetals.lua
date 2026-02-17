local module = {}

function module:setup()
    local metals = require('metals')
    local metals_config = metals.bare_config()
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
    metals_config.capabilities.textDocument.completion.completionItem
        .snippetSupport = false
    metals_config.init_options.statusBarProvider = "off"
    metals_config.on_attach = metals.setup_dap

    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals",
                                                          {clear = true})

    vim.api.nvim_create_autocmd("FileType", {
        pattern = {"scala", "sbt", "java"},
        callback = function(args)
            metals.initialize_or_attach(metals_config)
        end,
        group = nvim_metals_group
    })

    vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = {'*.scala'},
        group = nvim_metals_group,
        callback = function(args)
            local client = vim.lsp.get_clients({
                bufnr = args.buf,
                name = "metals"
            })[1]

            if client ~= nil then
                vim.lsp.buf.format({bufnr = args.buf, id = client.id})
            end
        end
    })

end

return module
