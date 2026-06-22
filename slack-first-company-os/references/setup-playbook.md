# Slack-First Company OS Setup Playbook

Use this playbook for a 0-10 person team setting up Slack, Notion, Linear, and GitHub from scratch or repairing a partially completed setup.

## Scope

Slack is the hub. Notion stores durable context. Linear tracks tasks/projects. GitHub owns code, pull requests, CI, and release history.

Organization/workspace scope matters:

- Slack: install apps into the Slack workspace.
- GitHub: install apps on the GitHub organization or selected organization repos.
- Linear: enable integrations in the Linear workspace, not only a personal account.
- Notion: install workspace connections under Settings & members -> Connections.

## Phase 0: Run Mode

Start by choosing one of two setup modes:

- **Guided mode**: ask and confirm progressively. Use this when the user is exploring, learning, or unsure.
- **Brief-first autopilot mode**: ask all material questions up front, summarize a run plan, get one confirmation, then execute automatically. Use this when the user wants `/goal`-style execution or a teammate-ready handoff.

If the user chooses brief-first autopilot, read `references/autopilot-brief.md` and complete the brief before Phase 1. In autopilot mode, click OAuth/authorization screens yourself when the exact app, workspace/org/repo, and permission category were pre-approved and the session is already logged in. Pause only for passwords, unavailable SSO/2FA/email access, captchas, payment, admin approvals, destructive actions, unapproved permission expansion, or contradictions in the brief.

## Phase 1: Inventory

Ask for current status before opening creation pages:

```text
Slack: existing / none / unsure
Notion: existing / none / unsure
Linear: existing / none / unsure
GitHub: existing / none / unsure
```

For existing assets, collect:

- URL or workspace/org name
- whether the user is admin/owner
- whether it should be reused, renamed, or replaced

Do not create anything until inventory and tooling preflight are complete.

## Phase 2: Tooling Preflight And Fallback Ladder

Before creating external assets, inspect what the current agent environment can actually use. Do this before choosing browser-only setup.

Preflight checklist:

- Available agent tools/skills/connectors: Slack, GitHub, Notion, Linear, browser control, computer use, filesystem, git, and shell.
- Installed CLIs: at minimum check likely commands such as `gh`; check Slack/Notion/Linear CLIs only when relevant because they may not be needed for marketplace integrations.
- CLI auth state with non-destructive commands, for example `gh auth status` before GitHub repo/org work.
- MCP servers or connectors already configured in the current agent host. Prefer tool discovery or the host's MCP listing mechanism over guessing.
- Browser automation availability and whether the browser is already logged into Slack, GitHub, Linear, Notion, and the email inbox.
- Whether missing CLIs/MCP/connectors can be installed or enabled under the current approval policy and user permissions.
- Whether the user approved installing tools, connecting MCP servers, or using existing credentials.

Use this fallback ladder:

```text
1. Use already-available, authorized connectors/MCP/CLI when they are safer or faster for the step.
2. If a useful tool is missing but can be installed or connected, explain the permission reason and ask before installing/enabling it.
3. If tool installation/auth is unavailable or slower than UI setup, use browser automation with logged-in sessions.
4. If browser automation is unavailable but computer-use control exists, use computer use for UI steps.
5. If neither tooling nor UI control is available, send exact step-by-step links and instructions, then wait for the user to report completion before continuing.
```

Do not skip directly to step 3 unless steps 1 and 2 are unavailable, unauthorized, blocked, or clearly worse for the specific action.

Tooling suggestions to evaluate, not silently enable:

