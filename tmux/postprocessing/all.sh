for f in ~/.tmux/postprocessing/*.sh; do
    if [[ "$f" != *all.sh* ]]; then
        bash "$f"
    fi
done
