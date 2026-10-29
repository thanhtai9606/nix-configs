{
  pkgs,
  ...
}:

let
  inherit (pkgs.vimUtils) buildVimPlugin;

  vimNerdtreeSync = buildVimPlugin {
    name = "vim-nerdtree-sync";
    src = pkgs.fetchFromGitHub {
      owner = "unkiwii";
      repo = "vim-nerdtree-sync";
      rev = "f0ec649ac2045f6bf9e32efffbdc3e7aaee419d2";
      hash = "sha256-32YhB2zlfmxpkOtPeI91Ibd8F/5DMmAoPhoy8s/yaJI=";
    };
  };

  vimJs = buildVimPlugin {
    name = "vim-js";
    src = pkgs.fetchFromGitHub {
      owner = "yuezk";
      repo = "vim-js";
      rev = "f38483322d84eb87ebfe08dcb23da538ab3454cc";
      hash = "sha256-Pz2zVCOXlTIHHwhHSbYUDCIlNg+ZpYKaFQsb+n/5qlU=";
    };
  };

  omnisharpVim = buildVimPlugin {
    name = "omnisharp-vim";
    src = pkgs.fetchFromGitHub {
      owner = "OmniSharp";
      repo = "omnisharp-vim";
      rev = "1e1d65e05ad2bd466851246654d28c91864ab2e7";
      hash = "sha256-NVGc4v++D8kPFHxBCfe2mQVk1BdmBJsoWV/KR7qv1vA=";
    };
  };

  cocTsserver = buildVimPlugin {
    name = "coc-tsserver";
    src = pkgs.fetchFromGitHub {
      owner = "neoclide";
      repo = "coc-tsserver";
      rev = "81f4617d8a55eac2af8350d0495448d0f26c3cb4";
      hash = "sha256-xojbx1dghbzzSJOqFRHvw7Oc2d9BqZyuW0Rz6I7q04w=";
    };
  };
in
{
  xdg.configFile."nvim/settings".source = ./nvim/settings;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    withNodeJs = true;
    withPython3 = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      fzf
      go
      gopls
      omnisharp-roslyn
    ];

    plugins = with pkgs.vimPlugins; [
      gruvbox
      nerdtree
      nerdtree-git-plugin
      vim-devicons
      vim-nerdtree-syntax-highlight
      vimNerdtreeSync
      fzf-vim
      ctrlp-vim
      vim-airline
      vim-airline-themes
      vim-floaterm
      coc-nvim
      auto-pairs
      vim-closetag
      emmet-vim
      nerdcommenter
      vista-vim
      ale
      vimJs
      omnisharpVim
      vimspector
      blamer-nvim
      vim-fugitive
      vim-go
      coc-snippets
      coc-pairs
      cocTsserver
      coc-eslint
      coc-prettier
      coc-json
    ];

    coc = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ./nvim/coc-settings.json);
    };

    extraConfig =
      builtins.readFile ./nvim/init.vim
      + ''

        for setting_file in split(glob(stdpath('config').'/settings/*.vim'), '\n')
          execute 'source' setting_file
        endfor
      '';
  };
}
