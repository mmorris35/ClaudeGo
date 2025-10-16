# System Blueprint Examples

This document shows three complete example blueprints for different project types. Use these as reference when creating your own blueprint.

---

## Table of Contents

1. [Example 1: TaskFlow - Async Task Management SaaS](#example-1-taskflow---async-task-management-saas)
2. [Example 2: MarketConnect - Local Services Marketplace](#example-2-marketconnect---local-services-marketplace)
3. [Example 3: TeamMetrics - Internal Analytics Dashboard](#example-3-teammetrics---internal-analytics-dashboard)

---

# Example 1: TaskFlow - Async Task Management SaaS

**Project Type:** SaaS Product (B2B)
**Team:** 2 full-stack developers
**Timeline:** 3 months to MVP
**Budget:** $500/month infrastructure

---

## Phase 1: Vision & Strategy 👤

### 1.1 Core Vision Statement
```
TaskFlow is a collaborative task management tool designed specifically for remote
teams working across time zones. It enables asynchronous communication and
automatic scheduling, eliminating the need for constant synchronization meetings
while maintaining team alignment.
```

**Problem:** Remote teams with 4+ hour time zone differences waste hours in
synchronization meetings and lose context switching between multiple tools.
Work gets blocked waiting for responses.

**Target Users:** Remote-first teams of 5-50 people with significant time zone spread.

### 1.2 Strategic Goals

**6-month goal:** 500 active users, validate product-market fit, achieve 20% WAU rate

**1-year goal:** 5,000 users, $10K MRR, become go-to tool for async remote teams

**Top 3 Objectives:**
1. Prove core value proposition (users save 5+ hours/week)
2. Build engaged community (20% weekly active users)
3. Achieve sustainability ($5K MRR covers costs)

**Primary Goal:** Generate revenue (SaaS model)

### 1.3 Success Metrics

| Metric | Target | Why It Matters |
|--------|--------|----------------|
| Weekly Active Users | 20% of total | Indicates product stickiness |
| Time Saved Per User | 5+ hours/week | Core value proposition |
| MRR | $10K by month 12 | Sustainability milestone |
| Churn Rate | <5% monthly | User retention indicator |

### 1.4 Market Positioning

**Competitors:**
- Asana (general task management, not async-focused)
- Trello (too simple, not built for distributed teams)
- Monday.com (complex, expensive, enterprise-focused)

**Differentiation:**
- Built specifically for async remote work
- AI-powered timezone scheduling
- Communication embedded in tasks (no context switching)
- Affordable for small teams ($10-20 per user/month)

**Unfair Advantage:**
- Founder managed remote teams for 10 years
- Access to 50-person remote company for beta testing
- Deep understanding of async communication patterns

### 1.5 Constraints & Context

**Team:**
- 2 full-stack developers
- Both experienced with Python and React
- Part-time designer (contractor)
- No dedicated DevOps

**Timeline:**
- MVP in 3 months
- Full-time commitment
- Launch target: September 15 (RemoteWeek conference)

**Budget:**
- Bootstrap (no external funding)
- $500/month max for infrastructure
- Can use free tiers of services

**Technical:**
- Team knows Python, JavaScript, PostgreSQL
- Prefer open-source tools
- No legacy systems to integrate

**Compliance:**
- GDPR compliance needed (EU customers expected)
- Standard security practices sufficient

---

## Phase 2: Product Definition 👤

### 2.1 User Personas

**Persona 1: Remote Team Lead (Sarah)**
- Goal: Coordinate 8-person team across 6 time zones
- Pain Points: Too many meetings, context lost in Slack, unclear task ownership
- Tech Savvy: Medium
- Context: Daily morning planning (30-60 min)
- Success: Reduced meetings, clear team visibility

**Persona 2: Individual Contributor (Dev)**
- Goal: Know what to work on without interruptions
- Pain Points: Meetings interrupt deep work, unclear priorities, too many tools
- Tech Savvy: High
- Context: Check 2-3x per day between coding
- Success: Uninterrupted work time, clear priorities

**Primary Persona:** Remote Team Lead (Sarah)

### 2.2 Core Features

**Feature 1: Task Creation & Assignment**
- Priority: Must-have
- User Story: As a team lead, I want to create and assign tasks so everyone knows responsibilities
- Success: Create task in <30 sec, assignee notified, appears in queue
- Complexity: LOW (2-3 days)

**Feature 2: Async Status Updates**
- Priority: Must-have
- User Story: As a developer, I want to post updates when I finish work without interrupting me
- Success: Post in <1 min, team sees updates, timezone-aware notifications
- Complexity: MEDIUM (5-7 days)

**Feature 3: Dashboard Overview**
- Priority: Must-have
- User Story: As an executive, I want project status at a glance without asking
- Success: Loads <2 sec, shows key metrics, auto-populated
- Complexity: MEDIUM (4-5 days)

**Feature 4: File Attachments**
- Priority: Should-have
- User Story: As a team member, I want to attach context to tasks
- Success: Support images/PDFs, max 10MB, preview for images
- Complexity: MEDIUM (3-4 days)

**Feature 5: Time Zone Scheduler** (Deferred to v1.1)
- Priority: Nice-to-have
- Complexity: HIGH (10-15 days)

**MVP Total:** 20-25 development days

### 2.3 User Flows

**Primary Flow: Team Lead Creates Task**

Happy Path:
1. User logs in → Dashboard
2. Click "New Task"
3. Fill: title, description, assignee (dropdown), due date
4. Click "Create"
5. Task appears in dashboard
6. Assignee gets notification
7. Assignee sees task in queue

Edge Cases:
- Invalid assignee → Show only team members
- Past due date → Allow with warning
- Assignee overloaded → Show warning ("Sarah has 15 open tasks")
- Notification fails → Retry queue + in-app notification

### 2.4 Extensibility Vision

**Level:** Medium (API + webhooks in v2.0)

**Who:** Third-party developers via public API (not MVP)

**What:** Integrations with other services (Slack, GitHub, etc.)

**Timeline:** Post-launch (v2.0) - focus on core product first

**Inspiration:** Like Zapier integrations - pre-built connectors

**Claude's Analysis:** 🤖
```
Extensibility Level: Medium

Implications:
- Architecture: API-first design, clear service boundaries
- Complexity: Adds 2-3 weeks post-MVP
- Timeline: Defer to v2 to hit 3-month MVP
- Ecosystem: Enables integrations without full plugin system

Recommendation:
→ MVP: Build with modularity in mind
→ v2.0 (Month 4-6): Add public REST API + webhooks
→ Future: Consider SDK if demand is high

This approach ships MVP faster while preserving extensibility path.
```

### 2.5 Non-Functional Requirements

**Performance:**
- 100 concurrent users initially → 5K by year 1
- Response time: <2 sec pages, <500ms actions
- Data: ~1GB per 1000 users

**Security:**
- Medium sensitivity (work data, not financial)
- Email/password + Google OAuth
- GDPR compliance

**Scalability:**
- Architecture should handle 10x current load
- Year 1: 5K users, Year 2: 50K users

**Availability:**
- 99.5% uptime target (3.6 hours/month downtime acceptable)
- Maintenance windows during low traffic OK

### 2.6 Out of Scope (MVP)

❌ Mobile apps - Web-first, responsive design
❌ Time tracking - Different use case
❌ Video calls - Use existing tools
❌ Email client - Integrate, don't replace
❌ Gantt charts - Too complex for MVP
❌ Custom branding - Enterprise feature

---

## Phase 3: Technical Architecture 🤖

### 3.1 Architecture Philosophy

**Recommended:** Modular Monolith

**Claude's Reasoning:**
```
✓ Team Size (2 developers)
  → Monolithic deployment manageable
  → Less operational complexity

✓ Timeline (3 months)
  → Proven approach, avoid distributed systems

✓ Extensibility (Medium, v2)
  → Modular design allows future API

✓ Scale (5K users year 1)
  → Single server sufficient
  → Vertical scaling + read replicas later

✓ Features
  → Real-time updates via WebSockets in same process
  → No features requiring service separation
```

**Trade-offs:**

Pros:
+ Faster development (no network overhead)
+ Simpler deployment (one artifact)
+ Easier debugging
+ Lower cost

Cons:
- Features scale together
- One deployment for all changes

**When to Revisit:**
- At 50K+ users
- If specific feature becomes bottleneck
- If team grows to 5+ developers

### 3.2 Technology Stack

**Frontend:** 🤖
- React 18 + TypeScript
- Zustand (state management)
- Tailwind CSS + shadcn/ui
- Vite (build tool)
- Socket.io-client (real-time)

**Why:**
- Team knows React
- TypeScript catches errors early
- Tailwind = fast prototyping
- Vite = instant HMR

**Backend:** 🤖
- Python 3.11 + FastAPI
- SQLAlchemy 2.0 (async ORM)
- JWT + httpOnly cookies
- Celery + Redis (background jobs)
- FastAPI WebSockets + Socket.io

**Why:**
- Team knows Python well
- FastAPI = modern, fast, auto-docs
- Async support for real-time features
- Strong typing (Pydantic)

**Database:** 🤖
- PostgreSQL 15 (primary)
- Redis (cache + jobs + pub/sub)
- Cloudflare R2 (file storage, S3-compatible)
- Alembic (migrations)

**Why:**
- PostgreSQL = reliable, JSONB flexibility
- Redis = multi-purpose (cache, queue, real-time)
- R2 = free egress (cost-effective)

**Infrastructure:** 🤖
- Hosting: Railway ($20-50/month)
- CI/CD: GitHub Actions (free)
- Docker (containerization)
- Cloudflare (DNS, CDN, DDoS protection)

**Why:**
- Railway = easy deployment, affordable
- Built-in PostgreSQL + Redis
- GitHub Actions = integrated, sufficient

**Third-Party Services:** 🤖

| Service | Purpose | Cost | Why |
|---------|---------|------|-----|
| Resend | Transactional email | $0-20/mo | Developer-friendly, good deliverability |
| Sentry | Error tracking | $0 (5K events) | Excellent error grouping |
| PostHog | Analytics | $0 (1M events) | Privacy-friendly, product analytics |
| UptimeRobot | Monitoring | $0 (50 monitors) | Simple uptime monitoring |

**Cost Estimate:**
- Month 1-3 (Dev): $5/month
- Month 4-6 (100-1K users): $85/month
- Month 7-12 (1K-5K users): $245/month

Well within $500/month budget ✅

### 3.3 Data Architecture

**Storage Strategy:**
- Primary: PostgreSQL (all business data)
- Cache: Redis (sessions, frequent queries, rate limits)
- Files: R2 (attachments, avatars)
- Search: PostgreSQL full-text (MVP), consider ElasticSearch at 50K+ users

**Data Flow:**
```
Request → FastAPI → Check Cache (Redis)
                   → Query DB (PostgreSQL) [on cache miss]
                   → Update Cache
                   → Publish Event (Redis Pub/Sub)
                   → WebSocket Push to Clients
```

### 3.4 API Design

**Style:** REST API with OpenAPI docs

**Base URL:** `https://api.taskflow.com/v1/`

**Authentication:** JWT in httpOnly cookies

**Rate Limiting:** 1000 req/hour per user

**Response Format:**
```json
{
  "data": { "id": "...", "title": "..." },
  "meta": { "timestamp": "2025-10-16T12:00:00Z" }
}
```

**Webhooks (v2.0):**
- Events: task.created, task.updated, comment.added
- POST to user-configured URL
- HMAC signature verification
- Retry with exponential backoff

### 3.5 Security Architecture

**Authentication:** 🤖
- Bcrypt hashing (cost 12)
- JWT: 15-min access, 30-day refresh
- Google OAuth
- 2FA with TOTP (v2)

**Authorization:** RBAC
- Roles: owner, admin, member, viewer
- Middleware checks on all routes

**Protection:**
- SQL Injection: ORM parameterized queries
- XSS: CSP headers, React escaping
- CSRF: Tokens, SameSite cookies
- Rate Limiting: 100 req/15min (anonymous), 1000/hour (auth)

**Data Protection:**
- TLS/SSL (force HTTPS)
- Database encryption (Railway managed)
- File encryption (R2 default)

**GDPR:**
- Data export endpoint
- Account deletion (30-day soft delete)
- Cookie consent banner

---

## Phase 4: Data & API Design 🤖

### 4.1 Data Models

**Entity: User**
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY,
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),
  name VARCHAR(255),
  avatar_url TEXT,
  timezone VARCHAR(50) DEFAULT 'UTC',
  google_id VARCHAR(255) UNIQUE,
  email_verified BOOLEAN DEFAULT FALSE,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
CREATE INDEX idx_users_email ON users(email);
```

**Entity: Team**
```sql
CREATE TABLE teams (
  id UUID PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,
  plan VARCHAR(50) DEFAULT 'free',
  created_at TIMESTAMP DEFAULT NOW()
);
```

**Entity: Task**
```sql
CREATE TABLE tasks (
  id UUID PRIMARY KEY,
  team_id UUID REFERENCES teams(id),
  title VARCHAR(200) NOT NULL,
  description TEXT,
  status VARCHAR(50) DEFAULT 'todo',
  assignee_id UUID REFERENCES users(id),
  created_by UUID REFERENCES users(id),
  due_date TIMESTAMP,
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW()
);
CREATE INDEX idx_tasks_team ON tasks(team_id);
CREATE INDEX idx_tasks_status ON tasks(team_id, status);
```

**Other Entities:**
- TeamMembership (join table with roles)
- StatusUpdate (async updates)
- Comment (discussions)
- Attachment (files)
- Notification (in-app alerts)

### 4.2 API Endpoints

**POST /api/v1/auth/register**
```
Request: { "email": "...", "password": "...", "name": "..." }
Response (201): { "data": { "id": "...", "email": "..." }, "meta": { "token": "..." } }
```

**GET /api/v1/tasks**
```
Query: ?status=todo&assignee_id=...&page=1
Response (200): { "data": [...], "meta": { "page": 1, "total": 145 } }
```

**POST /api/v1/tasks**
**GET /api/v1/tasks/:id**
**PATCH /api/v1/tasks/:id**
**DELETE /api/v1/tasks/:id**

_[Full CRUD for all resources]_

**WebSocket:** `wss://taskflow.com/ws`
Events: task.created, task.updated, comment.added

---

## Phase 5: Operations & Quality 🤖

### 5.1 Testing Strategy

- Unit Tests: 60% coverage (core logic)
- Integration: API endpoints, DB
- E2E: Critical flows (Playwright)
- Framework: Pytest (backend), Vitest (frontend)

### 5.2 CI/CD Pipeline

On PR:
1. Lint + Format check
2. Run unit tests
3. Build preview deployment

On Merge:
1. Full test suite
2. Deploy to staging
3. Smoke tests
4. Deploy to production

### 5.3 Monitoring

- Logging: Winston (structured JSON)
- Errors: Sentry (5K events/month free)
- Metrics: Railway built-in
- Uptime: UptimeRobot (every 5 min)
- Health: /health endpoint

---

## Phase 6: Growth Planning 🤖

### 6.1 Scalability Roadmap

**Current Limits:**
- Single server: ~1K concurrent users
- Good until: ~10K total users

**Scaling Triggers:**
- At 5K users: Add Redis caching
- At 10K users: Database read replicas
- At 50K users: Consider service extraction

**Cost Projection:**
- 0-1K: $50/month
- 1K-10K: $200/month
- 10K-50K: $1K/month

### 6.2 Feature Roadmap

**MVP (Month 1-3):**
- Core task management
- Async status updates
- Dashboard
- File attachments

**Post-MVP (Month 4-6):**
- Public API + webhooks
- Slack/GitHub integrations
- Advanced search
- Task templates

**Growth (Month 7-12):**
- Time zone scheduler
- Mobile apps (PWA first)
- Advanced analytics
- Team performance insights

### 6.3 Business Model

**MVP:** Freemium
- Free: 1 team, 5 users, basic features
- Pro: $12/user/month, unlimited teams, integrations, priority support

**Introduce Pricing:** At 500 users (validate PMF first)

**Enterprise (v2):** $25/user/month, SSO, SLA, dedicated support

---

## Summary

**Project:** TaskFlow - Async Task Management for Remote Teams

**Approach:**
- Modular monolith (3-month MVP)
- Python/FastAPI + React/TypeScript
- PostgreSQL + Redis + R2
- Host on Railway ($50-250/month)

**Key Decisions:**
- ✅ Medium extensibility (API in v2, not MVP)
- ✅ Freemium model (introduce at 500 users)
- ✅ Focus on core async features first
- ✅ Defer complex features (time scheduler) to v1.1

**Timeline:**
- Months 1-3: MVP development
- Months 4-6: Beta, API launch, integrations
- Months 7-12: Scale to 5K users, $10K MRR

**This blueprint is ready to use as foundation for development!**

---
---

# Example 2: MarketConnect - Local Services Marketplace

**Project Type:** Two-sided Marketplace (C2C)
**Team:** 1 developer (founder) + 1 part-time designer
**Timeline:** 6 months to MVP
**Budget:** $200/month infrastructure

---

## Phase 1: Vision & Strategy 👤

### 1.1 Core Vision Statement
```
MarketConnect is a local services marketplace connecting homeowners with
trusted service providers (plumbers, electricians, cleaners, etc.) in their
neighborhood. It combines instant booking, transparent pricing, and
community reviews to make hiring local services as easy as ordering food.
```

**Problem:** Finding and booking local service providers is painful - endless
phone calls, unclear pricing, uncertain availability, trust issues.

**Target Users:**
- Homeowners needing services (demand side)
- Local service providers wanting more clients (supply side)

### 1.2 Strategic Goals

**6-month goal:** 50 service providers, 200 bookings, launch in one city

**1-year goal:** 500 providers, 5K bookings, expand to 3 cities, $50K GMV/month

**Top 3 Objectives:**
1. Achieve liquidity (supply matches demand)
2. Build trust through reviews and verification
3. Streamline booking experience (< 2 min to book)

**Primary Goal:** Grow marketplace (network effects, then monetize)

### 1.3 Success Metrics

| Metric | Target | Why It Matters |
|--------|--------|----------------|
| GMV (Gross Merchandise Value) | $50K/month by month 12 | Marketplace health |
| Take Rate | 15% commission | Revenue model |
| Provider Utilization | >60% | Supply side health |
| Booking Completion Rate | >80% | User experience quality |
| Time to First Booking | <48 hours | Onboarding success |

### 1.4 Market Positioning

**Competitors:**
- Thumbtack (complex, too many categories)
- TaskRabbit (tasks, not services)
- Angi/HomeAdvisor (lead gen, not direct booking)
- Craigslist (untrustworthy, manual)

**Differentiation:**
- Instant booking (like OpenTable for services)
- Transparent, upfront pricing
- Neighborhood focus (local trust)
- Simple, focused categories (quality over quantity)

**Unfair Advantage:**
- Founder is licensed contractor (industry knowledge)
- Network of 50+ local providers willing to beta test
- Understanding of provider pain points

### 1.5 Constraints & Context

**Team:**
- 1 founder (full-stack developer)
- 1 part-time designer (contractor, 10 hours/week)
- No marketing budget initially (growth via providers)

**Timeline:**
- MVP in 6 months (longer runway, solo dev)
- Part-time initially (keeping day job first 3 months)
- Launch target: January 2026

**Budget:**
- Bootstrap
- $200/month max infrastructure
- Need to get to revenue quickly

**Technical:**
- Founder knows JavaScript/Node.js, some React
- Prefer full-stack JavaScript (fewer context switches)
- Mobile-first (users book on phones)

**Compliance:**
- Payment processing (Stripe)
- Background checks for providers (future)
- Insurance/liability considerations
- Local regulations (contractor licenses)

---

## Phase 2: Product Definition 👤

### 2.1 User Personas

**Persona 1: Homeowner (Lisa, 35, Busy Professional)**
- Goal: Find and book reliable plumber for leaky faucet ASAP
- Pain Points: Don't know who to trust, pricing uncertainty, hard to schedule
- Tech Savvy: Medium
- Context: Mobile phone, evenings/weekends
- Success: Book in <5 min, provider shows up on time, fair price

**Persona 2: Service Provider (Mike, 42, Independent Plumber)**
- Goal: Fill schedule gaps, get more clients without expensive ads
- Pain Points: Slow seasons, marketing costs, no-shows, payment delays
- Tech Savvy: Low-Medium
- Context: Mobile phone between jobs
- Success: Steady bookings, quick payment, no platform hassles

**Primary Persona:** Homeowner (demand creates supply)

### 2.2 Core Features

**Feature 1: Provider Search & Discovery**
- Priority: Must-have
- User Story: As a homeowner, I want to find available plumbers near me so I can book quickly
- Success: See 5+ available providers, filter by rating/price/availability
- Complexity: MEDIUM (7-10 days)

**Feature 2: Instant Booking**
- Priority: Must-have
- User Story: As a homeowner, I want to book a time slot so I don't have to play phone tag
- Success: Book in <2 min, instant confirmation, calendar sync
- Complexity: HIGH (10-12 days)

**Feature 3: Payment Processing**
- Priority: Must-have
- User Story: As a homeowner, I want to pay securely and as a provider want quick payouts
- Success: Pay with card, hold funds until service complete, payout in 2 days
- Complexity: MEDIUM (8-10 days with Stripe)

**Feature 4: Reviews & Ratings**
- Priority: Must-have
- User Story: As a homeowner, I want to see reviews so I know who to trust
- Success: View ratings, read recent reviews, filter by rating
- Complexity: LOW-MEDIUM (5-7 days)

**Feature 5: Provider Dashboard**
- Priority: Must-have
- User Story: As a provider, I want to manage bookings and availability
- Success: Accept/decline bookings, set availability, view earnings
- Complexity: MEDIUM (7-9 days)

**Feature 6: SMS Notifications**
- Priority: Should-have
- User Story: As both sides, I want SMS reminders so we don't miss appointments
- Success: Booking confirmations, day-before reminders, status updates
- Complexity: LOW (3-4 days with Twilio)

**MVP Total:** ~50-55 development days (realistic for solo dev over 6 months)

### 2.3 User Flows

**Primary Flow: Homeowner Books Service**

1. Land on homepage → Enter zip code + service type
2. See list of available providers (photo, rating, price, next availability)
3. Click provider → View profile (bio, reviews, pricing, photos of past work)
4. Click "Book Now" → Select date/time from calendar
5. Enter service details (description, photos optional)
6. Add payment method → Confirm booking
7. Receive confirmation (email + SMS)
8. Provider accepts → Final confirmation
9. Service completed → Rate & review

**Provider Flow: Accept Booking**

1. Receive notification of new booking request
2. View job details (location, time, homeowner info, price)
3. Accept or decline (with reason)
4. Complete service → Mark as complete
5. Receive payment (2-day payout)

### 2.4 Extensibility Vision

**Level:** Low (internal only for MVP)

**Who:** Just the founder/team initially

**What:** Not focused on extensibility - focused on core marketplace

**Timeline:** Maybe v3+ if successful

**Claude's Analysis:** 🤖
```
Extensibility Level: Low

Given:
- Solo developer with 6-month timeline
- Marketplace requires focus on supply/demand balance
- Limited resources

Recommendation:
→ Build focused, monolithic app
→ Don't over-engineer for extensibility
→ If successful, can add API for partners later (e.g., property mgmt companies)

This is the right call - marketplace mechanics are complex enough.
```

### 2.5 Non-Functional Requirements

**Performance:**
- 50 concurrent users initially → 1K by year 1
- Mobile-first (80% traffic from phones)
- Fast load times critical (<3 sec initial, <1 sec navigation)

**Security:**
- High sensitivity (payment data via Stripe, addresses)
- Phone/email verification for both sides
- Background checks for providers (future, use Checkr API)

**Scalability:**
- Start local (one city)
- Architecture should support multi-city expansion
- Year 1: 500 providers, 5K bookings

**Availability:**
- 99% uptime sufficient (booking marketplace, not critical infrastructure)
- Downtime during low-traffic hours acceptable

### 2.6 Out of Scope (MVP)

❌ Background checks - Manual verification initially
❌ In-app messaging - Use phone/SMS
❌ Provider scheduling tools - They manage own calendars
❌ Subscription plans - Focus on transaction fees
❌ Multiple service packages - Simple hourly rate
❌ Dispute resolution system - Manual initially

---

## Phase 3: Technical Architecture 🤖

### 3.1 Architecture Philosophy

**Recommended:** Monolith (with clear service boundaries)

**Claude's Reasoning:**
```
✓ Solo Developer
  → Simplest possible architecture
  → No distributed systems overhead
  → Faster iteration

✓ Timeline (6 months, part-time initially)
  → Need to ship fast
  → Proven technologies only

✓ Extensibility (Low)
  → Don't need plugin system
  → Monolith is perfect

✓ Scale (500 providers year 1)
  → Way under monolith limits
  → Can add replicas if needed
```

**Trade-offs:**

Pros:
+ Fastest development for solo dev
+ Simple deployment
+ Easy to debug
+ Low infrastructure cost

Cons:
- Harder to scale specific features independently (not a concern yet)

**When to Revisit:**
- At 10K+ providers (unlikely for years)
- If specific feature needs separation

### 3.2 Technology Stack

**Frontend:** 🤖
- Next.js 14 (React framework)
- TypeScript
- Tailwind CSS
- React Query (server state)
- Mobile-first responsive design

**Why:**
- Next.js = full-stack in one framework (less context switching)
- Server-side rendering = better SEO (critical for marketplace)
- Single language (JavaScript/TypeScript)
- Fast development for solo dev

**Backend:** 🤖
- Next.js API routes (serverless functions)
- Prisma (ORM)
- NextAuth.js (authentication)
- Stripe SDK (payments)
- Twilio SDK (SMS)

**Why:**
- Next.js API routes = no separate backend server
- Prisma = great DX, type-safe
- All in JavaScript (consistent)

**Database:** 🤖
- PostgreSQL (primary via Vercel Postgres)
- Redis (optional, for caching later)
- S3-compatible (R2) for images

**Why:**
- PostgreSQL = reliable, good for bookings/transactions
- Managed by hosting platform (less ops)

**Infrastructure:** 🤖
- Hosting: Vercel ($20/month Pro plan)
- Database: Vercel Postgres ($10-30/month)
- Email: Resend ($0-10/month)
- SMS: Twilio (pay-per-SMS, ~$50/month at scale)
- Payments: Stripe (no monthly fee, 2.9% + $0.30 per transaction)
- CDN: Cloudflare (free)

**Why:**
- Vercel = best Next.js hosting, zero config
- Serverless = pay for what you use
- Integrated platform = less to manage for solo dev

**Cost Estimate:**
- Month 1-3 (Dev): $0-20/month
- Month 4-6 (Soft launch): $50/month
- Month 7-12 (Growing): $150/month

Well within $200/month budget ✅

### 3.3 Data Architecture

**Storage:**
- PostgreSQL via Prisma (all data)
- R2 (provider photos, service photos)
- No cache initially (add Redis if needed)

**Key Tables:**
- Users (both homeowners and providers, type field)
- Services (categories: plumbing, electrical, etc.)
- ProviderProfiles (rates, bio, service areas)
- Bookings (marketplace core)
- Reviews
- Payouts

### 3.4 API Design

**Style:** Next.js API routes (REST-ish)

**Routes:**
```
/api/auth/[...nextauth] - NextAuth.js
/api/providers/search - Find providers
/api/bookings/create - Create booking
/api/bookings/[id]/accept - Provider accepts
/api/payments/webhook - Stripe webhooks
/api/reviews/create - Leave review
```

**No public API for MVP** (internal only)

### 3.5 Security

**Authentication:**
- NextAuth.js (email magic link + Google)
- Phone verification (Twilio)

**Payments:**
- Stripe Connect (hold funds, payout to providers)
- PCI compliance handled by Stripe

**Data Protection:**
- HTTPS only
- No sensitive data stored (Stripe tokenization)
- Phone numbers hashed

---

## Phase 4: Data & API Design 🤖

### 4.1 Key Data Models

**User:**
```prisma
model User {
  id String @id @default(uuid())
  email String @unique
  phone String? @unique
  name String
  type UserType // HOMEOWNER | PROVIDER
  providerProfile ProviderProfile?
  bookingsAsHomeowner Booking[] @relation("HomeownerBookings")
  bookingsAsProvider Booking[] @relation("ProviderBookings")
}
```

**ProviderProfile:**
```prisma
model ProviderProfile {
  id String @id
  user User @relation(...)
  bio String
  hourlyRate Decimal
  services Service[]
  zipCodes String[] // service areas
  availability Json // calendar
  rating Decimal?
  reviewCount Int
  photos String[]
  verified Boolean @default(false)
}
```

**Booking:**
```prisma
model Booking {
  id String @id
  homeowner User @relation("HomeownerBookings")
  provider User @relation("ProviderBookings")
  service Service
  scheduledFor DateTime
  duration Int // hours
  status BookingStatus // PENDING | CONFIRMED | COMPLETED | CANCELLED
  totalAmount Decimal
  stripePaymentIntentId String
  createdAt DateTime
  completedAt DateTime?
}
```

---

## Phase 5: Operations & Quality 🤖

### 5.1 Testing

- Unit tests for critical logic (booking, payments)
- E2E tests for booking flow (Playwright)
- Manual testing for MVP (solo dev)

### 5.2 CI/CD

- Vercel automatic deployments (git push = deploy)
- Preview deployments for branches
- Production = main branch

### 5.3 Monitoring

- Vercel analytics (built-in)
- Sentry (errors)
- Stripe dashboard (payments)
- Custom admin dashboard (bookings, providers, revenue)

---

## Phase 6: Growth Planning 🤖

### 6.1 Go-to-Market

**Month 1-3 (Build):**
- Build MVP
- Recruit 10 providers from network
- Beta test with friends

**Month 4-6 (Soft Launch):**
- Launch in one neighborhood
- Onboard 50 providers manually
- Promote via local Facebook groups
- First 100 bookings

**Month 7-12 (Scale):**
- Expand to full city
- 500 providers
- Facebook/Google ads
- Referral program (both sides)

### 6.2 Business Model

**Revenue:** 15% commission on bookings

**Pricing:**
- Homeowners: Free to book
- Providers: 15% fee per booking (charged to homeowner, remitted to platform)

**Example:**
- Homeowner pays $100
- Provider receives $85 (after 48 hours)
- Platform keeps $15

**Profitability:**
- Need ~1,000 bookings/month at $100 avg = $15K revenue
- Costs: ~$500/month (hosting, SMS, support)
- Break-even: ~30-40 bookings/month

### 6.3 Scaling Roadmap

**At 500 bookings/month:**
- Add Redis caching
- Optimize database queries
- Consider read replicas

**At 5K bookings/month:**
- Multi-city expansion
- Hire first customer support person
- Add background check automation

---

## Summary

**Project:** MarketConnect - Local Services Marketplace

**Approach:**
- Next.js monolith (simplest for solo dev)
- Serverless on Vercel
- PostgreSQL + Stripe + Twilio
- Mobile-first design

**Key Decisions:**
- ✅ Low extensibility (not needed)
- ✅ Commission-based revenue (15%)
- ✅ Start hyper-local (one city)
- ✅ Stripe Connect for payments

**Timeline:**
- Months 1-3: Build MVP (part-time)
- Months 4-6: Soft launch (50 providers)
- Months 7-12: Scale (500 providers, 5K bookings)

**This blueprint is ready for marketplace development!**

---
---

# Example 3: TeamMetrics - Internal Analytics Dashboard

**Project Type:** Internal Tool
**Team:** 1 developer (employee) + manager (stakeholder)
**Timeline:** 6 weeks
**Budget:** Company AWS account (existing)

---

## Phase 1: Vision & Strategy 👤

### 1.1 Core Vision Statement
```
TeamMetrics is an internal dashboard that consolidates engineering team
metrics from GitHub, Jira, and PagerDuty into one view, helping
engineering managers track team health, velocity, and incident trends
without manual data collection.
```

**Problem:** Engineering managers spend hours each week pulling data from
multiple tools to understand team performance and prepare reports.

**Target Users:** Engineering managers and tech leads (internal only, 5 people)

### 1.2 Strategic Goals

**6-week goal:** Replace manual weekly reporting process, save 3+ hours/week per manager

**1-year goal:** Expand to all teams (20 managers), add predictive insights

**Top 3 Objectives:**
1. Automate current manual reporting
2. Surface actionable insights (not just numbers)
3. Reduce meeting time spent on status updates

**Primary Goal:** Internal productivity (not revenue)

### 1.3 Success Metrics

| Metric | Target | Why It Matters |
|--------|--------|----------------|
| Time Saved | 3+ hours/week per manager | ROI of project |
| Adoption | 100% of managers (5/5) | Internal tool success |
| Data Freshness | <1 hour lag | Real-time enough |
| Report Generation | <5 min (was 2+ hours) | Workflow improvement |

### 1.4 Market Positioning

**Alternatives:**
- Manual spreadsheets (current process)
- Linear/Jira reports (fragmented)
- Third-party analytics tools (expensive, overkill)

**Why Build Internal:**
- Specific to company workflow
- Custom metrics not available in tools
- Security (data stays internal)
- Cost (existing AWS account)

### 1.5 Constraints & Context

**Team:**
- 1 developer (20% time allocation, 8 hours/week)
- Manager provides requirements + feedback

**Timeline:**
- 6 weeks to v1
- Must ship by Q1 planning cycle
- Hard deadline (manager needs for planning)

**Budget:**
- Use existing company AWS account
- No additional budget needed
- Must use company SSO (Okta)

**Technical:**
- Developer knows Python + React
- Must integrate with: GitHub, Jira, PagerDuty, Slack
- Deploy to company AWS
- Company uses Terraform (infrastructure as code)

**Compliance:**
- Internal only (no external access)
- Use company VPN
- Standard internal security practices

---

## Phase 2: Product Definition 👤

### 2.1 User Personas

**Persona 1: Engineering Manager (Sarah)**
- Goal: Understand team velocity, spot bottlenecks, report up
- Pain Points: Manual data collection, stale data, too many tools
- Tech Savvy: Medium
- Context: Weekly planning meetings, monthly reports
- Success: Dashboard shows everything in one view

**Persona 2: Tech Lead (Dev)**
- Goal: Monitor on-call load, track incident trends
- Pain Points: Reactive to incidents, no trend visibility
- Tech Savvy: High
- Context: Quick checks throughout the day
- Success: Spot problems before they escalate

**Primary Persona:** Engineering Manager

### 2.2 Core Features

**Feature 1: GitHub Metrics Dashboard**
- Priority: Must-have
- Metrics: PRs opened/merged, review time, deployment frequency
- Success: See 4-week trend in <5 sec
- Complexity: MEDIUM (5-7 days)

**Feature 2: Jira Velocity Tracking**
- Priority: Must-have
- Metrics: Story points completed, cycle time, WIP
- Success: Compare to previous sprints
- Complexity: MEDIUM (4-5 days)

**Feature 3: Incident Analytics (PagerDuty)**
- Priority: Must-have
- Metrics: Incident count, MTTR, on-call load
- Success: Spot trends, identify problem areas
- Complexity: MEDIUM (4-5 days)

**Feature 4: Weekly Report Generator**
- Priority: Must-have
- Generate PDF report for stakeholders
- Success: Click button → PDF in <1 min (was 2 hours manual)
- Complexity: LOW-MEDIUM (3-4 days)

**Feature 5: Slack Notifications**
- Priority: Should-have
- Alert on anomalies (incident spike, velocity drop)
- Success: Proactive alerts to #eng-metrics channel
- Complexity: LOW (2-3 days)

**Feature 6: Team Comparison View**
- Priority: Nice-to-have (v2)
- Compare metrics across teams
- Complexity: MEDIUM (defer to v2)

**MVP Total:** ~20-25 development days (realistic for 8 hours/week over 6 weeks)

### 2.3 User Flows

**Primary Flow: Manager Checks Dashboard**

1. Navigate to dashboard.company.com
2. Auto-login via Okta SSO
3. See overview (all metrics, current period)
4. Drill into specific metric (e.g., PR review time)
5. Filter by team member or time range
6. Export report as PDF
7. Share in Slack

### 2.4 Extensibility Vision

**Level:** None (internal tool, no extensibility needed)

**Claude's Analysis:** 🤖
```
Extensibility Level: None

This is correct for an internal tool:
- Small, known user base (5 people)
- Focused use case
- Speed of delivery matters more than flexibility
- Can always add features directly (we control the codebase)

Recommendation: Build fast, iterate based on feedback.
```

### 2.5 Non-Functional Requirements

**Performance:**
- 5 concurrent users max
- Data refresh: Every 30-60 minutes
- Dashboard load: <3 seconds

**Security:**
- Company VPN required
- Okta SSO integration
- Internal AWS VPC
- No external access

**Scalability:**
- 5 users → maybe 20 users in year 1
- Not a concern (overbuilt for 5 users)

**Availability:**
- Business hours uptime (9am-6pm PT)
- Downtime acceptable after hours

---

## Phase 3: Technical Architecture 🤖

### 3.1 Architecture Philosophy

**Recommended:** Simple Monolith

**Claude's Reasoning:**
```
✓ Internal Tool (5 users)
  → Simplest possible architecture
  → No need for scale

✓ Timeline (6 weeks, 20% time)
  → Must ship fast
  → No time for complexity

✓ Existing Infrastructure (AWS)
  → Use what's available
  → Leverage company tools

✓ No Extensibility Needed
  → Build exactly what's needed
  → Can add features later
```

### 3.2 Technology Stack

**Frontend:** 🤖
- React + TypeScript
- Recharts (data visualization)
- Tailwind CSS
- React Query

**Backend:** 🤖
- Python 3.11 + FastAPI
- Celery (background data sync)
- Redis (cache + Celery broker)

**Database:** 🤖
- PostgreSQL (metrics storage)
- Redis (caching API responses)

**Infrastructure:** 🤖
- AWS ECS Fargate (containers)
- AWS RDS PostgreSQL
- AWS ElastiCache (Redis)
- AWS ALB (load balancer + SSL)
- Deployed via Terraform (company standard)

**Integrations:** 🤖
- GitHub API (via personal access token)
- Jira REST API
- PagerDuty API
- Slack Webhooks
- Okta OAuth

**Why This Stack:**
- Developer knows Python + React
- FastAPI = fast API development
- Company already uses AWS + Terraform
- All integrations have good API docs

**Cost:** $0 (existing company AWS account absorbs it)

### 3.3 Data Architecture

**Data Flow:**
```
Every 30 minutes (Celery background job):
1. Fetch data from GitHub/Jira/PagerDuty APIs
2. Transform and aggregate
3. Store in PostgreSQL
4. Invalidate Redis cache

User Request:
1. Frontend → FastAPI
2. Check Redis cache
3. If miss → Query PostgreSQL
4. Cache result → Return to frontend
```

**Data Retention:**
- Keep 12 months of data
- Weekly aggregates for older data

### 3.4 API Design

**Internal API Only:**
```
GET /api/metrics/github?team=platform&period=4weeks
GET /api/metrics/jira?team=platform&period=sprint
GET /api/metrics/pagerduty?team=platform&period=month
POST /api/reports/generate (creates PDF)
```

No public API, no authentication needed (internal VPN + Okta gate)

### 3.5 Security

**Network:**
- VPN required (company standard)
- No public internet access
- AWS VPC internal

**Authentication:**
- Okta SSO (company standard)
- Frontend checks Okta token
- Backend trusts VPN + Okta

**Data:**
- Internal company data (not sensitive)
- Standard AWS encryption at rest

---

## Phase 4: Data & API Design 🤖

### 4.1 Data Models

**GitHubMetric:**
```sql
CREATE TABLE github_metrics (
  id UUID PRIMARY KEY,
  team VARCHAR(50),
  metric_date DATE,
  prs_opened INT,
  prs_merged INT,
  avg_review_time_hours DECIMAL,
  deployment_count INT,
  created_at TIMESTAMP
);
CREATE INDEX idx_github_team_date ON github_metrics(team, metric_date);
```

**JiraMetric**, **PagerDutyMetric** (similar structure)

---

## Phase 5: Operations & Quality 🤖

### 5.1 Testing

- Unit tests for data transformation logic
- Integration tests for API calls
- Manual testing (5 users, internal tool)

### 5.2 CI/CD

- GitHub Actions
- Terraform apply on merge to main
- Blue-green deployment (ECS)

### 5.3 Monitoring

- AWS CloudWatch (logs + metrics)
- Slack alerts on job failures
- Simple health check endpoint

---

## Phase 6: Growth Planning 🤖

### 6.1 Rollout

**Week 1-4:** Build
**Week 5:** Internal beta (2 managers)
**Week 6:** Full rollout (all 5 managers)

### 6.2 Future Enhancements

**v2 (Month 3-6):**
- Team comparison view
- Predictive insights (ML models)
- Custom metric definitions
- Export to Google Sheets

**v3 (Year 2):**
- Expand to all teams (20 managers)
- Executive dashboard
- Historical trending

---

## Summary

**Project:** TeamMetrics - Internal Analytics Dashboard

**Approach:**
- Simple monolith
- Python/FastAPI + React
- PostgreSQL + Redis
- Deploy to company AWS

**Key Decisions:**
- ✅ No extensibility (internal tool)
- ✅ VPN + Okta SSO (company standard)
- ✅ Background jobs sync data every 30 min
- ✅ Ship fast, iterate based on feedback

**Timeline:**
- Weeks 1-4: Build MVP
- Week 5: Beta test
- Week 6: Full rollout

**This blueprint is ready for internal tool development!**

---

# End of Examples

These three examples show how the blueprint process adapts to different project types:

1. **TaskFlow (SaaS):** Medium extensibility, growth-focused, freemium model
2. **MarketConnect (Marketplace):** Low extensibility, network effects, commission model
3. **TeamMetrics (Internal Tool):** No extensibility, productivity-focused, no revenue

Each blueprint is tailored to the specific constraints, team size, timeline, and goals. Use these as reference when creating your own!
