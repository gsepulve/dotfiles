if not vim.g.ccc_live_reload then
  vim.cmd("highlight clear")

  if vim.fn.exists("syntax_on") == 1 then
    vim.cmd("syntax reset")
  end
end

vim.g.colors_name = "my_theme_1"

-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
--
-- XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

local c = {
  bg                = "#222222", -- 1f1f1f 2a2a2a 1f1f00 111100 212c21 0c1818, 313c3c 142727
  bg_alt            = "#000000", -- 
  bg_float          = "#1f1f00", -- highlight when scrolling and keeping fn name on top
  fg_float          = "#ffffff", --  unknown
  fg                = "#919100", -- ffff00 16dc00

  fg_alt            = "#c70000", -- 
  border            = "#000000",
  line_nr           = "#9f9f9e", -- 131725
  cursor_line       = "#750606", --1a253d
  comment           = "#7f7f7f", -- 675007
  comment_bg        = "#0a0000", -- 150000 turn off
  keyword           = "#6f7efa", -- 0000ff and move L slider (CM) while K is 0 
  func              = "#ffc09e", -- C 0, M>Y,L 33 (aa00aa)(ffb8f6)
  type              = "#cf98ff", -- ff0000 and move L slider (MY) while K is 0

  string            = "#d2d6a6", -- 
  number            = "#ffffd0", -- ffff7f
  variable          = "#fff9ed", -- ffff7f 479e00
  field             = "#a7a7ff", -- Move L slider CM together. YK 0,0.
  constant          = "#ff7d64", -- 
  operator          = "#54a9ff", -- 005eff 7fffff 4875ff
  bracket           = "#a1b400", -- only k up
  parameter         = "#7fbfff",
  delimiter         = "#ffff00",
  punctuation       = "#fe6262", -- ff7f00 ; , maybe tiny bit more mage-nta
  rusty             = "#822e13", -- nothing
  ocean             = "#19407c", -- nothing

  error             = "#ff3333",
  warn              = "#ffff00", -- 
  info              = "#00d5ff",
  hint              = "#7be89b",

-- tabs
  tab_active        = "#000000", -- 
  tab_inactive      = "#000000", -- 
  tab_inactive_text = "#00a3ff",
  tab_inactive_fg   = "#ffffff", -- TAB ACTIVE OUT OF FOCUS TEXT
  tab_active_text   = "#bdbd00",
  tab_bg            = "#ff0000",
  tab_edge          = "#3d0000",
  tab_mod_text      = "#ffff5c",

  selection         = "#2a3f66",
  pmenu_sel         = "#00647a",
  search            = "#e07b00",
}

-- TODO: PUT ASCII PORN HERE
local hl = vim.api.nvim_set_hl

hl(0, "Normal",        { fg = c.fg, bg = c.bg })
hl(0, "NormalNC",      { fg = c.fg, bg = c.bg })
hl(0, "CursorLine",    { bg = c.cursor_line })
hl(0, "CursorColumn",  { bg = c.cursor_line })
hl(0, "LineNr",        { fg = c.line_nr })
hl(0, "CursorLineNr",  { fg = c.keyword, bold = true })
hl(0, "Visual",        { bg = c.selection })
hl(0, "VisualNOS",     { bg = c.selection })
hl(0, "VertSplit",     { fg = c.border, bg = c.bg })
hl(0, "WinSeparator",  { fg = c.border, bg = c.bg })
hl(0, "Search",        { fg = c.bg, bg = c.search })
hl(0, "IncSearch",     { fg = c.bg, bg = c.search })
hl(0, "CurSearch",     { fg = c.bg, bg = c.search })
hl(0, "Directory",     { fg = c.func, bold = true })
hl(0, "Title",         { fg = c.keyword, bold = true })
hl(0, "NonText",       { fg = c.line_nr })
hl(0, "EndOfBuffer",   { fg = c.bg })

hl(0, "NormalFloat",   { fg = c.fg_float, bg = c.bg_float })
hl(0, "FloatBorder",   { fg = c.border}) -- bg = c.fg_float
hl(0, "FloatTitle",    { fg = c.border, bold = true }) -- bg = c.bg_float,

hl(0, "Pmenu",         { fg = c.fg, bg = c.bg_alt })
hl(0, "PmenuSel",      { fg = c.bg, bg = c.pmenu_sel, bold = true })
hl(0, "PmenuSbar",     { bg = c.bg_alt })
hl(0, "PmenuThumb",    { bg = c.border })

