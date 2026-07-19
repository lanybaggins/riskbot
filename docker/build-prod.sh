# Only need to build on package changes
cd /usr/src/build-prod.sh
docker build --build-arg NODE_ENV=production -t riskbot:latest -f ../Dockerfile ..
