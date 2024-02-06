{ config, pkgs, ... }:
let
  # color = pkgs.writeText "color.vim" (import ./theme.nix config.colorscheme);
  # ddc-vim = pkgs.vimUtils.buildVimPlugin {
  #   name = "ddc.vim";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Shougo";
  #     repo = "ddc.vim";
  #     rev = "d24ae8cf1b46852a3251c10e8ee1d559609d2b2f";
  #     sha256 = "sha256-6bUWoczMVaqy69LuF2hgQHUp8sHYi7iOVKF3hpj547w=";
  #   };
  # };
  # ddc-ui-native = pkgs.vimUtils.buildVimPlugin {
  #   name = "ddc-ui-native";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Shougo";
  #     repo = "ddc-ui-native";
  #     rev = "3f370d0da93bd47bb3a937a0c8f8193582eee8c8";
  #     sha256 = "";
  #   };
  # };
  # ddc-source-around = pkgs.vimUtils.buildVimPlugin {
  #   name = "ddc-source-around";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Shougo";
  #     repo = "ddc-source-around";
  #     rev = "645919c9f2ca3f3b95d6d21bf86317f42638073d";
  #     sha256 = "";
  #   };
  # };
  # ddc-source-lsp = pkgs.vimUtils.buildVimPlugin {
  #   name = "ddc-source-lsp";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Shougo";
  #     repo = "ddc-source-lsp";
  #     rev = "ad43a10726ebdacea80fafee5034247816fb099d";
  #     sha256 = "";
  #   };
  # };
  # ddc-matcher_head = pkgs.vimUtils.buildVimPlugin {
  #   name = "ddc-matcher_head";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Shougo";
  #     repo = "ddc-matcher_head";
  #     rev = "17b656e38221743290bd0cd26f5b177efe318d77";
  #     sha256 = "sha256-VD8jyWKgupDUZJ37ABBku/txzAUmZKFVICM7+r7oYhQ=";
  #   };
  # };
  # ddc-sorter_rank = pkgs.vimUtils.buildVimPlugin {
  #   name = "ddc-sorter_rank";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "Shougo";
  #     repo = "ddc-sorter_rank";
  #     rev = "fccbd5892dc57f44f07cddcbef9d465838b36cee";
  #     sha256 = "sha256-eqvQzTYn8syzWLSmwCrWcqarQgIOUKb6PRiYjPBhRLM=";
  #   };
  # };
in
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
      jellybeans-nvim
      lightline-vim
      firenvim
      vim-nix
      denops-vim

      nvim-lspconfig
      vim-vsnip
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      cmp-git
      {
        plugin = nvim-cmp;
        config = ''
        lua <<EOF
          -- Set up nvim-cmp.
          local cmp = require'cmp'

          cmp.setup({
            snippet = {
              -- REQUIRED - you must specify a snippet engine
              expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
              end,
            },
            window = {
              -- completion = cmp.config.window.bordered(),
              -- documentation = cmp.config.window.bordered(),
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-u>'] = cmp.mapping.scroll_docs(-4),
              ['<C-d>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-c>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'vsnip' }, -- For vsnip users.
              -- { name = 'luasnip' }, -- For luasnip users.
              -- { name = 'ultisnips' }, -- For ultisnips users.
              -- { name = 'snippy' }, -- For snippy users.
            }, {
              { name = 'buffer' },
            })
          })

          -- Set configuration for specific filetype.
          cmp.setup.filetype('gitcommit', {
            sources = cmp.config.sources({
              { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
            }, {
              { name = 'buffer' },
            })
          })

          -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline({ '/', '?' }, {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
              { name = 'buffer' }
            }
          })

          -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
          cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
              { name = 'path' }
            }, {
              { name = 'cmdline' }
            })
          })

          -- Set up lspconfig.
          -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
          -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
          -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
          --   capabilities = capabilities
          -- }
        EOF
        '';
      }
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

