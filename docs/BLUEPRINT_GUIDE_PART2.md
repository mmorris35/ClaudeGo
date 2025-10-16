# System Blueprint Guide - Part 2
# Phases 3.5 - 6

*This is a continuation of BLUEPRINT_GUIDE.md*

---

## 3.5 Security Architecture

Claude specifies comprehensive security measures.

### Claude's Proposal:

```
SECURITY ARCHITECTURE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AUTHENTICATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Primary: Email + Password
- Password hashing: bcrypt (cost factor 12)
- Min password length: 12 characters
- Password strength indicator in UI
- No password complexity requirements (length > complexity)

Password Storage:
```python
from passlib.context import CryptContext
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")
hashed = pwd_context.hash(password)  # Cost factor 12
```

Session Management: JWT Tokens
- Access token: 15-minute expiration (short-lived)
- Refresh token: 30-day expiration (httpOnly cookie)
- Automatic token rotation on refresh
- Store refresh tokens in database (revocable)

Token Structure:
```json
{
  "sub": "user_id",
  "exp": 1634400000,
  "type": "access",
  "permissions": ["read:tasks", "write:tasks"]
}
```

Storage:
- Access token: Memory only (never localStorage - XSS risk)
- Refresh token: httpOnly, Secure, SameSite=Strict cookie

Social Authentication (OAuth 2.0):
- Google OAuth
- GitHub OAuth (for developer audience)
- Library: Authlib (Python) / NextAuth.js alternative

Multi-Factor Authentication (v2.0):
- TOTP (Time-based One-Time Password)
- Library: pyotp
- Backup codes (10 single-use codes)
- Recovery email

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
AUTHORIZATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Model: Role-Based Access Control (RBAC)

Roles:
```
Team Roles:
- owner: Full permissions (billing, delete team)
- admin: Manage members, create/delete anything
- member: Create/edit own tasks, view team tasks
- viewer: Read-only access

System Roles (future):
- super_admin: Platform administration
```

Permission Check Flow:
1. User makes request
2. Extract user_id from JWT
3. Check: Does user belong to this team?
4. Check: Does user's role allow this action?
5. Check: Resource-level permissions (e.g., task owner)

Example:
```python
@require_permission("write:task")
async def update_task(task_id: str, user: User):
    task = await get_task(task_id)

    # Check team membership
    if not user.in_team(task.team_id):
        raise PermissionDenied

    # Check ownership or admin
    if task.owner_id != user.id and not user.is_admin():
        raise PermissionDenied

    # Proceed with update
    ...
```

Authorization Matrix:

| Resource | Owner | Admin | Member | Viewer |
|----------|-------|-------|--------|--------|
| View task | ✓ | ✓ | ✓ | ✓ |
| Create task | ✓ | ✓ | ✓ | ✗ |
| Edit own task | ✓ | ✓ | ✓ | ✗ |
| Edit any task | ✓ | ✓ | ✗ | ✗ |
| Delete task | ✓ | ✓ | ✗ | ✗ |
| Invite user | ✓ | ✓ | ✗ | ✗ |
| Remove user | ✓ | ✓ | ✗ | ✗ |
| View billing | ✓ | ✗ | ✗ | ✗ |
| Delete team | ✓ | ✗ | ✗ | ✗ |

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INPUT VALIDATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Library: Pydantic (FastAPI built-in)

Example:
```python
from pydantic import BaseModel, Field, validator

class TaskCreate(BaseModel):
    title: str = Field(..., min_length=1, max_length=200)
    description: str = Field(default="", max_length=10000)
    due_date: Optional[datetime] = None
    assignee_id: Optional[UUID] = None

    @validator('title')
    def title_not_empty(cls, v):
        if not v.strip():
            raise ValueError('Title cannot be empty')
        return v.strip()

    @validator('due_date')
    def due_date_future(cls, v):
        if v and v < datetime.now():
            # Allow but warn
            logger.warning("Due date in the past")
        return v
