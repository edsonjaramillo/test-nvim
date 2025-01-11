---@file
---@author Edson
---@date 2025

-- Prompts user to open a new file using Telescope
---@return nil
local function open_new_file()
    local options = { "Yes", "No" }
    vim.ui.select(options, {
        prompt = "Do you want to open a new file?",
        format_item = function(item)
            return item
        end,
    }, function(choice)
        if choice == "Yes" then
            -- Clear the screen for neatness
            vim.cmd.redraw()
            -- Open file picker
            require('telescope.builtin').find_files()
        else
            -- Clear the screen for neatness
            vim.cmd.redraw()
            -- Force quit (discards all changes in the current buffer)
            vim.cmd.quit({ bang = true })
        end
    end)
end

-- Handles the save workflow for modified buffers
---@return nil
local function prompt_save_or_discard()
    if vim.bo.modified then
        local options = { "Yes", "No" }
        -- Prompt user to save or not
        vim.ui.select(options, {
            prompt = "Buffer has unsaved changes. Save changes?",
            format_item = function(item)
                return item
            end,
        }, function(choice)
            if choice == "Yes" then
                -- Force save: equivalent to :write!
                vim.cmd.write({ bang = true })
                vim.cmd.redraw()
                open_new_file()
            else
                -- Discard changes: skip saving
                vim.cmd.redraw()
                open_new_file()
            end
        end)
    else
        -- If no modifications, just jump straight to open_new_file
        open_new_file()
    end
end

-- Keymapping: ctrl-w triggers the workflow
vim.keymap.set("n", "<C-w>", prompt_save_or_discard, {
    noremap = true,
    silent = true,
    desc = "Prompt to save current file and then open new file"
})
