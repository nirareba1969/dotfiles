if &compatible
  set nocompatible               " Be iMproved
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('Shougo/deoplete.nvim')
  if !has('nvim')
    call dein#add('roxma/nvim-yarp')
    call dein#add('roxma/vim-hug-neovim-rpc')
  endif

  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  " color
  call dein#add('crusoexia/vim-monokai')
  call dein#add('mattn/emmet-vim')
  call dein#add('moll/vim-node')
  call dein#add('pangloss/vim-javascript')
  call dein#add('maxmellon/vim-jsx-pretty')
  call dein#add('posva/vim-vue')
  call dein#add('leafgarland/typescript-vim')
  call dein#add('nathanaelkane/vim-indent-guides')
  call dein#add('vim-scripts/AnsiEsc.vim')
  call dein#add('rust-lang/rust.vim')
  call dein#add('fatih/vim-go')
  call dein#add('vim-ruby/vim-ruby')
  call dein#add('hashivim/vim-terraform')
  call dein#add('dart-lang/dart-vim-plugin')
  call dein#add('slim-template/vim-slim')
  call dein#add('tpope/vim-haml')
  call dein#add('mechatroner/rainbow_csv')
  call dein#add('etdev/vim-hexcolor')
  call dein#add('plasticboy/vim-markdown')
  call dein#add('styled-components/vim-styled-components')
  call dein#add('cespare/vim-toml')
  " check
  call dein#add('scrooloose/syntastic')
  " useful
  call dein#add('tpope/vim-endwise')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rails')
  call dein#add('vim-scripts/gtags.vim')
  call dein#add('vim-jp/vimdoc-ja')
  call dein#add('jremmen/vim-ripgrep')
  call dein#add('junegunn/fzf', {'build': './install --all'})
  call dein#add('junegunn/fzf.vim')
  call dein#add('godlygeek/tabular')
  call dein#add('vim-scripts/Align')
  call dein#add('vim-scripts/SQLUtilities')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on

if dein#check_install()
  call dein#install()
endif

" help
set helplang=ja,en

" write
set autowrite

" syntax highlight
colorscheme monokai
syntax on

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" tab
set tabstop=2
set autoindent
set expandtab
set shiftwidth=2
" encoding
set encoding=utf-8
set fileencodings=utf-8

" fold
set foldenable
set foldlevelstart=1
set foldmethod=syntax

set synmaxcol=256
syntax sync minlines=256

" Don't screw up folds when inserting text that might affect them, until
" leaving insert mode. Foldmethod is local to the window. Protect against
" screwing up folding when switching between windows.
autocmd InsertEnter * if !exists('w:last_fdm') | let w:last_fdm=&foldmethod | setlocal foldmethod=manual | endif
autocmd InsertLeave,WinLeave * if exists('w:last_fdm') | let &l:foldmethod=w:last_fdm | unlet w:last_fdm | endif

" statusline
set laststatus=2

set statusline=%<%f\ %m%r%h%w
set statusline+=%{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'}
set statusline+=%=%l/%L,%c%V%8P

" matchit
source $VIMRUNTIME/macros/matchit.vim

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['eslint']

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup = 1
let indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=darkgrey   ctermbg=236
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=darkgrey   ctermbg=237
autocmd VimEnter,Colorscheme * :hi StatusLine       ctermfg=231 ctermbg=241 cterm=bold guifg=#f8f8f2 guibg=#64645e gui=bold
let indent_guides_color_change_percent = 10

" fugitive
autocmd QuickFixCmdPost *grep* cwindow
set statusline+=%{fugitive#statusline()}

" vim-markdown
let g:vim_markdown_folding_disabled=1

" ripgrep
if executable('rg')
    set grepprg=rg\ --vimgrep\ --no-heading
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Similarly, we can apply it to fzf#vim#grep. To use ripgrep instead of ag:
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" vim-local
augroup vimrc-local
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END

function! s:vimrc_local(loc)
  let files = findfile('.vimrc.local', escape(a:loc, ' ') . ';', -1)
  for i in reverse(filter(files, 'filereadable(v:val)'))
    source `=i`
  endfor
endfunction

" vim-ruby
let ruby_fold = 1

" vim-go
let g:go_null_module_warning = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_structs = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_auto_type_info = 1
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
let g:go_fmt_command = "goimports"
au FileType go setlocal sw=4 ts=4 sts=4 noet
filetype plugin indent on

" vim-jsx-pretty
let g:vim_jsx_pretty_colorful_config=0