```

All API inputs are validated before processing.

Sanitization:
- HTML input: bleach library (whitelist tags)
- SQL: Parameterized queries (SQLAlchemy ORM)
- File uploads: Validate MIME type and extension

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PROTECTION AGAINST COMMON ATTACKS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

SQL Injection:
✓ Using ORM (SQLAlchemy) with parameterized queries
✓ Never string concatenation for SQL
✓ Validate all inputs

Cross-Site Scripting (XSS):
✓ Content Security Policy (CSP) headers
✓ Sanitize HTML content (bleach)
✓ React escapes by default
✓ httpOnly cookies (token not accessible via JS)

Content-Security-Policy:
```
default-src 'self';
script-src 'self' 'unsafe-inline' https://cdn.yourapp.com;
style-src 'self' 'unsafe-inline';
img-src 'self' data: https:;
connect-src 'self' wss://yourapp.com;
```

Cross-Site Request Forgery (CSRF):
✓ CSRF tokens for state-changing operations
✓ SameSite=Strict cookies
✓ Check Origin/Referer headers

CSRF Token Flow:
1. Server generates token on session start
2. Token stored in cookie + returned in response
3. Client includes token in POST/PUT/DELETE headers
4. Server validates: cookie token == header token

Clickjacking:
✓ X-Frame-Options: DENY
✓ Content-Security-Policy: frame-ancestors 'none'

Server-Side Request Forgery (SSRF):
✓ Whitelist allowed domains for webhooks
✓ No user-provided URLs for server-side fetches
✓ Validate webhook endpoints

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DATA PROTECTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Encryption in Transit:
✓ TLS/SSL (HTTPS only)
✓ Force HTTPS (redirect HTTP → HTTPS)
✓ HSTS header (HTTP Strict Transport Security)
✓ TLS 1.2 minimum (1.3 preferred)

Header:
```
Strict-Transport-Security: max-age=31536000; includeSubDomains; preload
```

Encryption at Rest:
✓ Database encryption (Railway/Render managed)
✓ File storage encryption (R2 default encryption)
✓ Backup encryption

Sensitive Data Handling:
- PII (email, name): Encrypted in database (optional for MVP)
- Passwords: Hashed with bcrypt (never stored plain)
- API keys: Hashed (show once on creation)
- Tokens: Short expiration, rotation

Data Retention:
- Active users: Indefinite
- Deleted users: 30-day soft delete, then purge
- Logs: 90 days retention
- Backups: 30 days

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECRETS MANAGEMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Environment Variables:
```
# .env (NEVER commit to git)
DATABASE_URL=postgresql://...
REDIS_URL=redis://...
JWT_SECRET_KEY=<random-256-bit-key>
API_KEY_ENCRYPTION_KEY=<random-256-bit-key>
SENDGRID_API_KEY=...
R2_ACCESS_KEY=...
```

Secret Generation:
```python
import secrets
jwt_secret = secrets.token_urlsafe(32)  # 256 bits
```

Production:
- Secrets stored in Railway/Render environment variables
- Never in code or version control
- Rotate secrets quarterly

.gitignore:
```
.env
.env.local
*.pem
*.key
secrets/
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
RATE LIMITING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Strategy: Token Bucket (via Redis)

Limits:
- Anonymous requests: 100 per 15 minutes (by IP)
- Authenticated requests: 1000 per hour (by user_id)
- Login attempts: 5 per 15 minutes (by IP + username)
- File uploads: 10 per hour (by user_id)
- Password reset: 3 per hour (by email)

Implementation:
```python
from fastapi_limiter import FastAPILimiter
from fastapi_limiter.depends import RateLimiter

@app.post("/api/v1/tasks")
@limiter.limit("100/hour")
async def create_task(...):
    ...
```

Response:
```
HTTP 429 Too Many Requests
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 0
X-RateLimit-Reset: 1634400000
Retry-After: 3600

{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests. Please try again later."
  }
}
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
FILE UPLOAD SECURITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Validation:
1. File size: Max 10MB
2. MIME type: Whitelist (images, PDFs, docs)
3. Extension: Validate matches MIME type
4. Virus scan: ClamAV (async job after upload)

Allowed Types:
```python
ALLOWED_TYPES = {
    'image/jpeg': ['.jpg', '.jpeg'],
    'image/png': ['.png'],
    'image/gif': ['.gif'],
    'application/pdf': ['.pdf'],
    'application/msword': ['.doc'],
    'application/vnd.openxmlformats-officedocument.wordprocessingml.document': ['.docx'],
}
```

Upload Flow:
1. Validate file type and size
2. Generate unique filename (UUID)
3. Upload to R2 (quarantine bucket)
4. Queue virus scan job (Celery)
5. If clean: Move to public bucket, update database
6. If infected: Delete, notify user, log incident

Serving Files:
- Signed URLs (expire in 1 hour)
- No direct public access
- Content-Disposition header (force download for some types)

```python
url = s3_client.generate_presigned_url(
    'get_object',
    Params={'Bucket': 'uploads', 'Key': file_key},
    ExpiresIn=3600  # 1 hour
)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
LOGGING & MONITORING (SECURITY)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Security Events to Log:
- Failed login attempts (5+ triggers alert)
- Password changes
- Email changes
- Permission changes
- API key creation/deletion
- Unusual activity (geographic anomalies, etc.)

