# Setup Harness

Use this harness during every Slack + Notion + Linear + GitHub setup or repair run. It turns the setup into resumable state, hard gates, and verifiable evidence.

## Principles

- Evidence beats intention. Record what was verified, where, and by which tool.
- Idempotency first. Probe existing state before creating anything.
- Organization scope first. Personal accounts are only operators unless explicitly approved as targets.
- Secret hygiene always. Never log credentials, OAuth codes, tokens, magic links, recovery codes, or 2FA values.
- Resume from artifacts, not memory. On restart, read the log and re-probe real state.
- Human handoffs are small, explicit, and followed by agent verification.

## Artifact Layout

Create or resume one run log before asset creation:

```text
artifacts/<company-or-slug>-company-os-setup-log.md
```

If no project workspace exists, use the current working directory or a user-approved path. Do not write secrets into the artifact.

Minimum sections:

```text
Run metadata
Environment and tooling preflight
Assets and requested slugs
Permissions
OAuth attempts
Idempotency probes
Human handoffs
Integration evidence matrix
Smoke tests
Blockers and deferred items
Final grader
```

Suggested state block:

```yaml
company:
run_id:
operator:
approved_github_target_owner:
artifacts_path:
stage:
assets:
  slack:
  github:
  linear:
  notion:
permissions:
oauth_attempts:
evidence:
blockers:
grader:
```

## Environment Harness

Run this before choosing browser-only or manual setup.

Record:

| Check | Evidence |
| --- | --- |
| Browser or desktop control available | tool name or unavailable reason |
| Cloud VM or local shell available | shell path or unavailable reason |
| Agent connectors/MCP/skills available | Slack, GitHub, Linear, Notion, browser, computer use |
| CLIs available | `gh`, optional Slack/Linear/Notion tooling |
| Auth status | non-secret auth probe result |
| Email or 2FA access | available / human-only / unavailable |
| Install permission | allowed / ask first / denied |

Fallback modes:

- **Tooled automation**: connector, MCP, or CLI can complete and verify the step.
- **Browser automation**: authenticated browser can complete UI/OAuth steps.
- **Computer use**: desktop control is available when browser automation is insufficient.
- **Human bootstrap + agent verification**: no automation path exists. Give links, wait for completion, then verify with available evidence.

## Idempotency Harness

For every persistent object, probe first and choose one action: `reuse`, `create`, `repair`, `defer`, or `blocked`.

Use this table in the log:

| Asset | Target | Probe | Result | Action | Evidence | Next gate |
| --- | --- | --- | --- | --- | --- | --- |
| Slack workspace | name/url | UI or connector | | | | |
| GitHub org | slug | `gh api user/orgs` or UI | | | | |
| GitHub seed repo | owner/repo | `gh repo view` or UI | | | | |
| Linear workspace/team | url/team key | API/MCP/UI | | | | |
| Notion workspace/page | page URL | MCP/UI | | | | |
| Integrations | app + target | settings/API/UI | | | | |

Rules:

- Never create a duplicate when a matching object exists and is usable.
- Never accept a GitHub seed repo under the wrong owner when the approved target is an org.
- If a previous OAuth partially completed, re-open the owning product settings and verify installed state before retrying.

## Permission Harness

Before mutating each platform, record the operator role and allowed action.

GitHub checks:

- `gh auth status`
- `gh api user`
- `gh repo view <owner>/<repo> --json nameWithOwner,visibility,defaultBranchRef,viewerPermission,isPrivate`
- Org or repo app approval state when available
- If a GitHub OAuth/App action returns `403`, check org OAuth app restrictions or GitHub App approval requirements and hand off to an org owner.

Linear checks:

- Viewer, organization, and teams via MCP/API/UI when available.
- Workspace role: admin/member/unknown.
- Integration settings access before Slack/GitHub/GitHub Issues Sync changes.

Notion checks:

