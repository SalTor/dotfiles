" Syntax highlighting for jj status output

if exists("b:current_syntax")
  finish
endif

" Match the header and working copy info
syntax match jjStatusHeader "^Working copy changes:$"
syntax match jjStatusWorkingCopy "^Working copy.*$"
syntax match jjStatusParent "^Parent commit.*$"

" Define syntax regions for file status lines
syntax match jjStatusAdded "^A .*$"
syntax match jjStatusModified "^M .*$"
syntax match jjStatusDeleted "^D .*$"
syntax match jjStatusRenamed "^R .*$"
syntax match jjStatusCopied "^C .*$"
syntax match jjStatusUntracked "^? .*$"

" Match the status indicators at the beginning of lines
syntax match jjStatusIndicatorA "^A" contained containedin=jjStatusAdded
syntax match jjStatusIndicatorM "^M" contained containedin=jjStatusModified
syntax match jjStatusIndicatorD "^D" contained containedin=jjStatusDeleted
syntax match jjStatusIndicatorR "^R" contained containedin=jjStatusRenamed
syntax match jjStatusIndicatorC "^C" contained containedin=jjStatusCopied
syntax match jjStatusIndicatorU "^?" contained containedin=jjStatusUntracked

" Match file paths (everything after the status indicator and space)
syntax match jjStatusFilePath " .*$" contained containedin=jjStatusAdded,jjStatusModified,jjStatusDeleted,jjStatusRenamed,jjStatusCopied,jjStatusUntracked

" Match commit hashes and revision info
syntax match jjStatusCommitHash "\x\{8,\}" contained
syntax match jjStatusRevision "(@[^)]*)" contained

" Define highlight groups that match jj's color scheme
highlight default jjStatusHeader ctermfg=Cyan guifg=#00d7ff gui=bold
highlight default jjStatusWorkingCopy ctermfg=Green guifg=#00ff5f
highlight default jjStatusParent ctermfg=Blue guifg=#5f87ff

highlight default jjStatusIndicatorA ctermfg=Green guifg=#00ff5f gui=bold
highlight default jjStatusIndicatorM ctermfg=Yellow guifg=#ffff00 gui=bold  
highlight default jjStatusIndicatorD ctermfg=Red guifg=#ff5f5f gui=bold
highlight default jjStatusIndicatorR ctermfg=Cyan guifg=#00d7ff gui=bold
highlight default jjStatusIndicatorC ctermfg=Cyan guifg=#00d7ff gui=bold
highlight default jjStatusIndicatorU ctermfg=Magenta guifg=#ff87ff gui=bold

highlight default jjStatusFilePath ctermfg=White guifg=#ffffff
highlight default jjStatusCommitHash ctermfg=Yellow guifg=#d7af00
highlight default jjStatusRevision ctermfg=Magenta guifg=#af87ff

let b:current_syntax = "jjstatus"