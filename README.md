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

---

## Creating a System Blueprint for Your Project

Once you have Claude Code set up, use it to create comprehensive technical plans for your projects!

### What is a System Blueprint?

A System Blueprint is a complete technical and product specification document that covers:
- 📋 Vision and strategy
- 👥 User personas and features
- 🏗️ Technical architecture (Claude recommends based on your needs)
- 💾 Database schema and API design
- 🧪 Testing and deployment strategies
- 🚀 Growth and scaling plans

### Why Create a Blueprint?

- **Reduce project risk** - Think through problems before coding
- **Speed up development** - Clear specs = faster implementation
- **Make better decisions** - Claude analyzes your constraints and recommends optimal architecture
- **Onboard team members** - Complete documentation in one place
- **Plan for scale** - Know when and how to evolve your architecture

### How It Works

1. **You provide context** (30-45 min per phase):
   - Your project idea, goals, and constraints
   - Target users and features
   - Team size, timeline, and budget

2. **Claude analyzes and recommends** (I do the heavy lifting):
   - Architecture pattern (monolith vs microservices)
   - Complete tech stack with reasoning
   - Database schema design
   - API specifications
   - Security strategy
   - Scaling plan

3. **You get a complete blueprint** (3-4 hours total):
   - Professional `SYSTEM_BLUEPRINT.md` file
   - Ready to use as foundation for your new project repo
   - Living document that evolves with your project

### Quick Start with Blueprint Creation

**Option 1: Use the Slash Command (Recommended)**

In VSCode with Claude Code installed, open the Claude Code chat and type:

```
/create-blueprint
```

Claude will immediately start the interactive process, asking you questions and guiding you through all 6 phases.

**Option 2: Manual Start**

Open the [Complete Blueprint Guide](docs/BLUEPRINT_GUIDE.md) and read through Phase 1. Then in Claude Code chat, say:

```
"Let's create a system blueprint for my project. I'm ready for Phase 1."
```

**How to Use It:**

1. **Start the process** using one of the methods above
2. **Answer Claude's questions** - Be specific about your goals, constraints, team size, timeline, and budget
3. **Review Claude's recommendations** - Claude will analyze your answers and recommend architecture, tech stack, database design, etc.
4. **Iterate and refine** - Ask follow-up questions, request alternatives, or dive deeper into any area
5. **Get your blueprint** - After completing all 6 phases (3-4 hours total), Claude will generate a complete `SYSTEM_BLUEPRINT.md` file

**Tips for Best Results:**

- Block out 3-4 hours for the complete process (or do it in multiple sessions)
- Be honest about constraints (team size, timeline, budget, technical expertise)
- Ask "why" when Claude makes recommendations - understanding the reasoning helps you make better decisions
- Keep the [Blueprint Guide](docs/BLUEPRINT_GUIDE.md) open for reference
- Save the final `SYSTEM_BLUEPRINT.md` in your new project repository

### Documentation

- 📖 **[Complete Guide](docs/BLUEPRINT_GUIDE.md)** - Detailed walkthrough of all 6 phases with example questions
- 📋 **[Examples](docs/BLUEPRINT_EXAMPLES.md)** - Three complete blueprint examples (SaaS, Marketplace, Internal Tool)
- 📝 **[Template](docs/BLUEPRINT_TEMPLATE.md)** - See the structure of the final blueprint output
- 🎯 **[Specification](BLUEPRINT_SYSTEM_SPEC.md)** - Technical details of how the system works

### Example Flow

```
You: "/create-blueprint"

Claude: "Let's create a comprehensive System Blueprint! This takes 3-4 hours
but results in a complete technical plan.

Phase 1: Tell me about your project idea in 2-3 sentences. What problem
does it solve?"

You: "A collaborative task management tool for remote teams across time zones..."

Claude: "Great! Let me ask some clarifying questions about your vision..."

[After Phase 1-2, Claude analyzes your requirements]

Claude: "Based on your requirements:
- 2 developers, 3-month timeline
- Real-time features needed
- 5K users expected in year 1
- Medium extensibility (API + webhooks in v2)

I recommend:
- Architecture: Modular Monolith
- Backend: FastAPI (Python)
- Frontend: React + TypeScript
- Database: PostgreSQL + Redis
- Hosting: Railway

Here's my reasoning..."
```

### Key Features

✅ **Extensibility-Aware**: Claude asks about your extensibility needs early, then designs architecture accordingly

✅ **Intelligent Recommendations**: Not just documenting—Claude makes smart tech stack decisions based on your constraints

✅ **Pragmatic**: Recommendations match your team size, timeline, and budget (no over-engineering)

✅ **Complete**: Covers everything from vision to deployment strategy

✅ **Production-Ready**: Specifications are detailed enough to start building immediately

### What You'll Learn

Even if you don't use the final blueprint, the process helps you:
- Think through architecture decisions systematically
- Understand trade-offs between different approaches
- Plan for scale from day one
- Identify risks and dependencies early
- Budget time and resources accurately

---

## Creating a Development Plan from Your Blueprint

Once you have a System Blueprint, transform it into a bulletproof, paint-by-numbers development plan!

### What is a Development Plan?

A Development Plan (`DEV_PLAN.md`) is a detailed execution roadmap that breaks your blueprint into:
- 📋 **Numbered phases, tasks, and subtasks** - Clear hierarchy and dependencies
- 🌳 **Git workflow** - Feature branches, dev branch, and main branch discipline
- ✅ **Quality gates** - Concrete completion criteria for each task
- 🚫 **Zero technical debt** - No task is complete until it's code-complete (tests, docs, error handling, etc.)
- 📍 **Progress tracking** - Claude marks completion and you can ask "where are we?"

