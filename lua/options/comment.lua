-- Function to comment the current line
local function comment_current_line()
    require('Comment.api').toggle.linewise.current()
end

-- Map Ctrl-/ in normal mode to the comment function
vim.keymap.set("n", "<C-_>", comment_current_line, {
    noremap = true,
    silent = true,
    desc = "Comment the current line"
})
