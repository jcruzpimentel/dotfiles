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

# Install Ghostty if not already installed
if ! command -v ghostty &> /dev/null; then
    echo "👻 Installing Ghostty..."
    brew install --cask ghostty
else
    echo "✓ Ghostty already installed"
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

# fzf (fuzzy finder)
if ! command -v fzf &> /dev/null; then
    echo "📦 Installing fzf..."
    brew install fzf
else
    echo "✓ fzf already installed"
fi

# zoxide (smarter cd)
if ! command -v zoxide &> /dev/null; then
    echo "📦 Installing zoxide..."
    brew install zoxide
else
    echo "✓ zoxide already installed"
fi

# oh-my-posh (prompt theme engine)
if ! command -v oh-my-posh &> /dev/null; then
    echo "📦 Installing oh-my-posh..."
    brew install oh-my-posh
else
    echo "✓ oh-my-posh already installed"
fi

# eza (modern ls replacement with icons and git integration)
if ! command -v eza &> /dev/null; then
    echo "📦 Installing eza..."
    brew install eza
else
    echo "✓ eza already installed"
fi

# ripgrep (fast grep alternative)
if ! command -v rg &> /dev/null; then
    echo "📦 Installing ripgrep..."
    brew install ripgrep
else
    echo "✓ ripgrep already installed"
fi

# bat (cat replacement with syntax highlighting)
if ! command -v bat &> /dev/null; then
    echo "📦 Installing bat..."
    brew install bat
else
    echo "✓ bat already installed"
fi

# ncdu (disk usage analyzer with ncurses interface)
if ! command -v ncdu &> /dev/null; then
    echo "📦 Installing ncdu..."
    brew install ncdu
else
    echo "✓ ncdu already installed"
fi

# btop (resource monitor)
if ! command -v btop &> /dev/null; then
    echo "📦 Installing btop..."
    brew install btop
else
    echo "✓ btop already installed"
fi

# atuin (magical shell history)
if ! command -v atuin &> /dev/null; then
    echo "📦 Installing atuin..."
    brew install atuin
else
    echo "✓ atuin already installed"
fi

# micro (modern terminal text editor)
if ! command -v micro &> /dev/null; then
    echo "📦 Installing micro..."
    brew install micro
else
    echo "✓ micro already installed"
fi

# carapace (multi-shell completion generator)
if ! command -v carapace &> /dev/null; then
    echo "📦 Installing carapace..."
    brew install carapace
else
    echo "✓ carapace already installed"
fi

# Install Catppuccin theme for zsh-syntax-highlighting
echo "🎨 Installing Catppuccin Mocha theme for zsh-syntax-highlighting..."
CATPPUCCIN_ZSH_DIR="/tmp/catppuccin-zsh-syntax-highlighting"
if [ ! -f ~/.zsh/catppuccin_mocha-zsh-syntax-highlighting.zsh ]; then
    git clone https://github.com/catppuccin/zsh-syntax-highlighting.git "$CATPPUCCIN_ZSH_DIR"
    mkdir -p ~/.zsh
    cp -v "$CATPPUCCIN_ZSH_DIR/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh" ~/.zsh/
    rm -rf "$CATPPUCCIN_ZSH_DIR"
    echo "✓ Catppuccin Mocha theme installed"
else
    echo "✓ Catppuccin Mocha theme already installed"
fi

echo ""
echo "✅ Installation Complete!"
echo ""
echo "Next steps:"
echo "1. Deploy dotfiles with GNU Stow:"
echo "   cd ~/dotfiles"
echo "   stow zsh ssh alacritty ghostty bat micro"
echo ""
echo "2. Customize machine-specific configs:"
echo "   - Edit ~/.zsh/local.zsh with your SSH keys"
echo "   - Create ~/.ssh/config.local for machine-specific SSH hosts"
echo ""
echo "3. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "To change Alacritty theme, edit ~/.config/alacritty/alacritty.toml"
echo "Available themes: tokyo-night, gruvbox-dark, catppuccin-mocha, dracula, nord, zenbones-zenwritten-dark"
echo ""
echo "Ghostty config is located at ~/.config/ghostty/config"
