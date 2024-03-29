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

        let g:onedark_config = { 'transparent' : v:true }
        colorscheme onedark

        set cursorline

        hi ColorColumn ctermbg=DarkMagenta
        call matchadd('ColorColumn', '\%81v', 100)

        " Remove underline:
        hi CursorLine ctermbg=DarkMagenta
        hi clear CursorLine

        " To highlight only line number:
        hi CursorLineNR ctermbg=DarkCyan

        " Autocomplete COC using <tab>
        inoremap <expr> <tab> coc#pum#visible() ? coc#pum#confirm() : "<tab>"

        " Spell-check Markdown files and Git Commit Messages
        autocmd FileType markdown setlocal spell
        autocmd FileType latex setlocal spell
        autocmd FileType gitcommit setlocal spell

        " Enable dictionary auto-completion in Markdown files and Git Commit Messages
        autocmd FileType markdown setlocal complete+=kspell
        autocmd FileType latex setlocal complete+=kspell
        autocmd FileType gitcommit setlocal complete+=kspell

        function! ZoteroCite()
          " pick a format based on the filetype (customize at will)
          let format = &filetype =~ '.*tex' ? 'citep' : 'pandoc'
          let api_call = 'http://127.0.0.1:23119/better-bibtex/cayw?format='.format.'&brackets=1'
          let ref = system('curl -s '.shellescape(api_call))
          return ref
        endfunction

        noremap <leader>z "=ZoteroCite()<CR>p
        inoremap <C-z> <C-r>=ZoteroCite()<CR>
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
          pname = "vim-monkey-c";
          version = "1.0.0";
          src = vim-monkey-c;
        })
        vim-haskellConcealPlus
        lightspeed-nvim
        vimtex
        onedark-nvim
        purescript-vim
      ];
    };
  };
}
