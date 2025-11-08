# Environment Variables

# ============================================================================
# Zinit Configuration
# ============================================================================
export ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# ============================================================================
# History Configuration
# ============================================================================
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# History options
setopt APPEND_HISTORY          # Append to history file, don't overwrite
setopt SHARE_HISTORY           # Share history between all sessions
setopt HIST_EXPIRE_DUPS_FIRST  # Expire duplicate entries first when trimming
setopt HIST_IGNORE_DUPS        # Don't record duplicate entries
setopt HIST_IGNORE_ALL_DUPS    # Delete old duplicates when new one is added
setopt HIST_FIND_NO_DUPS       # Don't display duplicates when searching
setopt HIST_IGNORE_SPACE       # Don't record commands starting with space
setopt HIST_SAVE_NO_DUPS       # Don't write duplicates to history file
setopt HIST_VERIFY             # Show command with history expansion before running

# ============================================================================
# Colors Configuration
# ============================================================================
# Enable colors for ls and completion
export CLICOLOR=1

# Set LS_COLORS for better file/directory colors
# This works on both macOS and Linux
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS uses LSCOLORS
    export LSCOLORS="ExGxFxdxCxDxDxhbadExEx"
fi

# GNU ls colors (Linux and macOS with GNU coreutils)
export LS_COLORS="di=34:ln=36:so=35:pi=33:ex=32:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"

# ============================================================================
# fzf Configuration
# ============================================================================
# fzf default options
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --info=inline
"

# Use fd instead of find if available (faster, respects .gitignore)
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ============================================================================
# General Environment Variables
# ============================================================================
# Add any shared environment variables here
# Examples:
# export EDITOR=vim
# export VISUAL=vim
# export LANG=en_US.UTF-8
