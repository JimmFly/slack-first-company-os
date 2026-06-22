# Agent Install Prompt

Copy this prompt into any agent that can use local files or run shell commands:

```text
Install the Slack-First Company OS Agent Skill.

Source repo:
https://github.com/JimmFly/slack-first-company-os

Skill name:
slack-first-company-os

This is an Agent Skills / SKILL.md folder skill. Install the entire slack-first-company-os/ directory, not just SKILL.md. After installing, tell me I can run either guided mode or brief-first autopilot mode.

Steps:
1. Identify my agent's skills root.
   - Codex: ${CODEX_HOME:-$HOME/.codex}/skills
   - Claude Code: ~/.claude/skills
   - OpenClaw shared skills: ~/.openclaw/skills
   - OpenClaw personal agent skills: ~/.agents/skills
   - Unknown compatible agent: inspect the agent docs or ask me for the skills root.
2. Install with the script:
   curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="<skills-root>" bash
3. If shell scripts are not allowed, install the direct archive:
   mkdir -p "<skills-root>"
   curl -fsSL https://github.com/JimmFly/slack-first-company-os/releases/latest/download/slack-first-company-os.tar.gz | tar -xz -C "<skills-root>"
4. Verify:
   test -f "<skills-root>/slack-first-company-os/SKILL.md"
   test -f "<skills-root>/slack-first-company-os/references/setup-playbook.md"
   test -f "<skills-root>/slack-first-company-os/references/harness.md"
5. Restart or reload the agent if its skill discovery does not hot-reload.

Safety:
- Do not install Slack, Notion, Linear, GitHub CLIs, MCP servers, connectors, or browser extensions. This repository only installs the process skill.
- If the destination already exists, inspect it first and ask before replacing it. Use OVERWRITE=1 only after confirmation.
- Read SKILL.md before enabling the skill if this is a shared or production agent.
```

Direct human install examples:

```bash
# Codex
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | bash

# Claude Code
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="$HOME/.claude/skills" bash

# OpenClaw
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="$HOME/.openclaw/skills" bash

# Any compatible agent
curl -fsSL https://raw.githubusercontent.com/JimmFly/slack-first-company-os/main/install.sh | DEST_ROOT="/path/to/agent/skills" bash
```