-- TEXT
hl(0, "Comment",       { fg = c.comment, bg = c.bg, bold = false, italic = true }) --   ::::::
hl(0, "SpecialComment",{ fg = c.comment, bg = c.bg, bold = false }) --        ::::::::::::::::
hl(0, "String",        { fg = c.string })
hl(0, "Character",     { fg = c.string })
hl(0, "Number",        { fg = c.number })
hl(0, "Float",         { fg = c.number })
hl(0, "Boolean",       { fg = c.number, bold = true })
hl(0, "Constant",      { fg = c.constant })

hl(0, "Keyword",       { fg = c.keyword, bold = true })
hl(0, "Statement",     { fg = c.keyword })
hl(0, "Conditional",   { fg = c.keyword })
hl(0, "Repeat",        { fg = c.keyword })
hl(0, "Label",         { fg = c.keyword })
hl(0, "Operator",      { fg = c.operator })
hl(0, "Exception",     { fg = c.error, bold = true })

hl(0, "Function",      { fg = c.func })
hl(0, "Identifier",    { fg = c.variable })
hl(0, "Type",          { fg = c.type, bold = true })
hl(0, "Structure",     { fg = c.type })
hl(0, "StorageClass",  { fg = c.keyword })
hl(0, "TypeDef",       { fg = c.type })

hl(0, "PreProc",       { fg = c.keyword })
hl(0, "Include",       { fg = c.keyword })
hl(0, "Define",        { fg = c.keyword })
hl(0, "Macro",         { fg = c.func })
hl(0, "PreCondit",     { fg = c.keyword })
hl(0, "Special",       { fg = c.operator })
hl(0, "SpecialChar",   { fg = c.operator })
hl(0, "Delimiter",     { fg = c.delimiter }) -- :: for example

hl(0, "@variable",                  { fg = c.variable })
hl(0, "@variable.builtin",          { fg = c.keyword })
hl(0, "@variable.parameter",        { fg = c.parameter })
hl(0, "@variable.member",           { fg = c.field })
hl(0, "@property",                  { fg = c.field })
hl(0, "@field",                     { fg = c.field })
hl(0, "@type",                      { fg = c.type })
hl(0, "@type.builtin",              { fg = c.type })
hl(0, "@type.definition",           { fg = c.type })
hl(0, "@type.qualifier",            { fg = c.keyword })
hl(0, "@function",                  { fg = c.func })
hl(0, "@function.builtin",          { fg = c.func })
hl(0, "@function.call",             { fg = c.func })
hl(0, "@function.macro",            { fg = c.func })
hl(0, "@method",                    { fg = c.func })
hl(0, "@method.call",               { fg = c.func })
hl(0, "@constructor",               { fg = c.type })
hl(0, "@keyword",                   { fg = c.keyword })
hl(0, "@keyword.function",          { fg = c.keyword })
hl(0, "@keyword.operator",          { fg = c.operator })
hl(0, "@keyword.return",            { fg = c.keyword, bold = true })
hl(0, "@operator",                  { fg = c.operator })
hl(0, "@punctuation.delimiter",     { fg = c.punctuation }) -- ;
hl(0, "@punctuation.bracket",       { fg = c.bracket }) --fg_alt
hl(0, "@punctuation.special",       { fg = c.operator })
hl(0, "@string",                    { fg = c.string, italic = true })
hl(0, "@string.escape",             { fg = c.operator })
hl(0, "@string.regex",              { fg = c.string })
hl(0, "@number",                    { fg = c.number })
hl(0, "@boolean",                   { fg = c.number, bold = true })
hl(0, "@constant",                  { fg = c.constant })
hl(0, "@constant.builtin",          { fg = c.constant })
hl(0, "@constant.macro",            { fg = c.constant })
hl(0, "@namespace",                 { fg = c.type })
hl(0, "@module",                    { fg = c.type })
hl(0, "@label",                     { fg = c.keyword })
hl(0, "@comment",                   { fg = c.comment, bg = c.bg, bold = false, italic = true }) --             
hl(0, "@tag",                       { fg = c.keyword })
hl(0, "@tag.attribute",             { fg = c.func })
hl(0, "@tag.delimiter",             { fg = c.delimiter })

hl(0, "DiagnosticError",            { fg = c.error })
hl(0, "DiagnosticWarn",             { fg = c.warn })
hl(0, "DiagnosticInfo",             { fg = c.info })
hl(0, "DiagnosticHint",             { fg = c.hint })
hl(0, "DiagnosticUnderlineError",   { underline = true, sp = c.error })
hl(0, "DiagnosticUnderlineWarn",    { underline = true, sp = c.warn })
hl(0, "DiagnosticUnderlineInfo",    { underline = true, sp = c.info })
hl(0, "DiagnosticUnderlineHint",    { underline = true, sp = c.hint })



