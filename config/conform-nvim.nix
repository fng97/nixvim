{
  plugins.conform-nvim = {
    enable = true;

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
        "_" = [ "trim_whitespace" "trim_newlines" ];
      };

      # formatters = {
      #   shellcheck = { command = lib.getExe pkgs.shellcheck; };
      #   shfmt = { command = lib.getExe pkgs.shfmt; };
      #   shellharden = { command = lib.getExe pkgs.shellharden; };
      #   squeeze_blanks = { command = lib.getExe' pkgs.coreutils "cat"; };
      # };
    };
  };
}
