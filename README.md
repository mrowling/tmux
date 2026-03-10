# Tmux Configuration

Personal tmux configuration for reuse across multiple machines.

## Features

- 256 color support
- Dracula theme with custom plugins
- Tmux Pomodoro Plus integration
- Custom status bar with CPU, RAM, time, and current working directory
- Quick config reload with `prefix + r`

## Quick Setup

Clone this repository and run the setup script:

```bash
git clone https://github.com/mrowling/tmux.git ~/.tmux-config
cd ~/.tmux-config
./setup.sh
```

The setup script will:
1. Copy `.tmux.conf` to your home directory (`~/.tmux.conf`)
2. Install Tmux Plugin Manager (TPM)

## Manual Setup

If you prefer to set up manually:

```bash
# Clone the repository
git clone https://github.com/mrowling/tmux.git ~/.tmux-config

# Copy the configuration file
cp ~/.tmux-config/.tmux.conf ~/.tmux.conf

# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Installing Plugins

After setup, start tmux and install the plugins:

1. Start tmux: `tmux`
2. Press `prefix + I` (capital I) to install plugins
   - Default prefix is `Ctrl+b`

## Plugins Included

- [tpm](https://github.com/tmux-plugins/tpm) - Tmux Plugin Manager
- [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) - Basic tmux settings
- [dracula/tmux](https://github.com/dracula/tmux) - Dracula theme
- [tmux-pomodoro-plus](https://github.com/olimorris/tmux-pomodoro-plus) - Pomodoro timer

## Key Bindings

- `prefix + r` - Reload tmux configuration

## Updating Configuration

To update the configuration on a machine:

```bash
cd ~/.tmux-config
git pull
./setup.sh
```

Then reload tmux: `prefix + r` or restart tmux.
