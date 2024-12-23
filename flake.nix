{
  inputs.nixvim.url = "github:nix-community/nixvim";

  outputs = { self, nixvim, flake-parts, ... }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems =
        [ "aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux" ];

      perSystem = { pkgs, system, ... }:
        let
          nixvimLib = nixvim.lib.${system};
          nixvim' = nixvim.legacyPackages."${system}";
          nixVimModule = { module = import ./config; };
          nvim = nixvim'.makeNixvimWithModule nixVimModule;
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
