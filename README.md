# ClaudeGo - Your Complete AI Development Toolkit

**Stop planning. Start building.**

ClaudeGo is your all-in-one system for turning ideas into production-ready software—fast. Whether you're a solo developer or leading a team, ClaudeGo gives you three superpowers:

## 🚀 What You Get

### 1. **Zero-Friction Setup** (5 minutes)
Download one script, run it, and get Claude Code working in VSCode on Mac or Linux. No configuration hell. No debugging toolchains. Just working AI development in minutes.

### 2. **System Blueprint Generator** (3-4 hours → Complete Technical Spec)
Stop Googling "best architecture for X." Have a conversation with Claude, and get a production-grade technical specification covering:
- Architecture recommendations (with reasoning for YOUR constraints)
- Complete tech stack selection
- Database schema design
- API specifications
- Security, testing, and deployment strategies
- Scaling plans

**Claude analyzes your team size, timeline, and budget—then recommends the optimal approach.** No more over-engineering. No more under-planning.

### 3. **Parallel Development Plans** (Build 3-4x Faster!)
Transform your blueprint into a bulletproof execution roadmap with automatic parallel task execution:
- Paint-by-numbers tasks with zero-technical-debt quality gates
- **50-70% time savings** through intelligent parallel execution
- Automatic dependency analysis and conflict prevention
- Git workflow baked in (feature branches, proper merging, systematic commits)
- Always know exactly where you are: "Claude, where are we?"

**Example:** Traditional sequential development takes 40 hours? Parallel execution completes it in 15 hours.

---

## 💰 What It Costs

**Claude Code requires a Claude Pro subscription at $20/month** (or $17/month annual).

The free tier at Claude.ai does NOT include Claude Code access. You must upgrade to Pro or higher to use ClaudeGo features.

---

## 🎯 Quick Start: Get Running in 5 Minutes

### What You'll Need

1. **A Mac or Linux system**
   - macOS users: Use `install.sh`
   - Linux users: Use `install-linux.sh`
