return {
  "lervag/vimtex",
  lazy = false,     -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()

    local os_utils = require('marcus.osutils')

    -- VimTeX configuration goes here, e.g.
    if os_utils.is_windows then

        vim.g.vimtex_general_viewer = "SumatraPDf"
        vim.g.vimtex_view_general_options = '-reuse-instance -forward-search @tex @line @pdf'

    elseif os_utils.is_linux then

        vim.g.vimtex_view_method = "zathura"
    end
  end
}