- Workspace role: owner/admin/member/unknown.
- Page edit access for Company OS.
- Connection install access for Slack, GitHub, and Linear.
- Plan/admin gates for Linear AI Connector or MCP-style connectors.

Slack checks:

- Workspace role: owner/admin/member/unknown.
- App installation permission.
- Existing app visibility for Linear, GitHub, and Notion.

If permission is insufficient, do not keep clicking. Use the Human Handoff Harness.

## OAuth Harness

Handle one provider at a time. Do not start parallel OAuth flows.

For each OAuth attempt, log only non-secret metadata:

| Field | Value |
| --- | --- |
| Provider | Slack / GitHub / Linear / Notion |
| App name | displayed app |
| Target | workspace/org/repo |
| Alias/state id | short local id, not the raw secret state if sensitive |
| Scope category | read/write/issues/repos/messages/etc. |
| Authorization URL | paste when safe and useful for user fallback |
| Started at | timestamp |
| Result | installed / pending / denied / blocked / retry needed |
| Probe after auth | settings/API/UI evidence |

Rules:

- Paste the authorization URL in chat or the handoff when the agent cannot guarantee the popup/card is visible to the user.
- Click automatically only when the exact app, target, and permission category were pre-approved.
- Pause for changed target, broader scopes, payment, admin approval, captcha, unavailable 2FA, passkeys, or contradictions.
- After OAuth, immediately run the smallest API/UI probe that proves the integration exists.

## Scope Diff Harness

Compare actual consent screens against the approved brief before clicking.

Use this table:

| Provider | Expected app | Actual app | Expected target | Actual target | Expected scope category | Actual scope category | Decision |
| --- | --- | --- | --- | --- | --- | --- | --- |

Allowed automatic decision:

- same app
- same workspace/org/repo
- same or narrower permission category
- no payment/admin/identity contradiction

Pause when:

- the target workspace/org/repo is different
- requested scopes are materially broader
- the app is not the expected vendor/app
- the consent asks for admin approval or paid plan changes
- the user did not pre-approve OAuth clicking

## GitHub Org Harness

GitHub is a hard gate before Linear.

Required evidence:

```text
GitHub target owner:
Seed repo URL:
Repo owner verified:
Repo visibility:
Default branch:
viewerPermission:
GitHub App/OAuth restriction status:
```

Rules:

- For org setups, the seed repo URL must be `https://github.com/<org>/<repo>`.
- Reject `https://github.com/<operator-user>/<repo>` unless the user explicitly approved personal fallback.
- If the repo is empty and Linear/GitHub integration needs a selectable repo, initialize a README only when approved or already covered by the brief.
- Do not proceed to Linear GitHub integration until the seed repo owner gate passes.

## Plan And Billing Harness

Probe plan/admin gates before treating a connection as failed.

Common gates:

| Platform | Gate | Evidence | Action |
| --- | --- | --- | --- |
| Notion | Linear AI Connector may require Business/Enterprise plus Notion owner and Linear admin | settings text or docs/UI | mark blocked with reason or hand off |
| GitHub | Org third-party app restrictions or GitHub App approval | 403/settings page | hand off to org owner |
| Slack | App install restricted to admins | app directory/settings | hand off to workspace admin |
| Linear | Workspace integrations require admin | settings blocked/role | hand off to Linear admin |

Blocked means:

- exact blocker recorded
- required human/admin action recorded
- next verifiable step recorded
- setup continues only when the blocker is non-critical or explicitly deferred

## Secret Hygiene Harness

Never store these in chat artifacts, Notion, Slack, Linear, GitHub, commits, screenshots, or skill files:

- passwords
- OAuth access tokens or refresh tokens
- raw OAuth authorization codes
- magic links
- 2FA, recovery, backup, or verification codes
- session cookies
- personal access tokens

Use platform credential stores, device login, browser sessions, or MCP/connector auth instead.