2. **GitHub Account** - Create one at [github.com](https://github.com) if needed
3. **Claude Pro Subscription** - Sign up at [claude.ai](https://claude.ai) and upgrade at [claude.ai/settings/billing](https://claude.ai/settings/billing)

### Installation by Platform

<details>
<summary><b>📦 macOS Installation</b></summary>

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

The script will automatically install:
- ✅ Homebrew (package manager)
- ✅ Git (version control)
- ✅ Node.js and npm (no sudo required)
- ✅ VSCode (code editor)
- ✅ Claude CLI (command-line tool)
- ✅ Claude Code extension
- ✅ Authenticate with your Claude account (interactive)

**The script will prompt you to authenticate during installation.** Just follow the prompts!

### Step 2: Fork and Clone This Repository

**Why fork?** You'll get your own copy with all the blueprint and dev plan templates, ready to customize for your projects.

1. Go to [github.com/mmorris35/ClaudeGo](https://github.com/mmorris35/ClaudeGo)
2. Click "Fork" (top-right corner)
3. Open VSCode and clone YOUR fork:

1. Press `Cmd+Shift+P` to open Command Palette
2. Type "Git: Clone"
3. Paste: `https://github.com/YOUR_USERNAME/ClaudeGo.git` (replace with your GitHub username)
4. Choose a folder and click "Open"

### Step 3: Verify Everything Works

Open a new terminal (to ensure PATH is updated) and check:

```bash
claude status
```

You should see your Claude account information and subscription status.

**That's it. You're ready.** Now let's use these superpowers.

</details>

<details>
<summary><b>🐧 Linux Installation</b></summary>

### Step 1: Download and Run install-linux.sh

1. Download `install-linux.sh` from this repository (click the file, then "Download raw file")
2. Open Terminal
3. Navigate to where you downloaded the file:
   ```bash
   cd ~/Downloads
   ```
4. Run the installation script:
   ```bash
   chmod +x install-linux.sh
   ./install-linux.sh
   ```

The script will automatically install:
- ✅ System packages (curl, wget, gnupg)
- ✅ Git (version control)
- ✅ Node.js and npm (no sudo required)
- ✅ VSCode (code editor)
- ✅ Claude CLI (command-line tool)
- ✅ Claude Code extension
- ✅ Authenticate with your Claude account (interactive)

**The script will prompt you to authenticate during installation.** Just follow the prompts!

### Step 2: Fork and Clone This Repository

**Why fork?** You'll get your own copy with all the blueprint and dev plan templates, ready to customize for your projects.

1. Go to [github.com/mmorris35/ClaudeGo](https://github.com/mmorris35/ClaudeGo)
2. Click "Fork" (top-right corner)
3. Open VSCode and clone YOUR fork:

1. Press `Ctrl+Shift+P` to open Command Palette
2. Type "Git: Clone"
3. Paste: `https://github.com/YOUR_USERNAME/ClaudeGo.git` (replace with your GitHub username)
4. Choose a folder and click "Open"

### Step 3: Verify Everything Works

Open a new terminal (to ensure PATH is updated) and check:

```bash
claude status
```

You should see your Claude account information and subscription status.

**That's it. You're ready.** Now let's use these superpowers.

</details>

---

## 📋 Feature Deep Dive

### System Blueprint Generator

**Transform a conversation into a production-grade technical specification in 3-4 hours.**

#### What You Get

A complete `SYSTEM_BLUEPRINT.md` covering:
- 📋 Vision and strategy
- 👥 User personas and feature requirements
- 🏗️ Architecture recommendations (tailored to YOUR constraints)
- 💾 Database schema design
- 🌐 API specifications
- 🧪 Testing strategies
- 🚀 Deployment and scaling plans

#### Why It Matters

- **Reduce project risk** - Catch problems before coding
- **Speed up development** - Clear specs = faster implementation
- **Make better decisions** - Claude analyzes your constraints and recommends optimal solutions
- **Onboard faster** - Complete documentation in one place
- **Plan for scale** - Know when and how to evolve

#### How to Start

**Option 1: Slash Command (Recommended)**

In Claude Code chat:
```
/create-blueprint
```

**Option 2: Manual Start**

Open [docs/BLUEPRINT_GUIDE.md](docs/BLUEPRINT_GUIDE.md) and say:
```
"Let's create a system blueprint for my project. I'm ready for Phase 1."
```

#### The Process

1. **You answer questions** - Claude asks about your goals, users, constraints, team size, timeline, budget
2. **Claude analyzes and recommends** - Architecture pattern, tech stack, database design, APIs, security, scaling
3. **You refine together** - Ask "why", request alternatives, dive deeper
4. **Get your blueprint** - Complete `SYSTEM_BLUEPRINT.md` ready for development

**Time Investment:** 3-4 hours total (can split into multiple sessions)

#### Key Features

✅ **Extensibility-Aware** - Claude designs architecture based on your extensibility needs
✅ **Intelligent Recommendations** - Smart tech stack decisions for YOUR constraints
✅ **Pragmatic** - Matches your team size, timeline, budget (no over-engineering)
✅ **Complete** - Vision to deployment, everything covered
✅ **Production-Ready** - Detailed enough to start building immediately

#### Learn More

- 📖 [Complete Guide](docs/BLUEPRINT_GUIDE.md) - Full walkthrough with example questions
- 📋 [Examples](docs/BLUEPRINT_EXAMPLES.md) - Three complete blueprints (SaaS, Marketplace, Internal Tool)
- 📝 [Template](docs/BLUEPRINT_TEMPLATE.md) - See the final output structure

---

### Development Plans: Build 3-4x Faster with Parallel Execution

**Transform your blueprint into a bulletproof execution roadmap with automatic parallel task orchestration.**

#### What You Get

A complete `DEV_PLAN.md` with:
- 📋 **Numbered phases, tasks, subtasks** - Clear hierarchy and dependencies
- 🚀 **Parallel execution** - 50-70% time savings through intelligent task orchestration
- 🌳 **Git workflow** - Feature branches, dev branch, main branch discipline
- ✅ **Quality gates** - Concrete completion criteria (tests, docs, error handling, etc.)
- 🚫 **Zero technical debt** - No task complete until it's code-complete
- 📍 **Progress tracking** - Always know exactly where you are

#### Sequential vs Parallel Execution

**Sequential Dev Plan** (Traditional)
- One task at a time
- Simpler coordination, lower overhead
- Best for: Small projects (<10 tasks), learning, prototyping
- Guide: [docs/DEV_PLAN_GUIDE.md](docs/DEV_PLAN_GUIDE.md)

**Parallel Dev Plan** (3-4x Faster!) 🚀
- **Multiple tasks execute simultaneously**
- **50-70% time savings** on most projects
- Automatic dependency analysis and conflict prevention
- Best for: Medium-large projects (15+ tasks), time-critical delivery
- Guide: [docs/PARALLEL_DEV_PLAN_GUIDE.md](docs/PARALLEL_DEV_PLAN_GUIDE.md)

**Real Example:** Traditional 40 hours → Parallel 15 hours (62% faster)

#### How to Start

**Step 1:** Complete your System Blueprint first

**Step 2:** Open [docs/DEV_PLAN_GUIDE.md](docs/DEV_PLAN_GUIDE.md) or [docs/PARALLEL_DEV_PLAN_GUIDE.md](docs/PARALLEL_DEV_PLAN_GUIDE.md)

**Step 3:** Copy the prompt sequence and paste into Claude Code chat

**Step 4:** Claude generates your complete `DEV_PLAN.md`

**Step 5:** Start development:
```
"Let's start with Phase 1, Task 1.1"
```

Claude will:
- Create feature branches
- Guide you through subtasks
- Enforce quality gates
- Update the plan document
- Merge to dev when complete
- Update README and commit changes

#### Git Workflow

```
main (production)
 │
 └── dev (integration)
      ├── feature/task-1.1-project-setup
      ├── feature/task-1.2-database-setup
      └── feature/task-2.1-user-authentication
```

**For each task:**
1. Claude creates `feature/task-X.Y-description` from `dev`
2. Complete subtasks with Claude's guidance
3. Quality gates enforced (tests, docs, no TODOs)
4. Claude merges to `dev` when code-complete
5. README and plan updates committed

**After each phase:**
- `dev` merges to `main`
- Release tagged
- Fresh start from `dev`

#### Zero Technical Debt Policy

**No task marked complete until CODE-COMPLETE:**

✅ Functionality works as specified
✅ Tests written and passing
✅ Documentation updated
✅ Error handling for edge cases
✅ Input validation implemented
✅ No performance issues
✅ No security vulnerabilities
✅ Linting passes
✅ No TODOs, FIXMEs, commented code
✅ No unnecessary dependencies

Claude enforces this - you can't move forward until quality gates pass.

#### Progress Tracking

Ask Claude anytime:
```
"Where are we?"
```

Get instant status:
```
Phase 2: Core Features (40% complete)
  ✅ Task 2.1: Product Catalog
  ✅ Task 2.2: Search & Filters
  🔄 Task 2.3: Shopping Cart (in progress)
    ✅ 2.3.1: Create cart data model
    🔄 2.3.2: Implement cart persistence (current)
    ⏳ 2.3.3: Add/remove cart items
```

#### Learn More

- 📖 [Sequential Dev Plan Guide](docs/DEV_PLAN_GUIDE.md) - Traditional execution
- 🚀 [Parallel Dev Plan Guide](docs/PARALLEL_DEV_PLAN_GUIDE.md) - 3-4x faster with parallel agents

---

## 🛠️ Troubleshooting

### "Authentication failed"

1. Make sure you have an active Claude Pro subscription at [claude.ai/settings/billing](https://claude.ai/settings/billing)
2. Open a new terminal and run:
   ```bash
   claude auth login
   ```
3. **IMPORTANT:** Choose "Login with Claude.ai account" (NOT "API Key")
4. Your browser will open → Log in → Authorize → Done!

### "Homebrew installation failed"

The `install.sh` script will attempt to install Homebrew. If it fails:

1. Visit [brew.sh](https://brew.sh) for manual installation instructions
2. Once Homebrew is installed, run `install.sh` again

### "VSCode won't open or command not found"

After running `install.sh`:
1. Restart your Terminal
2. Try opening VSCode again with `code`
3. If that doesn't work, open VSCode from Applications

### "npm install requires sudo" or "EACCES permission errors"

If you see permission errors when installing npm packages globally:

1. The `install.sh` script automatically configures npm to avoid sudo, but if you installed Node.js another way, you may need to reconfigure:
   ```bash
   mkdir -p ~/.npm-global
   npm config set prefix ~/.npm-global
   ```

2. Add to your shell config (`~/.zshrc` or `~/.bash_profile`):
   ```bash
   export NPM_PREFIX="$HOME/.npm-global"
   export PATH="$NPM_PREFIX/bin:$PATH"
   ```

3. Restart your terminal and try installing Claude CLI again:
   ```bash
   npm install -g @anthropic-ai/claude-cli
   ```

**Why this happens:** Node.js installed system-wide (not via Homebrew) often requires sudo for global packages. Our script prevents this by using a user-local directory.

### Still Having Issues?

- Check [Claude Code documentation](https://docs.claude.com/en/docs/claude-code)
- Open an issue in this repository
- Contact Claude support at [support.claude.com](https://support.claude.com)

---

## 📚 Additional Resources

### What Gets Installed

The installation scripts install everything you need for Claude Code:

**macOS (`install.sh`):**
- **Homebrew** - Package manager for macOS (if not already installed)
- **Git** - Version control system (usually pre-installed, verified/installed if needed)
- **Node.js and npm** - JavaScript runtime and package manager (installed via Homebrew)
- **npm configuration** - Automatically configured for global installs without sudo (uses `~/.npm-global`)
- **VSCode** - Visual Studio Code editor (if not already installed)
- **Claude CLI** - Command-line tool for authentication and status checks (installed via npm)
- **Claude Code Extension** - Official Claude extension for VSCode

**Linux (`install-linux.sh`):**
- **System packages** - curl, wget, gnupg (if not already installed)
- **Git** - Version control system (installed via apt)
- **Node.js and npm** - JavaScript runtime and package manager (installed from NodeSource repository)
- **npm configuration** - Automatically configured for global installs without sudo (uses `~/.npm-global`)
- **VSCode** - Visual Studio Code editor (installed from Microsoft repository)
- **Claude CLI** - Command-line tool for authentication and status checks (installed via npm)
- **Claude Code Extension** - Official Claude extension for VSCode

All installations are automated and require no manual configuration. The scripts ensure npm works without sudo by configuring it to use a user-local directory (`~/.npm-global`) instead of system directories.

### Documentation Links

- **Blueprint System:**
  - [Complete Guide](docs/BLUEPRINT_GUIDE.md) - Full walkthrough with example questions
  - [Examples](docs/BLUEPRINT_EXAMPLES.md) - Three complete blueprints
  - [Template](docs/BLUEPRINT_TEMPLATE.md) - Output structure
  - [Specification](BLUEPRINT_SYSTEM_SPEC.md) - Technical details

- **Development Plans:**
  - [Sequential Dev Plan Guide](docs/DEV_PLAN_GUIDE.md) - Traditional execution
  - [Parallel Dev Plan Guide](docs/PARALLEL_DEV_PLAN_GUIDE.md) - 3-4x faster execution

### Uninstalling

**Remove Claude Code:**
1. VSCode: `Cmd+Shift+X` → Search "Claude Code" → Uninstall
2. (Optional) Delete VSCode: `/Applications/Visual Studio Code.app`

**Cancel subscription:** [claude.ai/settings/billing](https://claude.ai/settings/billing)

---

## Contributing

Found a bug or have a suggestion? Open an issue or submit a pull request!

## License

MIT License - feel free to use and modify as needed.

---

**Note:** This is an unofficial setup repository. Claude Code is developed by Anthropic. Visit [claude.ai](https://claude.ai) for official information.
