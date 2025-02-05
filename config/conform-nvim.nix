{ config, pkgs, ... }: {
  plugins.conform-nvim = {
    enable = true;

    # TODO: set up a keybind to toggle auto-format
    settings = {
      format_on_save = ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return { timeout_ms = 500, lsp_fallback = true }
         end
      '';

      formatters_by_ft = {
        bash = [ "shellcheck" "shfmt" ];
        cpp = [ "clang-format" ];
        lua = [ "stylua" ];
        rust = [ "rustfmt" ];
        python = [ "black" ];
        nix = [ "nixfmt" ];
        "_" = [ "prettier" "trim_whitespace" "trim_newlines" ];
      };
    };
  };

  extraPackages = with pkgs; [
    shellcheck
    shfmt
    clang-tools
    stylua
    rustfmt
    black
    nixfmt-classic
    nodePackages.prettier
  ];
}
