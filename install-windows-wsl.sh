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

        # Install fzf
        if ! command -v fzf &> /dev/null; then
            echo "📦 Installing fzf..."
            sudo apt install -y fzf
        else
            echo "✓ fzf already installed"
        fi

        # Install zoxide (smarter cd)
        if ! command -v zoxide &> /dev/null; then
            echo "📦 Installing zoxide..."
            curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        else
            echo "✓ zoxide already installed"
        fi

        # Install oh-my-posh (prompt theme engine)
        if ! command -v oh-my-posh &> /dev/null; then
            echo "📦 Installing oh-my-posh..."
            curl -s https://ohmyposh.dev/install.sh | bash -s
        else
            echo "✓ oh-my-posh already installed"
        fi

        # Install eza (modern ls replacement)
        if ! command -v eza &> /dev/null; then
            echo "📦 Installing eza..."
            sudo apt install -y gpg
            sudo mkdir -p /etc/apt/keyrings
            wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
            echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
            sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
            sudo apt update
            sudo apt install -y eza
        else
            echo "✓ eza already installed"
        fi

        # Install ripgrep (fast grep alternative)
        if ! command -v rg &> /dev/null; then
            echo "📦 Installing ripgrep..."
            sudo apt install -y ripgrep
        else
            echo "✓ ripgrep already installed"
        fi

        # Install bat (cat replacement with syntax highlighting)
        if ! command -v bat &> /dev/null; then
            echo "📦 Installing bat..."
            sudo apt install -y bat
            # Create symlink if bat is installed as batcat (Ubuntu/Debian)
            if command -v batcat &> /dev/null && [ ! -f ~/.local/bin/bat ]; then
                mkdir -p ~/.local/bin
                ln -s /usr/bin/batcat ~/.local/bin/bat
            fi
        else
            echo "✓ bat already installed"
        fi

        # Install ncdu (disk usage analyzer)
        if ! command -v ncdu &> /dev/null; then
            echo "📦 Installing ncdu..."
            sudo apt install -y ncdu
        else
            echo "✓ ncdu already installed"
        fi

        # Install btop (resource monitor)
        if ! command -v btop &> /dev/null; then
            echo "📦 Installing btop..."
            sudo apt install -y btop
        else
            echo "✓ btop already installed"
        fi

        # Install atuin (magical shell history)
        if ! command -v atuin &> /dev/null; then
            echo "📦 Installing atuin..."
            curl -sS https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash
        else
            echo "✓ atuin already installed"
        fi

        # Install micro (modern terminal text editor)
        if ! command -v micro &> /dev/null; then
            echo "📦 Installing micro..."
            cd /tmp
            curl -sS https://getmic.ro | bash
            sudo mv micro /usr/local/bin/
            cd -
        else
            echo "✓ micro already installed"
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

        # Install fzf
        if ! command -v fzf &> /dev/null; then
            echo "📦 Installing fzf..."
            sudo dnf install -y fzf
        else
            echo "✓ fzf already installed"
        fi

        # Install zoxide (smarter cd)
        if ! command -v zoxide &> /dev/null; then
            echo "📦 Installing zoxide..."
            curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
        else
            echo "✓ zoxide already installed"
        fi

        # Install oh-my-posh (prompt theme engine)
        if ! command -v oh-my-posh &> /dev/null; then
            echo "📦 Installing oh-my-posh..."
            curl -s https://ohmyposh.dev/install.sh | bash -s
        else
            echo "✓ oh-my-posh already installed"
        fi

        # Install eza (modern ls replacement)
        if ! command -v eza &> /dev/null; then
            echo "📦 Installing eza..."
            sudo dnf install -y eza
        else
            echo "✓ eza already installed"
        fi

        # Install ripgrep (fast grep alternative)
        if ! command -v rg &> /dev/null; then
            echo "📦 Installing ripgrep..."
            sudo dnf install -y ripgrep
        else
            echo "✓ ripgrep already installed"
        fi

        # Install bat (cat replacement with syntax highlighting)
        if ! command -v bat &> /dev/null; then
            echo "📦 Installing bat..."
            sudo dnf install -y bat
        else
            echo "✓ bat already installed"
        fi

        # Install ncdu (disk usage analyzer)
        if ! command -v ncdu &> /dev/null; then
            echo "📦 Installing ncdu..."
            sudo dnf install -y ncdu
        else
            echo "✓ ncdu already installed"
        fi

        # Install btop (resource monitor)
        if ! command -v btop &> /dev/null; then
            echo "📦 Installing btop..."
            sudo dnf install -y btop
        else
            echo "✓ btop already installed"
        fi

        # Install atuin (magical shell history)
        if ! command -v atuin &> /dev/null; then
            echo "📦 Installing atuin..."
            curl -sS https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash
        else
            echo "✓ atuin already installed"
        fi

        # Install micro (modern terminal text editor)
        if ! command -v micro &> /dev/null; then
            echo "📦 Installing micro..."
            cd /tmp
            curl -sS https://getmic.ro | bash
            sudo mv micro /usr/local/bin/
            cd -
        else
            echo "✓ micro already installed"
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

        # Install fzf
        if ! command -v fzf &> /dev/null; then
            echo "📦 Installing fzf..."
            sudo pacman -S --noconfirm fzf
        else
            echo "✓ fzf already installed"
        fi

        # Install zoxide (smarter cd)
        if ! command -v zoxide &> /dev/null; then
            echo "📦 Installing zoxide..."
            sudo pacman -S --noconfirm zoxide
        else
            echo "✓ zoxide already installed"
        fi

        # Install oh-my-posh (prompt theme engine)
        if ! command -v oh-my-posh &> /dev/null; then
            echo "📦 Installing oh-my-posh..."
            curl -s https://ohmyposh.dev/install.sh | bash -s
        else
            echo "✓ oh-my-posh already installed"
        fi

        # Install eza (modern ls replacement)
        if ! command -v eza &> /dev/null; then
            echo "📦 Installing eza..."
            sudo pacman -S --noconfirm eza
        else
            echo "✓ eza already installed"
        fi

        # Install ripgrep (fast grep alternative)
        if ! command -v rg &> /dev/null; then
            echo "📦 Installing ripgrep..."
            sudo pacman -S --noconfirm ripgrep
        else
            echo "✓ ripgrep already installed"
        fi

        # Install bat (cat replacement with syntax highlighting)
        if ! command -v bat &> /dev/null; then
            echo "📦 Installing bat..."
            sudo pacman -S --noconfirm bat
        else
            echo "✓ bat already installed"
        fi

        # Install ncdu (disk usage analyzer)
        if ! command -v ncdu &> /dev/null; then
            echo "📦 Installing ncdu..."
            sudo pacman -S --noconfirm ncdu
        else
            echo "✓ ncdu already installed"
        fi

        # Install btop (resource monitor)
        if ! command -v btop &> /dev/null; then
            echo "📦 Installing btop..."
            sudo pacman -S --noconfirm btop
        else
            echo "✓ btop already installed"
        fi

        # Install atuin (magical shell history)
        if ! command -v atuin &> /dev/null; then
            echo "📦 Installing atuin..."
            curl -sS https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh | bash
        else
            echo "✓ atuin already installed"
        fi

        # Install micro (modern terminal text editor)
        if ! command -v micro &> /dev/null; then
            echo "📦 Installing micro..."
            cd /tmp
            curl -sS https://getmic.ro | bash
            sudo mv micro /usr/local/bin/
            cd -
        else
            echo "✓ micro already installed"
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
echo "⚠️  IMPORTANT: Install terminal emulator on Windows (not in WSL)"
echo "   Alacritty: https://github.com/alacritty/alacritty/releases"
echo "   Or use winget: winget install Alacritty.Alacritty"
echo "   Ghostty: https://ghostty.org/download"
echo ""
echo "Next steps:"
echo "1. Deploy dotfiles with GNU Stow:"
echo "   cd ~/dotfiles"
echo "   stow zsh ssh alacritty ghostty"
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
echo ""
echo "Ghostty config is located at ~/.config/ghostty/config"
