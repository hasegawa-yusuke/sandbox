#!/bin/sh

ROCKETCHAT_URL=${ROCKETCHAT_DEMO_SERVICE_HOST}:3000
export ROCKETCHAT_URL

HUBOT_JENKINS_URL=${JENKINS_SERVICE_HOST}:8080
export HUBOT_JENKINS_URL

node -e "console.log(JSON.stringify('$EXTERNAL_SCRIPTS'.split(',')))" > external-scripts.json && \
	npm install $(node -e "console.log('$EXTERNAL_SCRIPTS'.split(',').join(' '))") && \
	bin/hubot -n $BOT_NAME -a rocketchat


