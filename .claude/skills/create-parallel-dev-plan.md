# Create Parallel Development Plan (3-4x Faster!)

You are helping the user transform their SYSTEM_BLUEPRINT.md into a parallel execution development plan that leverages Claude's multi-agent capabilities to complete tasks simultaneously, reducing project timeline by 50-70%.

## Your Role

Generate an advanced development plan with:
- **Dependency analysis** - Identify which tasks can run in parallel
- **Parallel batches** - Group independent tasks for simultaneous execution
- **Conflict prevention** - Ensure parallel tasks don't touch same files
- **Quality gates** - Same strict standards as sequential plans
- **Merge coordination** - Handle parallel branch merges systematically

## Prerequisites

Before starting, verify:
- ✅ User has a completed SYSTEM_BLUEPRINT.md
- ✅ User has a project repository set up
- ✅ User understands parallel execution benefits and complexity
- ✅ Project has sufficient independent work to benefit (15+ tasks)

## The Generation Process

### Step 1: Read and Analyze Blueprint

Read the SYSTEM_BLUEPRINT.md and identify all major features and tasks.

### Step 2: Dependency Analysis

For each task, identify:
- **Infrastructure dependencies** - Requires X to be set up first
- **Data dependencies** - Needs models/schemas from another task
- **File dependencies** - Modifies same files as another task
- **Independent tasks** - No dependencies, can run anytime

### Step 3: Create Parallel Batches

Group tasks into batches:

**Batch Structure:**
```
Batch X.A - Sequential (Foundation)
└── Task X.1: Project setup (must complete first)

Batch X.B - Parallel (Independent Features)
├── Task X.2: User management (parallel)
├── Task X.3: Email service (parallel)
├── Task X.4: File upload (parallel)
└── Task X.5: Logging system (parallel)

Batch X.C - Sequential (Integration)
└── Task X.6: Integrate all features (after parallel work)
```

### Step 4: Calculate Time Savings

For each phase, show:
- Sequential time: Sum of all task estimates
- Parallel time: Max time in each batch
- Time savings: Percentage reduction

**Example:**
```
Phase 1: Foundation
- Sequential: 15 hours
- Parallel: 6 hours (2h + 4h batches)
- Savings: 60%
```

### Step 5: Conflict Prevention Strategy

For each parallel batch, verify:
- No two tasks modify the same files
- Each task has isolated feature branch
- Merge order is documented
- Test coverage prevents integration issues

### Step 6: Quality Gates (Same Standards)

Every task must be code-complete:
- ✅ All functionality working
- ✅ Tests passing (unit + integration)
- ✅ Documentation complete
- ✅ No TODOs or FIXMEs
- ✅ Linting clean
- ✅ Security validated

## Output Format

Generate a DEV_PLAN.md with parallel execution structure:

```markdown
# Parallel Development Plan: [Project Name]

## Execution Strategy

**Parallel Execution Benefits:**
- 🚀 Sequential time: [X] hours
- 🚀 Parallel time: [Y] hours
- 🚀 Time savings: [Z]%

**Approach:**
- Tasks grouped into parallel batches
- Multiple agents work simultaneously
- Automatic conflict prevention
- Coordinated merges after batch completion

## Git Branching Strategy

```
main (production)
 │
 └── dev (integration)
      │
      ├─ Batch 1.A (Sequential)
      │  └── feature/task-1.1-setup
      │
      ├─ Batch 1.B (Parallel - all simultaneous)
      │  ├── feature/task-1.2-auth
      │  ├── feature/task-1.3-email
      │  └── feature/task-1.4-logging
      │
      └─ Batch 1.C (Sequential)
         └── feature/task-1.5-integration
```

## Phase 1: [Phase Name]

**Phase Timeline:**
- Sequential approach: [X] hours
- Parallel approach: [Y] hours
- Time savings: [Z]%

---

### Batch 1.A - Foundation (Sequential)

**Why Sequential:** These tasks set up infrastructure needed by others

#### Task 1.1: [Task Name]
**Branch:** feature/task-1.1-description
**Estimated Time:** [hours]
**Dependencies:** None (start here)

**Subtasks:**
- [ ] 1.1.1: [Step]
- [ ] 1.1.2: [Step]

**Quality Gates:**
[Standard quality gates]

**Status:** ⏳ Not Started

---

### Batch 1.B - Core Features (PARALLEL)

**Why Parallel:** These tasks are independent and touch different files

**Execution:** All tasks in this batch run simultaneously
**Batch Time:** [Max task time] hours (longest task)

#### Task 1.2: [Feature A]
**Branch:** feature/task-1.2-description
**Estimated Time:** [hours]
**Dependencies:** Task 1.1 complete
**Conflicts With:** None (isolated files)

[Subtasks, quality gates, status]

#### Task 1.3: [Feature B]
**Branch:** feature/task-1.3-description
**Estimated Time:** [hours]
**Dependencies:** Task 1.1 complete
**Conflicts With:** None (isolated files)

[Subtasks, quality gates, status]

#### Task 1.4: [Feature C]
[Same structure...]

---

### Batch 1.C - Integration (Sequential)

**Why Sequential:** Requires all Batch 1.B tasks complete

[Task structure...]

---

## Phase 2: [Phase Name]
[Same structure with batches...]

---

## Execution Instructions

### Starting a Parallel Batch

Say: "Let's start Batch 1.B in parallel"

I will:
1. Launch multiple agents (one per task)
2. Each agent works on its feature branch
3. Monitor progress across all agents
4. Coordinate when all complete
5. Merge branches in safe order
6. Verify integration tests pass

### Monitoring Progress

Say: "Show parallel batch status"

I'll show:
```
Batch 1.B Progress:
├── Task 1.2: 🔄 In Progress (Agent 1) - 60%
├── Task 1.3: ✅ Complete (Agent 2)
└── Task 1.4: 🔄 In Progress (Agent 3) - 80%

Batch Status: 2/3 tasks complete
Estimated Completion: 15 minutes
```

### Handling Issues

If a parallel task fails quality gates:
- Other tasks continue
- Failed task must be fixed before batch merges
- I coordinate retries and blockers

## Dependency Graph

```
Task 1.1 (setup)
    ↓
    ├──→ Task 1.2 (auth)  ─┐
    ├──→ Task 1.3 (email) ─┼─→ Task 1.5 (integration)
    └──→ Task 1.4 (logs)  ─┘
```

## Progress Tracking

[Standard tracking same as sequential plan]
```

## Important Guidelines

1. **Accurate dependency analysis** - Wrong dependencies = conflicts
2. **Realistic parallelization** - Not every task can be parallel
3. **File isolation** - Parallel tasks must touch different files
4. **Quality gates enforced** - No shortcuts for parallel work
5. **Clear batch boundaries** - Document why tasks are grouped
6. **Time estimates realistic** - Include parallel coordination overhead
7. **Merge strategy clear** - Document merge order to prevent conflicts

## When to Use Parallel Plans

**✅ Good Candidates:**
- Medium-large projects (15+ tasks)
- Multiple independent features
- Clear module boundaries
- Time-critical delivery
- Experienced team

**❌ Not Recommended:**
- Small projects (<10 tasks)
- Highly coupled architecture
- Single developer learning
- Prototype/MVP phase

## Starting the Process

Begin by asking:

"I'll help you create a parallel development plan that can reduce your project timeline by 50-70%!

This works best for projects with many independent features. Let me read your SYSTEM_BLUEPRINT.md and analyze which tasks can run in parallel.

Is your blueprint in the current directory, or would you like to paste it?"

Then follow the generation process above to create an optimized parallel execution plan.
