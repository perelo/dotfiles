
" config gor Plug 'https://github.com/apple/pkl-neovim.git'
lua <<EOF
local hasConfigs, configs = pcall(require, "nvim-treesitter.configs")
if hasConfigs then
  configs.setup {
    ensure_installed = "pkl",
    highlight = {
      enable = true,              -- false will disable the whole extension
    },
    indent = {
      enable = true
    }
  }
end

vim.g.pkl_neovim = {
    start_command = { "java", "-jar", "/home/eloi/Documents/pkl-lsp-0.3.2.jar" }
}
EOF

if exists(':VimuxRunCommand')
    nnoremap <buffer> <F1> :silent w <bar> VimuxRunCommand 'pkl eval ' . expand("%:p")<CR>
    inoremap <buffer> <F1> <Esc>:silent w <bar> VimuxRunCommand 'pkl eval ' . expand('%:p')<CR>
endif
