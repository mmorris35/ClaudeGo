#!/bin/bash

# ClaudeGo Verification Script for Linux
# Verifies that all components are installed correctly

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

# Track overall status
all_checks_passed=true

# Verify Linux
check_linux() {
    print_header "System Check"

    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        print_success "Running on Linux"
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            echo -e "   Distribution: $NAME"
            echo -e "   Version: $VERSION"
        fi
    else
        print_error "Not running on Linux"
        all_checks_passed=false
    fi
}

# Verify system packages
check_system_packages() {
    print_header "System Packages Check"

    local all_present=true

    if command -v curl &> /dev/null; then
        print_success "curl is installed"
    else
        print_warning "curl is not installed"
        all_present=false
    fi

    if command -v wget &> /dev/null; then
        print_success "wget is installed"
    else
        print_warning "wget is not installed"
        all_present=false
    fi

    if command -v gpg &> /dev/null; then
        print_success "gpg is installed"
    else
        print_warning "gpg is not installed"
        all_present=false
    fi

    if ! $all_present; then
        print_info "Run './install-linux.sh' to install missing packages"
    fi
}

# Verify Git
check_git() {
    print_header "Git Check"

    if command -v git &> /dev/null; then
        print_success "Git is installed"
        echo -e "   Version: $(git --version)"
    else
        print_error "Git is not installed"
        all_checks_passed=false
        print_info "Run './install-linux.sh' to install it"
    fi
}

# Verify Node.js and npm
check_node() {
    print_header "Node.js and npm Check"

    if command -v node &> /dev/null; then
        print_success "Node.js is installed"
        echo -e "   Version: $(node --version)"
    else
        print_error "Node.js is not installed"
        all_checks_passed=false
        print_info "Run './install-linux.sh' to install it"
    fi

    if command -v npm &> /dev/null; then
        print_success "npm is installed"
        echo -e "   Version: $(npm --version)"
    else
        print_error "npm is not installed"
        all_checks_passed=false
        print_info "Run './install-linux.sh' to install it"
    fi
}

# Verify npm configuration (no sudo required)
check_npm_config() {
    print_header "npm Configuration Check"

    if ! command -v npm &> /dev/null; then
        print_error "npm is not installed - skipping configuration check"
        return
    fi

    local NPM_PREFIX=$(npm config get prefix)

    if [[ "$NPM_PREFIX" == "$HOME"* ]]; then
        print_success "npm is configured for non-sudo global installs"
        echo -e "   Prefix: $NPM_PREFIX"
    elif [[ "$NPM_PREFIX" == "/usr/local" || "$NPM_PREFIX" == "/usr" ]]; then
        print_warning "npm prefix is set to a system directory: $NPM_PREFIX"
        print_info "This may require sudo for global installs"
        print_info "To fix, run:"
        print_info "  mkdir -p ~/.npm-global"
        print_info "  npm config set prefix ~/.npm-global"
        print_info "  export PATH=~/.npm-global/bin:\$PATH"
    else
        print_success "npm prefix is set to: $NPM_PREFIX"
    fi
}

# Verify Claude CLI
check_claude_cli() {
    print_header "Claude CLI Check"

    if command -v claude &> /dev/null; then
        print_success "Claude CLI is installed"

        # Try to get version
        local version=$(claude --version 2>/dev/null || echo "unknown")
        if [[ "$version" != "unknown" ]]; then
            echo -e "   Version: $version"
        fi
    else
        print_error "Claude CLI is not installed"
        all_checks_passed=false
        print_info "Run './install-linux.sh' to install it"
        print_info "Or manually: npm install -g @anthropic-ai/claude-cli"
    fi
}

# Verify VSCode
check_vscode() {
    print_header "VSCode Check"

    # Check if VSCode is installed
    if command -v code &> /dev/null; then
        print_success "VSCode is installed"
        version=$(code --version 2>/dev/null | head -n 1)
        if [[ -n "$version" ]]; then
            echo -e "   Version: $version"
        fi
        print_success "'code' command is available in PATH"
    else
        print_error "VSCode is not installed or 'code' command not in PATH"
        all_checks_passed=false
        print_info "Run './install-linux.sh' to install it"
    fi
}

