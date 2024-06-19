require "nvchad.options"

-- commands
vim.api.nvim_create_user_command("Transparent", function()
  require("base46").toggle_transparency()
end, {})

-- opts
local o = vim.o
o.cursorlineopt = "both"
o.scrolloff = 10
vim.wo.relativenumber = true

-- filetypes
vim.filetype.add {
  extension = {
    mdx = "markdown.mdx",
  },
}

vim.filetype.add {
  extension = {
    frag = "glsl",
  },
}
vim.filetype.add {
  extension = {
    vert = "glsl",
  },
}

-- cursor blinking
vim.api.nvim_command "set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"
