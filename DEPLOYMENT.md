# Riskbot Deployment Instructions

This file documents how this fork is deployed, including the Docker-based setup. It's separate from
`README` on purpose, since these are local hosting details that aren't part of the upstream project.

## Hosting Options

The riskbot can be installed directly on your machine or inside Docker.

## Hosting Option A: Direct Install

1. Install NPM
```bash
npm install
```

2. Setup Automatic Restarts
- The riskbot must be restarted every 24 hours to run continuously.
- When using Docker the "restarter" container does this for you.
- If not using Docker, you have two options:

  i. Local Install: CRON-JOB

Set up CRON-JOB to restart bot every 24 hours, add this line to your user crontab: (if you dont run on a linux server, there may be other tools than cron to handle this)

```
	1 15 * * * sh reboot_riskbot.sh
```

  ii. pm2

Set up pm2

```bash
npm install -g pm2
pm2 start riskbot.js --name riskbot
pm2 startup
pm2 save
```

## Hosting Option B: Docker

These docker instructions assume that you are running production and development on separate hosts, or at least
separate git clones.

1. Create a copy of `./docker/.env.sample` as `./docker/.env` and add the text below. Replace `prod` with `dev`
   to run in development.
```bash
COMPOSE_PROFILES=prod
COMPOSE_PROJECT_NAME=riskbot
```

2. Install Docker
There are several options to install Docker. Modify this for your repo and installation source:

```bash
sudo apt install docker.io
```

3. Build the image
`docker/build-prod.sh` and `docker/build-dev.sh` assume that your repo is in `/usr/src/riskbot/`. Modify as
necessary.

```bash
# Use ./docker/build-dev.sh for a dev version
./docker/build-prod.sh
```

4. Bring the stack up
```bash
./docker/up.sh
```

5. Watch the logs
```bash
./docker/logs-prod.sh
# or ./docker/logs-dev.sh
```
