local configure = function ()

  local neogit = require("neogit")

   vim.keymap.set('n', '<leader>gs', ":Neogit <CR>", { desc = '[S]earch [F]iles' })

  neogit.setup {
    mappings = {
      commit_editor = {
	["q"] = "Close",
	["<c-c><c-c>"] = "Submit",
	["<c-c><c-k>"] = "Abort",
      },
      rebase_editor = {
	["p"] = "Pick",
	["r"] = "Reword",
	["e"] = "Edit",
	["s"] = "Squash",
	["f"] = "Fixup",
	["x"] = "Execute",
	["d"] = "Drop",
	["b"] = "Break",
	["q"] = "Close",
	["<cr>"] = "OpenCommit",
	["gk"] = "MoveUp",
	["gj"] = "MoveDown",
	["<c-c><c-c>"] = "Submit",
	["<c-c><c-k>"] = "Abort",
      },
      finder = {
	["<cr>"] = "Select",
	["<c-c>"] = "Close",
	["<esc>"] = "Close",
	["<c-n>"] = "Next",
	["<c-p>"] = "Previous",
	["<down>"] = "Next",
	["<up>"] = "Previous",
	["<tab>"] = "MultiselectToggleNext",
	["<s-tab>"] = "MultiselectTogglePrevious",
	["<c-j>"] = "NOP",
      },
      -- Setting any of these to `false` will disable the mapping.
      popup = {
	["?"] = "HelpPopup",
	["A"] = "CherryPickPopup",
	["D"] = "DiffPopup",
	["M"] = "RemotePopup",
	["P"] = "PushPopup",
	["X"] = "ResetPopup",
	["Z"] = "StashPopup",
	["b"] = "BranchPopup",
	["c"] = "CommitPopup",
	["f"] = "FetchPopup",
	["l"] = "LogPopup",
	["m"] = "MergePopup",
	["p"] = "PullPopup",
	["r"] = "RebasePopup",
	["v"] = "RevertPopup",
      },
      status = {
	["q"] = "Close",
	["I"] = "InitRepo",
	["1"] = "Depth1",
	["2"] = "Depth2",
	["3"] = "Depth3",
	["4"] = "Depth4",
	["<tab>"] = "Toggle",
	["x"] = "Discard",
	["s"] = "Stage",
	["S"] = "StageUnstaged",
	["<c-s>"] = "StageAll",
	["u"] = "Unstage",
	["U"] = "UnstageStaged",
	["$"] = "CommandHistory",
	["#"] = "Console",
	["Y"] = "YankSelected",
	["<c-r>"] = "RefreshBuffer",
	["<enter>"] = "GoToFile",
	["<c-v>"] = "VSplitOpen",
	["<c-x>"] = "SplitOpen",
	["<c-t>"] = "TabOpen",
	["{"] = "GoToPreviousHunkHeader",
	["}"] = "GoToNextHunkHeader",
      },
    },
  }
end

return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration

    -- Only one of these is needed, not both.
    "nvim-telescope/telescope.nvim", -- optional
    "ibhagwan/fzf-lua",              -- optional
  },
  config = configure
}
