" =============================================================================
"  nord-light.vim — a light variant of the Nord palette
"  Snow Storm background · Polar Night text · Frost/Aurora accents darkened
"  for real contrast in bright environments (roughly WCAG AA on code tokens).
"
"  Drop this at ~/.vim/colors/nord-light.vim and `:colorscheme nord-light`.
"  Designed for termguicolors (truecolor); cterm fallbacks are approximate.
" =============================================================================

hi clear
if exists('syntax_on')
  syntax reset
endif
set background=light
let g:colors_name = 'nord-light'

" -----------------------------------------------------------------------------
"  Palette
" -----------------------------------------------------------------------------
"  Backgrounds (Nord Snow Storm, gentle off-whites — no harsh pure white)
let s:bg      = '#ECEFF4'   " nord6  — normal background
let s:bg_soft = '#E5E9F0'   " nord5  — pmenu / columns
let s:bg_sel  = '#DCE1EC'   " between nord5/4 — cursorline
let s:bg_vis  = '#CBD3E1'   " selection / visual (darker for clear contrast)
let s:bg_gut  = '#E9EDF3'   " sign/fold column

"  Foregrounds (Nord Polar Night)
let s:fg      = '#2E3440'   " nord0  — normal text (very dark, high contrast)
let s:fg_soft = '#3B4252'   " nord1
let s:fg_dim  = '#5E6A82'   " muted — comments / line nums (readable ~4.3:1)
let s:fg_faint= '#8A93A8'   " very muted — nontext / whitespace guides

"  Accents — Frost + Aurora, darkened so they read on a light background
let s:blue    = '#4C6E9B'   " keywords            (nord9-ish, darker)
let s:navy    = '#3B5C86'   " strong blue / titles
let s:cyan    = '#1F7A8C'   " functions           (darkened nord8)
let s:teal    = '#4E7E7C'   " types               (darkened nord7)
let s:green   = '#57761F'   " strings             (darkened nord14)
let s:yellow  = '#9A7413'   " special / warnings  (darkened nord13)
let s:orange  = '#B5673A'   " preproc / constants (darkened nord12)
let s:red     = '#AE3B45'   " errors / delete     (darkened nord11)
let s:purple  = '#8A5A8C'   " numbers / consts    (darkened nord15)

" -----------------------------------------------------------------------------
"  Helper
" -----------------------------------------------------------------------------
function! s:hi(group, fg, bg, attr) abort
  let l:cmd = 'hi ' . a:group
  if a:fg   !=# '' | let l:cmd .= ' guifg=' . a:fg   | endif
  if a:bg   !=# '' | let l:cmd .= ' guibg=' . a:bg   | endif
  if a:attr !=# '' | let l:cmd .= ' gui=' . a:attr . ' cterm=' . a:attr
  else             | let l:cmd .= ' gui=NONE cterm=NONE'
  endif
  execute l:cmd
endfunction

" -----------------------------------------------------------------------------
"  Editor UI
" -----------------------------------------------------------------------------
call s:hi('Normal',        s:fg,      s:bg,      '')
call s:hi('NormalFloat',   s:fg,      s:bg_soft, '')
call s:hi('LineNr',        s:fg_faint,s:bg,      '')
call s:hi('CursorLineNr',  s:navy,    s:bg_sel,  'bold')
call s:hi('CursorLine',    '',        s:bg_sel,  '')
call s:hi('CursorColumn',  '',        s:bg_sel,  '')
call s:hi('ColorColumn',   '',        s:bg_soft, '')
call s:hi('SignColumn',    s:fg_dim,  s:bg,      '')
call s:hi('FoldColumn',    s:fg_faint,s:bg,      '')
call s:hi('Folded',        s:fg_dim,  s:bg_soft, 'italic')
call s:hi('VertSplit',     s:bg_vis,  s:bg,      '')
call s:hi('WinSeparator',  s:bg_vis,  s:bg,      '')
call s:hi('Cursor',        s:bg,      s:fg,      '')
call s:hi('Directory',     s:navy,    '',        'bold')
call s:hi('Title',         s:navy,    '',        'bold')

" Status / tab line
call s:hi('StatusLine',    s:bg,      s:navy,    'bold')
call s:hi('StatusLineNC',  s:fg_dim,  s:bg_soft, '')
call s:hi('TabLine',       s:fg_dim,  s:bg_soft, '')
call s:hi('TabLineSel',    s:bg,      s:navy,    'bold')
call s:hi('TabLineFill',   s:fg_dim,  s:bg_soft, '')
call s:hi('WildMenu',      s:bg,      s:blue,    'bold')

" Popup menu (completion)
call s:hi('Pmenu',         s:fg,      s:bg_soft, '')
call s:hi('PmenuSel',      s:bg,      s:blue,    'bold')
call s:hi('PmenuSbar',     '',        s:bg_vis,  '')
call s:hi('PmenuThumb',    '',        s:fg_dim,  '')

" Search / selection / matching
call s:hi('Search',        s:fg,      '#F2D98B', 'bold')
call s:hi('IncSearch',     s:bg,      s:orange,  'bold')
call s:hi('CurSearch',     s:bg,      s:orange,  'bold')
call s:hi('Visual',        '',        s:bg_vis,  '')
call s:hi('MatchParen',    s:red,     s:bg_vis,  'bold')

" Messages
call s:hi('ErrorMsg',      s:red,     '',        'bold')
call s:hi('WarningMsg',    s:orange,  '',        'bold')
call s:hi('MoreMsg',       s:green,   '',        '')
call s:hi('Question',      s:green,   '',        '')
call s:hi('ModeMsg',       s:fg_dim,  '',        '')

