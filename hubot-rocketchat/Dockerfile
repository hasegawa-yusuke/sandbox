FROM node:0.12.4
MAINTAINER Rocket.Chat Team <buildmaster@rocket.chat>

RUN npm install -g coffee-script yo generator-hubot  &&  \
	useradd hubot -m

ADD ./run.sh /tmp
RUN chmod 777 /tmp/run.sh
RUN mv /tmp/run.sh /home/hubot

USER hubot

WORKDIR /home/hubot

ENV BOT_NAME "bot"
ENV BOT_OWNER "No owner specified"
ENV BOT_DESC "Hubot with rocketbot adapter"

ENV ROCKETCHAT_USER=bot \
     ROCKETCHAT_PASSWORD=bot \
     ROCKETCHAT_ROOM="" \
     LISTEN_ON_ALL_PUBLIC=true \
     ROCKETCHAT_AUTH="password"

ENV EXTERNAL_SCRIPTS=hubot-diagnostics,hubot-help,hubot-google-images,hubot-google-translate,hubot-pugme,hubot-maps,hubot-rules,hubot-shipit

RUN yo hubot --owner="$BOT_OWNER" --name="$BOT_NAME" --description="$BOT_DESC" --defaults && \
	sed -i /heroku/d ./external-scripts.json && \
	sed -i /redis-brain/d ./external-scripts.json && \
	npm install hubot-scripts

ADD . /home/hubot/node_modules/hubot-rocketchat
ADD ./hubot-scripts.json /home/hubot

# hack added to get around owner issue: https://github.com/docker/docker/issues/6119
USER root
RUN chown hubot:hubot -R /home/hubot/node_modules/hubot-rocketchat
USER hubot

RUN cd /home/hubot/node_modules/hubot-rocketchat && \
	npm install && \
	coffee -c /home/hubot/node_modules/hubot-rocketchat/src/*.coffee && \
	cd /home/hubot

CMD ["sh", "-c", "./run.sh"]
