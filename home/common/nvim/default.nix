{ config, pkgs, pkgs-unstable, ... }:
let
  vim-colors-paramount = pkgs.vimUtils.buildVimPlugin {
    name = "vim-colors-paramount";
    src = pkgs.fetchFromGitHub {
      owner = "owickstrom";
      repo = "vim-colors-paramount";
      rev = "a5601d36fb6932e8d1a6f8b37b179a99b1456798";
      hash = "sha256-j9nMjKYK7bqrGHprYp0ddLEWs1CNMudxXD13sOROVmY=";
    };
  };
in
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
      jellybeans-nvim
      lightline-vim
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
      plenary-nvim
      lspkind-nvim
      cmp-git
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile ./plugins/nvim-cmp.lua;
      }
      vim-colors-paramount
    ] ++ [
      pkgs-unstable.vimPlugins.doom-one-nvim
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

