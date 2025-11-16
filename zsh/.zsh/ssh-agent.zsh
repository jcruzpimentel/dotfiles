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
    # Get list of already loaded keys
    loaded_keys=$(ssh-add -l 2>/dev/null)

    for key in "${SSH_KEYS[@]}"; do
        if [ -f "$key" ]; then
            # Extract key fingerprint
            key_fingerprint=$(ssh-keygen -lf "$key" 2>/dev/null | awk '{print $2}')

            # Only add if not already loaded
            if [[ ! "$loaded_keys" =~ "$key_fingerprint" ]]; then
                ssh-add $keychain_flag "$key" 2>/dev/null
            fi
        fi
    done
fi

# Ensure proper permissions on SSH config
if [ -f ~/.ssh/config ]; then
    chmod 600 ~/.ssh/config 2>/dev/null
fi
