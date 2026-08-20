{ pkgs, lib, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    opts = {
      number = true;
      relativenumber = true;
      ignorecase = true;
      smartcase = true;
      clipboard = "unnamedplus";
      mouse = "a";
      scrolloff = 7;
      termguicolors = true;
    };
  };
}