Log Format:
```json
{
  "timestamp": "2025-10-16T12:00:00Z",
  "event": "failed_login",
  "ip": "1.2.3.4",
  "user_agent": "...",
  "username": "user@example.com",
  "reason": "invalid_password"
}
```

Alerts:
- 10 failed logins in 5 minutes → Alert ops
- API key used from new country → Email user
- Admin permission granted → Email team owner

Privacy:
- Never log passwords (even hashed)
- Redact sensitive fields in logs
- Limit log retention (90 days)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DEPENDENCY SECURITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Automated Scanning:
- Dependabot (GitHub, free)
- Snyk (free tier: 200 tests/month)
- pip-audit (Python) / npm audit (Node.js)

Workflow:
1. Dependabot opens PR for vulnerable dependency
2. CI runs tests
3. Review and merge
4. Deploy update

Manual Review:
- Monthly audit of direct dependencies
- Quarterly review of all dependencies
- Avoid packages with no recent updates or maintainers

Lock Files:
- Python: requirements.txt + pip freeze
- Node.js: package-lock.json
- Commit lock files (reproducible builds)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
COMPLIANCE (GDPR)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

GDPR Requirements (EU users):

Right to Access:
- User can export their data (JSON)
- Endpoint: GET /api/v1/users/me/export

Right to Deletion:
- User can request account deletion
- 30-day soft delete (recovery period)
- Hard delete after 30 days (irreversible)
- Endpoint: DELETE /api/v1/users/me

Right to Rectification:
- User can update their info
- Profile settings page

Right to Data Portability:
- Export includes all user data
- Machine-readable format (JSON)

Consent:
- Cookie consent banner
- Track consent status
- Allow opt-out of non-essential cookies

Privacy Policy:
- Clear, plain-language policy
- Updated annually or when changes occur
- Link in footer

Data Processing Agreement:
- For team owners (data controllers)
- Available on request

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECURITY HEADERS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

All HTTP Responses Include:
```
Content-Security-Policy: [see above]
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
Referrer-Policy: strict-origin-when-cross-origin
Permissions-Policy: geolocation=(), microphone=(), camera=()
Strict-Transport-Security: max-age=31536000; includeSubDomains
```

Implementation (FastAPI middleware):
```python
@app.middleware("http")
async def add_security_headers(request, call_next):
    response = await call_next(request)
    response.headers["X-Frame-Options"] = "DENY"
    response.headers["X-Content-Type-Options"] = "nosniff"
    # ... more headers
    return response
```

Test: https://securityheaders.com

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
INCIDENT RESPONSE PLAN
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

If Security Breach Detected:

1. Immediate (0-1 hour):
   - Assess scope and impact
   - Contain breach (revoke tokens, block IPs)
   - Notify team

2. Short-term (1-24 hours):
   - Investigate root cause
   - Patch vulnerability
   - Force password reset (if credentials leaked)
   - Notify affected users (if required by law)

3. Medium-term (1-7 days):
   - Post-mortem report
   - Implement additional safeguards
   - Security audit

4. Long-term:
   - Update security practices
   - Training for team
   - Monitor for repeat issues

Contacts:
- Security lead: [Email]
- Legal counsel: [If needed]
- GDPR DPO: [If needed]

This is a comprehensive security foundation for your MVP.
Ready for section 3.6?
```

---

## 3.6 Extension Architecture (If Applicable)

**Note**: Only include this section if you chose Medium or High extensibility in Phase 2.4.

### For High Extensibility (Plugin System):

```
PLUGIN SYSTEM ARCHITECTURE

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OVERVIEW
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Goal: Third-party developers can extend core functionality

