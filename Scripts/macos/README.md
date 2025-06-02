# macOS Development Environment Uninstaller

A script to completely uninstall the development environment set up by the YSP TDCS 2025 setup script.

## 🚀 Quick Start (One-Line Install)

Run directly from GitHub without downloading:

```bash
curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/init_setup_edition_2/Scripts/macos/purge_macos.sh | bash
```

### With Options

```bash
# Keep Homebrew installed (only remove packages)
curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/init_setup_edition_2/Scripts/macos/purge_macos.sh | bash -s -- --keep-homebrew

# Keep Homebrew and Xcode tools
curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/init_setup_edition_2/Scripts/macos/purge_macos.sh | bash -s -- --keep-homebrew --keep-xcode

# Keep the repository but remove everything else
curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/init_setup_edition_2/Scripts/macos/purge_macos.sh | bash -s -- --keep-repo

# Keep everything except packages (minimal uninstall)
curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/init_setup_edition_2/Scripts/macos/purge_macos.sh | bash -s -- --keep-homebrew --keep-xcode --keep-repo
```

## 📥 Manual Download & Run

If you prefer to download first:

```bash
# Download the script
curl -fsSL https://raw.githubusercontent.com/Makerspace-Ashoka/YSP_TDCS_2025/init_setup_edition_2/Scripts/macos/purge_macos.sh -o purge_macos.sh

# Make it executable
chmod +x purge_macos.sh

# Run with options
./uninstall.sh --help
./uninstall.sh --keep-homebrew
```

## 🗂️ What Gets Uninstalled

The script removes components in this order:

1. **VS Code Extensions**
   - ms-python.python
   - ms-python.vscode-pylance  
   - ms-toolsai.jupyter
   - ms-vscode.vscode-serial-monitor

2. **Python Environment**
   - Virtual environment (`.venv`)
   - YSP_TDCS_2025 repository (optional)

3. **Homebrew Packages**
   - Visual Studio Code
   - Python 3
   - IPython
   - Git

4. **Homebrew** (optional)
   - Complete removal of Homebrew

5. **Xcode Command Line Tools** (optional)
   - Complete removal with confirmation

## ⚙️ Command Line Options

| Option | Description | Default |
|--------|-------------|---------|
| `--keep-homebrew` | Keep Homebrew installed, only remove packages | `off` |
| `--keep-xcode` | Keep Xcode Command Line Tools | `off` |
| `--keep-repo` | Keep the cloned YSP_TDCS_2025 repository | `off` |
| `--help` | Show help message | - |


## ⚠️ Important Notes

### Before Running
- **Backup Important Data**: The script will permanently delete files
- **Close Applications**: Make sure VS Code and other apps are closed
- **Terminal Restart**: You may need to restart your terminal after running

### What Requires Confirmation
- Removing Homebrew completely
- Removing Xcode Command Line Tools  
- Deleting the YSP_TDCS_2025 repository

### Manual Cleanup
After running, you may need to manually:
- Remove Homebrew references from shell config files (`~/.zshrc`, `~/.bashrc`)
- Restart your terminal or run `source ~/.zshrc`
