# Slack-First Company OS Setup Playbook

Use this playbook for a 0-10 person team setting up Slack, Notion, Linear, and GitHub from scratch or repairing a partially completed setup.

## Scope

Slack is the hub. Notion stores durable context. Linear tracks tasks/projects. GitHub owns code, pull requests, CI, and release history.

Organization/workspace scope matters:

- Slack: install apps into the Slack workspace.
- GitHub: install apps on the GitHub organization or selected organization repos.
- Linear: enable integrations in the Linear workspace, not only a personal account.
- Notion: install workspace connections under Settings & members -> Connections.

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

Do not create anything until inventory and tooling mode are complete.

## Phase 2: Tooling Mode Choice

Before creating external assets, ask whether the user wants a browser-only run or wants Codex to use or install supporting tools.

Ask in the user's language with these options:

```text
How should I run this setup?

1. Browser-only: no CLI or extra installs; use product UIs and OAuth flows.
2. Use available Codex skills/connectors: use already-installed Slack, GitHub, Notion, or Linear capabilities if authorized.
3. Use platform CLI tooling where helpful: check existing CLIs first, then ask before installing anything.
4. Use MCP servers/connectors where helpful: check current official docs and installed MCP clients first, then ask before connecting a workspace.
5. Decide later: create the core workspaces first, revisit tooling after integrations are verified.
```

Default recommendation for a first run is browser-only. It keeps permissions visible and avoids debugging local tooling while account setup is still moving.

Tooling suggestions to offer, not silently enable:

| Platform | CLI option | MCP / connector option | Setup default |
| --- | --- | --- | --- |
| Slack | Slack CLI is useful for creating, running, and deploying custom Slack apps. It is not required for installing marketplace apps into a workspace. | Use an installed Slack connector/MCP only when the user wants Codex to read/post Slack context or manage Slack objects. | Browser/OAuth for workspace and app installs. |
| GitHub | GitHub CLI `gh` can create repos, inspect org/repo state, and verify auth when already installed or explicitly approved. | GitHub MCP or a GitHub connector can help with repos, issues, PRs, and code context after org permissions are clear. | Browser or `gh` for repo setup; MCP/connector for ongoing automation. |
| Notion | No CLI is required for this setup. Use API tooling only if the user asks for automation. | Notion MCP or a Notion connector can read/write workspace pages and databases after workspace access is authorized. | Browser/OAuth for workspace connections and pages. |
| Linear | No CLI is required for this setup. Use API tooling only if the user asks for automation. | Linear MCP or a Linear connector can read/write issues, projects, and team context after workspace access is authorized. | Browser/OAuth for integrations; MCP/connector for ongoing execution workflows. |

Connector, skill, and MCP guidance:

- Use already-available Codex skills/connectors when they are installed and authorized.
- Do not request plugin, connector, CLI, or MCP installation unless the user explicitly chooses that route.
- Before adding MCP, verify the official endpoint/docs or a trusted registry, explain the permissions, and confirm the exact target workspace/org.
- If a connector install is requested, explain the permission reason and verify the exact target workspace/org before continuing.

Record the chosen mode in the setup log and final matrix.

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

Why: Linear GitHub integration can fail or half-complete if the GitHub org has no repositories.

Verification:

- GitHub org exists.
- Seed repo exists.
- If a GitHub App is installed, verify it is installed on the organization or selected repo, not only authorized personally.

## Phase 6: Linear

Create or reuse the Linear workspace.

Recommended for small teams:

- one initial team, often named after the company/product
- defer projects/templates unless requested

Connect integrations:

1. Linear -> Slack
2. Linear -> GitHub after the GitHub org has at least one repo

Verification:

- Linear Settings -> Integrations -> Slack shows enabled.
- Slack sidebar shows `Linear` app.
- Linear Settings -> Integrations -> GitHub shows enabled.
- Linear GitHub page lists the connected organization.

Do not trust onboarding progress alone. If GitHub was attempted before a repo existed, re-open Linear Settings -> Integrations -> GitHub and verify the actual enabled state.

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

Recommended Notion connections:

- Slack link previews: install first, low risk, useful.
- GitHub link preview/database sync: optional; verify carefully.
- Linear link preview: optional; install only if the user wants Linear issues/projects to preview in Notion.
- AI connectors and MCP server connections: defer unless explicitly needed; permissions are broader.

Known Notion issue:

- GitHub workspace connection can complete GitHub-side authorization but return to a small Notion popup instead of updating the parent settings window.
- Workaround: close the popup, refresh Notion Settings & members -> Connections, reopen the connection, and verify `installed` count. If it remains `0/N`, treat it as not installed.

## Phase 8: Slack App Installs

Install Slack apps at workspace scope:

- GitHub for Slack
- Linear for Slack
- Notion for Slack link previews/notifications as needed

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
- Notion GitHub/Linear deeper connections
- Notion AI connector or MCP connector
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

- Ask whether to run browser-only, use available skills/connectors, use/install CLI tooling, or connect Slack/GitHub/Notion/Linear MCP after inventory and before setup.
- Ask before creating channels or repos. Even sensible defaults should be confirmed.
- A Slack app in the sidebar means the app is installed, not that notifications are routed.
- A Notion page link is not the same as a workspace connection.
- Linear GitHub setup depends on GitHub repo existence.
- Linear GitHub integration does not automatically create GitHub issues. Configure GitHub Issues Sync separately if the user expects Linear issues to appear in GitHub.
- For Slack -> Linear -> GitHub workflows, configure GitHub Issues Sync as a repo/team link with two-way sync.
- Slack-created Linear issues can sync a Slack thread; closing the Linear issue should update that thread when sync is enabled.
- Always verify integrations in the owning product settings after OAuth.
- When publishing the setup as a reusable skill, make the installer agent-neutral with `DEST_ROOT`; test both the installer and direct archive from the public remote.
