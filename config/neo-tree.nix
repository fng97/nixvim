{
  plugins.neo-tree.enable = true;

  keymaps = [{
    mode = "n";
    key = "<leader>e";
    action.__raw = ''
      function()
        require('neo-tree.command').execute({
          toggle = true,
        })
      end
    '';
    options.desc = "Reveal file tree";
  }];
}
