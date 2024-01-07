{ config, pkgs, ... }:
# let
#   color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
# in
{
  imports = [
    # ./lsp.nix
    # ./syntaxes.nix
    # ./ui.nix
    # ./copilot.nix
  ];
  home.sessionVariables.EDITOR = "nvim";

  programs.neovim = {
    enable = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      fzf-vim
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
      jellybeans-nvim
      lightline-vim
      firenvim
      vim-nix
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

