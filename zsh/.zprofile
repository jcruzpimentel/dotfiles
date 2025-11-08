# .zprofile - Runs for login shells
# Environment setup that should run once per session

# Homebrew initialization
# Detect and initialize Homebrew based on OS and architecture
if [[ "$(uname -s)" == "Darwin" ]]; then
    # macOS - Apple Silicon
    if [ -f /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
elif [[ "$(uname -s)" == "Linux" ]]; then
    # Linux - check common Homebrew locations
    if [ -f /home/linuxbrew/.linuxbrew/bin/brew ]; then
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    elif [ -f ~/.linuxbrew/bin/brew ]; then
        eval "$(~/.linuxbrew/bin/brew shellenv)"
    fi
fi

# Add any other login-shell specific configurations below
