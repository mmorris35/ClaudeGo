#!/bin/bash

# ClaudeGo Installation Script
# Installs VSCode and Claude Code extension on macOS

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${BLUE}ℹ${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════════${NC}"
    echo ""
}

# Check if running on macOS
check_macos() {
    print_header "Checking System Requirements"

    if [[ "$OSTYPE" != "darwin"* ]]; then
        print_error "This script only works on macOS"
        exit 1
    fi
    print_success "Running on macOS"
}

# Check for Claude Pro subscription
check_claude_subscription() {
    print_header "Verifying Claude Pro Subscription"

    print_info "Please verify your Claude subscription status:"
    print_info "1. Open https://claude.ai/settings/billing in your browser"
    print_info "2. Confirm you have an active Pro subscription ($20/month)"
    echo ""

    read -p "Do you have an active Claude Pro subscription? (yes/no): " has_subscription

    if [[ "$has_subscription" != "yes" && "$has_subscription" != "y" ]]; then
        print_error "Claude Pro subscription is required for Claude Code"
        print_info "Please visit https://claude.ai/settings/billing to upgrade"
        exit 1
    fi

    print_success "Claude Pro subscription confirmed"
}

# Install Homebrew if not present
install_homebrew() {
    print_header "Checking Homebrew"

    if command -v brew &> /dev/null; then
        print_success "Homebrew is already installed"
        return
    fi

    print_info "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == 'arm64' ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    if command -v brew &> /dev/null; then
        print_success "Homebrew installed successfully"
    else
        print_error "Failed to install Homebrew"
        exit 1
    fi
}

# Check Git (usually pre-installed on macOS)
check_git() {
    print_header "Checking Git"

    if command -v git &> /dev/null; then
        print_success "Git is already installed ($(git --version))"
        return
    fi

    print_info "Git not found. Installing via Homebrew..."
    brew install git

    if command -v git &> /dev/null; then
        print_success "Git installed successfully"
    else
        print_error "Failed to install Git"
        exit 1
    fi
}

# Install Node.js and npm if not present
install_node() {
    print_header "Checking Node.js and npm"

    if command -v node &> /dev/null && command -v npm &> /dev/null; then
        print_success "Node.js $(node --version) and npm $(npm --version) are already installed"
        return
    fi

    print_info "Installing Node.js and npm via Homebrew..."
    brew install node

    if command -v node &> /dev/null && command -v npm &> /dev/null; then
        print_success "Node.js and npm installed successfully"
        print_info "Node.js version: $(node --version)"
        print_info "npm version: $(npm --version)"
    else
        print_error "Failed to install Node.js and npm"
        exit 1
    fi
}

# Install VSCode if not present
install_vscode() {
    print_header "Checking VSCode"

    if command -v code &> /dev/null; then
        print_success "VSCode is already installed"
        return
    fi

    # Check if VSCode app exists but command is not in PATH
    if [[ -d "/Applications/Visual Studio Code.app" ]]; then
        print_warning "VSCode is installed but 'code' command not in PATH"
        print_info "Adding 'code' command to PATH..."

        # Try to add code to PATH
        cat << 'EOF' >> ~/.zshrc

# VSCode command line tool
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
EOF

        export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

        print_success "VSCode command added to PATH"
        print_warning "You may need to restart your terminal for changes to take effect"
        return
    fi

    print_info "Installing VSCode via Homebrew..."
    brew install --cask visual-studio-code

    # Add code command to PATH
    export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

    if command -v code &> /dev/null || [[ -d "/Applications/Visual Studio Code.app" ]]; then
        print_success "VSCode installed successfully"
    else
        print_error "Failed to install VSCode"
        exit 1
    fi
}

# Install Claude CLI
install_claude_cli() {
    print_header "Installing Claude CLI"

    if command -v claude &> /dev/null; then
        print_success "Claude CLI is already installed ($(claude --version))"
        return
    fi

    print_info "Installing Claude CLI via npm..."
    npm install -g @anthropic-ai/claude-cli

    if command -v claude &> /dev/null; then
        print_success "Claude CLI installed successfully"
        print_info "Claude CLI version: $(claude --version)"
    else
        print_error "Failed to install Claude CLI"
        print_warning "You may need to restart your terminal for the PATH changes to take effect"
        print_info "After restarting, verify with: claude --version"
    fi
}