Plugin Capabilities:
✓ Add UI components (React components)
✓ Hook into events (task created, user invited, etc.)
✓ Add API endpoints
✓ Store plugin-specific data
✓ Access core data (with permissions)
✓ Provide settings UI

Architecture Style: Event-Driven with Hooks

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PLUGIN STRUCTURE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Plugin Manifest (plugin.json):
```json
{
  "id": "com.example.time-tracker",
  "name": "Time Tracker",
  "version": "1.0.0",
  "description": "Track time spent on tasks",
  "author": "Example Inc",
  "license": "MIT",
  "homepage": "https://example.com/plugin",

  "permissions": [
    "read:tasks",
    "write:tasks",
    "read:users"
  ],

  "hooks": [
    "task.created",
    "task.updated",
    "task.completed"
  ],

  "settings": {
    "schema": "settings-schema.json",
    "ui": "settings-ui.tsx"
  },

  "entry": {
    "backend": "dist/backend.js",
    "frontend": "dist/frontend.js"
  }
}
```

Directory Structure:
```
time-tracker-plugin/
├── plugin.json
├── src/
│   ├── backend/
│   │   ├── index.ts
│   │   └── handlers.ts
│   ├── frontend/
│   │   ├── index.tsx
│   │   └── components/
│   └── types/
├── dist/  (compiled)
├── README.md
└── package.json
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PLUGIN SDK
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Backend SDK (TypeScript/JavaScript):
```typescript
import { Plugin, TaskEvent } from '@yourapp/plugin-sdk';

export default class TimeTrackerPlugin extends Plugin {
  async onInstall() {
    // Setup database tables, etc.
    await this.db.createTable('time_entries', {...});
  }

  async onEnable() {
    // Register event listeners
    this.on('task.updated', this.handleTaskUpdate);
  }

  async handleTaskUpdate(event: TaskEvent) {
    const task = event.data;
    if (task.status === 'in_progress') {
      await this.db.insert('time_entries', {
        task_id: task.id,
        started_at: new Date(),
      });
    }
  }

  // Custom API endpoint
  async getTimeSpent(taskId: string): Promise<number> {
    const entries = await this.db.find('time_entries', {
      task_id: taskId
    });
    return entries.reduce((sum, e) => sum + e.duration, 0);
  }
}
```

Frontend SDK (React):
```typescript
import { PluginComponent, useTask } from '@yourapp/plugin-sdk';

export const TimeTrackerWidget: PluginComponent = () => {
  const task = useTask();  // Current task context
  const [timeSpent, setTimeSpent] = useState(0);

  useEffect(() => {
    // Call plugin's backend API
    plugin.api.getTimeSpent(task.id).then(setTimeSpent);
  }, [task.id]);

  return (
    <div className="time-tracker">
      <h4>Time Tracked</h4>
      <p>{formatDuration(timeSpent)}</p>
    </div>
  );
};
```

SDK Features:
- Database access (scoped to plugin)
- API client (call core API)
- Event system (subscribe to hooks)
- Storage (key-value for plugin settings)
- UI components (React hooks)
- Permissions system

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EVENT SYSTEM (HOOKS)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Available Hooks:

Lifecycle:
- plugin.install
- plugin.enable
- plugin.disable
- plugin.uninstall

Task Events:
- task.beforeCreate
- task.created
- task.beforeUpdate
- task.updated
- task.beforeDelete
- task.deleted
- task.assigned
- task.completed

User Events:
- user.invited
- user.joined
- user.removed

Team Events:
- team.created
- team.deleted

Comment Events:
- comment.created
- comment.updated
- comment.deleted

Hook Example (Core System):
```typescript
// Core system publishes events
class TaskService {
  async createTask(data: TaskData) {
    // Before hook (plugins can modify data)
    const modifiedData = await hooks.execute('task.beforeCreate', data);

    const task = await db.tasks.create(modifiedData);

    // After hook (plugins notified, cannot modify)
    await hooks.execute('task.created', task);

    return task;
  }
}
```

Plugin Subscribes:
```typescript
// Plugin listens to event
this.on('task.created', async (task) => {
  // Send Slack notification
  await this.slack.notify(`New task: ${task.title}`);
});
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SANDBOXING & SECURITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Execution Environment:
- Plugins run in isolated Node.js VM contexts
- Limited access to Node.js APIs (no file system, no network directly)
- All external access via SDK

