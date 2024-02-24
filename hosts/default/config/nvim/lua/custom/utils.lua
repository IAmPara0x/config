local M = {}

function M.make_ivy_function  (name)
   return string.format(":lua require'telescope.builtin'.%s(require('telescope.themes').get_ivy({}))<CR>", name)
end

return M
