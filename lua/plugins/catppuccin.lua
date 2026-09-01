return {
	"catppuccin/nvim", 
	lazy = false,
	name = "catppuccin", 
	priority = 1000,
	opts = {
		flavour = "mocha",
		transparent_background = false,
	},

	config = function(_, opts)
		require("catppuccin").setup(opts)
		vim.cmd.colorscheme "catppuccin-nvim"
	end
}


