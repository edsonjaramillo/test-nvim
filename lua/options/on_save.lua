---@file
---@author Edson
---@date 2025

-- Prompts user to open a new file using Telescope
---@return nil
local function open_new_file()
    local options = { "Yes", "No" }
    -- Create selection dialog for new file
    vim.ui.select(options, {
        prompt = "Do you want to open a new file?",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice == "Yes" then
            vim.cmd.redraw()                          -- Clear screen
            require('telescope.builtin').find_files() -- Open file picker
        else
            vim.cmd.redraw()                          -- Clear screen
            vim.cmd.quit({ bang = true })             -- Force quit
        end
    end)
end

-- Handles the save workflow for modified buffers
---@return nil
local function prompt_save_or_discard()
    -- Check if current buffer has unsaved changes
    if vim.bo.modified then
        local options = { "Yes", "No" }
        -- Create save dialog
        vim.ui.select(options, {
            prompt = "Buffer has unsaved changes. Save changes?",
            format_item = function(item)
                return item
            end,
        }, function(choice)
            if choice == "Yes" then
                vim.cmd.write({ bang = true }) -- Force save
                vim.cmd.redraw()               -- Clear screen
                open_new_file()                -- Prompt for new file
            else
                vim.cmd.redraw()               -- Clear screen
                open_new_file()                -- Prompt for new file without saving
            end
        end)
    else
        open_new_file() -- No changes, directly prompt for new file
    end
end

-- Keymapping: <leader>w triggers the save/new file workflow
vim.keymap.set("n", "<leader>w", prompt_save_or_discard, {
    noremap = true,
    silent = true,
    desc = "Save current file and open new file workflow"
})
