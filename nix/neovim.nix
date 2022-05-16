{ config, pkgs, vim-monkey-c, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    #withPython3 = true;
    #withNodeJs = true; # For CoC
    configure = {
      customRC = ''
        filetype plugin indent on
        syntax enable

        let mapleader="\<SPACE>"
        let maplocalleader="\\"

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

        set ignorecase
        set smartcase
        set gdefault

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

        hi link CocFloating markdown

        let g:airline#extensions#tabline#enabled = 1
        let g:airline_theme='violet'

        set expandtab
        '';

      packages.nix.start = with pkgs.vimPlugins; [
        vim-plug
        vim-airline
        vim-airline-themes
        vim-gitgutter
        vim-closetag
        coc-nvim coc-git coc-highlight coc-html coc-java coc-pyright coc-vimtex
        nerdcommenter
        vim-closetag
        vim-nix
        Coqtail
        idris2-vim
        agda-vim
        vim-fish
        vim-hoogle
        (pkgs.vimUtils.buildVimPlugin {
          name = "vim-monkey-c";
          src = vim-monkey-c;
        })
        vim-haskellConcealPlus
        lightspeed-nvim
        vimtex
      ];
    };
  };
}
