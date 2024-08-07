{ pkgs, ... }: {

  imports = [
    ./plugins.nix
  ];

  environment.systemPackages = [ pkgs.neovim ];

  home-manager.users.rico.programs.neovim = {
    enable = true;

    extraLuaConfig = /*lua*/ ''
      local o = vim.o
      local opt = vim.opt

      opt.syntax = enable

      opt.number = true
      opt.relativenumber = true
      opt.cursorline = true

      opt.tabstop = 2
      opt.shiftwidth = 2
      opt.softtabstop = 2
      opt.expandtab = true
      opt.autoindent = true
      opt.smartindent = true

      opt.wrap = false

      opt.hlsearch = false
      opt.incsearch = true

      opt.scrolloff = 13

      vim.g.mapleader = " "
      vim.keymap.set("n", "<leader>e", vim.cmd.Ex)
    '';

    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
}