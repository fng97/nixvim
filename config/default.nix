{ pkgs, ... }: {
  imports = [
    ./telescope.nix
    ./keymaps.nix
    ./neo-tree.nix
    ./conform-nvim.nix
    ./lsp.nix
  ];

  globals.mapleader = " ";
  globals.maplocalleader = " ";

  extraConfigLua = ''
    vim.opt.termguicolors = false
    vim.cmd([[colorscheme dim]])
  '';

  extraPlugins = [ pkgs.vimPlugins.vim-dim ];

  opts = {
    number = true;
    relativenumber = true;
    confirm = true;
    ignorecase = true;
    smartcase = true; # if search contains capitals don't ignore case
    tabstop = 2;
    softtabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    smartindent = true;
  };

  autoCmd = [{
    event = "TextYankPost";
    pattern = "*";
    command = "lua vim.highlight.on_yank{timeout=150}";
  }];

  plugins = {
    treesitter.enable = true;
    bufferline.enable = true;
    bufferline.settings.options.always_show_bufferline = false;
    nvim-autopairs.enable = true;
    snacks.enable = true; # TODO: do I need all that this packages?
    mini.enable = true; # TODO: again, lots here, copy or limit what's bundled
  };

  performance = {
    byteCompileLua = {
      enable = true;
      nvimRuntime = true;
      configs = true;
      plugins = true;
    };
  };
}
