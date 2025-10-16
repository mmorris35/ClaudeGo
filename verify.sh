#!/bin/bash

# ClaudeGo Verification Script
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

# Verify macOS
check_macos() {
    print_header "System Check"

    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_success "Running on macOS"
        echo -e "   Version: $(sw_vers -productVersion)"
    else
        print_error "Not running on macOS"
        all_checks_passed=false
    fi
}

# Verify Homebrew
check_homebrew() {
    print_header "Homebrew Check"

    if command -v brew &> /dev/null; then
        print_success "Homebrew is installed"
        echo -e "   Version: $(brew --version | head -n 1)"
    else
        print_warning "Homebrew is not installed (optional but recommended)"
    fi
}

# Verify VSCode
check_vscode() {
    print_header "VSCode Check"

    # Check if VSCode app exists
    if [[ -d "/Applications/Visual Studio Code.app" ]]; then
        print_success "VSCode application is installed"

        # Get version
        if command -v code &> /dev/null; then
            version=$(code --version | head -n 1)
            echo -e "   Version: $version"
        fi
    else
        print_error "VSCode is not installed"
        all_checks_passed=false
    fi

    # Check if code command is available
    if command -v code &> /dev/null; then
        print_success "'code' command is available in PATH"
    else
        print_warning "'code' command not in PATH"
        print_info "You can add it via: VSCode → Cmd+Shift+P → 'Shell Command: Install code command in PATH'"
    fi
}

# Verify Claude Code extension
check_claude_extension() {
    print_header "Claude Code Extension Check"

    # Check if code command is available
    if ! command -v code &> /dev/null; then
        if [[ -d "/Applications/Visual Studio Code.app" ]]; then
            export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
        fi
    fi

    if command -v code &> /dev/null; then
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
            print_info "Run './install.sh' to install it"
        fi
    else
        print_error "Cannot check extensions - 'code' command not available"
        all_checks_passed=false
    fi
}

# Check Claude authentication
check_authentication() {
    print_header "Claude Authentication Check"

    print_info "To verify authentication:"
    print_info "1. Open VSCode"
    print_info "2. Press Cmd+Shift+P"
    print_info "3. Type 'Claude Code'"
    print_info "4. If you see Claude commands, you're authenticated!"
    echo ""

    read -p "Are you able to use Claude Code commands in VSCode? (yes/no): " is_authenticated

    if [[ "$is_authenticated" == "yes" || "$is_authenticated" == "y" ]]; then
        print_success "Claude Code is authenticated and working"
    else
        print_error "Claude Code is not authenticated"
        all_checks_passed=false
        print_info "To authenticate:"
        print_info "1. Open VSCode"
        print_info "2. Press Cmd+Shift+P"
        print_info "3. Type 'Claude Code: Sign In'"
        print_info "4. Follow the prompts"
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
        print_info "Open VSCode and press Cmd+Shift+P to start using Claude Code"
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
        print_info "Run './install.sh' to fix missing components"
        echo ""
        exit 1
    fi
}

# Main verification flow
main() {
    echo ""
    echo -e "${BLUE}╔═══════════════════════════════════════════════════╗${NC}"
    echo -e "${BLUE}║                                                   ║${NC}"
    echo -e "${BLUE}║          ClaudeGo Verification Script             ║${NC}"
    echo -e "${BLUE}║                                                   ║${NC}"
    echo -e "${BLUE}╚═══════════════════════════════════════════════════╝${NC}"

    check_macos
    check_homebrew
    check_vscode
    check_claude_extension
    check_authentication
    check_subscription

    display_summary
}

# Run main function
main
