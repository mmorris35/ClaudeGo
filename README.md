# ClaudeGo - Easy Claude Code Setup for Mac

Get Claude Code running in VSCode on your Mac in just a few minutes. Download one script, run it, and you're ready to go.

## 💰 Cost Transparency

**Claude Code requires a Claude Pro subscription at $20/month** (or $17/month with annual billing).

There is a free tier for Claude.ai, but it does not include Claude Code access. You must upgrade to Pro or higher to use Claude Code in VSCode.

## Prerequisites

Before you begin, you'll need:

1. **A Mac** running macOS (these scripts are Mac-only)
2. **GitHub Account**
   - Go to [github.com](https://github.com) and create an account if you don't have one
3. **Claude Account with Pro Subscription**
   - Go to [claude.ai](https://claude.ai) and create an account
   - Upgrade to Pro plan ($20/month) at [claude.ai/settings/billing](https://claude.ai/settings/billing)

## Why Fork This Repository?

When you fork this repository to your GitHub account, you get:
- **Your own copy** - You can make changes without affecting the original
- **Push commits** - You can save your work and push to your forked repository
- **Environment setup** - You'll have templates and guides to customize for your projects
- **Version control** - Track all your Claude Code projects and experiments

## Quick Start

### Step 1: Download and Run install.sh

1. Download `install.sh` from this repository (click the file, then "Download raw file")
2. Open Terminal on your Mac (Applications > Utilities > Terminal)
3. Navigate to where you downloaded the file:
   ```bash
   cd ~/Downloads
   ```
4. Run the installation script:
   ```bash
   chmod +x install.sh
   ./install.sh
   ```

The script will:
- ✅ Verify you have Claude Pro subscription
- ✅ Install Homebrew (if needed)
- ✅ Install VSCode (if not already installed)
- ✅ Install the Claude Code extension

### Step 2: Fork This Repository

1. Go to [github.com/mmorris35/ClaudeGo](https://github.com/mmorris35/ClaudeGo)
2. Click the "Fork" button in the top-right corner
3. This creates your own copy of the repository on your GitHub account

### Step 3: Clone Your Forked Repository in VSCode

Once installation completes:

1. Open VSCode (it's now installed)
2. Press `Cmd+Shift+P` to open the Command Palette
3. Type "Git: Clone" and select it
4. Paste this URL: `https://github.com/YOUR_USERNAME/ClaudeGo.git` (use your own GitHub username)
5. Choose a folder location and click "Open"

### Step 4: Authenticate with Claude

In VSCode Terminal (`Terminal > New Terminal` or `Ctrl+~`), run:

```bash
claude auth login
```

**IMPORTANT:** When prompted, select the authentication method:
- ✅ **Choose "Login with Claude.ai account"** (this uses your Pro/Max subscription)
- ❌ **DO NOT choose "API Key"** (this is for API usage, not Claude Code)

Follow the prompts to:
1. Your browser will open to authenticate
2. Log in with your Claude account (the one with Pro subscription)
3. Authorize the connection
4. Return to VSCode - you're authenticated!

To verify authentication worked, run:
```bash
claude status
```

You should see your account information and subscription status.

## Verification

Want to check if everything is set up correctly? In VSCode Terminal, run:

```bash
claude status
```

This will show you your Claude authentication status. You can also verify the installation by:

1. Press `Cmd+Shift+P` in VSCode
2. Type "Claude" to see available commands
3. If you see Claude commands, you're all set!

## Troubleshooting

### "Authentication failed"

1. Make sure you have an active Claude Pro subscription at [claude.ai/settings/billing](https://claude.ai/settings/billing)
2. In VSCode Terminal, run:
   ```bash
   claude auth login
   ```
3. Follow the authentication prompts

### "Homebrew installation failed"

The `install.sh` script will attempt to install Homebrew. If it fails:

1. Visit [brew.sh](https://brew.sh) for manual installation instructions
2. Once Homebrew is installed, run `install.sh` again

### "VSCode won't open or command not found"

After running `install.sh`:
1. Restart your Terminal
2. Try opening VSCode again with `code`
3. If that doesn't work, open VSCode from Applications

### Still having issues?

- Check the [Claude Code documentation](https://docs.claude.com/en/docs/claude-code)
- Open an issue in this repository
- Contact Claude support at [support.claude.com](https://support.claude.com)

## What Gets Installed

- **Homebrew**: Package manager for macOS (if not already installed)
- **VSCode**: Visual Studio Code editor (if not already installed)
- **Claude Code Extension**: The official Claude extension for VSCode

## Uninstalling

To remove Claude Code:

1. Uninstall the Claude Code extension in VSCode (Cmd+Shift+X, search "Claude Code", click Uninstall)
2. Optionally uninstall VSCode: Delete `/Applications/Visual Studio Code.app`

To cancel your Claude Pro subscription, visit [claude.ai/settings/billing](https://claude.ai/settings/billing)

## Contributing

Found a bug or have a suggestion? Please open an issue or submit a pull request!

## License

MIT License - feel free to use and modify as needed.

---

**Note**: This is an unofficial setup repository. Claude Code is developed by Anthropic. Visit [claude.ai](https://claude.ai) for official information.
