local configure = function ()
  require('leap').create_default_mappings()
end

return
  {
    "ggandor/leap.nvim"
  , 
    dependencies = {
      'tpope/vim-repeat',
    },
  config = configure
  }
