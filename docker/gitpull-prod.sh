cd /usr/src/riskbot/docker
gh repo sync || true
git fetch --all --prune
git checkout main
git pull --ff-only
sudo docker compose up --build --remove-orphans --detach --wait
sudo docker compose logs -f riskbot-riskbot-1
