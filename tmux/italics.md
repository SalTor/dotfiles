# To enable italics in iTerm + tmux [link](https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be)

## 1. Create these files

`xterm-256color-italic.terminfo`
```
xterm-256color-italic|xterm with 256 colors and italic,
  sitm=\E[3m, ritm=\E[23m,
  use=xterm-256color,
```

`tmux-256color.terminfo`
```
tmux-256color|tmux with 256 colors,
  ritm=\E[23m, rmso=\E[27m, sitm=\E[3m, smso=\E[7m, Ms@,
  khome=\E[1~, kend=\E[4~,
  use=xterm-256color, use=screen-256color,
```

## 2. Install them by running
```
tic -x xterm-256color-italic.terminfo
tic -x tmux-256color.terminfo
```

## 3. Go to `Preferences > Profiles > Default`
## 4. Make sure `Text > Italic text` is checked
## 5. Set `Terminal > Report Terminal Type` to `xterm-256color-italic`
