return {
    "uga-rosa/ccc.nvim",
    config = function()
        local ccc = require("ccc")
        ccc.setup({
            inputs = {
                ccc.input.rgb,
                ccc.input.hsl,
                ccc.input.oklch,
            },
            outputs = {
                ccc.output.hex,
                ccc.output.css_rgb,
                ccc.output.css_hsl,
                ccc.output.css_oklab,
                ccc.output.css_oklch,
            },
            highlighter = {
                auto_enable = true,
                lsp = true,
            },
        })
        -- leader cp for command :CccPick
        vim.keymap.set("n", "<leader>cp", function()
            vim.cmd("CccPick")
        end, { noremap = true, silent = true, desc = "Colorizer picker", })
    end,
}
