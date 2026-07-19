# Riskbot (Lany's fork)

## Git workflow

This repo uses GitButler (the `but` CLI), not raw `git commit`/`git push`. See the user's global git-workflow
instructions for the general `but` commands (`but status`, `but branch new`, `but commit`, `but push`) and the
stage-then-commit pitfall to avoid.

### Branch routing

This repo splits work across branches by category, not by chronology. Before committing, classify each
changed file:

**`lany-initial-setup`** — system/deployment and AI-instruction changes:
- `docker/**`
- `.claude/**`
- `README_lany.md`, `DEPLOYMENT_lany.md`
- `reboot_riskbot.sh`
- any other deployment, CI, or Claude Code configuration added later

Commit these to the existing `lany-initial-setup` branch (`but commit lany-initial-setup -m "..." --changes <ids>`),
not a new branch.

**Everything else** — application code (bot commands, modules, features, bugfixes, upstream `README`/
`DEPLOYMENT.md` edits, etc.) — use the normal GitButler flow: a separate branch per cohesive piece of work
(`but branch new <name>`), not `lany-initial-setup` and not lumped together with unrelated app changes.

If a single edit touches both categories (rare), split it into separate commits on the two branches rather
than mixing them in one commit.
