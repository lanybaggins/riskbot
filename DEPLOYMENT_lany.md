# Riskbot Deployment Instructions (Lany's fork)

This documents how *this* fork is actually deployed. It supersedes `DEPLOYMENT.md`, which documents the
upstream author's setup (separate prod/dev hosts, `deploy-commands.js`) — that doesn't apply here.

## Differences from upstream

- Docker only, single environment. There's no prod/dev split — the `dev` compose profile is the only one
  that exists, and it's what's actually run.
- Slash commands are registered with `deploy-commands-lany.js`, not `deploy-commands.js`. Edit that file
  (not the upstream one) when commands or server IDs change.

## Setup

1. Create `riskbot_config.json` per `README` (config keys, token, guild IDs).  Add the extra key:
```json
  "imposter": {
    "allowDev": ["415848204136087563"]
  }
```

2. Create a copy of `./docker/.env.sample` as `./docker/.env`:
```bash
COMPOSE_PROJECT_NAME=riskbot
```

3. Build the image
```bash
./docker/build-dev.sh
```

4. Bring the stack up
```bash
./docker/up.sh
```

5. Watch the logs
```bash
./docker/logs-dev.sh
```

6. Register slash commands (only needed when commands/servers change — not run automatically by Docker)
```bash
docker compose -f docker/compose.yml exec riskbot-dev node deploy-commands-lany.js
```

7. `/imposter-cheat` is hidden from everyone by default (`default_member_permissions: 0`). Per-server, grant it
   to whichever role(s) should have it via Server Settings > Integrations > riskbot > `/imposter-cheat`. This
   is a one-time manual step per server, not config-driven — Discord doesn't let a bot push role permissions
   for a command via its own token.

## Automatic restarts

The `restarter-dev` container restarts `riskbot-riskbot-dev-1` every 24 hours, same as upstream's restarter.
No separate cron/pm2 setup needed.
