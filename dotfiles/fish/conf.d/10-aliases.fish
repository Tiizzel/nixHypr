# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------

# -----------------------------------------------------
# General
# -----------------------------------------------------
alias ..='cd ..'
alias c='clear'
alias nf='fastfetch'
alias pf='fastfetch'
alias ff='fastfetch'
alias ls='eza -a --icons=always'
alias ll='eza -al --icons=always'
alias lt='eza -a --tree --level=1 --icons=always'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vim='$EDITOR'
alias wifi='nmtui'
alias arch-cleanup='~/.config/nixHypr/scripts/arch/cleanup.sh'
alias apps='~/.config/nixHypr/bin/nixHypr-apps'
alias screenshot='~/.config/nixHypr/bin/nixHypr-screenshot'
alias updates='~/.config/nixHypr/scripts/nixHypr-install-system-updates'
alias filemanager='~/.config/nixHypr/settings/filemanager'
alias lock='hyprlock'
alias clock='tty-clock'
alias system='~/.config/nixHypr/settings/systemmonitor'
alias quick='~/.config/nixHypr/bin/nixHypr-quicklinks'
alias wallpaper='~/.config/nixHypr/bin/nixHypr-wallpaper'
alias settings='nixHypr-dotfiles-settings com.nixHypr.dotfiles'

# -----------------------------------------------------
# NixHypr Apps
# -----------------------------------------------------
alias nixHypr-settings='qs -p ~/.local/share/nixHypr-dotfiles-settings/quickshell ipc call settings toggle'
alias nixHypr-hyprland='flatpak run com.nixHypr.hyprlandsettings'

# -----------------------------------------------------
# Git
# -----------------------------------------------------
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gst="git stash"
alias gsp="git stash; git pull"
alias gfo="git fetch origin"
alias gcheck="git checkout"
alias gcredential="git config credential.helper store"

# -----------------------------------------------------
# Scripts
# -----------------------------------------------------
alias ascii='~/.config/nixHypr/scripts/figlet.sh'

# -----------------------------------------------------
# System
# -----------------------------------------------------
alias update-grub='sudo grub-mkconfig -o /boot/grub/grub.cfg'
