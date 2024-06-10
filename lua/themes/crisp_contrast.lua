local M = {}

M.base_30 = {
  white = "#ffffff",
  darker_black = "#0a070a",
  black = "#0c090c", -- nvim bg
  black2 = "#151015",
  one_bg = "#1e191e",
  one_bg2 = "#272227",
  one_bg3 = "#302b30",
  grey = "#574457",
  grey_fg = "#634b63",
  grey_fg2 = "#6f526f",
  light_grey = "#7b597b",

  red = "#e61f44",
  baby_pink = "#fc6a0f",
  pink = "#fc9a0f",

  line = "#151015", -- for lines like vertsplit

  green = "#a7da1e",
  vibrant_green = "#b8e02a",

  blue = "#cba0cd",
  nord_blue = "#d4aad6",

  yellow = "#f7b83d",
  sun = "#fc9a0f",

  purple = "#cba0cd",
  dark_purple = "#765478",

  teal = "#826682",

  orange = "#fc6a0f",

  cyan = "#b8dceb",

  statusline_bg = "#151015",

  lightbg = "#1e191e",

  pmenu_bg = "#fc6a0f",

  folder_bg = "#cba0cd",
}

M.base_16 = {
  base00 = "#0c090c",
  base01 = "#151015",
  base02 = "#1e191e",
  base03 = "#272227",
  base04 = "#302b30",
  base05 = "#634b63",
  base06 = "#7b597b",
  base07 = "#ffffff",
  base08 = "#fc6a0f",
  base09 = "#fc9a0f",
  base0A = "#f7b83d",
  base0B = "#a7da1e",
  base0C = "#b8dceb",
  base0D = "#cba0cd",
  base0E = "#765478",
  base0F = "#826682",
}

M.type = "dark"

M.polish_hl = {
  Cursor = { fg = M.base_30.black, bg = M.base_30.white },
  Visual = { fg = M.base_30.white, bg = M.base_30.orange },
  CursorLine = { bg = "#151015" },
  CursorLineNr = { fg = "#634b63", bg = M.base_30.black },
  CursorColumn = { bg = M.base_30.black },
  ColorColumn = { bg = M.base_30.black },
  LineNr = { fg = "#291f29", bg = M.base_30.black },
  VertSplit = { fg = "#291f29", bg = "#291f29" },
  MatchParen = { fg = M.base_30.dark_purple, underline = true },
  StatusLine = { fg = M.base_30.white, bg = M.base_30.black, bold = true },
  StatusLineNC = { fg = M.base_30.white, bg = M.base_30.black },
  Pmenu = { fg = M.base_30.white, bg = M.base_30.black },
  PmenuSel = { bg = M.base_30.purple },
  IncSearch = { fg = M.base_30.white, bg = M.base_30.light_orange },
  Search = { underline = true },
  Directory = { fg = M.base_30.purple },
  Folded = { fg = M.base_16.light_grey, bg = M.base_black },
  Normal = { fg = M.orange, bg = M.bg0 },
  Boolean = { fg = M.orange },
  Character = { fg = M.light_orange },
  Comment = { fg = M.dark_grey },
  Conditional = { fg = M.orange },
}

return M
