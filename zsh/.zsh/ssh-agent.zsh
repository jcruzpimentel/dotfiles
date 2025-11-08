# SSH Agent Configuration

# Start ssh-agent if not already running
if [ -z "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -s)" > /dev/null
fi

# Auto-add SSH keys to agent
# Detect OS for keychain compatibility
case "$(uname -s)" in
    Darwin)
        # macOS - use keychain integration
        keychain_flag="--apple-use-keychain"
        ;;
    Linux)
        # Linux - no keychain flag
        keychain_flag=""
        ;;
esac

# Load SSH keys from SSH_KEYS array (defined in local.zsh)
if [ -n "$SSH_KEYS" ]; then
    for key in "${SSH_KEYS[@]}"; do
        if [ -f "$key" ]; then
            ssh-add $keychain_flag "$key" 2>/dev/null
        fi
    done
fi

# Ensure proper permissions on SSH config
if [ -f ~/.ssh/config ]; then
    chmod 600 ~/.ssh/config 2>/dev/null
fi
