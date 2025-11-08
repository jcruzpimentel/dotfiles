# Dotfiles

Personal dotfiles managed with GNU Stow for easy deployment across multiple machines.

## Features

- **Modular Zsh Configuration**: Split into logical modules for easy maintenance
- **Cross-Platform**: Works on macOS (Apple Silicon) and Linux
- **SSH Agent**: Automatic SSH key loading with OS-specific keychain support
- **Machine-Specific Configs**: Gitignored local configurations for per-machine customization
- **GNU Stow**: Simple symlink management

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
└── ssh/
    └── .ssh/
        ├── config          # Shared SSH config
        ├── config.local.example  # Template for machine-specific
        └── config.d/       # Optional shared host configs
```

## Installation

### Prerequisites

- Git
- GNU Stow
- Zsh

### On macOS

```bash
# Install Homebrew if needed
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install stow
brew install stow
```

### On Linux

```bash
# Debian/Ubuntu
sudo apt install stow

# Arch
sudo pacman -S stow

# Fedora
sudo dnf install stow
```

### Setup

1. Clone this repository:
   ```bash
   git clone <your-repo-url> ~/dotfiles
   cd ~/dotfiles
   ```

2. Deploy with stow:
   ```bash
   stow zsh ssh
   ```

3. Create machine-specific configurations:
   ```bash
   # Create local SSH config for this machine
   cp ssh/.ssh/config.local.example ~/.ssh/config.local
   # Edit with your machine-specific hosts

   # Customize SSH keys to load
   # Edit ~/.zsh/local.zsh and update the SSH_KEYS array
   ```

4. Reload your shell:
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

## Updating

```bash
cd ~/dotfiles
git pull
```

Changes are reflected immediately since files are symlinked.

## Uninstalling

```bash
cd ~/dotfiles
stow -D zsh ssh
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
