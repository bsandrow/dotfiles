" Vim color file
" Name:       gentooish.vim
" Maintainer: Brian Carper
" Version: 0.1
" Source: http://briancarper.net/2008/05/10/vim-color-scheme-gentooish/

set background=dark
hi clear
if exists("syntax_on")
   syntax reset
endif

let g:colors_name = "gentooish"

hi Normal         gui=NONE   guifg=#cccccc   guibg=#191919

hi IncSearch      gui=NONE   guifg=#000000   guibg=#8bff95
hi Search         gui=NONE   guifg=#cccccc   guibg=#863132
hi ErrorMsg       gui=NONE   guifg=#cccccc   guibg=#863132
hi WarningMsg     gui=NONE   guifg=#cccccc   guibg=#863132
hi ModeMsg        gui=NONE   guifg=#cccccc   guibg=NONE
hi MoreMsg        gui=NONE   guifg=#cccccc   guibg=NONE
hi Question       gui=NONE   guifg=#cccccc   guibg=NONE

hi StatusLine     gui=BOLD   guifg=#cccccc   guibg=#333333
hi User1          gui=BOLD   guifg=#999999   guibg=#333333
hi User2          gui=BOLD   guifg=#8bff95   guibg=#333333
hi StatusLineNC   gui=NONE   guifg=#999999   guibg=#333333
hi VertSplit      gui=NONE   guifg=#cccccc   guibg=#333333

hi WildMenu       gui=BOLD   guifg=#cf7dff   guibg=#1F0F29

hi DiffText       gui=NONE   guifg=#000000  guibg=#4cd169
hi DiffChange     gui=NONE   guifg=NONE     guibg=#541691
hi DiffDelete     gui=NONE   guifg=#cccccc  guibg=#863132
hi DiffAdd        gui=NONE   guifg=#cccccc  guibg=#306d30

hi Cursor         gui=NONE   guifg=#000000   guibg=#8bff95

hi Folded         gui=NONE   guifg=#aaa400   guibg=#000000
hi FoldColumn     gui=NONE   guifg=#cccccc   guibg=#000000

hi Directory      gui=NONE   guifg=#8bff95   guibg=NONE
hi LineNr         gui=NONE   guifg=#bbbbbb   guibg=#222222
hi NonText        gui=NONE   guifg=#555555   guibg=NONE
hi SpecialKey     gui=NONE   guifg=#6f6f2f   guibg=NONE
hi Title          gui=NONE   guifg=#9a383a   guibg=NONE
hi Visual         gui=NONE   guifg=#cccccc   guibg=#1d474f

hi Comment        gui=NONE   guifg=#666666   guibg=NONE
hi Constant       gui=NONE   guifg=#b8bb00   guibg=NONE
hi Boolean        gui=NONE   guifg=#00ff00   guibg=NONE
hi String         gui=NONE   guifg=#5dff9e   guibg=#0f291a
hi Error          gui=NONE   guifg=#990000   guibg=#000000
hi Identifier     gui=NONE   guifg=#4cbbd1   guibg=NONE
hi Ignore         gui=NONE   guifg=#555555
hi Number         gui=NONE   guifg=#ddaa66   guibg=NONE
hi PreProc        gui=NONE   guifg=#9a383a   guibg=NONE

hi Special        gui=NONE   guifg=#ffcd8b   guibg=NONE

hi Statement      gui=NONE   guifg=#4cd169   guibg=NONE
hi Todo           gui=NONE   guifg=#cccccc   guibg=#863132
hi Type           gui=NONE   guifg=#c476f1   guibg=NONE
hi Underlined     gui=UNDERLINE   guifg=#cccccc   guibg=NONE

hi Visual         gui=NONE   guifg=#ffffff   guibg=#6e4287
hi VisualNOS      gui=NONE   guifg=#cccccc   guibg=#000000

hi CursorLine     gui=NONE   guifg=NONE      guibg=#222222
hi CursorColumn   gui=NONE   guifg=NONE      guibg=#222222

hi lispList       gui=NONE   guifg=#555555

if v:version >= 700
  hi Pmenu        gui=NONE   guifg=#cccccc   guibg=#222222
  hi PMenuSel     gui=BOLD   guifg=#c476f1   guibg=#000000
  hi PmenuSbar    gui=NONE   guifg=#cccccc   guibg=#000000
  hi PmenuThumb   gui=NONE   guifg=#cccccc   guibg=#333333

  hi SpellBad     gui=undercurl guisp=#cc6666
  hi SpellRare    gui=undercurl guisp=#cc66cc
  hi SpellLocal   gui=undercurl guisp=#cccc66
  hi SpellCap     gui=undercurl guisp=#66cccc

  hi MatchParen   gui=NONE      guifg=#ffffff   guibg=#005500
endif

" vim: set et :
