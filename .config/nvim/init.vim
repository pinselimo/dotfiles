let mapleader="\<SPACE>"

set cursorline

hi ColorColumn ctermbg=DarkMagenta
call matchadd('ColorColumn', '\%81v', 100)

" Remove underline:
hi CursorLine ctermbg=DarkMagenta
hi clear CursorLine

" To highlight only line number:
hi CursorLineNR ctermbg=DarkCyan

" Support clipboard across instances
set clipboard^=unnamed

set showmatch
set number
set tabstop=4
set shiftwidth=4
set expandtab

set nojoinspaces

set splitbelow
set splitright

if !&scrolloff
    set scrolloff=3
endif
if !&sidescrolloff
    set sidescrolloff=5
endif
set nostartofline

if &listchars ==# 'eol:$'
    set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list

"highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
"match ExtraWhitespace /\s\+$\|\t/

set ignorecase
set smartcase
set gdefault

if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

nmap <Leader>s :%s//<Left><Left>

function! NumberToggle()
    if(&relativenumber == 1)
        set nornu
        set number
    else
        set rnu
    endif
endfunc

nnoremap <Leader>r :call NumberToggle()<cr>

call plug#begin()
" Git integration
Plug 'airblade/vim-gitgutter'

" Colors
Plug 'etdev/vim-hexcolor'

" Haskell
"""" Plug 'neovimhaskell/haskell-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Comment lines
Plug 'preservim/nerdcommenter'

" Monkey-C
Plug '/home/pinselimo/vim/vim-monkey-c'

" HTML Tag Closing
Plug 'alvan/vim-closetag'

call plug#end()

" Make coc popups readable
hi link CocFloating markdown
