# Zsh Plugin Management with Zinit

# Bootstrap zinit if not installed
if [ ! -d "$ZINIT_HOME" ]; then
    echo "Installing zinit..."
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add plugins below
# Using 'light' mode for faster loading (no reporting/tracking)

# fzf key bindings (load FIRST, before other completions)
# Modern way: use fzf --zsh (fzf 0.48.0+)
if command -v fzf &> /dev/null; then
    eval "$(fzf --zsh)"
fi

# zoxide - smarter cd command with fzf integration
# --cmd cd replaces the cd command to use zoxide
if command -v zoxide &> /dev/null; then
    eval "$(zoxide init --cmd cd zsh)"
fi

# Additional completion definitions
zinit light zsh-users/zsh-completions

# Fish-like autosuggestions
zinit light zsh-users/zsh-autosuggestions

# History substring search (match history by typed prefix)
zinit light zsh-users/zsh-history-substring-search

# Syntax highlighting (load last for best results)
zinit light zsh-users/zsh-syntax-highlighting

# Load completions
autoload -Uz compinit && compinit

# Replay compdefs for performance (must come after compinit)
zinit cdreplay -q

# fzf-tab (replace zsh tab completion with fzf)
# MUST load AFTER compinit to intercept completions
zinit light Aloxaf/fzf-tab

# ============================================================================
# Oh My Zsh Plugins (OMZP)
# ============================================================================

# Git aliases and functions (gst, gco, gp, etc.)
zinit snippet OMZP::git

# Press ESC twice to add sudo to previous command
zinit snippet OMZP::sudo

# Suggests package to install when command not found
zinit snippet OMZP::command-not-found

# Colorizes man pages for better readability
zinit snippet OMZP::colored-man-pages

# Docker aliases and completions
zinit snippet OMZP::docker

# ============================================================================
# Completion Options
# ============================================================================

# Case-insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Partial completion - allows matching in the middle of words
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# ============================================================================
# fzf-tab Configuration
# ============================================================================
# Disable default zsh completion menu to let fzf-tab take over
zstyle ':completion:*' menu no

# Enable fzf-tab
zstyle ':fzf-tab:*' fzf-command fzf

# Simple completion group format (no colors for descriptions)
zstyle ':completion:*:descriptions' format '[%d]'

# Disable default list-colors to reduce jarring colors in fzf-tab
zstyle ':completion:*' list-colors ''

# But enable colors only for file/directory completions
zstyle ':completion:*:*:*:*:files' list-colors '=(#b)*(/)=0=34'
zstyle ':completion:*:*:*:*:directories' list-colors '=(#b)*(/)=0=34'

# Preview directories when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls -1 --color $realpath'

# Preview for zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls -1 --color $realpath'

# Use tmux popup if available
zstyle ':fzf-tab:*' fzf-flags --height=60% --border

# ============================================================================
# Key Bindings
# ============================================================================

# History substring search key bindings
# Bind UP and DOWN arrow keys
bindkey '^[[A' history-substring-search-up     # Up arrow
bindkey '^[[B' history-substring-search-down   # Down arrow

# Also bind for vi mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
