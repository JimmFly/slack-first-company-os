# Slack-First Company OS Skill

Codex skill for setting up or auditing a Slack-first operating system for a small team using Slack, Notion, Linear, and GitHub.

## One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | bash
```

Restart Codex after installing so the new skill is discovered.

## Codex Skill Installer

If Codex already has the system skill installer available, install directly from this repo:

```bash
python3 "${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-installer/scripts/install-skill-from-github.py" \
  --url https://github.com/JimmFly/slack-first-company-os/tree/main/slack-first-company-os
```

## What It Covers

- Slack workspace setup and app installs
- GitHub organization and seed repository prerequisites
- Linear Slack, GitHub, and GitHub Issues Sync configuration
- Notion workspace/page setup and connection verification
- End-to-end smoke tests across Slack, Linear, and GitHub

## Skill Path

The installable skill is in:

```text
slack-first-company-os/
```

## Manual Install

For agents that support the same `SKILL.md` folder layout but do not have the Codex installer, copy `slack-first-company-os/` into that agent's skills directory.
