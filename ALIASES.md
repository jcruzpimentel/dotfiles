# ZSH Aliases & Shortcuts Reference Guide

Quick reference for all aliases and shortcuts available in this dotfiles configuration.

## Table of Contents
- [Zoxide - Smarter cd](#zoxide---smarter-cd)
- [Git Aliases (OMZP::git)](#git-aliases)
- [Docker Aliases (OMZP::docker)](#docker-aliases)
- [Sudo Plugin](#sudo-plugin)
- [fzf Keyboard Shortcuts](#fzf-keyboard-shortcuts)
- [History Navigation](#history-navigation)

---

## Zoxide - Smarter cd

Zoxide is a smarter cd command that learns your most used directories and lets you jump to them quickly. It replaces the `cd` command with intelligent directory tracking.

### Basic Usage

| Command | Description |
|---------|-------------|
| `cd directory` | Works like normal cd, but tracks frequency |
| `cd partial` | Jump to directory matching "partial" |
| `cd partial1 partial2` | Match with multiple keywords |
| `cdi` | Interactive directory selection with fzf |

### Examples

**Jump to frequently used directories**:
```bash
cd dotfiles        # Jump to ~/dotfiles (if visited before)
cd doc             # Jump to ~/Documents (partial match)
cd proj web        # Jump to ~/projects/website (multiple keywords)
```

**Interactive selection with fzf**:
```bash
cdi                # Opens fzf to select from all tracked directories
```

### How it Works

- Zoxide **tracks** every directory you visit
- **Ranks** directories by frequency and recency
- Lets you jump using **partial matches**
- Uses **fuzzy matching** for flexible navigation

### Tips

- After using your shell for a while, zoxide learns your patterns
- You don't need full paths - just memorable parts
- Use `cdi` when you're not sure of the exact match
- Combine with tab completion for best results

---

## Git Aliases

### Basic Commands

| Alias | Command | Description |
|-------|---------|-------------|
| `g` | `git` | Base git command |
| `ga` | `git add` | Stage files |
| `gaa` | `git add --all` | Stage all files |
| `gapa` | `git add --patch` | Stage interactively |
| `gau` | `git add --update` | Stage modified/deleted files |

### Branch Management

| Alias | Command | Description |
|-------|---------|-------------|
| `gb` | `git branch` | List branches |
| `gba` | `git branch -a` | List all branches (local + remote) |
| `gbd` | `git branch -d` | Delete branch |
| `gbD` | `git branch -D` | Force delete branch |
| `gbnm` | `git branch --no-merged` | List unmerged branches |
| `gbr` | `git branch --remote` | List remote branches |
| `ggsup` | `git branch --set-upstream-to=origin/$(current_branch)` | Set upstream |

### Checkout

| Alias | Command | Description |
|-------|---------|-------------|
| `gco` | `git checkout` | Checkout branch/files |
| `gcb` | `git checkout -b` | Create and checkout new branch |
| `gcom` | `git checkout main` | Checkout main branch |
| `gcod` | `git checkout develop` | Checkout develop branch |

### Commit

| Alias | Command | Description |
|-------|---------|-------------|
| `gc` | `git commit -v` | Commit with verbose diff |
| `gc!` | `git commit -v --amend` | Amend last commit |
| `gcn!` | `git commit -v --no-edit --amend` | Amend without editing message |
| `gca` | `git commit -v -a` | Commit all staged files |
| `gca!` | `git commit -v -a --amend` | Amend all staged files |
| `gcam` | `git commit -a -m` | Commit all with message |
| `gcmsg` | `git commit -m` | Commit with message |
| `gcs` | `git commit -S` | GPG signed commit |

### Diff

| Alias | Command | Description |
|-------|---------|-------------|
| `gd` | `git diff` | Show unstaged changes |
| `gdca` | `git diff --cached` | Show staged changes |
| `gdcw` | `git diff --cached --word-diff` | Show staged changes word-by-word |
| `gds` | `git diff --staged` | Show staged changes |
| `gdt` | `git diff-tree --no-commit-id --name-only -r` | Show files changed in commit |

### Fetch & Pull

| Alias | Command | Description |
|-------|---------|-------------|
| `gf` | `git fetch` | Fetch from remote |
| `gfa` | `git fetch --all --prune` | Fetch all remotes, prune deleted |
| `gfo` | `git fetch origin` | Fetch from origin |
| `gl` | `git pull` | Pull from remote |
| `gup` | `git pull --rebase` | Pull with rebase |
| `gupa` | `git pull --rebase --autostash` | Pull with rebase and autostash |

### Push

| Alias | Command | Description |
|-------|---------|-------------|
| `gp` | `git push` | Push to remote |
| `gpd` | `git push --dry-run` | Test push without doing it |
| `gpf` | `git push --force-with-lease` | Force push (safer) |
| `gpf!` | `git push --force` | Force push (dangerous!) |
| `gpsup` | `git push --set-upstream origin $(current_branch)` | Push and set upstream |
| `gpu` | `git push upstream` | Push to upstream |

### Log & History

| Alias | Command | Description |
|-------|---------|-------------|
| `glo` | `git log --oneline --decorate` | Compact log |
| `glog` | `git log --oneline --decorate --graph` | Graph log |
| `gloga` | `git log --oneline --decorate --graph --all` | Graph log (all branches) |
| `glol` | `git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'` | Pretty log |
| `glola` | Same as glol but `--all` | Pretty log (all branches) |
| `glg` | `git log --stat` | Log with file stats |
| `glgp` | `git log --stat -p` | Log with file stats and patches |

### Merge & Rebase

| Alias | Command | Description |
|-------|---------|-------------|
| `gm` | `git merge` | Merge branch |
| `gma` | `git merge --abort` | Abort merge |
| `gmom` | `git merge origin/main` | Merge origin/main |
| `grb` | `git rebase` | Rebase |
| `grba` | `git rebase --abort` | Abort rebase |
| `grbc` | `git rebase --continue` | Continue rebase |
| `grbi` | `git rebase -i` | Interactive rebase |
| `grbm` | `git rebase main` | Rebase on main |

### Remote

| Alias | Command | Description |
|-------|---------|-------------|
| `gr` | `git remote` | List remotes |
| `gra` | `git remote add` | Add remote |
| `grv` | `git remote -v` | List remotes verbose |
| `grmv` | `git remote rename` | Rename remote |
| `grrm` | `git remote remove` | Remove remote |
| `gru` | `git remote update` | Update remote refs |

### Stash

| Alias | Command | Description |
|-------|---------|-------------|
| `gsta` | `git stash push` | Stash changes |
| `gstaa` | `git stash apply` | Apply stash |
| `gstc` | `git stash clear` | Clear all stashes |
| `gstd` | `git stash drop` | Drop stash |
| `gstl` | `git stash list` | List stashes |
| `gstp` | `git stash pop` | Pop stash |
| `gsts` | `git stash show --text` | Show stash contents |

### Status & Show

| Alias | Command | Description |
|-------|---------|-------------|
| `gst` | `git status` | Show status |
| `gss` | `git status -s` | Short status |
| `gsb` | `git status -sb` | Short status with branch |
| `gsh` | `git show` | Show commit |
| `gsps` | `git show --pretty=short --show-signature` | Show with signature |

### Other Useful Aliases

| Alias | Command | Description |
|-------|---------|-------------|
| `gcount` | `git shortlog -sn` | Count commits by author |
| `gcp` | `git cherry-pick` | Cherry-pick commit |
| `gcpa` | `git cherry-pick --abort` | Abort cherry-pick |
| `gcpc` | `git cherry-pick --continue` | Continue cherry-pick |
| `gclean` | `git clean -id` | Clean untracked files |
| `grh` | `git reset` | Reset HEAD |
| `grhh` | `git reset --hard` | Hard reset |
| `gwip` | `git add -A; git commit -m "--wip--"` | Quick WIP commit |

---

## Docker Aliases

### Container Management

| Alias | Command | Description |
|-------|---------|-------------|
| `dbl` | `docker build` | Build image |
| `dcin` | `docker container inspect` | Inspect container |
| `dlo` | `docker container logs` | Show container logs |
| `dlf` | `docker container logs -f` | Follow container logs |
| `dls` | `docker container ls` | List running containers |
| `dlsa` | `docker container ls -a` | List all containers |
| `dpo` | `docker container port` | Show port mappings |
| `dr` | `docker container run` | Run container |
| `drit` | `docker container run -it` | Run interactive container |
| `drm` | `docker container rm` | Remove container |
| `drm!` | `docker container rm -f` | Force remove container |
| `dst` | `docker container start` | Start container |
| `drs` | `docker container restart` | Restart container |
| `dsta` | `docker stop $(docker ps -q)` | Stop all running containers |
| `dstp` | `docker container stop` | Stop container |
| `dtop` | `docker top` | Show running processes in container |
| `dxc` | `docker container exec` | Execute command in container |
| `dxcit` | `docker container exec -it` | Execute interactive command |

### Image Management

| Alias | Command | Description |
|-------|---------|-------------|
| `dib` | `docker image build` | Build image |
| `dii` | `docker image inspect` | Inspect image |
| `dils` | `docker image ls` | List images |
| `dipu` | `docker image push` | Push image |
| `dipl` | `docker image pull` | Pull image |
| `dirm` | `docker image rm` | Remove image |
| `dit` | `docker image tag` | Tag image |
| `dprune` | `docker image prune -a -f` | Remove all unused images |

### Volume Management

| Alias | Command | Description |
|-------|---------|-------------|
| `dvi` | `docker volume inspect` | Inspect volume |
| `dvls` | `docker volume ls` | List volumes |
| `dvrm` | `docker volume rm` | Remove volume |
| `dvprune` | `docker volume prune -f` | Remove unused volumes |

### Network Management

| Alias | Command | Description |
|-------|---------|-------------|
| `dnc` | `docker network create` | Create network |
| `dni` | `docker network inspect` | Inspect network |
| `dnls` | `docker network ls` | List networks |
| `dnrm` | `docker network rm` | Remove network |

### Docker Compose

| Alias | Command | Description |
|-------|---------|-------------|
| `dcu` | `docker-compose up` | Start services |
| `dcub` | `docker-compose up --build` | Build and start services |
| `dcud` | `docker-compose up -d` | Start services in background |
| `dcd` | `docker-compose down` | Stop and remove services |
| `dcl` | `docker-compose logs` | Show logs |
| `dclf` | `docker-compose logs -f` | Follow logs |
| `dcpull` | `docker-compose pull` | Pull service images |
| `dcstart` | `docker-compose start` | Start services |
| `dcstop` | `docker-compose stop` | Stop services |
| `dcrestart` | `docker-compose restart` | Restart services |
| `dcps` | `docker-compose ps` | List running services |
| `dcexec` | `docker-compose exec` | Execute command in service |

### System

| Alias | Command | Description |
|-------|---------|-------------|
| `dinfo` | `docker info` | Show docker info |
| `dv` | `docker version` | Show docker version |
| `dsp` | `docker system prune -a -f` | Clean up everything |

---

## Sudo Plugin

**Keyboard Shortcut**: Press `ESC` twice

When you forget to type `sudo` before a command, just press ESC twice and it will prepend `sudo` to your current or previous command.

**Example**:
```bash
apt update  # Oops, forgot sudo
# Press ESC ESC
sudo apt update  # Fixed!
```

---

## fzf Keyboard Shortcuts

| Shortcut | Description |
|----------|-------------|
| `Ctrl-R` | Search command history with fuzzy finding |
| `Ctrl-T` | Search files in current directory and paste path |
| `Alt-C` | Fuzzy find directory and cd into it |
| `Tab` | Fuzzy completion for commands (via fzf-tab) |

**fzf Navigation** (when fzf window is open):
- `Ctrl-J` / `Down Arrow` - Move down
- `Ctrl-K` / `Up Arrow` - Move up
- `Enter` - Select
- `Ctrl-C` / `Esc` - Cancel
- `Tab` - Multi-select (when applicable)

---

## History Navigation

| Shortcut | Description |
|----------|-------------|
| `Up Arrow` | Search history matching your typed prefix |
| `Down Arrow` | Search forward in history |

**Example**: Type `git` and press Up Arrow to see only git commands from history.

---

## Command-Not-Found Plugin

When you type a command that doesn't exist, this plugin suggests which package to install.

**Example**:
```bash
$ htop
Command 'htop' not found, but can be installed with:
sudo apt install htop
```

---

## Colored Man Pages

Simply use `man` as usual - pages will be automatically colorized for better readability:

```bash
man git
man docker
man zsh
```

---

## Tips & Tricks

### Git Workflow Examples

**Quick daily workflow**:
```bash
gst           # Check status
gaa           # Stage all changes
gcam "message" # Commit with message
gp            # Push to remote
```

**Feature branch workflow**:
```bash
gcb feature-x      # Create and checkout new branch
# ... make changes ...
gaa                # Stage changes
gcmsg "Add feature X"
gpsup              # Push and set upstream
```

**Update from main**:
```bash
gco main           # Checkout main
gl                 # Pull latest
gco feature-x      # Back to feature branch
grbm               # Rebase on main
```

### Docker Workflow Examples

**Development workflow**:
```bash
dcub               # Build and start all services
dclf               # Follow logs
dcexec web bash    # Jump into web container
dcd                # Stop and remove everything
```

**Container debugging**:
```bash
dls                # See running containers
dlo container-name # Check logs
dxcit container-name bash  # Get shell in container
```

**Cleanup**:
```bash
dsta               # Stop all containers
dsp                # Clean up everything
dvprune            # Remove unused volumes
```

---

## Learning Suggestions

1. **Start with these essential git aliases**:
   - `gst` (status), `gaa` (add all), `gcam` (commit), `gp` (push)
   - `gco` (checkout), `gcb` (new branch), `gl` (pull)

2. **Essential docker aliases**:
   - `dls` (list containers), `dlo` (logs), `dcud` (compose up)
   - `dxcit` (exec interactive), `dcd` (compose down)

3. **Use `Ctrl-R`** extensively - it's a game changer for command history

4. **Remember ESC ESC** when you forget sudo

5. **Print this guide** or keep it open in a tab while learning

---

## Quick Reference Card

**Most Used Commands**:
```
Zoxide: cd <partial> cdi
Git:    gst gaa gcam gp gco gcb gl glog
Docker: dls dlo dcud dcd dxcit
fzf:    Ctrl-R Ctrl-T Alt-C
Other:  ESC-ESC (sudo)
```
