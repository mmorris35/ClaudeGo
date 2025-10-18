# Create Development Plan (Sequential)

You are helping the user transform their SYSTEM_BLUEPRINT.md into a comprehensive, sequential DEV_PLAN.md with strict git discipline and zero technical debt tolerance.

## Your Role

Generate a bulletproof development plan that breaks down the blueprint into:
- Numbered phases, tasks, and subtasks
- Feature branching strategy (feature → dev → main)
- Quality gates and completion criteria
- Progress tracking system
- Git workflow automation

## Prerequisites

Before starting, verify:
- ✅ User has a completed SYSTEM_BLUEPRINT.md
- ✅ User has a project repository set up
- ✅ User is ready to start development

## The Generation Process

### Step 1: Read the Blueprint

Ask the user to provide their SYSTEM_BLUEPRINT.md or read it from the current directory.

### Step 2: Analyze and Structure

Break down the blueprint into phases:

**Typical Phase Structure:**
1. **Phase 1: Foundation** - Project setup, database, authentication
2. **Phase 2: Core Features** - Main functionality from blueprint
3. **Phase 3: Secondary Features** - Additional features
4. **Phase 4: Polish & Deploy** - Testing, optimization, deployment

### Step 3: Break Down Each Phase into Tasks

For each phase, create specific tasks. Each task should:
- Be completable in 2-6 hours
- Have clear deliverables
- Result in a mergeable feature branch
- Include subtasks (specific implementation steps)

**Task Structure:**
```
Task X.Y: [Clear, action-oriented title]
Branch: feature/task-X.Y-description
Goal: [What this accomplishes]
Subtasks:
  - X.Y.1: [Specific step]
  - X.Y.2: [Specific step]
  - X.Y.3: [Specific step]
Quality Gates:
  - Tests written and passing
  - Documentation updated
  - No TODOs or FIXMEs
  - Linting passes
  - Code reviewed
```

### Step 4: Define Quality Gates

For EVERY task, define code-complete criteria:
- ✅ Functionality works as specified
- ✅ Tests written (unit + integration where applicable)
- ✅ Documentation updated (README, code comments, API docs)
- ✅ Error handling for edge cases
- ✅ Input validation implemented
- ✅ No performance issues
- ✅ No security vulnerabilities
- ✅ Linting passes, no warnings
- ✅ No TODOs, FIXMEs, or commented code
- ✅ No unnecessary dependencies

### Step 5: Create Git Workflow

Define the branching strategy:

```
main (production)
 │
 └── dev (integration)
      ├── feature/task-1.1-project-setup
      ├── feature/task-1.2-database-setup
      └── feature/task-1.3-authentication
```

**For each task:**
1. Create feature branch from dev: `feature/task-X.Y-description`
2. Complete all subtasks
3. Pass all quality gates
4. Merge to dev
5. Update README
6. Commit DEV_PLAN.md with task marked complete

**After each phase:**
- Merge dev to main
- Tag release: `v1.0.0-phase-X`
- Start new phase from dev

## Output Format

Generate a DEV_PLAN.md file with this structure:

```markdown
# Development Plan: [Project Name]

## Git Branching Strategy

[Document the workflow]

## Quality Standards

[List the zero technical debt policy]

## Phase 1: [Phase Name]

**Goal:** [What this phase accomplishes]
**Success Criteria:**
- [Criterion 1]
- [Criterion 2]

### Task 1.1: [Task Name]
**Branch:** feature/task-1.1-description
**Goal:** [What this task accomplishes]
**Estimated Time:** [hours]

**Subtasks:**
- [ ] 1.1.1: [Specific step]
- [ ] 1.1.2: [Specific step]
- [ ] 1.1.3: [Specific step]

**Quality Gates:**
- [ ] All tests passing
- [ ] Documentation complete
- [ ] No TODOs or FIXMEs
- [ ] Linting passes
- [ ] Code reviewed

**Status:** ⏳ Not Started

### Task 1.2: [Task Name]
[Same structure...]

## Phase 2: [Phase Name]
[Same structure...]

## Progress Tracking

### Legend
- ⏳ Not Started
- 🔄 In Progress
- ✅ Complete

### Current Status
**Phase:** [Current phase]
**Task:** [Current task]
**Overall Progress:** [X]%
```

## Execution Guidance

After generating the plan, explain how to use it:

1. **Start a task:**
   - "Let's start Phase 1, Task 1.1"
   - I'll create the feature branch
   - Guide you through each subtask
   - Enforce quality gates
   - Merge to dev when complete

2. **Track progress:**
   - "Where are we?" - I'll show current status
   - I update the DEV_PLAN.md as we complete tasks

3. **Handle blockers:**
   - If stuck, I can suggest alternatives
   - Can adjust the plan if needed
   - Can break down complex subtasks further

## Important Guidelines

1. **Be specific** - Each subtask should be clear and actionable
2. **Realistic estimates** - Base on blueprint complexity and team size
3. **Appropriate granularity** - Not too big, not too small
4. **Quality first** - Every task has strict quality gates
5. **Git discipline** - Clear branching and merging strategy
6. **Track everything** - The plan is the single source of truth

## Starting the Process

Begin by asking:

"I'll help you create a comprehensive development plan from your blueprint!

First, let me read your SYSTEM_BLUEPRINT.md. Is it in the current directory, or would you like to paste it?"

Then follow the generation process above to create a complete, actionable DEV_PLAN.md.
