{
  # TODO: rebind <C-a/x> to something like <C-k/j> (or h/l)
  keymaps = [
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }

    # buffers
    {
      mode = "n";
      key = "<leader>bd";
      action.__raw = "function() Snacks.bufdelete() end";
      options.desc = "Delete buffer";
    }
    {
      mode = "n";
      key = "<leader>bo";
      action.__raw = "function() Snacks.bufdelete.other() end";
      options.desc = "Delete other buffers";
    }
  ];

  extraConfigLua = ''
    local map = vim.keymap.set

    -- better up/down
    map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
    map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
    map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
    map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

    -- center on page up/down
    map("n", "<C-u>", "<C-u>zz")
    map("n", "<C-d>", "<C-d>zz")

    -- Move to window using the <ctrl> hjkl keys
    map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
    map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
    map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
    map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

    -- Resize window using <ctrl> arrow keys
    map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
    map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
    map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
    map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

    -- Move Lines
    map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
    map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
    map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
    map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
    map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
    map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

    -- buffers
    map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
    map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
    map("n", "<leader>bD", "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

    -- save file
    map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

    -- better indenting
    map("v", "<", "<gv")
    map("v", ">", ">gv")

    -- go to header/impl
    map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", { desc = "Go to declaration" })
    map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", { desc = "Go to definition" })

    -- new file
    map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

    -- toggle options
    Snacks.toggle.diagnostics():map("<leader>ud")
    if vim.lsp.inlay_hint then
      Snacks.toggle.inlay_hints():map("<leader>uh")
    end

    -- lazygit
    if vim.fn.executable("lazygit") == 1 then
      map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
    end

    map("n", "<leader>gb", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
    map({ "n", "x" }, "<leader>gB", function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })

    -- quit
    map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

    -- windows
    map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })
    map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
    map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
    map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

    -- system clipboard
    vim.api.nvim_set_keymap('n', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Yank to system clipboard (motion, e.g. <leader>yib)" })
    vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard after cursor" })
    vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true, desc = "Paste from system clipboard before cursor" })
    vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true, desc = "Yank selection to system clipboard" })
    vim.api.nvim_set_keymap('v', '<leader>p', '"+p', { noremap = true, silent = true, desc = "Paste from system clipboard after cursor" })
    vim.api.nvim_set_keymap('v', '<leader>P', '"+P', { noremap = true, silent = true, desc = "Paste from system clipboard before cursor" })
  '';
}