# Verify Claude Code extension
check_claude_extension() {
    print_header "Claude Code Extension Check"

    if ! command -v code &> /dev/null; then
        print_error "Cannot check extensions - 'code' command not available"
        all_checks_passed=false
        return
    fi

    if code --list-extensions 2>/dev/null | grep -q "anthropics.claude-code"; then
        print_success "Claude Code extension is installed"

        # Get extension version
        version=$(code --list-extensions --show-versions 2>/dev/null | grep "anthropics.claude-code" | cut -d'@' -f2)
        if [[ -n "$version" ]]; then
            echo -e "   Version: $version"
        fi
    else
        print_error "Claude Code extension is not installed"
        all_checks_passed=false
        print_info "Run './install-linux.sh' to install it"
    fi
}

# Check Claude authentication
check_authentication() {
    print_header "Claude Authentication Check"

    if ! command -v claude &> /dev/null; then
        print_error "Claude CLI not found - cannot check authentication"
        all_checks_passed=false
        print_info "Install Claude CLI first: run './install-linux.sh'"
        return
    fi

    # Try to get claude status
    if claude status &> /dev/null; then
        print_success "Claude CLI is authenticated"
        echo ""
        print_info "Account details:"
        claude status | head -n 10
        echo ""
    else
        print_error "Claude CLI is not authenticated"
        all_checks_passed=false
        echo ""
        print_info "To authenticate, run:"
        print_info "  claude auth login"
        echo ""
        print_info "IMPORTANT: Choose 'Login with Claude.ai account' (NOT 'API Key')"
    fi
}

# Check Claude Pro subscription
check_subscription() {
    print_header "Claude Pro Subscription Check"

    print_info "Please verify your Claude subscription:"
    echo ""

    read -p "Do you have an active Claude Pro subscription? (yes/no): " has_subscription

    if [[ "$has_subscription" == "yes" || "$has_subscription" == "y" ]]; then
        print_success "Claude Pro subscription confirmed"
    else
        print_error "Claude Pro subscription not found"
        all_checks_passed=false
        print_info "Visit https://claude.ai/settings/billing to upgrade"
    fi
}

# Display final summary
display_summary() {
    print_header "Verification Summary"

    if $all_checks_passed; then
        echo -e "${GREEN}╔═══════════════════════════════════════════════════╗${NC}"
        echo -e "${GREEN}║                                                   ║${NC}"
        echo -e "${GREEN}║            All checks passed! ✓                   ║${NC}"
        echo -e "${GREEN}║                                                   ║${NC}"
        echo -e "${GREEN}║         You're ready to use Claude Code!         ║${NC}"
        echo -e "${GREEN}║                                                   ║${NC}"
        echo -e "${GREEN}╚═══════════════════════════════════════════════════╝${NC}"
        echo ""
        print_info "Open VSCode and press Ctrl+Shift+P to start using Claude Code"
        echo ""
        exit 0
    else
        echo -e "${RED}╔═══════════════════════════════════════════════════╗${NC}"
        echo -e "${RED}║                                                   ║${NC}"
        echo -e "${RED}║            Some checks failed ✗                   ║${NC}"
        echo -e "${RED}║                                                   ║${NC}"
        echo -e "${RED}╚═══════════════════════════════════════════════════╝${NC}"
        echo ""
        print_info "Please review the errors above"
        print_info "Run './install-linux.sh' to fix missing components"
        echo ""
        exit 1
    fi
}

# Main verification flow
main() {
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                                                   ║${NC}"
    echo -e "${BLUE}║     ClaudeGo Verification Script (Linux)          ║${NC}"
    echo -e "${BLUE}║                                                   ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════╝${NC}"

    check_linux
    check_system_packages
    check_git
    check_node
    check_npm_config
    check_vscode
    check_claude_cli
    check_claude_extension
    check_authentication
    check_subscription

    display_summary
}

# Run main function
main