Permissions System:
```
Plugin requests permissions in manifest:
"permissions": [
  "read:tasks",      // Can read task data
  "write:tasks",     // Can create/update tasks
  "read:users",      // Can read user profiles
  "network:*",       // Can make HTTP requests (broad)
  "network:api.slack.com"  // Restricted to specific domain
]
```

User Approval:
- User sees permission requests on install
- Must explicitly approve
- Can revoke permissions anytime

Resource Limits:
- CPU: Max 5 seconds per hook execution
- Memory: Max 128MB per plugin
- Database: Max 100MB per plugin
- API calls: Subject to rate limits

Monitoring:
- Track plugin performance
- Timeout slow plugins
- Alert if plugin crashes repeatedly
- Automatic disable if misbehaving

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PLUGIN DATABASE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Each Plugin Gets Isolated Storage:

Schema:
```sql
CREATE TABLE plugin_data (
  id UUID PRIMARY KEY,
  plugin_id VARCHAR(255),     -- com.example.time-tracker
  team_id UUID,               -- Scoped to team
  namespace VARCHAR(255),     -- Table name
  key VARCHAR(255),           -- Record ID
  data JSONB,                 -- Plugin's data
  created_at TIMESTAMP,
  updated_at TIMESTAMP,

  INDEX(plugin_id, team_id, namespace, key)
);
```

SDK Usage:
```typescript
// Plugin uses simple key-value API
await this.db.set('time_entries', task.id, {
  started_at: new Date(),
  duration: 0,
});

const entry = await this.db.get('time_entries', task.id);

await this.db.update('time_entries', task.id, {
  duration: 3600,  // 1 hour
});

await this.db.delete('time_entries', task.id);

// Query
const entries = await this.db.find('time_entries', {
  where: { duration: { gt: 0 } },
  orderBy: 'started_at',
  limit: 10,
});
```

Advantages:
- Simple for plugin developers
- Isolated from core database
- Easy to delete plugin data on uninstall
- No schema migrations needed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PLUGIN MARKETPLACE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Discovery:
- Marketplace website (marketplace.yourapp.com)
- Search and filter (category, rating, price)
- Featured plugins
- "Trending" and "New" sections

Submission Process:
1. Developer creates plugin
2. Submits to marketplace (via CLI or web)
3. Automated security scan
4. Manual code review (for paid or popular plugins)
5. Approved → Published

Marketplace Listing:
- Name, description, screenshots
- Version history and changelog
- Reviews and ratings
- Install count
- Author info
- Source code link (if open-source)
- Price (free or paid)

Installation:
- One-click install from marketplace
- Or: Manual install via ZIP upload

Revenue Sharing (if paid plugins):
- Platform takes 20-30% commission
- Developer receives 70-80%
- Monthly payouts

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VERSIONING & UPDATES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Semantic Versioning: MAJOR.MINOR.PATCH

Update Strategy:
- Auto-update for PATCH (bug fixes)
- Notify for MINOR (new features)
- Manual approval for MAJOR (breaking changes)

Compatibility:
- Plugins declare compatible API versions
- Platform provides API versioning
- Deprecated APIs supported for 12 months

Rollback:
- Keep previous version for 30 days
- One-click rollback if update breaks

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DEVELOPER EXPERIENCE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CLI Tool:
```bash
# Create new plugin from template
$ yourapp-cli plugin create time-tracker

# Test locally
$ yourapp-cli plugin dev

# Build for production
$ yourapp-cli plugin build

# Publish to marketplace
$ yourapp-cli plugin publish
```

Documentation:
- Plugin Developer Guide
- API Reference (auto-generated)
- Example plugins (GitHub)
- Video tutorials
- Best practices

Testing:
- Test harness (simulates events)
- Mock SDK for unit tests
- Integration test environment

Support:
- Developer forum
- Discord server
- Office hours (monthly)
- Partner program (for popular plugins)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
IMPLEMENTATION TIMELINE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Phase 1 (Months 1-3): MVP, no plugins

Phase 2 (Months 4-6): Plugin foundation
- Event system in core app
- Plugin SDK (alpha)
- 2-3 internal example plugins
- Documentation

