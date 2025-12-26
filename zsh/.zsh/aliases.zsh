# Aliases

# ============================================================================
# micro - Modern terminal text editor
# ============================================================================

if command -v micro &> /dev/null; then
    alias m='micro'
    alias nano='micro'  # Replace nano with micro
fi

# ============================================================================
# bat - Cat replacement with syntax highlighting
# ============================================================================

#if command -v bat &> /dev/null; then
#    alias cat='bat --paging=never'
#    alias bcat='bat'  # Original bat with paging
#fi

# ============================================================================
# eza - Modern ls replacement with icons and git integration
# ============================================================================

if command -v eza &> /dev/null; then
    # Basic ls replacement
    alias ls='eza --icons --group-directories-first'
    alias ll='eza --icons --long --group-directories-first --git'
    alias la='eza --icons --long --all --group-directories-first --git'

    # Tree views
    alias lt='eza --icons --tree --level=2 --group-directories-first'
    alias lta='eza --icons --tree --level=2 --all --group-directories-first'
    alias lt3='eza --icons --tree --level=3 --group-directories-first'

    # Detailed views
    alias l='eza --icons --long --header --group --group-directories-first --git'
    alias lh='eza --icons --long --header --group --all --group-directories-first --git'
else
    # Fallback to regular ls with colors
    alias ls='ls --color=auto'
    alias ll='ls -lh'
    alias la='ls -lAh'
    alias l='ls -lh'
fi
