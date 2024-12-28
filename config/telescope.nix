# TODO: add grepping with <leader>/
{
  plugins = {
    telescope.enable = true;
    web-devicons.enable = true; # dependency
  };

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
      action.__raw = ''
        function()
          require("telescope.builtin").find_files()
        end
      '';
      options.desc = "Find files";
    }
  ];
}