Phase 3 (Months 7-9): Private beta
- Invite 5-10 developers
- Refine SDK based on feedback
- Plugin CLI tool
- Marketplace (beta)

Phase 4 (Months 10-12): Public launch
- Open marketplace
- Review process
- Developer onboarding
- Marketing to developers

This is an ambitious but achievable plugin system.

⚠️  REALITY CHECK:
Given your 2-developer team and 3-month MVP timeline,
I recommend focusing on core product first. Add plugin
system in Phase 2 (months 4-9).

Agree with this approach?
```

---

## Phase 3 Complete! 🎉

Claude will summarize the technical architecture and save to SYSTEM_BLUEPRINT.md.

### Sample Summary:
```
Technical Architecture Summary:

✓ Architecture: Modular Monolith
✓ Tech Stack:
  - Frontend: React + TypeScript + Tailwind
  - Backend: Python + FastAPI
  - Database: PostgreSQL + Redis
  - Hosting: Railway

✓ Security:
  - JWT authentication with httpOnly cookies
  - RBAC authorization
  - GDPR compliant
  - Comprehensive input validation

✓ API: REST with OpenAPI docs
✓ Extensibility: Plugin system (Phase 2)

Cost: $50-250/month (within budget)
Timeline Impact: None (realistic for 3 months)

This is a solid, production-ready architecture.

Ready for Phase 4: Data & API Design?
```

---

# Phase 4: Data & API Design

**Goal**: Design database schema and API endpoints
**Your Role**: Review and validate Claude's designs
**Claude's Role**: Create complete data models and API specifications

---

## 4.1 Data Models

Claude analyzes your features from Phase 2 and creates entity models.

### Claude's Process:

1. Identify entities from features
2. Define relationships
3. Design schema with indexes
4. Plan for extensibility (custom fields if needed)

### Claude's Output:

```
DATABASE SCHEMA DESIGN

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CORE ENTITIES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Based on your features, here are the required entities:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: User
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Represents a user account