-- tabline plugins
hl(0, "BufferCurrent",              { fg = c.tab_active_text, bg = c.tab_active, bold = true })
hl(0, "BufferCurrentSign",          { fg = c.tab_edge, bg = c.tab_active })
hl(0, "BufferCurrentMod",           { fg = c.tab_mod_text, bg = c.tab_active, bold = true })
hl(0, "BufferCurrentIndex",         { fg = c.tab_active_text, bg = c.tab_active })

hl(0, "BufferVisible",              { fg = c.tab_inactive_fg, bg = c.tab_inactive }) --1
hl(0, "BufferVisibleSign",          { fg = c.tab_edge, bg = c.tab_inactive })
hl(0, "BufferVisibleMod",           { fg = c.tab_mod_text, bg = c.tab_active })

hl(0, "BufferInactive",             { fg = c.tab_inactive_text, bg = c.tab_inactive })
hl(0, "BufferInactiveSign",         { fg = c.tab_edge, bg = c.tab_inactive }) --!fg
hl(0, "BufferInactiveMod",          { fg = c.tab_mod_text, bg = c.tab_inactive, bold = true })
hl(0, "BufferInactiveIndex",        { fg = c.tab_inactive_fg, bg = c.tab_inactive })

hl(0, "BufferOffset",               { fg = c.tab_bg, bg = c.tab_bg })
hl(0, "TabLineFill",                { fg = c.tab_bg, bg = c.tab_bg })
hl(0, "BufferTabpageFill",          { bg = c.tab_bg }) -- maybe the only thing that works

-- tabline tests
hl(0, "TabLine",    { fg = c.tab_inactive_text, bg = c.tab_inactive, underline = false })
--hl(0, "TabLineSel", { fg = c.tab_active_text, bg = c.tab_active, bold = true, underline = false })
-- hl(0, "BufferDefaultInactiveIndex", { fg = c.tab_inactive_fg, bg = c.tab_inactive, underline = false })
--hl(0, "BufferDefaultInactiveSign", { fg = c.tab_edge, bg = c.tab_inactive, underline = false })
-- hl(0, "BufferDefaultInactiveSignRight", { fg = c.tab_edge, bg = c.tab_inactive, underline = false })

hl(0, "MiniTablineCurrent", { fg = c.tab_active_text, bg = c.tab_active, bold = false })
hl(0, "MiniTablineVisible", { fg = c.tab_inactive_fg, bg = c.tab_inactive })
hl(0, "MiniTablineHidden", { fg = c.tab_inactive_text, bg = c.tab_inactive })
hl(0, "MiniTablineModifiedCurrent", { fg = c.tab_mod_text, bg = c.tab_active, bold = true })
hl(0, "MiniTablineModifiedVisible", { fg = c.tab_mod_text, bg = c.tab_inactive })
hl(0, "MiniTablineModifiedHidden", { fg = c.tab_mod_text, bg = c.tab_inactive })
hl(0, "MiniTablineFill", { fg = c.tab_inactive_text, bg = c.tab_inactive })
hl(0, "MiniTablineTabpagesection", { fg = c.tab_active_text, bg = c.tab_active, bold = true })
hl(0, "MiniTablineTrunc", { fg = c.tab_inactive_fg, bg = c.tab_inactive })

hl(0, "CmpItemAbbr",                { fg = c.fg })
hl(0, "CmpItemAbbrDeprecated",      { fg = c.line_nr, strikethrough = true })
hl(0, "CmpItemAbbrMatch",           { fg = c.keyword, bold = true })
hl(0, "CmpItemAbbrMatchFuzzy",      { fg = c.keyword, bold = true })
hl(0, "CmpItemKind",                { fg = c.type })
hl(0, "CmpItemMenu",                { fg = c.comment })

hl(0, "TelescopeNormal",            { fg = c.fg, bg = c.bg_alt })
hl(0, "TelescopeBorder",            { fg = c.border, bg = c.bg_alt })
hl(0, "TelescopePromptNormal",      { fg = c.fg, bg = c.bg })
hl(0, "TelescopePromptBorder",      { fg = c.border, bg = c.bg })
hl(0, "TelescopePromptTitle",       { fg = c.bg, bg = c.border, bold = true })
hl(0, "TelescopePreviewTitle",      { fg = c.bg, bg = c.type, bold = true })
hl(0, "TelescopeResultsTitle",      { fg = c.bg, bg = c.string, bold = true })
hl(0, "TelescopeSelection",         { bg = c.selection })
hl(0, "TelescopeMatching",          { fg = c.keyword, bold = true })
