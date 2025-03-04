{ pkgs, ... }: {
  plugins = {
    lsp.enable = true;
    lsp-format.enable = true;

    lsp.servers = {
      pylsp.enable = true;
      ruff.enable = true;
      cmake.enable = true;
      clangd.enable = true;
      nixd.enable = true;
      zls.enable = true;
      rust-analyzer.enable = true;
    };
  };

  extraPackages = with pkgs; [
    ruff
    cmake-language-server
    clang-tools
    nixd
    zls
  ];
}
