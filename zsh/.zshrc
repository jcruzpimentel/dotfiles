# Main zsh configuration file
# This file sources all modular configuration files

# Source .zprofile for Homebrew and other login shell configurations
# This ensures Homebrew is available even in non-login shells
if [ -f ~/.zprofile ]; then
    source ~/.zprofile
fi

# Source all zsh config files in order
# Order matters: env.zsh should be first, local.zsh should be loaded early for variables
for config_file in ~/.zsh/env.zsh ~/.zsh/local.zsh ~/.zsh/*.zsh; do
    # Skip env.zsh and local.zsh in the glob since we already loaded them
    if [[ "$config_file" != *"env.zsh" ]] && [[ "$config_file" != *"local.zsh" ]]; then
        [ -f "$config_file" ] && source "$config_file"
    elif [[ "$config_file" == *"env.zsh" ]] || [[ "$config_file" == *"local.zsh" ]]; then
        [ -f "$config_file" ] && source "$config_file"
    fi
done
