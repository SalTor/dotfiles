# Launch Zsh
if [ -t 1 ]; then
    exec zsh
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -f ~/.aliases ] && source ~/.aliases

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
