while true; do
    read "answer?${1:-Continue?} [y/n]: "
    case $answer in
      [yY]) return 0 ;;
      [nN]) return 1 ;;
      *) echo 'Not an option'; return 1 ;;
    esac
done
