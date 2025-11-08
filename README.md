# Dotfiles

Personal dotfiles managed with GNU Stow for easy deployment across multiple machines.

## Features

- **Modular Zsh Configuration**: Split into logical modules for easy maintenance
- **Cross-Platform Terminal**: Alacritty config works on macOS, Linux, and Windows (WSL2)
- **Cross-Platform Shell**: Works on macOS (Apple Silicon), Linux, and Windows (WSL2)
- **SSH Agent**: Automatic SSH key loading with OS-specific keychain support
- **Machine-Specific Configs**: Gitignored local configurations for per-machine customization
- **GNU Stow**: Simple symlink management
- **Multiple Color Themes**: Easy-to-switch Alacritty themes included

## Structure

```
dotfiles/
├── zsh/
│   ├── .zshrc              # Main loader - sources all modules
│   ├── .zprofile           # Homebrew initialization (login shell)
│   └── .zsh/
│       ├── env.zsh         # Environment variables
│       ├── local.zsh       # Machine-specific (gitignored)
│       └── ssh-agent.zsh   # SSH agent + key loading
├── ssh/
│   └── .ssh/
│       ├── config          # Shared SSH config
│       ├── config.local.example  # Template for machine-specific
│       └── config.d/       # Optional shared host configs
├── alacritty/
│   └── .config/alacritty/
│       ├── alacritty.toml  # Main Alacritty config
│       └── themes/         # Color scheme collection
├── install-macos.sh        # Automated setup for macOS
└── install-windows-wsl.sh  # Automated setup for Windows WSL2
```

## Installation

### Quick Install

**macOS:**
```bash
git clone https://gitlab.jcruzpimentel.dev/jcruzpimentel/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install-macos.sh
```

**Windows WSL2:**
```bash
git clone https://gitlab.jcruzpimentel.dev/jcruzpimentel/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install-windows-wsl.sh
```

The install scripts will:
- Install all dependencies (Homebrew, Stow, Alacritty, Fonts, etc.)
- Guide you through deploying dotfiles with Stow

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://gitlab.jcruzpimentel.dev/jcruzpimentel/dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Install dependencies:

   **macOS:**
   ```bash
   brew install stow
   brew install --cask alacritty
   brew install --cask font-fantasque-sans-mono-nerd-font
   ```

   **Linux (Debian/Ubuntu):**
   ```bash
   sudo apt install stow zsh git
   ```

   **Linux (Arch):**
   ```bash
   sudo pacman -S stow zsh git
   ```

3. Deploy with Stow:
   ```bash
   cd ~/dotfiles
   stow zsh ssh alacritty
   ```

4. Create machine-specific configurations:
   ```bash
   # Create local SSH config for this machine
   cp ssh/.ssh/config.local.example ~/.ssh/config.local
   # Edit with your machine-specific hosts

   # Customize SSH keys to load
   # Edit ~/.zsh/local.zsh and update the SSH_KEYS array
   ```

5. Restart your terminal or reload shell:
   ```bash
   source ~/.zshrc
   ```

## Customization

### Adding SSH Keys

Edit `~/.zsh/local.zsh` and modify the `SSH_KEYS` array:

```zsh
SSH_KEYS=(
    ~/.ssh/id_ed25519
    ~/.ssh/id_rsa
    ~/.ssh/work_key
)
```

### Machine-Specific SSH Hosts

Add hosts to `~/.ssh/config.local`:

```
Host myserver
    HostName server.example.com
    User username
    IdentityFile ~/.ssh/custom_key
```

### Adding More Zsh Modules

Create new `.zsh` files in `zsh/.zsh/`:

```bash
# Example: create aliases module
echo '# Aliases' > ~/dotfiles/zsh/.zsh/aliases.zsh
echo 'alias ll="ls -la"' >> ~/dotfiles/zsh/.zsh/aliases.zsh
```

The main `.zshrc` automatically sources all `.zsh` files.

### Changing Alacritty Color Themes

Edit `~/.config/alacritty/alacritty.toml` and change the import line:

```toml
import = [
    "~/.config/alacritty/themes/gruvbox-dark.toml"  # Change this line
]
```

**Available themes:**
- `tokyo-night.toml` - Modern neon-influenced
- `gruvbox-dark.toml` - Warm retro-inspired
- `catppuccin-mocha.toml` - Pastel soothing
- `dracula.toml` - Vibrant purples/pinks
- `nord.toml` - Cool arctic blues
- `zenbones-zenwritten-dark.toml` - Custom theme

Preview themes at: https://alacritty-themes.vercel.app/

### Windows WSL2 Configuration

For Alacritty on Windows to use WSL, edit `~/.config/alacritty/alacritty.toml`:

```toml
[shell]
# Comment out the macOS/Linux shell:
# program = "/bin/zsh"
# args = ["--login"]

# Uncomment for Windows WSL2:
program = "wsl.exe"
args = ["~"]
```

**Note:** Alacritty must be installed on Windows (not in WSL). Your WSL dotfiles config will still be accessible from the Windows Alacritty terminal.

## Updating

```bash
cd ~/dotfiles
git pull
```

Changes are reflected immediately since files are symlinked.

## Uninstalling

```bash
cd ~/dotfiles
stow -D zsh ssh alacritty
```

This removes all symlinks but preserves your local configs.

## What's Gitignored

- `zsh/.zsh/local.zsh` - Machine-specific zsh config
- `ssh/.ssh/config.local` - Machine-specific SSH hosts
- `ssh/.ssh/id_*` - SSH keys
- `ssh/.ssh/*.pem`, `ssh/.ssh/*.key` - Private keys
- `ssh/.ssh/known_hosts` - SSH known hosts

## License

Personal dotfiles - use freely
