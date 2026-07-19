#!/bin/bash
set -eu

screen -X -S riskbot kill
sleep 1
screen -dmL -S riskbot -Logfile riskbot.log node riskbot.js
