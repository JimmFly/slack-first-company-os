# Brief-First Autopilot Setup

Use this reference when the user wants the agent to ask everything up front, then run the Slack + Notion + Linear + GitHub setup with minimal interruption.

## Mode Contract

Brief-first autopilot has two phases:

1. **Brief phase**: ask for all required setup decisions in one consolidated questionnaire. Do not create external objects yet.
2. **Execution phase**: after the user confirms the completed brief, create/configure approved assets without asking again for decisions already covered.

The agent must still pause for:

- password entry, unavailable SSO, unavailable 2FA, captcha, passkeys, hardware keys, and account recovery
- billing plan purchases or payment method entry
- admin approval by someone other than the current operator
- destructive actions, visibility downgrade/upgrade, or broad permission grants not approved in the brief
- contradictions or missing values that change the setup outcome

When pausing, state exactly what the human must do and why, then continue after confirmation.

OAuth and verification policy:

- If the browser is already logged in and the brief approved the exact app, target workspace/org/repo, and permission category, click OAuth/authorization consent screens directly.
- If OAuth asks for materially broader scopes, a different target org/workspace, paid plan upgrade, or admin approval not covered by the brief, pause and explain.
- If email access is already authorized in the agent environment, use it to retrieve magic links or one-time codes when permitted by the user. Do not paste codes or tokens into the setup log.
- If CLI/MCP/API tooling needs authentication, prefer standard device login or OAuth flows and the platform's credential store. Do not ask the user to paste long-lived access tokens into chat unless no safer path exists and the user explicitly chooses it.
- Never record passwords, 2FA codes, OAuth access tokens, refresh tokens, recovery codes, or magic links in `Company OS`, Slack, GitHub issues, Linear issues, setup logs, commits, or skill files.

## Upfront Questionnaire

Ask in the user's language. Keep it as one message when possible.

```text
I can run this in brief-first autopilot mode: you answer the setup brief once, I produce a run plan, you confirm, then I execute. I can click pre-approved OAuth screens myself, and I only pause for passwords, unavailable 2FA/email/captcha, admin/payment boundaries, changed permission scope, or contradictions.

1. Run mode and permissions
- Should I use browser-only, existing connectors/skills, CLI tools, MCP/connectors, or a mix?
- May I create approved workspaces/orgs/repos/pages/channels automatically after you confirm the run plan?
- May I install missing CLIs or MCP/connectors if useful, or should I only suggest them?
- May I click OAuth/authorization consent screens myself when the exact app, target workspace/org/repo, and permission category are already approved in this brief?
- Who will handle password/captcha/payment/admin approval handoffs?

2. Identity and access
- Operator email/account for Slack:
- Operator GitHub account:
- Operator Linear account/email:
- Operator Notion account/email:
- Do you have owner/admin rights for each target workspace/org?
- Is the browser already logged into the needed accounts?
- Is there an email inbox or mailbox connector available for magic links and verification codes?
- If CLI/MCP/API auth is needed, should I use standard OAuth/device login and credential stores?

3. Naming
- Organization display name:
- Preferred slug/subdomain:
- Acceptable fallback slug pattern:
- Timezone and locale:
- Team/member count:

4. Slack
- Create new workspace or reuse existing? URL/name if existing:
- Initial channels to create now:
- Channels to defer:
- Apps to install now: Linear / GitHub / Notion
- Should GitHub repo event subscriptions be configured now? If yes, which channel and repo?

5. GitHub
- Create new org or reuse existing? Org slug/name if existing:
- If org creation is unavailable, should I use the operator's personal account?
- Seed repo name:
- Repo visibility: private / public
- Create README/license/gitignore?
- Branch protection, issue templates, PR templates: now or defer?

6. Linear
- Create new workspace or reuse existing? URL/name if existing:
- Workspace slug:
- Team name and key:
- Connect Slack now?
- Connect GitHub org/repo now?
- Configure GitHub Issues Sync? none / one-way GitHub to Linear / two-way
- If two-way, which Linear team maps to which GitHub repo?

7. Notion
- Create new workspace or reuse existing? URL/name if existing:
- Create Company OS page now?
- Company OS page sections to include:
- Connections to install now: Slack / GitHub / Linear
- AI connector or MCP permissions: now or defer?

8. Smoke tests
- Create Slack -> Linear test issue?
- Expect Linear issue to sync to GitHub issue?
- Close Linear issue and verify Slack/GitHub feedback?
- Should test artifacts be left in place, closed, archived, or deleted when possible?

9. Constraints
- Anything I must not create?
- Any naming, visibility, security, or billing constraints?
- Any platform where you only want instructions, not automation?
```

## Run Plan Before Execution

After the user answers, summarize a run plan before creating anything:

```text
Run mode:
Approved automation:
Human handoffs expected:
OAuth scopes pre-approved:
Assets to create/reuse:
Integrations to install:
Deferred items:
Smoke tests:
Stop conditions:
```

Ask for one explicit confirmation. After confirmation, execute the approved plan without re-asking for every object.

## Execution Rules

- Keep a running setup log with actual names, slugs, URLs, and deviations from the brief.
- Prefer organization/workspace-scoped installs over personal-only authorization.
- If a slug/name is unavailable, use the approved fallback pattern. If no fallback exists, pause.
- If a platform requires an empty org to have a repo before integration, create the approved seed repo before connecting integrations.
- If the user approved two-way Linear GitHub Issues Sync, configure the repo/team link after the basic GitHub integration.
- If an OAuth popup opens and the consent target/scope was pre-approved, click through it. If it differs, pause.
- If verification email or magic link access is authorized, retrieve and use it without logging secret material.
- Do not treat marketplace app installation as notification routing. Configure Slack subscriptions only when approved.
- Finish with the verification matrix from `references/setup-playbook.md`.

## Handoff Phrases

Use precise handoff language:

```text
Paused for OAuth: please approve the GitHub app installation for org <org> and selected repo <repo>. This grants Linear access needed for PR/issue sync. Tell me when the authorization window closes.
```

```text
Paused for 2FA/email: Slack sent a verification code to <email>. Please complete it in the browser. I will continue after you confirm.
```

```text
Continuing through OAuth: the brief pre-approved <app> for <workspace/org> with <permission category>, and the browser is already logged in. I will click the authorization prompts and verify the installed state afterward.
```

```text
Paused for admin rights: this action needs owner/admin access in <tool>. Ask an owner to approve or tell me to switch to an alternative path.
```
