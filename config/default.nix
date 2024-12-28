# TODO:
# 
# - format on save
# - copy lualine from LazyVim, get rid of dead space at the bottom
# - clipboard support
# - number of items in search

{
  imports = [ ./telescope.nix ./keymaps.nix ./neo-tree.nix ];

  globals.mapleader = " ";
  globals.maplocalleader = " ";

  colorschemes.gruvbox.enable = true;

  opts = {
    number = true;
    relativenumber = true;
    showmode = false; # covered by lualine
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
    lualine.enable = true;
    bufferline.enable = true;
    bufferline.settings.options.always_show_bufferline = false;
    nvim-autopairs.enable = true;
    which-key.enable = true;

    # NOT SET UP
    treesitter-refactor.enable = true;
    lsp.enable = true;
    conform-nvim.enable = true;
    lsp-format.enable = true;
    # gitsigns.enable = true;
    snacks.enable = true; # TODO: do I need all that this packages?
    mini.enable = true; # TODO: again, lots here, copy or limit what's bundled
    nix.enable = true;
    zig.enable = true;
    clangd-extensions.enable = true;
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