" Whitespace / non-text
call s:hi('NonText',       s:fg_faint,'',        '')
call s:hi('SpecialKey',    s:fg_faint,'',        '')
call s:hi('Whitespace',    s:fg_faint,'',        '')
call s:hi('Conceal',       s:fg_dim,  '',        '')

" -----------------------------------------------------------------------------
"  Syntax
" -----------------------------------------------------------------------------
call s:hi('Comment',       s:fg_dim,  '',        'italic')

call s:hi('Constant',      s:purple,  '',        '')
call s:hi('String',        s:green,   '',        '')
call s:hi('Character',     s:green,   '',        '')
call s:hi('Number',        s:purple,  '',        '')
call s:hi('Boolean',       s:purple,  '',        'bold')
call s:hi('Float',         s:purple,  '',        '')

call s:hi('Identifier',    s:fg_soft, '',        '')
call s:hi('Function',      s:cyan,    '',        'bold')

call s:hi('Statement',     s:blue,    '',        'bold')
call s:hi('Conditional',   s:blue,    '',        'bold')
call s:hi('Repeat',        s:blue,    '',        'bold')
call s:hi('Label',         s:blue,    '',        '')
call s:hi('Operator',      s:teal,    '',        '')
call s:hi('Keyword',       s:blue,    '',        'bold')
call s:hi('Exception',     s:red,     '',        'bold')

call s:hi('PreProc',       s:orange,  '',        '')
call s:hi('Include',       s:orange,  '',        '')
call s:hi('Define',        s:orange,  '',        '')
call s:hi('Macro',         s:orange,  '',        '')
call s:hi('PreCondit',     s:orange,  '',        '')

call s:hi('Type',          s:teal,    '',        'bold')
call s:hi('StorageClass',  s:teal,    '',        '')
call s:hi('Structure',     s:teal,    '',        '')
call s:hi('Typedef',       s:teal,    '',        '')

call s:hi('Special',       s:orange,  '',        '')
call s:hi('SpecialChar',   s:orange,  '',        '')
call s:hi('Tag',           s:blue,    '',        '')
call s:hi('Delimiter',     s:fg_soft, '',        '')
call s:hi('SpecialComment',s:fg_dim,  '',        'bold')
call s:hi('Debug',         s:red,     '',        '')

call s:hi('Underlined',    s:navy,    '',        'underline')
call s:hi('Ignore',        s:fg_faint,'',        '')
call s:hi('Error',         s:bg,      s:red,     'bold')
call s:hi('Todo',          s:bg,      s:yellow,  'bold')

" -----------------------------------------------------------------------------
"  Diff
" -----------------------------------------------------------------------------
call s:hi('DiffAdd',       s:green,   '#E4EEDB', '')
call s:hi('DiffChange',    s:blue,    '#E0E8F2', '')
call s:hi('DiffDelete',    s:red,     '#F3DEE0', '')
call s:hi('DiffText',      s:navy,    '#D2E0F2', 'bold')

" -----------------------------------------------------------------------------
"  Spell
" -----------------------------------------------------------------------------
call s:hi('SpellBad',      s:red,     '',        'undercurl')
call s:hi('SpellCap',      s:blue,    '',        'undercurl')
call s:hi('SpellRare',     s:purple,  '',        'undercurl')
call s:hi('SpellLocal',    s:teal,    '',        'undercurl')

" -----------------------------------------------------------------------------
"  GitGutter
" -----------------------------------------------------------------------------
call s:hi('GitGutterAdd',          s:green,  s:bg, 'bold')
call s:hi('GitGutterChange',       s:blue,   s:bg, 'bold')
call s:hi('GitGutterDelete',       s:red,    s:bg, 'bold')
call s:hi('GitGutterChangeDelete', s:orange, s:bg, 'bold')

" -----------------------------------------------------------------------------
"  coc.nvim (diagnostics, completion, symbol highlight)
" -----------------------------------------------------------------------------
call s:hi('CocErrorSign',      s:red,    s:bg,      'bold')
call s:hi('CocWarningSign',    s:orange, s:bg,      'bold')
call s:hi('CocInfoSign',       s:blue,   s:bg,      'bold')
call s:hi('CocHintSign',       s:teal,   s:bg,      'bold')
call s:hi('CocErrorHighlight',   s:red,    '',      'undercurl')
call s:hi('CocWarningHighlight', s:orange, '',      'undercurl')
call s:hi('CocInfoHighlight',    s:blue,   '',      'undercurl')
call s:hi('CocHintHighlight',    s:teal,   '',      'undercurl')
call s:hi('CocFloating',       s:fg,     s:bg_soft, '')
call s:hi('CocMenuSel',        s:bg,     s:blue,    'bold')
call s:hi('CocSearch',         s:cyan,   '',        'bold')
call s:hi('CocSelectedText',   s:red,    '',        'bold')
call s:hi('CocHighlightText',  '',       s:bg_vis,  '')

" -----------------------------------------------------------------------------
"  NERDTree
" -----------------------------------------------------------------------------
call s:hi('NERDTreeDir',       s:navy,   '', 'bold')
call s:hi('NERDTreeDirSlash',  s:fg_faint,'', '')
call s:hi('NERDTreeOpenable',  s:fg_dim, '', '')
call s:hi('NERDTreeClosable',  s:fg_dim, '', '')
call s:hi('NERDTreeFile',      s:fg,     '', '')
call s:hi('NERDTreeExecFile',  s:green,  '', '')
call s:hi('NERDTreeCWD',       s:cyan,   '', 'bold')

delfunction s:hi

" =============================================================================
"  End of nord-light.vim
" =============================================================================
