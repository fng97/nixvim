{ config, pkgs, ... }: {
  plugins = {
    telescope.enable = true;
    web-devicons.enable = true; # dependency
  };

  extraPackages = [ pkgs.ripgrep pkgs.fd ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>fF";
      action.__raw = ''
        function()
          require("telescope.builtin").find_files({ hidden = true, no_ignore = true})
        end
      '';
      options.desc = "Find all files";
    }
    {
      mode = "n";
      key = "<leader><leader>";
      action.__raw =
        ''function() require("telescope.builtin").find_files() end'';
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>/";
      action.__raw =
        ''function() require("telescope.builtin").live_grep() end'';
      options.desc = "Live grep";
    }
  ];
}