# Install Claude Code extension
install_claude_extension() {
    print_header "Installing Claude Code Extension"

    # Make sure code command is available
    if ! command -v code &> /dev/null; then
        if [[ -d "/Applications/Visual Studio Code.app" ]]; then
            export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
        else
            print_error "VSCode is not installed"
            exit 1
        fi
    fi

    # Check if extension is already installed
    if code --list-extensions | grep -q "anthropics.claude-code"; then
        print_success "Claude Code extension is already installed"
        return
    fi

    print_info "Installing Claude Code extension..."

    # Install the extension
    if code --install-extension anthropics.claude-code --force; then
        print_success "Claude Code extension installed successfully"
    else
        print_error "Failed to install Claude Code extension"
        print_info "You can manually install it from VSCode:"
        print_info "1. Open VSCode"
        print_info "2. Press Cmd+Shift+X"
        print_info "3. Search for 'Claude Code'"
        print_info "4. Click Install"
        exit 1
    fi
}

# Authenticate with Claude
setup_authentication() {
    print_header "Setting Up Authentication"

    print_info "Now we'll authenticate with your Claude account"
    print_info "This will open your browser to complete the login"
    echo ""

    # Check if claude command is available
    if ! command -v claude &> /dev/null; then
        print_warning "Claude CLI not found in PATH"
        print_info "You may need to restart your terminal and run: claude auth login"
        return
    fi

    read -p "Ready to authenticate? (yes/no): " ready_to_auth

    if [[ "$ready_to_auth" != "yes" && "$ready_to_auth" != "y" ]]; then
        print_info "Skipping authentication for now"
        print_info "You can authenticate later by running: claude auth login"
        return
    fi

    print_info "Starting authentication..."
    print_warning "IMPORTANT: When prompted, choose 'Login with Claude.ai account' (NOT 'API Key')"
    echo ""
    sleep 2

    # Run claude auth login
    if claude auth login; then
        echo ""
        print_success "Authentication successful!"
        echo ""
        print_info "Verifying authentication..."
        claude status
    else
        print_warning "Authentication was not completed"
        print_info "You can authenticate later by running: claude auth login"
    fi
}

# Main installation flow
main() {
    echo ""
    echo -e "${GREEN}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                   ║${NC}"
    echo -e "${GREEN}║           ClaudeGo Installation Script            ║${NC}"
    echo -e "${GREEN}║                                                   ║${NC}"
    echo -e "${GREEN}╚═══════════════════════════════════════════════════╝${NC}"
    echo ""

    check_macos
    check_claude_subscription
    install_homebrew
    check_git
    install_node
    install_vscode
    install_claude_cli
    install_claude_extension
    setup_authentication

    print_header "Installation Complete!"

    print_success "All components installed successfully!"
    echo ""
    print_info "What was installed:"
    print_info "  ✓ Homebrew (package manager)"
    print_info "  ✓ Git (version control)"
    print_info "  ✓ Node.js and npm (JavaScript runtime)"
    print_info "  ✓ VSCode (code editor)"
    print_info "  ✓ Claude CLI (command-line tool)"
    print_info "  ✓ Claude Code extension (VSCode extension)"
    echo ""
    print_info "Next steps:"
    print_info "1. Restart your terminal (recommended to ensure PATH is updated)"
    print_info "2. Clone this repository (if you haven't already):"
    print_info "   git clone https://github.com/YOUR_USERNAME/ClaudeGo.git"
    print_info "3. Open the cloned folder in VSCode"
    print_info "4. If you skipped authentication, run: claude auth login"
    print_info "5. Start using Claude Code!"
    echo ""
    print_info "Run './verify.sh' to verify your installation"
    echo ""
}

# Run main function
main