| Platform | CLI option | MCP / connector option | Setup default |
| --- | --- | --- | --- |
| Slack | Slack CLI is useful for custom Slack app development; it is usually not required for marketplace app installs. | Use an installed Slack connector/MCP when the agent needs to read/post Slack context or manage Slack objects. | Prefer connector/MCP if already authorized for Slack object checks; otherwise browser/OAuth for workspace and marketplace app installs. |
| GitHub | GitHub CLI `gh` can create repos, inspect org/repo state, verify auth, and enforce the repo owner gate. | GitHub MCP or connector can help with repos, issues, PRs, and code context after org permissions are clear. | Prefer `gh` or GitHub connector for repo/org verification; browser for OAuth app installs when needed. |
| Notion | No CLI is required for normal workspace connection setup. Use API tooling only if the user asks for page/database automation. | Notion MCP or connector can read/write workspace pages and verify pages/databases after authorization. | Prefer connector/MCP for page creation if available; browser/OAuth for Notion Connections and AI Connector setup. |
| Linear | No CLI is required for normal setup. Use API/MCP tooling when available for issue/project/team verification. | Linear MCP or connector can read/write issues, projects, and team context after workspace authorization. | Prefer onboarding/settings UI for initial integrations; use connector/MCP for verification and smoke tests when available. |

Connector, skill, and MCP guidance:

- Use already-available Codex skills/connectors when they are installed and authorized.
- Do not request plugin, connector, CLI, or MCP installation unless the user explicitly chooses that route.
- Before adding MCP, verify the official endpoint/docs or a trusted registry, explain the permissions, and confirm the exact target workspace/org.
- If a connector install is requested, explain the permission reason and verify the exact target workspace/org before continuing.
- Record why each unavailable tool path was skipped: missing command, missing auth, insufficient permission, install not allowed, no MCP host, no browser control, or user chose manual.

Record the preflight result, chosen primary path, fallback path, and any manual handoff links in the setup log and final matrix.

## Phase 3: Names And Slugs

Collect:

- organization display name
- requested slug
- acceptable fallback slug pattern

Check obvious public availability signals for Slack subdomain, GitHub org/user, and Linear workspace slug. Record actual values, because requested slugs are often unavailable.

## Phase 4: Slack

Create or reuse the Slack workspace first. Keep channels minimal until routing is confirmed.

Recommended initial channel:

- `#announcements`

Do not create `#feed-github`, `#feed-linear`, or `#feed-notion` until the user confirms notification routing. App installation can happen before feed channels.

Verification:

- User can open Slack workspace in browser.
- Slack sidebar shows expected installed apps after integrations.

## Phase 5: GitHub

Create or reuse the GitHub organization before Linear GitHub setup.

Required seed repo:

- Create at least one repo before connecting Linear to GitHub.
- Recommended seed repo: `company-os`.
- Private is usually safest for a new organization.
- The seed repo owner must be the approved target GitHub owner. For a new organization setup, this means the repo URL must be `https://github.com/<target-org>/<repo>`, not `https://github.com/<operator-user>/<repo>`.

Why: Linear GitHub integration can fail or half-complete if the GitHub org has no repositories.

Hard gate before Linear:

- Verify the GitHub repo owner from the browser URL, GitHub repo header, or `gh repo view <owner>/<repo>`.
- If the target owner is a GitHub org and the repo was created under a personal account, STOP. Do not continue to Linear onboarding or Linear GitHub integration.
- Fix by creating the repo inside the org, or by transferring the repo only if the user explicitly approves and the operator has permission.
- Record the verified `owner/repo` in the setup log and use only that repo for Linear, Slack subscriptions, and Notion GitHub connections.

Verification:

- GitHub org exists.
- Seed repo exists under the approved target owner.
- If a GitHub App is installed, verify it is installed on the organization or selected repo, not only authorized personally.

## Phase 6: Linear

Create or reuse the Linear workspace. Linear registration/onboarding may offer to connect Slack and GitHub before the user lands in the full workspace. Use those onboarding integration steps when offered, after the GitHub org/repo hard gate has passed.

Recommended for small teams:

- one initial team, often named after the company/product
- defer projects/templates unless requested

Connect integrations:

1. Linear -> Slack, either in onboarding or in Linear Settings -> Integrations -> Slack
2. Linear -> GitHub, either in onboarding or in Linear Settings -> Integrations -> GitHub, only after the GitHub org has a verified org-owned repo

Verification:

- Linear Settings -> Integrations -> Slack shows enabled.
- Slack sidebar shows `Linear` app.
- Linear Settings -> Integrations -> GitHub shows enabled.
- Linear GitHub page lists the connected organization.

