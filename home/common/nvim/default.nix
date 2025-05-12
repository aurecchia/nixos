{ config, pkgs, ... }:
{
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    # Plugins at https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/vim/plugins/generated.nix
    plugins = with pkgs.vimPlugins; [
      {
        plugin = fzf-vim;
        config = ''
          " Default fzf layout
          " - down / up / left / right
          let g:fzf_layout = { 'down': '~20%' }

          " Customize fzf colors to match your color scheme
          let g:fzf_colors =
          \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
        '';
      }
      readline-vim
      vim-closetag
      traces-vim
      vim-fugitive
      vim-commentary
      vim-git
      vim-gitgutter
      vim-surround
      nvim-lspconfig
      goyo-vim
      ir_black
      openscad-nvim
      {
        plugin = jellybeans-vim;
        config = ''
          let g:jellybeans_overrides = {
          \    'background':  { 'ctermbg': '0A0A0A', 'guibg': '0A0A0A' },
          \    'SignColumn':  { 'ctermbg': '0A0A0A', 'guibg': '0A0A0A' },
          \    'TabLine':     { 'ctermbg': '000000', 'guibg': '000000' },
          \    'TabLineFill': { 'ctermbg': '000000', 'guibg': '000000',
          \                     'ctermfg': '000000', 'guifg': '000000' },
          \    'TabLineSel':  { 'ctermbg': '000000', 'guibg': '000000',
          \                     'ctermfg': 'FFFFFF', 'guifg': 'FFFFFF' },
          \}
        '';
      }
      oxocarbon-nvim
      #github-nvim-theme
      vscode-nvim
      #nvim-grey
      {
        plugin = lightline-vim;
        config = ''
          let s:p = {'normal': {}, 'inactive': {}, 'insert': {}, 'replace': {}, 'visual': {}, 'tabline': {}}
          let s:p.normal.left = [ ['darkestgreen', 'brightgreen', 'bold'], ['white', 'gray4'] ]
          let s:p.normal.right = [ ['gray5', 'gray10'], ['gray9', 'gray4'], ['gray8', 'gray2'] ]
          let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
          let s:p.inactive.left = s:p.inactive.right[1:]
          let s:p.insert.left = [ ['darkestcyan', 'white', 'bold'], ['white', 'darkblue'] ]
          let s:p.insert.right = [ [ 'darkestcyan', 'mediumcyan' ], [ 'mediumcyan', 'darkblue' ], [ 'mediumcyan', 'darkestblue' ] ]
          let s:p.replace.left = [ ['white', 'brightred', 'bold'], ['white', 'gray4'] ]
          let s:p.visual.left = [ ['darkred', 'brightorange', 'bold'], ['white', 'gray4'] ]
          let s:p.normal.middle = [ [ 'gray7', 'gray2' ] ]
          let s:p.insert.middle = [ [ 'mediumcyan', 'darkestblue' ] ]
          let s:p.replace.middle = s:p.normal.middle
          let s:p.replace.right = s:p.normal.right
          let s:p.tabline.left = [ [ 'gray8', 'gray1' ] ]
          let s:p.tabline.tabsel = [ [ '#ffffff', '#A0A0A' ] ]
          let s:p.tabline.middle = [ [ 'gray8', 'gray3' ] ]
          let s:p.tabline.right = [ [ 'gray8', 'gray2' ] ]
          let s:p.normal.error = [ [ 'gray9', 'brightestred' ] ]
          let s:p.normal.warning = [ [ 'gray1', 'yellow' ] ]

          let g:lightline#colorscheme#auri#palette = lightline#colorscheme#fill(s:p)

          let g:jellybeans_use_term_italics = 1

          let g:lightline = {
          \    'colorscheme': 'auri',
          \}
        '';
      }
      firenvim
      vim-nix
      denops-vim
      typst-vim
      nvim-lspconfig
      vim-vsnip
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-emoji
      cmp-git
      plenary-nvim
      lspkind-nvim
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-cmp.lua;
      }
      vim-elixir
      vim-svelte
      vim-javascript
      vim-just
    ];

    extraConfig = builtins.readFile ./init.vim;
  };

  xdg.desktopEntries = {
    nvim = {
      name = "Neovim";
      genericName = "Text Editor";
      comment = "Edit text files";
      exec = "nvim %F";
      icon = "nvim";
      mimeType = [
        "text/english"
        "text/plain"
        "text/x-makefile"
        "text/x-c++hdr"
        "text/x-c++src"
        "text/x-chdr"
        "text/x-csrc"
        "text/x-java"
        "text/x-moc"
        "text/x-pascal"
        "text/x-tcl"
        "text/x-tex"
        "application/x-shellscript"
        "text/x-c"
        "text/x-c++"
      ];
      terminal = true;
      type = "Application";
      categories = [ "Utility" "TextEditor" ];
    };
  };
}

