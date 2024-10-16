-- Keymap Settings
-- <CR> = ENTER

-- Keymap Settings
local mapKey = require("utils.keyMapper").mapKey

-- Use Leader + C for copying to clipboard in visual mode
mapKey("<leader>c", '"+y', "v")

-- Function to resize the split
function ResizeSplit(direction)
	if direction == "increase" then
		vim.cmd("vertical resize +3") -- Increase the width by 3
	elseif direction == "decrease" then
		vim.cmd("vertical resize -3") -- Decrease the width by 3
	end
end

-- Key mapping to decrease the size of the right split
mapKey("<C-=>", ":lua ResizeSplit('increase')<CR>")

-- Key mapping to increase the size of the right split
mapKey("<C-->", ":lua ResizeSplit('decrease')<CR>")

-- Map <leader>e to toggle
mapKey("<leader>e", ":Neotree toggle<CR>")

-- pane navigation
mapKey("<leader><Left>", "<C-w>h") -- left
mapKey("<leader><Right>", "<C-w>l") -- right
mapKey("<leader><Up>", "<C-w>k") -- up
mapKey("<leader><Down>", "<C-w>j") -- down

-- clear search highlights when using /
mapKey("<leader>h", ":nohlsearch<CR>")

-- back to the nvim lobby menu
mapKey("<leader>w", ":Ex<CR>")

-- fuzzy finder
mapKey("<leader>ff", ":Telescope find_files<CR>")

-- live grep finder
mapKey("<leader>fd", ":Telescope live_grep<CR>")

-- indentation
mapKey("<", "<gv", "v")
mapKey(">", ">gv", "v")

--- run current python file with leader+r
mapKey("<leader>r", ":w<CR>:!python3 %<CR>")

-- Function to run current Python file in IPython
function RunPythonInIPython()
	local current_file = vim.fn.expand("%:p") -- Get the full path of the current file
	vim.cmd("rightbelow vsplit") -- Create a vertical split
	vim.cmd("term ipython -i " .. current_file) -- Open IPython with the current file
end
-- Create a command for it
vim.api.nvim_create_user_command("RunPythonInIPython", RunPythonInIPython, {})
-- Key mapping to run the current Python file in IPython
vim.api.nvim_set_keymap("n", "<leader>re", ":RunPythonInIPython<CR>", { noremap = true, silent = true })

-- Add the faster.nvim mappings
-- Normal mode: Faster movement for j and k
mapKey("j", "<Plug>(faster_move_j)", "n")
mapKey("k", "<Plug>(faster_move_k)", "n")

-- Normal mode: Faster movement for gj and gk (for wrapped lines)
mapKey("j", "<Plug>(faster_move_gj)", "n")
mapKey("k", "<Plug>(faster_move_gk)", "n")

-- Visual mode: Faster movement for j and k
mapKey("j", "<Plug>(faster_vmove_j)", "v")
mapKey("k", "<Plug>(faster_vmove_k)", "v")

-- Normal mode: Faster movement for arrow keys (Down and Up)
mapKey("<Down>", "<Plug>(faster_move_j)", "n")
mapKey("<Up>", "<Plug>(faster_move_k)", "n")

-- Visual mode: Faster movement for arrow keys (Down and Up)
mapKey("<Down>", "<Plug>(faster_vmove_j)", "v")
mapKey("<Up>", "<Plug>(faster_vmove_k)", "v")

-- comment the selected words
mapKey("vf", "<Plug>(comment_toggle_linewise)", "n")
mapKey("vf", "<Plug>(comment_toggle_linewise_visual)", "x")

-- Set up keybinding to toggle Undotree
mapKey("<leader>u", vim.cmd.UndotreeToggle)

-- -- Open Git status
mapKey("<leader>gs", ":Git<CR>")

-- Open Git log
mapKey("<leader>gl", ":Git log<CR>")

-- Git push
mapKey("<leader>gp", ":Git push origin main<CR>")

-- -- Git pull
-- mapKey("<leader>gpl", ":Git pull<CR>")

-- -- Git diff
-- mapKey("<leader>gd", ":Gdiff<CR>")

-- -- Git blame
-- mapKey("<leader>gb", ":Git blame<CR>")

-- Git add (stage) current file
mapKey("<leader>ga", ":Git add %<CR>")

-- Git add all (stage all changes)
mapKey("<leader>gA", ":Git add .<CR>")

-- Git commit (opens commit message buffer)
mapKey("<leader>gc", function()
	vim.ui.input({ prompt = "Commit message: " }, function(msg)
		if msg then
			vim.cmd(string.format('Git commit -m "%s"', msg))
		end
	end)
end)

-- Git add all and commit (with prompt for commit message)
mapKey("<leader>gac", function()
	vim.ui.input({ prompt = "Commit message: " }, function(msg)
		if msg then
			vim.cmd("Git add .")
			vim.cmd(string.format('Git commit -m "%s"', msg))
		end
	end)
end)
