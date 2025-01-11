local function undo()
    vim.cmd("undo")
end

local function redo()
    vim.cmd("redo")
end


local function prompt_git_revert()
    -- Get current file path
    local file_path = vim.fn.expand('%:p')

    -- Check if file is tracked and modified
    local git_status = vim.fn.system('git -C ' .. vim.fn.expand('%:p:h') .. ' status --porcelain ' .. file_path)
    if git_status == "" then
        vim.notify("File unchanged or not in git", vim.log.levels.INFO)
        return
    end

    -- Prompt for confirmation
    local options = { "Yes", "No" }
    vim.ui.select(options, {
        prompt = "Revert changes in current file?",
        format_item = function(item) return item end,
    }, function(choice)
        if choice == "Yes" then
            -- Use git restore for safer file restoration
            local result = vim.fn.system('git restore ' .. file_path)

            if vim.v.shell_error == 0 then
                vim.cmd('e!') -- Reload buffer
                vim.notify("File restored to last commit", vim.log.levels.INFO)
            else
                vim.notify("Failed to restore: " .. result, vim.log.levels.ERROR)
            end
        end
    end)
end

-- Map to <leader>gr
vim.keymap.set("n", "<leader>gr", prompt_git_revert, {
    noremap = true,
    silent = true,
    desc = "Restore file to last git commit"
})

-- Add keymapping for git revert
vim.keymap.set("n", "<leader>z", prompt_git_revert, {
    noremap = true,
    silent = true,
    desc = "Revert all changes to last git commit"
})
vim.keymap.set("n", "<C-z>", undo, { noremap = true, silent = true, desc = "Undo" })
vim.keymap.set("n", "<C-x>", redo, { noremap = true, silent = true, desc = "Redo" })