Schema:
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR(255) UNIQUE NOT NULL,
  password_hash VARCHAR(255),  -- NULL if OAuth only
  name VARCHAR(255) NOT NULL,
  avatar_url TEXT,
  timezone VARCHAR(50) DEFAULT 'UTC',
  locale VARCHAR(10) DEFAULT 'en',

  -- OAuth
  google_id VARCHAR(255) UNIQUE,
  github_id VARCHAR(255) UNIQUE,

  -- Status
  email_verified BOOLEAN DEFAULT FALSE,
  is_active BOOLEAN DEFAULT TRUE,
  last_login_at TIMESTAMP,

  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP  -- Soft delete
);

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_google_id ON users(google_id) WHERE google_id IS NOT NULL;
CREATE INDEX idx_users_github_id ON users(github_id) WHERE github_id IS NOT NULL;
```

Relationships:
- has_many: TeamMemberships
- has_many: Tasks (as assignee)
- has_many: Tasks (as creator)
- has_many: Comments

Validation:
- Email: Valid format, unique
- Name: 1-255 characters
- Timezone: Valid IANA timezone
- Password: Min 12 characters (if not OAuth)

Extensibility:
- metadata JSONB field for future custom attributes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: Team
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Workspace/organization for collaboration

Schema:
```sql
CREATE TABLE teams (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name VARCHAR(255) NOT NULL,
  slug VARCHAR(255) UNIQUE NOT NULL,  -- URL-friendly
  description TEXT,
  avatar_url TEXT,

  -- Settings
  settings JSONB DEFAULT '{}'::jsonb,

  -- Billing (future)
  plan VARCHAR(50) DEFAULT 'free',  -- free, pro, enterprise
  trial_ends_at TIMESTAMP,

  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

CREATE INDEX idx_teams_slug ON teams(slug);
```

Relationships:
- has_many: TeamMemberships
- has_many: Tasks
- has_many: Projects (future)

Validation:
- Name: 1-255 characters
- Slug: Lowercase, alphanumeric + hyphens, unique

Settings Example:
```json
{
  "work_hours": {"start": "09:00", "end": "17:00"},
  "notifications": {"email": true, "slack": false}
}
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: TeamMembership
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Join table for users and teams with roles

Schema:
```sql
CREATE TABLE team_memberships (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  role VARCHAR(50) NOT NULL,  -- owner, admin, member, viewer

  -- Invitation
  invited_by UUID REFERENCES users(id),
  invited_at TIMESTAMP,
  accepted_at TIMESTAMP,

  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),

  UNIQUE(team_id, user_id)
);

CREATE INDEX idx_team_memberships_team ON team_memberships(team_id);
CREATE INDEX idx_team_memberships_user ON team_memberships(user_id);
CREATE INDEX idx_team_memberships_role ON team_memberships(team_id, role);
```

Relationships:
- belongs_to: Team
- belongs_to: User

Roles:
- owner: Full control (billing, delete team)
- admin: Manage members, all team data
- member: Create/edit own tasks
- viewer: Read-only

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: Task
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Work item to be completed

Schema:
```sql
CREATE TABLE tasks (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  team_id UUID NOT NULL REFERENCES teams(id) ON DELETE CASCADE,

  -- Content
  title VARCHAR(200) NOT NULL,
  description TEXT,
  status VARCHAR(50) NOT NULL DEFAULT 'todo',  -- todo, in_progress, done
  priority VARCHAR(50) DEFAULT 'medium',  -- low, medium, high, urgent

  -- Assignment
  assignee_id UUID REFERENCES users(id) ON DELETE SET NULL,
  created_by UUID NOT NULL REFERENCES users(id),

  -- Dates
  due_date TIMESTAMP,
  started_at TIMESTAMP,
  completed_at TIMESTAMP,

  -- Organization (future: projects, tags)
  project_id UUID REFERENCES projects(id),  -- Future
  tags TEXT[],  -- Array of tag strings

  -- Ordering
  position INTEGER DEFAULT 0,  -- For manual sorting

  -- Extensibility
  custom_fields JSONB DEFAULT '{}'::jsonb,

  -- Timestamps
  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

CREATE INDEX idx_tasks_team ON tasks(team_id);
CREATE INDEX idx_tasks_assignee ON tasks(assignee_id) WHERE assignee_id IS NOT NULL;
CREATE INDEX idx_tasks_created_by ON tasks(created_by);
CREATE INDEX idx_tasks_status ON tasks(team_id, status);
CREATE INDEX idx_tasks_due_date ON tasks(due_date) WHERE due_date IS NOT NULL;
CREATE INDEX idx_tasks_project ON tasks(project_id) WHERE project_id IS NOT NULL;

-- Full-text search
CREATE INDEX idx_tasks_search ON tasks
  USING GIN(to_tsvector('english', title || ' ' || COALESCE(description, '')));
```

Relationships:
- belongs_to: Team
- belongs_to: User (assignee)
- belongs_to: User (creator)
- has_many: Comments
- has_many: Attachments
- has_many: StatusUpdates

Validation:
- Title: 1-200 characters, required
- Status: Enum ['todo', 'in_progress', 'done']
- Priority: Enum ['low', 'medium', 'high', 'urgent']
- Due date: Optional, can be in past (backlog)

Status Transitions:
- todo → in_progress (sets started_at)
- in_progress → done (sets completed_at)
- done → in_progress (clears completed_at)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: StatusUpdate
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Async updates on task progress

Schema:
```sql
CREATE TABLE status_updates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id),

  content TEXT NOT NULL,

  -- Optional status change
  old_status VARCHAR(50),
  new_status VARCHAR(50),

  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

CREATE INDEX idx_status_updates_task ON status_updates(task_id);
CREATE INDEX idx_status_updates_user ON status_updates(user_id);
CREATE INDEX idx_status_updates_created ON status_updates(created_at DESC);
```

Relationships:
- belongs_to: Task
- belongs_to: User

Example:
```
User posts: "Made good progress, 80% done. Waiting on design review."
System records: old_status='in_progress', new_status=NULL (no change)
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: Comment
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Discussion on tasks

Schema:
```sql
CREATE TABLE comments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  user_id UUID NOT NULL REFERENCES users(id),

  content TEXT NOT NULL,

  -- Threading (future)
  parent_id UUID REFERENCES comments(id),

  created_at TIMESTAMP DEFAULT NOW(),
  updated_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

CREATE INDEX idx_comments_task ON comments(task_id);
CREATE INDEX idx_comments_user ON comments(user_id);
CREATE INDEX idx_comments_parent ON comments(parent_id) WHERE parent_id IS NOT NULL;
```

Relationships:
- belongs_to: Task
- belongs_to: User
- belongs_to: Comment (parent, optional)

Validation:
- Content: 1-10000 characters

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: Attachment
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: Files attached to tasks

Schema:
```sql
CREATE TABLE attachments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  task_id UUID NOT NULL REFERENCES tasks(id) ON DELETE CASCADE,
  uploaded_by UUID NOT NULL REFERENCES users(id),

  -- File info
  filename VARCHAR(255) NOT NULL,
  mime_type VARCHAR(100) NOT NULL,
  file_size INTEGER NOT NULL,  -- bytes
  storage_key TEXT NOT NULL,  -- R2 object key

  -- Processing
  virus_scan_status VARCHAR(50) DEFAULT 'pending',  -- pending, clean, infected
  virus_scan_result TEXT,

  created_at TIMESTAMP DEFAULT NOW(),
  deleted_at TIMESTAMP
);

