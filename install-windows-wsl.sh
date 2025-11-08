#!/bin/bash
# Windows WSL2 Installation Script for Dotfiles Dependencies

set -e  # Exit on error

echo "🪟 Windows WSL2 Dotfiles Installation Script"
echo "============================================="

# Detect Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "❌ Cannot detect Linux distribution"
    exit 1
fi

echo "📍 Detected distribution: $OS"

# Install based on distribution
case $OS in
    ubuntu|debian)
        echo "📦 Updating package lists..."
        sudo apt update

        echo "📦 Installing dependencies..."
        # Install stow
        if ! command -v stow &> /dev/null; then
            sudo apt install -y stow
        else
            echo "✓ GNU Stow already installed"
        fi

        # Install git
        if ! command -v git &> /dev/null; then
            sudo apt install -y git
        else
            echo "✓ Git already installed"
        fi

        # Install zsh
        if ! command -v zsh &> /dev/null; then
            sudo apt install -y zsh
            echo "🐚 Setting zsh as default shell..."
            chsh -s $(which zsh)
        else
            echo "✓ Zsh already installed"
        fi

        # Install Homebrew for Linux (optional but recommended)
        if ! command -v brew &> /dev/null; then
            echo "📦 Installing Homebrew for Linux..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        else
            echo "✓ Homebrew already installed"
        fi
        ;;

    fedora|rhel|centos)
        echo "📦 Installing dependencies..."
        # Install stow
        if ! command -v stow &> /dev/null; then
            sudo dnf install -y stow
        else
            echo "✓ GNU Stow already installed"
        fi

        # Install git
        if ! command -v git &> /dev/null; then
            sudo dnf install -y git
        else
            echo "✓ Git already installed"
        fi

        # Install zsh
        if ! command -v zsh &> /dev/null; then
            sudo dnf install -y zsh
            echo "🐚 Setting zsh as default shell..."
            chsh -s $(which zsh)
        else
            echo "✓ Zsh already installed"
        fi
        ;;

    arch|manjaro)
        echo "📦 Installing dependencies..."
        # Install stow
        if ! command -v stow &> /dev/null; then
            sudo pacman -S --noconfirm stow
        else
            echo "✓ GNU Stow already installed"
        fi

        # Install git
        if ! command -v git &> /dev/null; then
            sudo pacman -S --noconfirm git
        else
            echo "✓ Git already installed"
        fi

        # Install zsh
        if ! command -v zsh &> /dev/null; then
            sudo pacman -S --noconfirm zsh
            echo "🐚 Setting zsh as default shell..."
            chsh -s $(which zsh)
        else
            echo "✓ Zsh already installed"
        fi
        ;;

    *)
        echo "❌ Unsupported distribution: $OS"
        echo "Please install the following manually: git, zsh, stow"
        exit 1
        ;;
esac

# Install Fantasque Sans Mono Nerd Font for WSL/Linux
echo "🔤 Installing Fantasque Sans Mono Nerd Font..."
FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/FantasqueSansMNerdFont-Regular.ttf" ]; then
    echo "Downloading font..."
    cd /tmp
    curl -fLo "FantasqueSansMono.zip" \
        https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FantasqueSansMono.zip
    unzip -o FantasqueSansMono.zip -d "$FONT_DIR"
    rm FantasqueSansMono.zip
    fc-cache -fv
    echo "✓ Font installed"
else
    echo "✓ Fantasque Sans Mono Nerd Font already installed"
fi

echo ""
echo "✅ WSL2 Installation Complete!"
echo ""
echo "⚠️  IMPORTANT: Install Alacritty on Windows (not in WSL)"
echo "   Download from: https://github.com/alacritty/alacritty/releases"
echo "   Or use winget: winget install Alacritty.Alacritty"
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
echo "3. Configure Alacritty on Windows to use WSL:"
echo "   The config is already set up at ~/.config/alacritty/alacritty.toml"
echo "   Uncomment the WSL shell section in the config"
echo ""
echo "4. Log out and log back in (or run: zsh) to start using zsh"
echo ""
echo "To change Alacritty theme, edit ~/.config/alacritty/alacritty.toml"
echo "Available themes: tokyo-night, gruvbox-dark, catppuccin-mocha, dracula, nord, zenbones-zenwritten-dark"
