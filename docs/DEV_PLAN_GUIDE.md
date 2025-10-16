# Development Plan Generator - From Blueprint to Code

This guide helps you transform your completed SYSTEM_BLUEPRINT.md into a bulletproof, paint-by-numbers development plan with strict git discipline, feature branching, and zero technical debt tolerance.

---

## Overview

**Input:** Your completed SYSTEM_BLUEPRINT.md

**Output:** A comprehensive DEV_PLAN.md with:
- Numbered phases, tasks, and subtasks
- Feature branching strategy (task → dev → main)
- Quality gates and completion criteria
- Progress tracking (Claude marks completion as you work)
- Zero technical debt policy (code-complete or not done)
- Automatic README updates and git commits

---

## Table of Contents

1. [Quick Start](#quick-start)
2. [How the Plan Works](#how-the-plan-works)
3. [Git Branching Strategy](#git-branching-strategy)
4. [Quality Standards](#quality-standards)
5. [Progress Tracking](#progress-tracking)
6. [The Prompt Sequence](#the-prompt-sequence)

---

## Quick Start

### Prerequisites

✅ You have a completed SYSTEM_BLUEPRINT.md (use `/create-blueprint`)
✅ You have a new project repository set up
✅ Claude Code is installed and authenticated
✅ You're ready to start building

### Generate Your Dev Plan

**Step 1:** Copy your SYSTEM_BLUEPRINT.md to your new project repo

**Step 2:** In Claude Code, say:

```
"I have a completed SYSTEM_BLUEPRINT.md and I'm ready to generate a
bulletproof development plan. Please read my blueprint and create a
comprehensive DEV_PLAN.md following the Development Plan Generator
process from the ClaudeGo docs/DEV_PLAN_GUIDE.md."
```

**Step 3:** Claude will generate your DEV_PLAN.md with all phases, tasks, and subtasks

**Step 4:** Review and approve the plan

**Step 5:** Start development:

```
"Let's begin Phase 1, Task 1"
```

Claude will create the feature branch, guide you through the work, enforce quality gates, and handle all git operations.

---

## How the Plan Works

### Structure

```
DEV_PLAN.md
│
├── Phase 1: Foundation
│   ├── Task 1.1: Project Setup
│   │   ├── Subtask 1.1.1: Initialize repository
│   │   ├── Subtask 1.1.2: Configure package.json
│   │   └── Subtask 1.1.3: Set up linting
│   ├── Task 1.2: Database Setup
│   └── Task 1.3: Authentication
│
├── Phase 2: Core Features
│   ├── Task 2.1: User Management
│   └── Task 2.2: Main Feature
│
└── Phase 3: Polish & Deploy
    ├── Task 3.1: Testing
    └── Task 3.2: Deployment
```

### Phase Structure

Each phase has:
- **Goal:** What this phase accomplishes
- **Success Criteria:** How you know the phase is complete
- **Tasks:** Numbered tasks that make up the phase
- **Merge Target:** `dev` branch (all tasks merge here)

### Task Structure

Each task has:
- **Objective:** Clear description of what to build
- **Feature Branch:** `feature/task-X.Y-description`
- **Subtasks:** Step-by-step breakdown
- **Quality Gates:** Must pass before completion
- **Completion Criteria:** Concrete checklist
- **Status:** ⏳ Pending | 🔄 In Progress | ✅ Complete

### Subtask Structure

Each subtask has:
- **Action:** Specific thing to do
- **Expected Outcome:** What should exist after
- **Verification:** How to test it works
- **Status:** ⏳ | 🔄 | ✅

---

## Git Branching Strategy

### Branch Structure

```
main (production)
 │
 └── dev (integration)
      ├── feature/task-1.1-project-setup
      ├── feature/task-1.2-database-setup
      ├── feature/task-1.3-authentication
      ├── feature/task-2.1-user-management
      └── ...
```

### Workflow

**For Each Task:**

1. **Create Feature Branch**
   ```bash
   git checkout dev
   git pull origin dev
   git checkout -b feature/task-X.Y-description
   ```

2. **Work on Subtasks**
   - Complete each subtask
   - Commit frequently with clear messages
   - Claude marks subtask complete in DEV_PLAN.md

3. **Complete Task Quality Gates**
   - All subtasks ✅
   - All tests passing
   - Code reviewed (self-review or pair)
   - Documentation updated
   - No TODOs or FIXMEs
   - Zero technical debt

4. **Merge to Dev**
   ```bash
   git checkout dev
   git merge feature/task-X.Y-description --no-ff
   git push origin dev
   git branch -d feature/task-X.Y-description
   ```

5. **Update Plan & README**
   - Claude marks task ✅ in DEV_PLAN.md
   - Claude updates README with new features
   - Commit and push

**After Phase Completion:**

All phase tasks complete → Dev is stable → Merge dev to main

```bash
git checkout main
git merge dev --no-ff -m "Complete Phase X: [Phase Name]"
git push origin main
git tag v0.X.0
git push origin v0.X.0
```

### Commit Message Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Formatting (no code change)
- `refactor`: Code change (no feature/bug)
- `test`: Adding tests
- `chore`: Build process, dependencies

**Example:**
```
feat(auth): implement JWT authentication

- Add login endpoint
- Add token validation middleware
- Add refresh token logic

Task 1.3.2 complete
```

---

## Quality Standards

### Zero Technical Debt Policy

**Definition:** A task is NOT complete until it is code-complete.

**Code-Complete Means:**

✅ **Functionality:** Feature works as specified
✅ **Tests:** Adequate test coverage (unit + integration)
✅ **Documentation:** Code comments, README updates, API docs
✅ **Error Handling:** All edge cases handled
✅ **Validation:** All inputs validated
✅ **Performance:** No obvious performance issues
✅ **Security:** No security vulnerabilities
✅ **Code Quality:** Linting passes, no warnings
✅ **Clean Code:** No TODOs, no FIXMEs, no commented code
✅ **Dependencies:** No unnecessary dependencies

**Claude Enforces:**

If you try to mark a task complete without meeting ALL criteria, Claude will:
1. Review the code
2. Identify what's missing
3. Refuse to mark task complete
4. Tell you exactly what needs to be done

**Example:**

```
User: "Task 1.3 is done, let's merge to dev"

Claude: "I'm reviewing Task 1.3 before marking complete...

❌ Task 1.3 is NOT code-complete. Issues found:

1. Missing error handling in login endpoint (auth.ts:45)
2. No unit tests for token validation middleware
3. Password not validated for minimum length
4. TODO comment on line 67: 'implement rate limiting'
5. README not updated with authentication setup

Task 1.3 remains 🔄 In Progress.

Would you like me to help fix these issues?"
```

### Quality Gates (Per Task)

Before merging any task to dev, ALL must pass:

**1. Code Quality Gate**
- [ ] Linter passes (no errors, no warnings)
- [ ] Type checking passes (if using TypeScript)
- [ ] No console.logs (use proper logging)
- [ ] No commented-out code
- [ ] No TODOs or FIXMEs
- [ ] Consistent formatting

**2. Testing Gate**
- [ ] Unit tests written and passing
- [ ] Integration tests (if applicable)
- [ ] Edge cases covered
- [ ] Error cases tested
- [ ] Test coverage meets minimum (60%+ for critical code)

**3. Documentation Gate**
- [ ] Code comments for complex logic
- [ ] API endpoints documented (if applicable)
- [ ] README updated with new features
- [ ] Environment variables documented (if added)
- [ ] Usage examples provided

**4. Security Gate**
- [ ] All inputs validated
- [ ] SQL injection protected (parameterized queries)
- [ ] XSS protected (sanitization)
- [ ] Authentication/authorization implemented
- [ ] Secrets not committed (env variables)
- [ ] No sensitive data in logs

**5. Functionality Gate**
- [ ] Feature works as specified
- [ ] All subtasks completed
- [ ] Manual testing performed
- [ ] Edge cases work correctly
- [ ] Error messages are user-friendly

**6. Performance Gate**
- [ ] No obvious N+1 queries
- [ ] Database indexes added (if needed)
- [ ] Large data handled efficiently
- [ ] No memory leaks (in long-running processes)

**Claude's Role:**

After you say "Task X.Y is complete", Claude will:
1. Review the code changes
2. Check each quality gate
3. Run tests (if possible)
4. Verify completion criteria
5. Either:
   - ✅ Approve and mark complete
   - ❌ Reject and list what's missing

---

## Progress Tracking

### Ask Claude Anytime

**"Where are we?"**

```
Claude: "Current Progress:

📍 Phase 2: Core Features (In Progress)
   ✅ Task 2.1: User Management (Complete)
   ✅ Task 2.2: Task Creation (Complete)
   🔄 Task 2.3: Real-time Updates (In Progress)
      ✅ Subtask 2.3.1: WebSocket server setup
      ✅ Subtask 2.3.2: Client connection logic
      🔄 Subtask 2.3.3: Event broadcasting (Current)
      ⏳ Subtask 2.3.4: Reconnection handling
   ⏳ Task 2.4: File Attachments (Pending)

Overall Progress: 12/25 tasks complete (48%)
Current Branch: feature/task-2.3-realtime-updates"
```

**"What's next?"**

```
Claude: "Next Up:

Current: Subtask 2.3.3 - Event broadcasting
- Implement Redis pub/sub for WebSocket events
- Test with multiple clients
- Handle room-based broadcasting

After this subtask:
→ Subtask 2.3.4: Reconnection handling
→ Complete Task 2.3 quality gates
→ Merge to dev
→ Begin Task 2.4: File Attachments"
```

**"Show me Phase 3"**

```
Claude: "Phase 3: Polish & Deploy

Status: ⏳ Pending (0/4 tasks complete)

Tasks:
⏳ Task 3.1: Testing Suite
⏳ Task 3.2: Performance Optimization
⏳ Task 3.3: Production Deployment
⏳ Task 3.4: Monitoring Setup

Estimated Start: After Phase 2 complete
Dependencies: All Phase 2 features working"
```

### Status Indicators

**Phases:**
- ⏳ **Pending** - Not started
- 🔄 **In Progress** - At least one task started
- ✅ **Complete** - All tasks complete, merged to main

**Tasks:**
- ⏳ **Pending** - Not started, no branch
- 🔄 **In Progress** - Feature branch exists, work underway
- ✅ **Complete** - Quality gates passed, merged to dev

**Subtasks:**
- ⏳ **Pending** - Not started
- 🔄 **In Progress** - Currently working on this
- ✅ **Complete** - Done and verified

### Plan Document Updates

Claude automatically updates DEV_PLAN.md as you progress:

**When Starting a Task:**
- Changes task status from ⏳ to 🔄
- Records branch name
- Records start date
- Commits: "Start Task X.Y: [description]"

**When Completing a Subtask:**
- Changes subtask status to ✅
- Records completion time
- Commits: "Complete Subtask X.Y.Z"

**When Completing a Task:**
- Changes task status to ✅
- Records merge commit
- Updates README with new features
- Commits: "Complete Task X.Y: [description]"

**When Completing a Phase:**
- Changes phase status to ✅
- Creates summary of what was built
- Creates git tag
- Commits: "Complete Phase X: [phase name]"

---

## The Prompt Sequence

### Part 1: Generate the Development Plan

**Prompt to Claude:**

```
I have a completed SYSTEM_BLUEPRINT.md in this repository. I need you to
generate a comprehensive, bulletproof development plan (DEV_PLAN.md) that
transforms the blueprint into executable work.

Follow these requirements:

1. STRUCTURE
   - Break the project into 3-5 numbered phases
   - Break each phase into numbered tasks (e.g., Task 1.1, 1.2, 1.3)
   - Break each task into numbered subtasks (e.g., 1.1.1, 1.1.2)
   - Each phase should be cohesive and shippable

2. BRANCHING STRATEGY
   - Each task gets a feature branch: feature/task-X.Y-description
   - All tasks merge to 'dev' branch
   - Phases merge 'dev' to 'main' when complete
   - Include exact git commands

3. QUALITY GATES
   - Define concrete completion criteria for each task
   - Include code quality, testing, documentation, security checks
   - Zero technical debt tolerance
   - No TODOs, FIXMEs, or incomplete code allowed

4. PROGRESS TRACKING
   - Add status indicators: ⏳ Pending | 🔄 In Progress | ✅ Complete
   - Include "Current Progress" section at top
   - Enable "where are we?" queries

5. METADATA
   - Estimated time for each task
   - Dependencies between tasks
   - Order of execution
   - Blocking vs parallel tasks

Please read my SYSTEM_BLUEPRINT.md and create the DEV_PLAN.md now.
```

**Claude will generate a complete DEV_PLAN.md with all phases, tasks, and subtasks.**

### Part 2: Review and Approve the Plan

**After Claude generates the plan:**

```
Review the plan and tell me:
1. Total estimated timeline
2. Any tasks that could be parallelized
3. Any risks or dependencies I should be aware of
4. Recommendations for order of execution

Then ask if I approve the plan or want adjustments.
```

**Make any needed adjustments, then approve.**

### Part 3: Initialize the Repository

**Prompt:**

```
The plan is approved. Let's initialize the repository for this development plan:

1. Create 'dev' branch from main
2. Create initial commit with:
   - DEV_PLAN.md
   - Updated README with project status section
   - .gitignore if not exists
   - Initial package.json/requirements.txt (based on tech stack)
3. Push to remote
4. Confirm we're ready to start Phase 1, Task 1

After setup, show me the current state and ask if I'm ready to begin.
```

### Part 4: Start Development

**For each task, use this pattern:**

```
Let's begin Task X.Y
```

**Claude will:**
1. Checkout dev, pull latest
2. Create feature branch
3. Update DEV_PLAN.md (mark task 🔄)
4. Commit and push
5. Guide you through each subtask
6. Enforce quality standards
7. Review code before marking complete

**During the task:**

```
"I've completed Subtask X.Y.Z"
```

**Claude will:**
1. Review what you did
2. Verify it meets criteria
3. Mark subtask ✅ in DEV_PLAN.md
4. Commit the change
5. Move to next subtask or complete task

**Complete the task:**

```
"Task X.Y is complete, ready for quality gates"
```

**Claude will:**
1. Run through all quality gates
2. Check code-complete criteria
3. Either:
   - ✅ Approve → merge to dev → update README → push
   - ❌ Reject → list what's missing → stay in task

### Part 5: Complete a Phase

**After all tasks in a phase:**

```
"Phase X is complete, merge to main"
```

**Claude will:**
1. Verify all phase tasks ✅
2. Checkout main
3. Merge dev to main
4. Create git tag (v0.X.0)
5. Update DEV_PLAN.md (mark phase ✅)
6. Push to remote
7. Celebrate! 🎉

### Part 6: Progress Checks (Anytime)

```
"Where are we?"
→ Shows current phase, task, subtask

"What's next?"
→ Shows upcoming work

"Show me Phase X"
→ Details of specific phase

"Show progress summary"
→ Overall completion percentage
```

---

## Example DEV_PLAN.md Structure

Here's what Claude will generate:

```markdown
# Development Plan: [Project Name]

**Generated from:** SYSTEM_BLUEPRINT.md v1.0
**Generated on:** 2025-10-16
**Estimated Timeline:** 12 weeks
**Current Status:** Phase 1, Task 1.1 🔄 In Progress

---

## Current Progress

**Overall:** 2/25 tasks complete (8%)

**Phase 1: Foundation** 🔄 In Progress (2/6 tasks complete)
- ✅ Task 1.1: Project Setup
- ✅ Task 1.2: Database Setup
- 🔄 Task 1.3: Authentication (Current)
- ⏳ Task 1.4: API Foundation
- ⏳ Task 1.5: Error Handling
- ⏳ Task 1.6: Logging

**Phase 2: Core Features** ⏳ Pending (0/8 tasks)
**Phase 3: Advanced Features** ⏳ Pending (0/6 tasks)
**Phase 4: Polish** ⏳ Pending (0/3 tasks)
**Phase 5: Deploy** ⏳ Pending (0/2 tasks)

**Current Branch:** feature/task-1.3-authentication
**Last Updated:** 2025-10-16 14:32:00

---

## Git Workflow Summary

```
main (production)
 └── dev (integration)
      └── feature/task-X.Y-description (current work)
```

**Branch per task → Merge to dev → Phase complete → Merge to main**

---

## Phase 1: Foundation

**Goal:** Set up project infrastructure, database, authentication, and core API structure

**Success Criteria:**
- [ ] Project builds without errors
- [ ] Database connected and migrations working
- [ ] Authentication endpoints functional and tested
- [ ] API foundation with error handling and logging
- [ ] All tests passing
- [ ] Documentation complete

**Estimated Time:** 2 weeks

**Merge Target:** dev → main after all tasks complete

---

### Task 1.1: Project Setup ✅

**Status:** ✅ Complete
**Branch:** feature/task-1.1-project-setup (merged)
**Time Estimate:** 4 hours
**Actual Time:** 3.5 hours
**Started:** 2025-10-15 09:00
**Completed:** 2025-10-15 12:30

**Objective:** Initialize repository structure, package management, linting, and basic configuration

**Subtasks:**

#### 1.1.1: Initialize Repository ✅
- **Action:** Create repository structure with proper folders
- **Expected Outcome:**
  - src/, tests/, docs/ folders exist
  - .gitignore configured
  - README with project overview
- **Verification:** `ls -la` shows structure
- **Status:** ✅ Complete
- **Time:** 30 min

#### 1.1.2: Configure Package Management ✅
- **Action:** Set up package.json with scripts and dependencies
- **Expected Outcome:**
  - package.json with name, version, scripts
  - npm install works
  - npm run dev starts server
- **Verification:** `npm run dev` starts successfully
- **Status:** ✅ Complete
- **Time:** 1 hour

#### 1.1.3: Set Up Linting and Formatting ✅
- **Action:** Configure ESLint, Prettier, and pre-commit hooks
- **Expected Outcome:**
  - .eslintrc.js configured
  - .prettierrc configured
  - Husky pre-commit hook runs linting
  - npm run lint works
- **Verification:** `npm run lint` passes, commit triggers hook
- **Status:** ✅ Complete
- **Time:** 1 hour

#### 1.1.4: Configure TypeScript ✅
- **Action:** Set up TypeScript with strict mode
- **Expected Outcome:**
  - tsconfig.json with strict settings
  - npm run build compiles successfully
  - Type checking works
- **Verification:** `npm run build` succeeds
- **Status:** ✅ Complete
- **Time:** 1 hour

**Quality Gates:**
- [x] Linter passes with no warnings
- [x] TypeScript compiles with strict mode
- [x] Pre-commit hooks work
- [x] README documents setup process
- [x] No TODOs or FIXMEs

**Completion Criteria:**
- [x] All subtasks complete
- [x] Repository structure follows best practices
- [x] New developers can clone and run
- [x] CI/CD foundation ready
- [x] Quality gates passed

**Merged to dev:** 2025-10-15 12:45 (commit abc123)

---

### Task 1.2: Database Setup ✅

**Status:** ✅ Complete
**Branch:** feature/task-1.2-database-setup (merged)
**Time Estimate:** 6 hours
**Actual Time:** 5 hours
**Started:** 2025-10-15 13:00
**Completed:** 2025-10-15 18:00

**Objective:** Set up PostgreSQL database, ORM, migrations, and seed data

**Subtasks:**

#### 1.2.1: Install and Configure Prisma ✅
- **Action:** Install Prisma, configure connection
- **Expected Outcome:**
  - Prisma installed
  - .env with DATABASE_URL
  - prisma/schema.prisma exists
  - Connection works
- **Verification:** `npx prisma db pull` connects
- **Status:** ✅ Complete
- **Time:** 1 hour

#### 1.2.2: Create Initial Schema ✅
- **Action:** Define User, Team models from blueprint
- **Expected Outcome:**
  - schema.prisma with models
  - Relationships defined
  - Indexes added
- **Verification:** `npx prisma validate` passes
- **Status:** ✅ Complete
- **Time:** 2 hours

#### 1.2.3: Create and Run Migrations ✅
- **Action:** Generate initial migration, apply to DB
- **Expected Outcome:**
  - Migration file created
  - Database tables exist
  - Migration history tracked
- **Verification:** `npx prisma migrate dev` succeeds
- **Status:** ✅ Complete
- **Time:** 1 hour

#### 1.2.4: Create Seed Data ✅
- **Action:** Write seed script for development
- **Expected Outcome:**
  - prisma/seed.ts with test data
  - npm run seed works
  - Test users and teams created
- **Verification:** `npm run seed` populates DB
- **Status:** ✅ Complete
- **Time:** 1 hour

**Quality Gates:**
- [x] Schema matches blueprint data models
- [x] All indexes defined
- [x] Migrations run cleanly
- [x] Seed data is realistic
- [x] Documentation added to README
- [x] Connection pooling configured

**Completion Criteria:**
- [x] All subtasks complete
- [x] Database accessible from application
- [x] Migrations reversible
- [x] Seed data for testing
- [x] Documentation complete

**Merged to dev:** 2025-10-15 18:15 (commit def456)

---

### Task 1.3: Authentication 🔄

**Status:** 🔄 In Progress
**Branch:** feature/task-1.3-authentication (current)
**Time Estimate:** 8 hours
**Actual Time:** 5 hours (so far)
**Started:** 2025-10-16 09:00
**Estimated Completion:** 2025-10-16 17:00

**Objective:** Implement JWT authentication with login, registration, and token refresh

**Dependencies:** Task 1.2 (Database Setup)

**Subtasks:**

#### 1.3.1: Create Auth Models and Database Tables ✅
- **Action:** Add auth-related fields to User model
- **Expected Outcome:**
  - password_hash field
  - refresh_token field
  - Migration created and applied
- **Verification:** Fields exist in database
- **Status:** ✅ Complete
- **Time:** 1 hour

#### 1.3.2: Implement Password Hashing 🔄
- **Action:** Add bcrypt for password hashing
- **Expected Outcome:**
  - hashPassword function
  - comparePassword function
  - Cost factor = 12
  - Unit tests passing
- **Verification:** Test hashing and comparison
- **Status:** 🔄 In Progress (Current)
- **Time:** 1.5 hours (estimated)

#### 1.3.3: Create JWT Token Service ⏳
- **Action:** Implement JWT generation and validation
- **Expected Outcome:**
  - generateAccessToken function
  - generateRefreshToken function
  - verifyToken function
  - 15-min access, 30-day refresh
  - Unit tests
- **Verification:** Tokens generate and validate
- **Status:** ⏳ Pending
- **Time:** 2 hours (estimated)

#### 1.3.4: Build Registration Endpoint ⏳
- **Action:** POST /api/auth/register
- **Expected Outcome:**
  - Email validation
  - Password strength check
  - Hash password
  - Create user
  - Return tokens
  - Integration test
- **Verification:** Can register new user via API
- **Status:** ⏳ Pending
- **Time:** 1.5 hours (estimated)

#### 1.3.5: Build Login Endpoint ⏳
- **Action:** POST /api/auth/login
- **Expected Outcome:**
  - Validate credentials
  - Generate tokens
  - Store refresh token
  - Return tokens in httpOnly cookies
  - Integration test
- **Verification:** Can login with credentials
- **Status:** ⏳ Pending
- **Time:** 1 hour (estimated)

#### 1.3.6: Create Auth Middleware ⏳
- **Action:** Middleware to protect routes
- **Expected Outcome:**
  - requireAuth middleware
  - Extract and validate JWT
  - Attach user to request
  - Error handling
  - Unit tests
- **Verification:** Protected routes require auth
- **Status:** ⏳ Pending
- **Time:** 1 hour (estimated)

**Quality Gates:**
- [ ] All subtasks complete
- [ ] All endpoints tested (unit + integration)
- [ ] Password security best practices followed
- [ ] Token expiration works correctly
- [ ] Error messages don't leak info
- [ ] Documentation updated
- [ ] No TODOs or FIXMEs
- [ ] Code reviewed (self-review checklist)

**Completion Criteria:**
- [ ] Users can register
- [ ] Users can login
- [ ] JWT tokens work correctly
- [ ] Protected routes require valid token
- [ ] Refresh token rotation works
- [ ] All tests passing
- [ ] Security review complete

**Blocked By:** None
**Blocks:** Task 1.4 (API Foundation needs auth)

---

### Task 1.4: API Foundation ⏳

**Status:** ⏳ Pending
**Branch:** Not created yet
**Time Estimate:** 6 hours
**Dependencies:** Task 1.3 (Authentication)

**Objective:** Set up API route structure, request validation, and response formatting

[... continues with same detail ...]

---

### Task 1.5: Error Handling ⏳
### Task 1.6: Logging ⏳

---

## Phase 2: Core Features ⏳

[... continues with all tasks ...]

---

## Phase 3: Advanced Features ⏳
## Phase 4: Polish ⏳
## Phase 5: Deploy ⏳

---

## Appendix: Quality Checklists

### Code Complete Checklist (Per Task)

Before marking any task complete:

**Functionality:**
- [ ] Feature works as specified
- [ ] All subtasks complete
- [ ] Manual testing done
- [ ] Edge cases handled
- [ ] Error cases handled

**Testing:**
- [ ] Unit tests written and passing
- [ ] Integration tests (if applicable)
- [ ] Test coverage adequate (60%+ for critical code)
- [ ] Edge cases tested
- [ ] Error cases tested

**Code Quality:**
- [ ] Linter passes (no errors, no warnings)
- [ ] Type checking passes (if TypeScript)
- [ ] No console.logs (proper logging used)
- [ ] No commented-out code
- [ ] No TODOs or FIXMEs
- [ ] Consistent formatting

**Documentation:**
- [ ] Code comments for complex logic
- [ ] API endpoints documented
- [ ] README updated
- [ ] Environment variables documented
- [ ] Usage examples provided

**Security:**
- [ ] All inputs validated
- [ ] SQL injection protected
- [ ] XSS protected
- [ ] Auth/authz implemented
- [ ] Secrets not committed
- [ ] No sensitive data in logs

**Performance:**
- [ ] No N+1 queries
- [ ] Database indexes added
- [ ] Efficient algorithms used
- [ ] No memory leaks

---

## Appendix: Git Command Reference

### Starting a Task
```bash
git checkout dev
git pull origin dev
git checkout -b feature/task-X.Y-description
```

### During Task (Frequent Commits)
```bash
git add .
git commit -m "feat(scope): description

- Detail 1
- Detail 2

Subtask X.Y.Z complete"
git push origin feature/task-X.Y-description
```

### Completing a Task
```bash
# Ensure all committed
git status

# Switch to dev
git checkout dev
git pull origin dev

# Merge feature
git merge feature/task-X.Y-description --no-ff -m "Complete Task X.Y: [description]"

# Push
git push origin dev

# Delete feature branch
git branch -d feature/task-X.Y-description
git push origin --delete feature/task-X.Y-description
```

### Completing a Phase
```bash
# Ensure dev is clean
git checkout dev
git pull origin dev

# Merge to main
git checkout main
git pull origin main
git merge dev --no-ff -m "Complete Phase X: [phase name]"

# Tag
git tag -a v0.X.0 -m "Phase X: [phase name]"

# Push
git push origin main
git push origin v0.X.0
```

---

**End of DEV_PLAN.md Structure**
```

---

## Usage Tips

### For Best Results

1. **Be Specific with Claude**
   - "Task 1.3 Subtask 2 is done" is better than "I finished the auth thing"
   - Claude tracks exact numbering

2. **Trust the Quality Gates**
   - If Claude says it's not code-complete, it's not
   - Fix the issues rather than arguing
   - Zero tech debt pays off later

3. **Commit Frequently**
   - After each meaningful change
   - Claude helps with commit messages
   - Easier to revert if needed

4. **Keep README Updated**
   - Claude does this automatically after each task
   - Always reflects current state
   - New contributors can onboard easily

5. **Ask for Help**
   - "How should I implement Subtask X.Y.Z?"
   - "What's the best approach for this?"
   - Claude has context from the blueprint

### Common Commands

```
"Let's begin Task X.Y"
"Subtask X.Y.Z is complete"
"Task X.Y is ready for quality review"
"Where are we?"
"What's next?"
"Show me the completion criteria for this task"
"Help me with Subtask X.Y.Z"
"What are the quality gates for this task?"
```

---

## Advantages of This Approach

✅ **Zero Ambiguity** - Every task has clear completion criteria
✅ **Progress Tracking** - Always know exactly where you are
✅ **Quality Enforced** - Can't merge incomplete work
✅ **Git Discipline** - Consistent branching and commits
✅ **Documentation** - README always up-to-date
✅ **Collaboration Ready** - Clear for team members to follow
✅ **Audit Trail** - Complete history of what was built when
✅ **Resumable** - Can pause and resume anytime
✅ **Learning Tool** - Claude explains best practices as you go

---

## Next Steps

Ready to turn your blueprint into a development plan?

1. Copy your SYSTEM_BLUEPRINT.md to your new project repo
2. Use the prompt sequence above
3. Review and approve the generated DEV_PLAN.md
4. Start building!

**Remember:** Code-complete or not complete. No compromises. Ship quality. 🚀
