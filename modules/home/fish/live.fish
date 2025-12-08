# ==========================================
# Environment Variables
# ==========================================
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx GOPATH $HOME/go
set -gx BROWSER zen-browser

# XDG Base Directory
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share
set -gx XDG_CACHE_HOME $HOME/.cache

# Path additions
fish_add_path $HOME/go/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/.cargo/bin

# ==========================================
# Starship Prompt
# ==========================================
starship init fish | source

# ==========================================
# Zoxide (better cd)
# ==========================================
zoxide init fish | source

# ==========================================
# Aliases - Nix/System Management
# ==========================================
alias ns='sudo nvim /etc/nixos/configuration.nix'
alias hn='nvim ~/nix-config/modules/home/home.nix'
alias fn='nvim ~/nix-config/modules/home/fish/config.fish'
alias update='sudo nix-channel --update'
alias nr='cd ~/nix-config && sudo nixos-rebuild switch --flake .#SuperDuperComputer'
alias hr='home-manager switch --flake ~/nix-config#tikhaboom'
alias hb='home-manager switch --flake ~/nix-config#tikhaboom -b backup'
alias nc='nix-collect-garbage -d'
alias ncs='sudo nix-collect-garbage -d'
alias nd='nix-store --query --requisites /run/current-system | grep -F /nix/store | xargs du -sh | sort -hr'
alias see='nix search nixpkgs'
alias ndev='nix develop'
alias nshell='nix-shell'
alias hib='sudo systemctl hibernate'
alias susp='sudo systemctl suspend'
alias reboot='sudo systemctl reboot'
alias poweroff='sudo systemctl poweroff'

# ==========================================
# Aliases - Git
# ==========================================
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gp='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias gll='git log --graph --pretty=format:"%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset" --abbrev-commit'
alias gb='git branch'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gm='git merge'
alias gr='git rebase'
alias gst='git stash'
alias gstp='git stash pop'
alias gclone='git clone'
alias greset='git reset --hard'
alias gundo='git reset --soft HEAD~1'

# ==========================================
# Aliases - Home Manager & Dotfiles
# ==========================================
alias hm='home-manager'
alias hme='home-manager edit'
alias hmg='home-manager generations'
alias hmr='home-manager switch --rollback'
alias dotfiles='cd ~/nix-config && nvim'
alias backup='cd ~/nix-config && git add -A && git commit -m "backup: $(date +%Y-%m-%d_%H:%M:%S)" && git push'
alias sync='cd ~/nix-config && git pull && hr'

# ==========================================
# Aliases - Essential Shell
# ==========================================
alias q='exit'
alias c='clear'
alias h='history'
alias w='cd ~/Work'
alias d='cd ~/Downloads'
alias doc='cd ~/Documents'
alias nconf='cd ~/nix-config'

# LS aliases (using eza)
alias ls='eza --icons'
alias ll='eza -l --icons --git'
alias la='eza -a --icons'
alias lla='eza -la --icons --git'
alias lt='eza --tree --icons'
alias lta='eza --tree --level=2 --icons -a'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# File operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Grep with color
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Process management
alias psf='ps aux | grep -v grep | grep -i'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias killall='killall -v'
alias cmyram='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'

# System info
alias sysinfo='fastfetch'
alias mem='free -h'
alias disk='df -h'
alias ports='ss -tulanp'

# ==========================================
# Aliases - Development
# ==========================================
alias v='nvim'
alias vim='nvim'
alias nano='sudo -E nvim'
alias code='code .'
alias zed='zed .'

# Python
alias py='python3'
alias pip='pip3'
alias venv='python3 -m venv venv'
alias srcfish='source ~/nix-config/modules/home/fish/live.fish'

# Docker
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias dex='docker exec -it'
alias dlog='docker logs -f'
alias dstop='docker stop'
alias drm='docker rm'
alias drmi='docker rmi'
alias dprune='docker system prune -af'

# ==========================================
# Functions
# ==========================================

# Quick project starter
function mkcd
    mkdir -p $argv[1]
    cd $argv[1]
end

# Extract archives
function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

# Git commit with automatic message
function gac
    git add .
    if test (count $argv) -gt 0
        git commit -m "$argv"
    else
        git commit -m "Quick update: $(date +%Y-%m-%d_%H:%M)"
    end
end

# Git add, commit, push in one command
function gacp
    git add .
    if test (count $argv) -gt 0
        git commit -m "$argv"
    else
        git commit -m "Quick update: $(date +%Y-%m-%d_%H:%M)"
    end
    git push
end

# Quick nix rebuild with commit
function nrb
    cd ~/nix-config
    git add -A
    if test (count $argv) -gt 0
        git commit -m "$argv"
    else
        git commit -m "config: $(date +%Y-%m-%d_%H:%M)"
    end
    sudo nixos-rebuild switch --flake .#SuperDuperComputer
end

# Quick home-manager rebuild with commit
function hrb
    cd ~/nix-config
    git add -A
    if test (count $argv) -gt 0
        git commit -m "$argv"
    else
        git commit -m "home: $(date +%Y-%m-%d_%H:%M)"
    end
    home-manager switch --flake .#tikhaboom
end

# Search nix packages and show details
function seeless
    nix search nixpkgs $argv | less
end

# Create a temporary nix shell with packages
function tmp
    nix-shell -p $argv
end

# Quick server
function serve
    set port 8000
    if test (count $argv) -gt 0
        set port $argv[1]
    end
    python3 -m http.server $port
end

# Find and kill process by name
function kp
    ps aux | grep -v grep | grep -i $argv[1] | awk '{print $2}' | xargs kill -9
end

# ==========================================
# Conditional Configurations
# ==========================================

# Load direnv if available
if type -q direnv
    direnv hook fish | source
end

# Load fzf keybindings if available
if type -q fzf
    fzf --fish | source
end

# ==========================================
# Welcome Message (optional)
# ==========================================
# Uncomment to show system info on startup
# fastfetch --logo nixos

# Show git status if in a git repo
if test -d .git
    echo "📁 Git repository detected"
    git status -sb
end
