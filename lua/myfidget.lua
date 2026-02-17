local module = {}

function module:setup()
    require("fidget").setup {
        notification = {
            view = {render_message = function(msg, _) return msg end},
            window = {align = "top", winblend = 0}
        }
    }
end

return module
