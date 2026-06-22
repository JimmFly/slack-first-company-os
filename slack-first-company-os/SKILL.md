---
name: slack-first-company-os
description: Use when setting up, auditing, or repairing a Slack-first operating system for a small team using Slack, Notion, Linear, and GitHub, especially from zero-to-one account creation, workspace/org setup, organization-scoped integrations, Slack app installs, Linear-GitHub/Slack wiring, Notion connection setup, or integration verification.
---

# Slack-First Company OS

Use this skill to build or audit a small-team collaboration stack where Slack is the hub, Notion is durable context, Linear is task/project execution, and GitHub is code/review history.

## Core Rule

Treat personal accounts only as authorization operators. The target state is organization/workspace-scoped connections across Slack workspace, Notion workspace, Linear workspace, and GitHub organization.

## Workflow

1. Inventory existing assets before creating anything: Slack workspace, Notion workspace, Linear workspace, GitHub org, URLs/slugs, and admin/owner access.
2. Offer a tooling mode before external setup: browser-only, existing Codex skills/connectors, platform CLIs, MCP servers/connectors, or defer. Do not install CLIs/plugins/connectors/MCP servers unless the user chooses that route.
3. Confirm the object list before creating persistent objects such as workspaces, channels, repos, teams, databases, projects, or integrations.
4. Record requested names/slugs and actual names/slugs. Requested slugs are often taken.
5. Create or reuse the core assets in this order: Slack workspace, GitHub org plus at least one repo, Linear workspace, Notion workspace/page.
6. Install integrations at workspace/org scope, then verify each integration in its owning product settings.
7. Defer Slack notification routing and feed channels until the user confirms channel structure.

## Verification Matrix

Verify evidence, not intent:

- Slack app sidebar shows `Linear` and `GitHub` when installed.
- Linear Settings -> Integrations -> Slack shows enabled.
- Linear Settings -> Integrations -> GitHub shows enabled and lists the connected GitHub organization.
- Slack -> Linear smoke test creates a real Linear issue, and closing it in Linear updates the synced Slack thread.
- GitHub issues appear only when Linear GitHub Issues Sync is configured for a repo/team link; use two-way sync when Linear issues should create or close GitHub issues.
- Notion Settings & members -> Connections shows installed connection types.
- GitHub organization has the relevant GitHub Apps installed or configured, not just a personal OAuth account.
- A Notion `Company OS` page links to the real Slack, Linear, GitHub, and Notion assets.

## Known Failure Modes

- Linear cannot reliably connect GitHub until the GitHub org has at least one repo. Create a seed repo first.
- Linear onboarding can advance after a failed GitHub attempt without actually enabling GitHub. Always verify in Linear integration settings.
- Linear GitHub integration is not the same as GitHub Issues Sync. Without a GitHub Issues repo/team link, Slack-created Linear issues will not appear as GitHub issues; one-way sync from GitHub to Linear is also insufficient for Linear-created issues.
- Notion GitHub OAuth can return to a small popup without updating the parent Notion settings window. Close the popup, refresh Notion Connections, and trust only the installed-state indicator.
- Slack app installation is not the same as repository/channel subscription. GitHub for Slack can be installed without `/github subscribe owner/repo`.

## Detailed Playbook

For step-by-step setup, object naming, integration order, and troubleshooting, read `references/setup-playbook.md`.
