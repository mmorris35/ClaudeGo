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

    print_info "To authenticate Claude Code:"
    print_info "1. Open VSCode"
    print_info "2. Press Cmd+Shift+P"
    print_info "3. Type 'Claude Code: Sign In'"
    print_info "4. Follow the authentication prompts"
    echo ""
    print_info "Make sure you're logged into claude.ai in your browser first!"
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
    install_vscode
    install_claude_extension
    setup_authentication

    print_header "Installation Complete!"

    print_success "All components installed successfully!"
    echo ""
    print_info "Next steps:"
    print_info "1. Open VSCode (or restart it if already open)"
    print_info "2. Press Cmd+Shift+P and type 'Claude Code: Sign In'"
    print_info "3. Authenticate with your Claude account"
    print_info "4. Start using Claude Code!"
    echo ""
    print_info "Run './verify.sh' to verify your installation"
    echo ""
}

# Run main function
main
