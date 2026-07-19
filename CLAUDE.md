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

## Personal bypasses / testing-only carve-outs

Never hardcode a personal bypass or testing-only carve-out (e.g. a Discord user ID that skips rule checks)
directly in source. Source is public/mergeable-to-main; a hardcoded ID would need branch-level gating to keep
it out of main, which is fragile and easy to forget.

Instead, drive it from `riskbot_config.json` (git-ignored, loaded as `global.config` in `riskbot.js`), which
never enters git history at all. Each command/feature that needs a carve-out gets its own subkey object in
config, named after the command — not a generic shared key or a flat `<feature>RuleBenders`-style key — since
these are one-off personal exceptions, not a general permissions system. Example: `commands/imposter.js` reads
`global.config.imposter.allowDev` (an array of user IDs) rather than comparing against a literal ID or using
a flat top-level key.

Always read these with a fallback through the whole chain (`global.config.<feature>?.<key> ?? []` or
equivalent) — the production server's config is not expected to define the feature subkey at all, so code
must behave correctly (bypass simply unavailable) when it's absent, not throw or assume it exists.

Add new carve-outs the same way: a feature-named config subkey, read at the call site with a safe fallback,
no ID literals in committed code. Code written this way is ordinary application code and follows the normal
branch routing above — no special never-push-to-main branch needed.
