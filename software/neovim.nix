{ config, lib, pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      FTerm-nvim
      supertab
      vim-startify
      nvim-surround
      vim-autoformat
      vimtex
      nvim-comment
      nvim-treesitter.withAllGrammars
      lazygit-nvim
      vim-gitgutter
      vim-fugitive
      vim-css-color
      vim-devicons
      nvim-tree-lua
      lualine-nvim
      nvim-web-devicons
    ];
    extraConfig = (builtins.readFile ../files/nvimscript);
    initLua = (builtins.readFile ../files/nvimlua);
    coc.enable = true;
  };
}
