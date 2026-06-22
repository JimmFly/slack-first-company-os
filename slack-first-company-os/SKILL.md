---
name: slack-first-company-os
description: Use when setting up, auditing, or repairing a Slack-first operating system for a small team using Slack, Notion, Linear, and GitHub, especially zero-to-one account creation, organization-scoped integrations, guided setup, brief-first autopilot setup, Slack app installs, Linear-GitHub/Slack wiring, Notion setup, or integration verification.
---

# Slack-First Company OS

Use this skill to build or audit a small-team collaboration stack where Slack is the hub, Notion is durable context, Linear is task/project execution, and GitHub is code/review history.

## Core Rule

Treat personal accounts only as authorization operators. The target state is organization/workspace-scoped connections across Slack workspace, Notion workspace, Linear workspace, and GitHub organization.

## Workflow

1. Choose the run mode:
   - **Guided mode**: ask/confirm as work proceeds. Use this by default for a first-time user or unclear workspace.
   - **Brief-first autopilot mode**: ask all setup questions up front, get one confirmation, then execute automatically. Use this when the user asks for `/goal`, "fully automatic", "ask everything first", or a teammate-ready setup flow. Read `references/autopilot-brief.md`.
2. Inventory existing assets before creating anything: Slack workspace, Notion workspace, Linear workspace, GitHub org, URLs/slugs, and admin/owner access.
3. Run a tooling preflight before external setup: inspect available connectors/skills/MCP tools, installed CLIs, auth state, browser automation, and computer-use capability. Prefer reliable authorized tools over manual UI work.
4. Start or resume the setup harness from `references/harness.md`: create the setup log, use idempotency/permission/OAuth/scope-diff gates, and keep evidence current after each step.
5. Confirm the object list before creating persistent objects such as workspaces, channels, repos, teams, databases, projects, or integrations.
6. Record requested names/slugs and actual names/slugs. Requested slugs are often taken.
7. Create or reuse the core assets in this order: Slack workspace, GitHub org plus a verified target-owned seed repo, Linear workspace, Notion workspace/page. For new org setups, target-owned means org-owned unless the user explicitly approved personal fallback.
8. Before entering Linear, verify the seed repo owner is the approved GitHub target owner, normally the new org. If the repo was created under a personal account by mistake, stop and fix it first.
9. During Linear registration/onboarding, use the built-in Slack and GitHub integration steps when offered after the GitHub repo owner gate passes.
10. Install integrations at workspace/org scope, then verify each integration in its owning product settings.
11. Defer Slack notification routing and feed channels until the user confirms channel structure.

## Verification Matrix

Verify evidence, not intent:

- Slack app sidebar shows `Linear` and `GitHub` when installed.
- Linear Settings -> Integrations -> Slack shows enabled.
- Linear Settings -> Integrations -> GitHub shows enabled and lists the connected GitHub organization.
- GitHub seed repo URL owner matches the approved target owner, not an accidental personal account.
- Slack -> Linear smoke test creates a real Linear issue, and closing it in Linear updates the synced Slack thread.
- GitHub issues appear only when Linear GitHub Issues Sync is configured for a repo/team link; use two-way sync when Linear issues should create or close GitHub issues.
- Notion Settings & members -> Connections or Notion AI settings shows Slack, GitHub, and Linear installed, pending, or blocked with an explicit reason.
- GitHub organization has the relevant GitHub Apps installed or configured, not just a personal OAuth account.
- A Notion `Company OS` page links to the real Slack, Linear, GitHub, and Notion assets.

## Known Failure Modes

- Linear cannot reliably connect GitHub until the GitHub org has at least one repo. Create a seed repo first.
- GitHub repo creation UIs and CLIs can default to the operator's personal account. If the target is a GitHub org, verify the repo URL is `<target-org>/<repo>` before opening Linear. Do not continue into Linear with a personal-account seed repo unless the user explicitly approved personal fallback.
- Linear onboarding can advance after a failed GitHub attempt without actually enabling GitHub. Always verify in Linear integration settings.
- Linear GitHub integration is not the same as GitHub Issues Sync. Without a GitHub Issues repo/team link, Slack-created Linear issues will not appear as GitHub issues; one-way sync from GitHub to Linear is also insufficient for Linear-created issues.
- Notion GitHub OAuth can return to a small popup without updating the parent Notion settings window. Close the popup, refresh Notion Connections, and trust only the installed-state indicator.
- Notion integrations are not optional by default in this setup. Install Slack, GitHub, and Linear connections unless the user explicitly defers one or the product blocks it because of plan/admin limitations.
- Slack app installation is not the same as repository/channel subscription. GitHub for Slack can be installed without `/github subscribe owner/repo`.
- In autopilot mode, click OAuth/authorization screens automatically when the exact app, workspace/org, and permission scope were approved in the upfront brief and the browser session is already authenticated. Pause only for passwords, unavailable 2FA/captcha/email access, payment, admin approvals, unapproved permission expansion, or contradictions.
- Do not jump straight to browser-only setup unless tooling preflight shows CLI/MCP/connector paths are unavailable, unauthenticated, not installable under the user's permissions, or less reliable for the current step. If browser or computer use is unavailable too, provide step-by-step links and wait for the user to complete each handoff.

## Detailed Playbook

For step-by-step setup, object naming, integration order, and troubleshooting, read `references/setup-playbook.md`.

For execution harnesses, evidence logging, resume/reconcile behavior, OAuth scope diffing, human handoffs, and pass/fail grading, read `references/harness.md`.

For upfront questionnaire and full-execution mode, read `references/autopilot-brief.md`.