When evidence would expose a secret:

- redact it before logging
- describe the non-secret result
- prefer a post-auth settings page or API probe over a callback URL

## Resume And Reconcile Harness

Run this at startup, after runtime restarts, and after any long human handoff.

Steps:

1. Read the setup log.
2. Re-probe every asset and integration that the log says exists.
3. Mark each row `confirmed`, `drifted`, `missing`, `blocked`, or `deferred`.
4. Continue from the first incomplete hard gate.
5. Do not trust memory, browser tab titles, or prior OAuth redirects without a fresh probe.

Use this table:

| Stage | Logged state | Fresh probe | Status | Next action |
| --- | --- | --- | --- | --- |

## Human Handoff Harness

Use this template whenever the agent cannot safely continue alone:

```text
Action needed:
Link:
Account/workspace:
Why:
Expected result:
Safety note:
Tell me when:
```

Examples:

```text
Action needed: Approve the Linear GitHub app for the GitHub organization.
Link: <authorization URL>
Account/workspace: GitHub org <org>, Linear workspace <workspace>
Why: Linear needs org-scoped repo access for PR links and issue sync.
Expected result: The authorization window closes and Linear settings show GitHub enabled.
Safety note: Approve only the named org/repo. Do not paste tokens into chat.
Tell me when: The page says installed or returns to Linear.
```

When no browser or desktop control exists, switch to **human bootstrap + agent verification**. Ask only for the minimum URLs:

```text
Slack workspace URL:
GitHub org URL:
GitHub seed repo URL:
Linear workspace/team URL:
Notion Company OS page URL:
```

Then the agent verifies instead of asking the user to reason through integration state.

## Integration Evidence Matrix

Every final answer should include evidence status, not only prose.

Use statuses:

```text
verified / pending / blocked / deferred / not-requested / failed
```

Use evidence types:

```text
CLI / API / MCP / connector / UI / user-confirmed / handoff-link
```

Minimum matrix:

```text
Harness log:
Grader:
Slack workspace:
Slack app Linear:
Slack app GitHub:
Slack app Notion:
GitHub org:
GitHub seed repo:
GitHub repo owner gate:
GitHub app restrictions:
Linear workspace:
Linear team:
Linear -> Slack:
Linear -> GitHub:
Linear GitHub Issues Sync:
Notion workspace:
Notion Company OS page:
Notion -> Slack:
Notion -> GitHub:
Notion -> Linear:
Slack-created Linear issue smoke:
Linear close -> Slack thread update:
Linear issue -> GitHub issue sync:
Deferred items:
Blockers:
```

## Smoke Harness

Default smoke flow:

1. Create a test Linear issue from Slack.
2. Verify the Linear issue URL and synced Slack resource.
3. If GitHub Issues Sync is expected, verify the GitHub issue exists in the approved repo.
4. Close the issue in Linear.
5. Verify Slack receives the status update.
6. Verify GitHub reflects the configured sync direction.

Record:

```text
Test title:
Slack source:
Linear issue URL:
GitHub issue URL or sync mode reason:
Close action evidence:
Slack feedback evidence:
Cleanup decision:
```

## Final Grader

End with one grade:

| Grade | Criteria |
| --- | --- |
| `not-started` | No core asset has verified evidence. |
| `bootstrap-complete` | Slack workspace, GitHub seed repo under approved owner, Linear workspace/team, and Notion page exist. |
| `core-integrated` | GitHub + Linear are verified, Linear <-> Slack is verified or user-confirmed, Linear <-> GitHub is verified, and Notion required connections are verified or explicitly blocked/deferred. |
| `fully-smoked` | Slack-created Linear issue works, Linear close updates Slack, and GitHub Issues Sync behavior matches the requested mode. |
| `blocked-with-evidence` | A required gate cannot continue, with blocker, owner, link, and next action recorded. |

Do not claim a higher grade than the evidence supports.