CREATE INDEX idx_attachments_task ON attachments(task_id);
CREATE INDEX idx_attachments_uploaded_by ON attachments(uploaded_by);
CREATE INDEX idx_attachments_scan_status ON attachments(virus_scan_status)
  WHERE virus_scan_status = 'pending';
```

Relationships:
- belongs_to: Task
- belongs_to: User (uploader)

Validation:
- File size: Max 10MB (10485760 bytes)
- MIME type: Whitelist (images, PDFs, docs)

Storage Pattern:
- Database: Metadata only
- R2: Actual file
- storage_key format: "attachments/{team_id}/{task_id}/{uuid}.{ext}"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Entity: Notification
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Purpose: In-app notifications

Schema:
```sql
CREATE TABLE notifications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES users(id) ON DELETE CASCADE,

  -- Notification content
  type VARCHAR(50) NOT NULL,  -- task_assigned, comment_added, etc.
  title VARCHAR(255) NOT NULL,
  content TEXT,

  -- Link
  link_type VARCHAR(50),  -- task, comment, etc.
  link_id UUID,

  -- Status
  read_at TIMESTAMP,
  archived_at TIMESTAMP,

  created_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_notifications_user ON notifications(user_id);
CREATE INDEX idx_notifications_unread ON notifications(user_id, read_at)
  WHERE read_at IS NULL;
CREATE INDEX idx_notifications_created ON notifications(created_at DESC);
```

Relationships:
- belongs_to: User

Notification Types:
- task_assigned: "You were assigned to '{task.title}'"
- comment_added: "{user.name} commented on '{task.title}'"
- task_completed: "'{task.title}' was marked as done"
- user_invited: "You were invited to team '{team.name}'"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ENTITY RELATIONSHIP DIAGRAM
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

```
┌──────────┐
│  User    │
└────┬─────┘
     │
     │ has_many
     ▼
┌────────────────┐        ┌──────────┐
│TeamMembership  ├───────►│  Team    │
└────────────────┘belongs_to└────┬─────┘
                                 │
                                 │ has_many
                                 ▼
                            ┌─────────┐
                            │  Task   │
                            └────┬────┘
                                 │
                 ┌───────────────┼───────────────┐
                 │               │               │
        has_many │      has_many │      has_many │
                 ▼               ▼               ▼
        ┌──────────────┐ ┌──────────┐  ┌─────────────┐
        │StatusUpdate  │ │ Comment  │  │ Attachment  │
        └──────────────┘ └──────────┘  └─────────────┘

┌─────────────┐
│Notification │ ───belongs_to──► User
└─────────────┘
```

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
MIGRATION STRATEGY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Tool: Alembic (Python) or similar

Initial Migration (001_create_tables.sql):
- Create all tables
- Create indexes
- Add foreign keys

Future Migrations:
- Add columns (ALTER TABLE ADD COLUMN)
- Add indexes
- Data migrations (backfill data)
- Never drop columns (just stop using them)

Example:
```bash
# Create migration
$ alembic revision -m "Create users and teams tables"

# Apply migration
$ alembic upgrade head

# Rollback
$ alembic downgrade -1
```

This schema supports all your MVP features and is extensible.
Questions or changes needed?
```

*[Continuing with Phase 4.2 API Endpoints in next message due to length...]*

---

