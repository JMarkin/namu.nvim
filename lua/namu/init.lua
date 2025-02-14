local M = {}

-- Default configuration
M.config = {
  namu_symbols = { enable = true, options = {} },
  selecta = { enable = true, options = {} },
  colorscheme = { enable = false, options = {} },
  -- ui_select = { enable = false, options = {} },
}

M.setup = function(opts)
  opts = opts or {}
  -- Merge the top-level config
  M.config = vim.tbl_deep_extend("force", M.config, opts)

  -- Set up namu_symbols if enabled
  if M.config.namu_symbols.enable then
    -- Pass ONLY the options part to the module
    require("namu.namu_symbols").setup(M.config.namu_symbols.options)
  end

  if M.config.colorscheme.enable then
    require("namu.colorscheme").setup(M.config.colorscheme.options)
  end
end

return M
