-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
   local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
      local current_file = vim.api.nvim_buf_get_name(0)
      local current_dir
      local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
      if current_file == '' then
	 current_dir = cwd
      else
      -- Extract the directory from the current file's path
	 current_dir = vim.fn.fnamemodify(current_file, ':h')
      end

  -- Find the Git root directory from the current file's path
      local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
      if vim.v.shell_error ~= 0 then
	 print 'Not a git repository. Searching on current working directory'
	 return cwd
      end
      return git_root
   end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
   local git_root = find_git_root()
   if git_root then
      require('telescope.builtin').live_grep {
	 search_dirs = { git_root },
	 }.get_ivy({})
   end
end

local configure = function ()

   local telescope = require('telescope');
   local actions = require "telescope.actions"

   telescope.setup {
      defaults = {
	 mappings = {
	    i = {
	       ['<C-j>'] = actions.move_selection_next,
	       ['<C-k>'] = actions.move_selection_previous,
	    },
	 },
      },
   }

   -- Enable telescope fzf native, if installed
   pcall(require('telescope').load_extension, 'fzf')

   local utils = require("custom.utils")

   vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
   vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
   vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
   vim.keymap.set('n', '<leader>s',
		  function()
		     -- You can pass additional configuration to telescope to change theme, layout, etc.
		     require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
									       winblend = 10,
									       previewer = false,
									   })
		  end, { desc = '[/] Fuzzily search in current buffer' })

   vim.keymap.set('n', '<leader>fb', utils.make_ivy_function("buffers"), { desc = '[S]earch [/] in Open Files' })
   vim.keymap.set('n', '<leader>ff', utils.make_ivy_function("find_files"), { desc = '[S]earch [F]iles' })
   vim.keymap.set('n', '<leader>gf', utils.make_ivy_function("git_files"), { desc = 'Search [G]it [F]iles' })
   vim.keymap.set('n', '<leader>fr', utils.make_ivy_function("live_grep") ,{ desc = '[S]earch by [G]rep' })

end

return {
   'nvim-telescope/telescope.nvim',
   branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
   config = configure
}
