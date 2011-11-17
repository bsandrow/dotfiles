if exists("perl_fold")
  if !exists("perl_nofold_subs")
    syn clear perlSubFold
    syn region perlSubFold
            \ start="^\z(\s*\)\<sub\>.\{-}[^};,]\s*$"
            \ end="^\z1[)}]\?},\?\s*\%(#.*\)\=$"
            \ transparent fold keepend
    syn region perlSubFold
            \ start="^\z(\s*\)\<\%(BEGIN\|END\|CHECK\|INIT\|UNITCHECK\)\>.*[^};]$"
            \ end="^\z1}\s*$"
            \ transparent fold keepend
  endif
endif