### Sequential vs Parallel Execution

**Sequential Dev Plan** (Traditional)
- Tasks execute one at a time
- Simpler coordination, lower overhead
- Best for: Small projects (<10 tasks), learning, prototyping
- Guide: [docs/DEV_PLAN_GUIDE.md](docs/DEV_PLAN_GUIDE.md)

**Parallel Dev Plan** (3-4x Faster!) 🚀
- Multiple tasks execute simultaneously using parallel agents
- 50-70% time savings on most projects
- Automatic dependency analysis and conflict prevention
- Best for: Medium-large projects (15+ tasks), time-critical delivery
- Guide: [docs/PARALLEL_DEV_PLAN_GUIDE.md](docs/PARALLEL_DEV_PLAN_GUIDE.md)

**Example Speed Comparison:**

Traditional Sequential: 40 hours → Parallel Execution: 15 hours (62% faster)

### Why Create a Dev Plan?

- **No missed steps** - Every detail from blueprint becomes a concrete task
- **Quality assurance** - Built-in quality gates prevent shipping incomplete work
- **Clear progress** - Always know exactly where you are in the project
- **Git discipline** - Systematic branching prevents merge chaos
- **Team alignment** - Everyone knows what's done, what's in progress, and what's next

### How It Works

1. **You provide your blueprint** - The completed `SYSTEM_BLUEPRINT.md` from the blueprint process
2. **Claude generates the dev plan** - Breaks down every feature into specific tasks with subtasks
3. **Claude guides execution** - Marks tasks complete, enforces quality gates, updates the plan
4. **You ask "where are we?"** - Claude reports exact phase, task, and subtask location

### Quick Start with Dev Plan Creation

**Step 1: Open the Dev Plan Guide**

Open [docs/DEV_PLAN_GUIDE.md](docs/DEV_PLAN_GUIDE.md) in VSCode.

**Step 2: Copy the Prompt Sequence**

Find the "## Prompt Sequence to Generate DEV_PLAN.md" section and copy the complete prompt.

**Step 3: Paste into Claude Code Chat**

Open Claude Code chat and paste the prompt. Make sure your `SYSTEM_BLUEPRINT.md` is in the project or paste its contents.

**Step 4: Review and Approve**

Claude will generate a complete `DEV_PLAN.md` with all phases, tasks, subtasks, and quality gates. Review it and approve.

**Step 5: Start Development**

Tell Claude: "Let's start with Phase 1, Task 1.1"

Claude will:
- Create the feature branch
- Guide you through subtasks
- Enforce quality gates
- Update the plan document
- Merge to dev when task is complete
- Update README and commit changes

### Git Workflow in Dev Plans

```
main (production)
 │
 └── dev (integration)
      ├── feature/task-1.1-project-setup
      ├── feature/task-1.2-database-setup
      └── feature/task-2.1-user-authentication
```

**For each task:**
1. Claude creates `feature/task-X.Y-description` branch from `dev`
2. You complete subtasks with Claude's guidance
3. Claude enforces quality gates (tests pass, docs written, no TODOs, etc.)
4. Claude merges to `dev` when code-complete
5. Claude updates README and commits plan updates

**After each phase:**
- Claude merges `dev` to `main`
- Claude tags the release
- New phase starts fresh from `dev`

### Zero Technical Debt Policy

**No task is marked complete until it is CODE-COMPLETE:**

✅ Functionality works as specified
✅ Tests written and passing (unit + integration)
✅ Documentation updated (code comments, README, API docs)
✅ Error handling for all edge cases
✅ Input validation implemented
✅ No performance issues
✅ No security vulnerabilities
✅ Linting passes, no warnings
✅ No TODOs, FIXMEs, or commented code
✅ No unnecessary dependencies

Claude enforces this - you can't move forward until quality gates pass.

### Progress Tracking Example

```
You: "Where are we?"

Claude: "We're in Phase 2: Core Features, currently on Task 2.3: Shopping Cart
Implementation, specifically working on Subtask 2.3.2: Implement cart persistence.

Status:
✅ Phase 1: Foundation (100% complete)
🔄 Phase 2: Core Features (40% complete)
  ✅ Task 2.1: Product Catalog
  ✅ Task 2.2: Search & Filters
  🔄 Task 2.3: Shopping Cart (in progress)
    ✅ 2.3.1: Create cart data model
    🔄 2.3.2: Implement cart persistence (current)
    ⏳ 2.3.3: Add/remove cart items
⏳ Phase 3: Payment & Checkout (not started)"
```

### Documentation

- 📖 **[Sequential Dev Plan Guide](docs/DEV_PLAN_GUIDE.md)** - Traditional one-task-at-a-time execution
- 🚀 **[Parallel Dev Plan Guide](docs/PARALLEL_DEV_PLAN_GUIDE.md)** - NEW! 3-4x faster with parallel agents
- 📋 **Example Plans** - See structures inside both guides

### Tips for Best Results

- **Complete the blueprint first** - A thorough blueprint = a better dev plan
- **Review the generated plan** - Make sure task breakdown makes sense for your project
- **Trust the process** - The quality gates exist to prevent technical debt
- **Ask Claude for help** - If stuck on a subtask, Claude can provide guidance or alternative approaches
- **Update estimates** - As you progress, update time estimates in the plan to improve future planning

---

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
