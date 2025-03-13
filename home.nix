{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "aren.windham";
  home.homeDirectory = "/Users/aren.windham";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # Packages I need everywhere.
    pkgs.jujutsu
    pkgs.ripgrep
    pkgs.helix
    pkgs.tmux

    # Lsp for editing this file.
    pkgs.nixd
    pkgs.nil

    pkgs.typescript-language-server

    # Other stuff
    pkgs.grex

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    ".config/zed/settings.json".source = ./dots/zed.json;
    ".config/jj/config.toml".source = ./dots/jujutsu.toml;
    ".config/ghostty/config".source =  ./dots/ghostty.toml;
    ".config/helix/config.toml".source = ./dots/helix.toml;
    ".config/tmux/tmux.conf".source = ./dots/tmux.conf;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/aren.windham/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    JJ_CONFIG="$HOME/.config/jj/config.toml";
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting.
    '';
    shellAliases = {
      e = "hx";
      eee = "sed 's/[a-z]/e/g; s/[A-Z]/E/g; s/[0-9]/0/g'";
      ls = "ls -F";
    };
    plugins = [
      # Using this package in a standalone home-manager installation is easier
      # than setting all the environment variables manually.
      { name = "nix-env.fish";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk=";
        };
      }
    ];
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      (nvim-treesitter.withPlugins(p: [ p.bash p.json p.yaml p.markdown p.nix ]))
      conform-nvim
      modus-themes-nvim
      fzf-vim
    ];
    extraLuaConfig = '' 
    vim.wo.relativenumber = true
    vim.wo.number = true
    vim.opt.smartindent = true
    vim.opt.termguicolors = true
    vim.opt.scrolloff = 10
    vim.cmd('colorscheme modus_operandi')
    vim.opt.clipboard = unnamedplus


    -- keybinds
    vim.g.mapleader = ' '
    vim.api.nvim_set_keymap('n', '<Leader>ff', ':GFiles<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>fg', ':Rg<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<Leader>fb', ':Buffers<CR>', { noremap = true, silent = true })

    require("conform").setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
      format_on_save = true,
    })

    local lsp = require('lspconfig')
    lsp.ts_ls.setup{}
    '';
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
