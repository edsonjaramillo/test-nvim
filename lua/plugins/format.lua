local format_settings = {
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
}

return {
    {
        'nvimtools/none-ls.nvim',
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-null-ls.nvim",
        },
        config = function()
            require("mason-null-ls").setup({
                ensure_installed = { "stylua", "gofumpt" }
            })
        end,
    },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            -- Setup
            local conform = require("conform")
            conform.setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    go = { "gofumpt" },
                },
                format_on_save = format_settings,
            })

            -- Keybindings
            vim.keymap.set({ "n", "v" }, "<leader>s", function()
                conform.format(format_settings)
            end, { desc = "Format file or range (in visual mode)" })

            -- Automatically format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    conform.format({ bufnr = args.buf })
                end,
            })
        end,
    }
}
