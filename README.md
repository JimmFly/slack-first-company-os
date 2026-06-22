# Slack-First Company OS Skill

Codex skill for setting up or auditing a Slack-first operating system for a small team using Slack, Notion, Linear, and GitHub.

## Run Modes

This skill supports two setup styles:

- **Guided mode**: the agent walks the user through setup step by step and confirms important objects before creating them.
- **Brief-first autopilot mode**: the agent asks the full setup brief up front, produces a run plan, gets one confirmation, then executes automatically. It can click pre-approved OAuth screens itself and pauses only for passwords, unavailable 2FA/email/captcha, admin, payment, or changed permission scope.

## Give This To An Agent

If someone wants their own coding agent to install this skill, send them this repo plus [`AGENT_INSTALL.md`](AGENT_INSTALL.md). The short prompt is:

```text
Install the Agent Skill at https://github.com/JimmFly/slack-first-company-os.
It is a directory-style SKILL.md skill named slack-first-company-os.
Find my agent's skills directory, install the whole slack-first-company-os/ folder there, verify SKILL.md and references/setup-playbook.md exist, then tell me whether I need to restart or reload the agent.
Do not install Slack, Notion, Linear, GitHub CLIs, MCP servers, or connectors unless I separately ask for that.
After installing, tell me I can run either guided mode or brief-first autopilot mode.
```

## One-Line Install For Codex

```bash
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | bash
```

Restart Codex after installing so the new skill is discovered.

## Install For Any Compatible Agent

Use this when the agent supports the Agent Skills / `SKILL.md` folder layout and you know its skills root:

```bash
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="/path/to/agent/skills" bash
```

Verify the final layout:

```text
/path/to/agent/skills/slack-first-company-os/SKILL.md
/path/to/agent/skills/slack-first-company-os/references/setup-playbook.md
```

## Install For Claude Code

Claude Code discovers personal skills from `~/.claude/skills/<skill-name>/SKILL.md`.

```bash
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="$HOME/.claude/skills" bash
```

Restart Claude Code or reload the session if needed.

## Install For OpenClaw

OpenClaw follows the `SKILL.md` Agent Skills format and can load shared skills from `~/.openclaw/skills`.

```bash
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="$HOME/.openclaw/skills" bash
```

## Direct Archive Download

For agents or environments that do not want to run the installer script, download the skill folder archive directly:

```bash
mkdir -p "/path/to/agent/skills"
curl -fsSL https://github.com/JimmFly/slack-first-company-os/releases/latest/download/slack-first-company-os.tar.gz | tar -xz -C "/path/to/agent/skills"
```

## Codex Skill Installer

If Codex already has the system skill installer available, install directly from this repo:

```bash
python3 "${CODEX_HOME:-$HOME/.codex}/skills/.system/skill-installer/scripts/install-skill-from-github.py" \
  --url https://github.com/JimmFly/slack-first-company-os/tree/main/slack-first-company-os
```

## What It Covers

- Slack workspace setup and app installs
- GitHub organization and verified target-owned seed repository prerequisites
- Linear onboarding/settings Slack, GitHub, and GitHub Issues Sync configuration
- Notion workspace/page setup plus Slack, GitHub, and Linear connection verification
- End-to-end smoke tests across Slack, Linear, and GitHub
- Guided setup and brief-first autopilot setup

## Skill Path

The installable skill is in:

```text
slack-first-company-os/
```

## Manual Install

For agents that support the same `SKILL.md` folder layout but do not have the Codex installer, copy `slack-first-company-os/` into that agent's skills directory.

## Installer Options

The installer supports:

- `DEST_ROOT`: target skills root. Defaults to `${CODEX_HOME:-$HOME/.codex}/skills`.
- `OVERWRITE=1`: replace an existing installed copy.
- `REPO`, `REF`, `SKILL_NAME`: override the GitHub repo, branch/tag/commit, or skill folder name.
