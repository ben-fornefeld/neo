-- views can only be fully collapsed with the global statusline (avante)
vim.opt.laststatus = 3

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true -- Enable true color support

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Show mode in command line when using the built-in statusline
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 300

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.diagnostic.config({
	virtual_text = {
		prefix = function(diagnostic)
			local icons = {
				[1] = ' ',
				[2] = ' ',
				[3] = ' 󰙎',
				[4] = ' ⚐',
			}
			return icons[diagnostic.severity] or tostring(diagnostic.severity)
		end,
	},
	severity_sort = true,
})

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true

-- set tag space width
vim.opt.tabstop = 4


-- cursor blinking
vim.api.nvim_command 'set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- [[ Neovide GUI ]]
-- These only apply when running inside Neovide (ignored in a terminal).
if vim.g.neovide then
  -- Transparency + blur to match Ghostty (background-opacity = 0.9, background-blur-radius = 60).
  -- Neovide has no blur-radius option; it uses the macOS system blur.
  vim.g.neovide_opacity = 0.9
  vim.g.neovide_normal_opacity = 0.9
  vim.g.neovide_window_blurred = true

  -- No cursor trail animation: cursor jumps instantly, no particle effects.
  vim.g.neovide_cursor_animation_length = 0
  vim.g.neovide_cursor_trail_size = 0
  vim.g.neovide_cursor_vfx_mode = ''
end
