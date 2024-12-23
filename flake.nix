# TODO:
# 
# - format on save
# - tab multiple lines without having to reselect
#
# FIXME:
# - leader key broken?

{
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs = { self, nixvim, flake-parts, ... }@inputs:
    let
      config = {
        globals.mapleader = " ";
        globals.maplocalleader = " ";

        opts = {
          number = true;
          relativenumber = true;
          showmode = false; # covered by lualine
          ignorecase = true; # ignore case...
          smartcase = true; # unless search contains capitals
        };

        keymaps = [{
          mode = "n";
          key = "<Esc>";
          action = "<cmd>nohlsearch<CR>";
        }];

        autoCmd = [{
          event = "TextYankPost";
          pattern = "*";
          command = "lua vim.highlight.on_yank{timeout=150}";
        }];

        colorschemes.gruvbox.enable = true;

        plugins = {
          treesitter.enable = true;
          lualine.enable = true;
          web-devicons.enable = true;
          nvim-autopairs.enable = true;
          conform-nvim.enable = true;

          # NOT WORKING
          # nix.enable = true;
          # zig.enable = true;
	  # clangd-extensions.enable = true;
          # telescope.enable = true;
          # which-key.enable = true;
          # bufferline.enable = true;
          # lsp-format.enable = true;
        };

        performance = {
          byteCompileLua = {
            enable = true;
            nvimRuntime = true;
            configs = true;
            plugins = true;
          };
        };
      };
    in flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];

      perSystem = { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages."${system}";
          nvim = nixvim'.makeNixvim config;
        in {
          packages = {
            inherit nvim;
            default = nvim;
          };

          checks = {
            # run `nix flake check . --all-systems` to verify configs are not broken
            default = nixvimLib.check.mkTestDerivationFromNvim {
              name = "Nixvim flake validation";
              nvim = nvim;
            };
          };
        };
    };
}
