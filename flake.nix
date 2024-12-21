{
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs = { self, nixvim, flake-parts, ... }@inputs:
    let
      config = {
        globals.mapleader = " ";

        opts = {
          number = true;
          relativenumber = true;
        };

        colorschemes.gruvbox.enable = true;

        plugins = {
          treesitter.enable = true;
          telescope.enable = true;
          which-key.enable = true;
          bufferline.enable = true;
          lualine.enable = true;
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

# {
#   description = "A nixvim configuration";
#
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     nixvim.url = "github:nix-community/nixvim";
#     flake-parts.url = "github:hercules-ci/flake-parts";
#   };
#
#   outputs = { nixvim, flake-parts, ... }@inputs:
#     flake-parts.lib.mkFlake { inherit inputs; } {
#       systems =
#         [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
#
#       perSystem = { pkgs, system, ... }:
#         let
#           nixvimLib = nixvim.lib.${system};
#           nixvim' = nixvim.legacyPackages.${system};
#           nixvimModule = {
#             inherit pkgs;
#             module = import ./config; # import the module directly
#             # You can use `extraSpecialArgs` to pass additional arguments to your module files
#             extraSpecialArgs = {
#               # inherit (inputs) foo;
#             };
#           };
#           nvim = nixvim'.makeNixvimWithModule nixvimModule;
#         in {
#           checks = {
#             # Run `nix flake check .` to verify that your config is not broken
#             default =
#               nixvimLib.check.mkTestDerivationFromNixvimModule nixvimModule;
#           };
#
#           packages = {
#             # Lets you run `nix run .` to start nixvim
#             default = nvim;
#           };
#         };
#     };
# }
