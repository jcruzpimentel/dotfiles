#!/bin/bash
# macOS Installation Script for Dotfiles Dependencies

set -e  # Exit on error

echo "🍎 macOS Dotfiles Installation Script"
echo "======================================"

# Check if Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "📦 Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo "Adding Homebrew to PATH for Apple Silicon..."
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
else
    echo "✓ Homebrew already installed"
fi

# Update Homebrew
echo "📦 Updating Homebrew..."
brew update

# Install GNU Stow if not already installed
if ! command -v stow &> /dev/null; then
    echo "📦 Installing GNU Stow..."
    brew install stow
else
    echo "✓ GNU Stow already installed"
fi

# Install Alacritty if not already installed
if ! command -v alacritty &> /dev/null; then
    echo "🖥️  Installing Alacritty..."
    brew install --cask alacritty
else
    echo "✓ Alacritty already installed"
fi

# Install Fantasque Sans Mono Nerd Font
echo "🔤 Installing Fantasque Sans Mono Nerd Font..."
if brew list --cask font-fantasque-sans-mono-nerd-font &> /dev/null; then
    echo "✓ Fantasque Sans Mono Nerd Font already installed"
else
    brew install --cask font-fantasque-sans-mono-nerd-font
fi

# Install other useful tools (optional but recommended)
echo "🔧 Installing additional useful tools..."

# Git (if not already installed)
if ! command -v git &> /dev/null; then
    brew install git
else
    echo "✓ Git already installed"
fi

# Zsh (macOS comes with zsh, but we ensure it's up to date)
brew install zsh

echo ""
echo "✅ Installation Complete!"
echo ""
echo "Next steps:"
echo "1. Deploy dotfiles with GNU Stow:"
echo "   cd ~/dotfiles"
echo "   stow zsh ssh alacritty"
echo ""
echo "2. Customize machine-specific configs:"
echo "   - Edit ~/.zsh/local.zsh with your SSH keys"
echo "   - Create ~/.ssh/config.local for machine-specific SSH hosts"
echo ""
echo "3. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "To change Alacritty theme, edit ~/.config/alacritty/alacritty.toml"
echo "Available themes: tokyo-night, gruvbox-dark, catppuccin-mocha, dracula, nord, zenbones-zenwritten-dark"
