function tmp --description 'Open a new temp file in $EDITOR, print its path'
    set -l f (mktemp)
    set -l ed $EDITOR
    test -n "$ed"; or set ed vim
    $ed $f
    echo $f
end
