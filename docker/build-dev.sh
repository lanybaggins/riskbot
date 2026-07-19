#!/bin/bash
set -euo pipefail

# Only need to build on package changes
cd "$(dirname "$0")"
docker build --build-arg NODE_ENV=development -t riskbot:latest -f ../Dockerfile ..
