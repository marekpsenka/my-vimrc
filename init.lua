vim.opt.runtimepath:prepend(vim.fn.expand("~/.vim"))
vim.opt.runtimepath:append(vim.fn.expand("~/.vim/after"))

vim.opt.packpath = vim.opt.runtimepath:get()

vim.cmd("source ~/.vimrc")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    {
      "carlos-algms/agentic.nvim",

      --- @type agentic.PartialUserConfig
      opts = {
        provider = "opencode-acp",
      },

      keys = {
        {
          "<C-\\>",
          function() require("agentic").toggle() end,
          mode = { "n", "v", "i" },
          desc = "Toggle Agentic Chat"
        },
        {
          "<C-'>",
          function() require("agentic").add_selection_or_file_to_context() end,
          mode = { "n", "v" },
          desc = "Add file or selection to Agentic to Context"
        },
        {
          "<C-,>",
          function() require("agentic").new_session() end,
          mode = { "n", "v", "i" },
          desc = "New Agentic Session"
        },
        {
          "<A-i>r", -- ai Restore
          function()
              require("agentic").restore_session()
          end,
          desc = "Agentic Restore session",
          silent = true,
          mode = { "n", "v", "i" },
        },
        {
          "<leader>ad", -- ai Diagnostics
          function()
              require("agentic").add_current_line_diagnostics()
          end,
          desc = "Add current line diagnostic to Agentic",
          mode = { "n" },
        },
        {
          "<leader>aD", -- ai all Diagnostics
          function()
              require("agentic").add_buffer_diagnostics()
          end,
          desc = "Add all buffer diagnostics to Agentic",
          mode = { "n" },
        },
      },
    }
  },
  performance = {
      -- Prevent lazy.nvim from resetting runtimepath and wiping vim-plug paths
      rtp = {
        reset = false,
      },
    },
})

