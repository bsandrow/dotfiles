" Vim syntax file
" Language:	Vim 7.2 script
" Filenames:    *.ini, .hgrc, */.hg/hgrc
" Maintainer:	Peter Hosey
" Last Change:	Nov 11, 2008
" Version:	7.2-02

" Quit when a syntax file was already loaded
if exists("b:current_syntax")
  finish
endif

syn match   iniSection skipwhite contains=iniRule "^\[.\+\]$"

syn match   iniRule "^[^=:]\{-1,}="
syn match   iniRule "^[^:=]\{-1,}:"

syn match   iniComment skipwhite "^[#;].*"

" Highlighting Settings
" ====================

hi def link iniSection Keyword
hi def link iniRule Identifier
hi def link iniComment Comment

let b:current_syntax = "ini"

" ##############
" # README.txt #
" ##############
"
" First, copy this file to ~/.vim/syntax/ini.vim. (You will need to create
" that directory, if you haven't already.)
"
" Then, to make vim automatically use that syntax definition for .ini and hgrc
" files, you'll need to add this to your ~/.vim/filetype.vim file (which you
" will need to create, if you haven't already):
"
" au BufNewFile,BufRead *.ini,*/.hgrc,*/.hg/hgrc setf ini
"
" What this means is:
" 	Upon creating or reading any file
" 		whose name ends in .ini,
" 		or whose name is .hgrc,
" 		or whose name is hgrc and is in a .hg directory,
" 	set the file type to "ini".
"
" When you set (or the auto-command sets) the file type, vim will load the
" syntax definition.
"
" This syntax definition and this README are both copyright 2008 Peter Hosey.
"
" ###############
" # LICENSE.txt #
" ###############
"
" Copyright © 2008 Peter Hosey
"  All rights reserved.
"
" Redistribution and use in source and binary forms, with or without
" modification, are permitted provided that the following conditions are met:
"
" - Redistributions of source code must retain the above copyright notice, this
" list of conditions and the following disclaimer.
"
" - Redistributions in binary form must reproduce the above copyright notice,
" this list of conditions and the following disclaimer in the documentation
" and/or other materials provided with the distribution.
"
" Neither the name of Peter Hosey nor the names of his contributors may be
" used to endorse or promote products derived from this software without
" specific prior written permission.
"
" THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
" IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
" ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
" LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
" CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
" SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
" INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
" CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
" ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
" POSSIBILITY OF SUCH DAMAGE.