Do not trust onboarding progress alone. After onboarding finishes, re-open Linear Settings -> Integrations and verify Slack and GitHub enabled states. If GitHub was attempted before the verified repo existed, re-run the GitHub integration from settings.

## Phase 7: Notion

Create or reuse the Notion workspace.

Create a minimal `Company OS` page with:

- Purpose
- Tooling Map
- Mission / Principles
- Operating Rhythm
- Decision Log
- Projects
- Meeting Notes
- Tooling Setup Notes

The page is an operating map, not a replacement for Linear or GitHub. It should link to the real Slack workspace, GitHub org/repo, Linear workspace, and relevant Notion pages.

Required Notion connections by default:

- Slack connection/link previews/notifications.
- GitHub workspace connection for the approved target GitHub org/repo.
- Linear connection or Linear AI Connector, depending on what Notion exposes for the workspace.

Do not skip Notion integrations because they feel less important. Only skip one when the user explicitly defers it or the product blocks it because of plan, admin, or OAuth limitations. When blocked, record the exact reason and whether a human/admin action can unblock it.

Notion Linear caveat:

- The Linear AI Connector requires Linear workspace admin, Notion workspace owner, and a Notion Business or Enterprise plan. If the workspace cannot satisfy that, mark Notion -> Linear as `blocked: plan/admin requirement`, not silently deferred.

AI connectors and MCP connections beyond Slack/GitHub/Linear are optional and can be deferred unless explicitly needed.

Known Notion issue:

- GitHub workspace connection can complete GitHub-side authorization but return to a small Notion popup instead of updating the parent settings window.
- Workaround: close the popup, refresh Notion Settings & members -> Connections, reopen the connection, and verify `installed` count. If it remains `0/N`, treat it as not installed.

Verification:

- Notion -> Slack: Settings/Notifications/Connections shows the Slack workspace connected, or Slack shows the Notion app connection.
- Notion -> GitHub: Settings -> Connections shows GitHub workspace connection installed for the approved GitHub owner/repo.
- Notion -> Linear: Settings -> Notion AI -> Linear or the relevant Connections page shows connected, pending, or blocked with exact plan/admin reason.
- Company OS page links to the real Slack workspace, verified GitHub org/repo, Linear workspace/team, and Notion connection status.

## Phase 8: Slack App Installs

Install Slack apps at workspace scope:

- GitHub for Slack
- Linear for Slack
- Notion for Slack link previews/notifications unless explicitly deferred

GitHub for Slack verification:

- Slack sidebar shows `GitHub`.
- GitHub app DM opens and shows commands such as `/github subscribe owner/repo`.

Subscription is separate:

- `/github subscribe owner/repo` routes repo events to the current Slack channel.
- Do not subscribe repos until channel routing is confirmed.

## Phase 9: Final Connection Matrix

Run a small smoke test before calling the stack connected:

1. In Slack, create a test Linear issue with `/linear` or a Linear message action.
2. Verify the Linear issue exists and shows a synced Slack resource.
3. Search the connected GitHub repo for the same title.
4. Mark the Linear issue `Done`.
5. Verify the synced Slack thread updates with the status change.
6. Verify GitHub behavior matches the configured sync mode.

Expected default result:

- Slack -> Linear works when the Linear Slack app is installed and the form can submit.
- Linear -> Slack works when the issue has a synced Slack thread; closing the issue posts a status-change reply and updates the Slack preview.
- Linear -> GitHub issues does not happen from the basic GitHub integration alone. It requires GitHub Issues Sync configured under Linear Settings -> Integrations -> GitHub -> GitHub Issues -> Add new link.
- If the user expects Slack-created Linear issues to appear in GitHub and close in GitHub when completed in Linear, choose `Two-way sync issues between Linear and this repository`, not `Only sync issues from this repository to Linear`.

Finish with a matrix:

