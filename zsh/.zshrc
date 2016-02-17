#load configs
for config (~/.zsh/*.zsh) source $config

#to get colors working properly
eval `dircolors ~/.dir_colors`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

#startx on login
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
