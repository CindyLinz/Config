" Author : Cindylinz
" Date   : 2013.3.3

if !empty(glob($HOME . "/.vim/autoload/pathogen.vim"))
    execute pathogen#infect()
endif

set ts=8
set sw=4
set backspace=indent,eol,start
set encoding=utf8
set fileencodings=utf8,big5,big5-hkscs,utf-16le
set ai
set nocin
set foldmethod=indent
set nofen
set bg=dark
set ruler
set wildmenu
set modeline
set et
"set mouse=a
filetype plugin on
syn on

hi MatchParen ctermbg=4
hi Normal ctermbg=0

au BufNewFile,BufRead *.coffee set filetype=coffee
au BufNewFile,BufRead *.md set filetype=markdown
au BufNewFile,BufRead *.ls set filetype=ls
au BufNewFile,BufRead *.agda set filetype=agda
au BufNewFile,BufRead *.lagda set filetype=agda
au BufNewFile,BufRead *.hs set filetype=haskell
au FileType c,cpp,java,perl set cin sw=4
au FileType perl set isident-=$
au FileType coffee,ls,javascript,cabal,haskell,tex,markdown,agda,sql,svg set sw=2 nocin ai
au BufNewFile,BufRead *.hspl,*.hspm set nocin ai sw=2 fo=ql syn=off

if version >= 700
  map g1 :tabn 1<CR>
  map g2 :tabn 2<CR>
  map g3 :tabn 3<CR>
  map g4 :tabn 4<CR>
  map g5 :tabn 5<CR>
  map g6 :tabn 6<CR>
  map g7 :tabn 7<CR>
  map g8 :tabn 8<CR>
  map g9 :tabl<CR>
  map gm1 :tabm 0<CR>
  map gm2 :tabm 1<CR>
  map gm3 :tabm 2<CR>
  map gm4 :tabm 3<CR>
  map gm5 :tabm 4<CR>
  map gm6 :tabm 5<CR>
  map gm7 :tabm 6<CR>
  map gm8 :tabm 7<CR>
  map gm9 :tabm<CR>
  map gc :tabnew<CR>
  map <C-o> :tabn<CR>
  map <C-p> :tabp<CR>
  imap <C-o> :tabn<CR>
  imap <C-p> :tabp<CR>

  highlight TabLineSel term=bold cterm=bold ctermfg=5 ctermbg=0
  highlight TabLine    term=bold cterm=bold ctermfg=0 ctermbg=0
  highlight clear TabLineFill

  "au BufNewFile,BufRead *.txt,*.tex set spell
end

set wildmenu
set wildmode=longest,list

if !empty(glob($HOME . "/.vim/bundle/nerdtree")) || !empty(glob($HOME . "/.vim/plugin/NERD_tree.vim"))
    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    "autocmd vimenter * if !argc() | NERDTree | endif
    map gn :NERDTreeToggle \| :silent NERDTreeMirror<CR>
    map <leader>n :NERDTreeFind<CR>
endif

if !empty(glob($HOME . "/.vim/bundle/vim-easymotion"))
    map gJ <Plug>(easymotion-j)
    map gK <Plug>(easymotion-k)

    map gs <Plug>(easymotion-s)

    map gw <Plug>(easymotion-w)
    map gW <Plug>(easymotion-W)
    map ge <Plug>(easymotion-e)
    map gE <Plug>(easymotion-E)
    map gf <Plug>(easymotion-f)
    map gF <Plug>(easymotion-F)
    map gb <Plug>(easymotion-b)
    map gB <Plug>(easymotion-B)
else
    set relativenumber
endif

"colorscheme default
let g:indent_guides_auto_colors = 0 
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=1 
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=4 
"let g:indent_guides_auto_colors = 0
"hi IndentGuidesOdd  guibg=red   ctermbg=3
"hi IndentGuidesEven guibg=green ctermbg=4
"snipmate (good!)
"large file plugin https://github.com/gmunkhbaatarmn/vim-largefile http://www.vim.org/scripts/script.php?script_id=1506

" highlight trailing whitespaces and spaces before a tab
au BufNewFile,BufRead * hi ExtraWhitespace ctermbg=red guibg=red
au BufNewFile,BufRead * match ExtraWhitespace /\s\+$\| \+\ze\t/