```text
Tooling mode chosen:
Tooling preflight result:
Primary execution path:
Fallback/manual handoff path:
Slack -> Linear app:
Slack -> GitHub app:
Slack -> Notion app/link preview:
Linear -> Slack:
Linear -> GitHub org:
Linear GitHub Issues Sync:
Slack-created Linear issue smoke test:
Linear close -> Slack thread update:
Linear issue -> GitHub issue sync:
Notion -> Slack:
Notion -> GitHub:
Notion -> Linear:
GitHub -> Slack subscriptions:
Company OS page links:
```

Use concrete evidence for each line, such as a settings page, sidebar app entry, connected organization name, installed connection count, or command shown by an app.

## Phase 10: Defer Explicitly

Write down deferred decisions instead of silently skipping them:

- CLI/tool/connector installation or use
- Slack, GitHub, Notion, and Linear MCP connections
- extra Slack channels
- feed channel routing
- GitHub Slack subscriptions
- Notion AI/MCP extras beyond the required Slack, GitHub, and Linear Notion connections
- Linear teams/projects/templates
- GitHub repo templates, branch protection, issue/PR templates

## Phase 11: Reusable Skill Handoff

When the setup process is being turned into a reusable skill, finish with install guidance for both humans and other agents.

Publishable handoff checklist:

- Put the installable skill in a directory named after the skill, with `SKILL.md` at the root.
- Include `references/` files needed by the skill, not just `SKILL.md`.
- Provide a one-line installer that accepts `DEST_ROOT` so users can target Codex, Claude Code, OpenClaw, or another compatible agent.
- Provide a direct archive download for agents that should not run installer scripts.
- Provide a copy/paste prompt that tells another agent how to find its skills root, install the full skill folder, verify required files, and restart or reload.
- Keep process-skill installation separate from platform tooling installation. Installing this skill should not install Slack, Notion, Linear, GitHub CLIs, MCP servers, or connectors unless the user separately chooses that route.

Canonical install examples for this skill:

```bash
# Codex
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | bash

# Any compatible Agent Skills client
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="/path/to/agent/skills" bash

# Direct archive, no installer script
mkdir -p "/path/to/agent/skills"
curl -fsSL https://github.com/JimmFly/slack-first-company-os/releases/latest/download/slack-first-company-os.tar.gz | tar -xz -C "/path/to/agent/skills"
```

Verification before sharing:

- Run the installer into a temporary `DEST_ROOT`.
- Extract the direct archive into a temporary skills root.
- Confirm `slack-first-company-os/SKILL.md` and `slack-first-company-os/references/setup-playbook.md` exist.
- Run the skill validator if available.

## Lessons From Real Setup

- Offer both guided mode and brief-first autopilot mode. The former is better for learning; the latter is better when the user wants to answer once and let the agent execute.
- Run tooling preflight before choosing browser/computer/manual setup. Prefer authorized CLI/MCP/connector paths when they are safer or faster; fall back to browser use, then computer use, then step-by-step links.
- Ask before creating channels or repos. Even sensible defaults should be confirmed.
- A Slack app in the sidebar means the app is installed, not that notifications are routed.
- A Notion page link is not the same as a workspace connection.
- GitHub seed repo ownership must be verified before Linear. If the target is an org, `owner/repo` must be the org, not the operator's personal account.
- Linear onboarding can be used to connect Slack and GitHub, but settings verification still decides whether the integration is truly enabled.
- Notion Slack, GitHub, and Linear integrations are required by default for this setup; blocked integrations need explicit blocked reasons.
- Linear GitHub setup depends on GitHub repo existence and correct repo ownership.
- Linear GitHub integration does not automatically create GitHub issues. Configure GitHub Issues Sync separately if the user expects Linear issues to appear in GitHub.
- For Slack -> Linear -> GitHub workflows, configure GitHub Issues Sync as a repo/team link with two-way sync.
- Slack-created Linear issues can sync a Slack thread; closing the Linear issue should update that thread when sync is enabled.
- Always verify integrations in the owning product settings after OAuth.
- When publishing the setup as a reusable skill, make the installer agent-neutral with `DEST_ROOT`; test both the installer and direct archive from the public remote.
