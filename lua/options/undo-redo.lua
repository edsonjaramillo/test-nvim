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


-- Add keymapping for git revert
vim.keymap.set("n", "<leader>z", prompt_git_revert, {
    noremap = true,
    silent = true,
    desc = "Revert all changes to last git commit"
})

-- Define mappings for undo/redo operations
local mappings = {
    { modes = { "n", "i" }, key = "<C-z>", action = undo, desc = "Undo" },
    { modes = { "n", "i" }, key = "<C-x>", action = redo, desc = "Redo" },
}

-- Apply all mappings
for _, mapping in ipairs(mappings) do
    for _, mode in ipairs(mapping.modes) do
        vim.keymap.set(mode, mapping.key, mapping.action, {
            noremap = true,
            silent = true,
            desc = mapping.desc .. " in " .. mode .. " mode"
        })
    end
end
