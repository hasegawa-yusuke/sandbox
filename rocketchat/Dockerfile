FROM rocketchat/base

ENV RC_VERSION latest

MAINTAINER buildmaster@rocket.chat

VOLUME /app/uploads

RUN set -x \
 && curl -SLf "https://rocket.chat/releases/${RC_VERSION}/download" -o rocket.chat.tgz \
 && curl -SLf "https://rocket.chat/releases/${RC_VERSION}/asc" -o rocket.chat.tgz.asc \
 && gpg --verify rocket.chat.tgz.asc \
 && tar -zxf rocket.chat.tgz -C /app \
 && rm rocket.chat.tgz rocket.chat.tgz.asc \
 && cd /app/bundle/programs/server \
 && npm install \
 && npm cache clear

ADD https://raw.githubusercontent.com/hasegawa-yusuke/sandbox/master/rocketchat/run.sh /tmp
RUN chmod 777 /tmp/run.sh
RUN mv /tmp/run.sh /app/bundle/

USER rocketchat

WORKDIR /app/bundle

# needs a mongoinstance - defaults to container linking with alias 'mongo'
ENV MONGO_URL=mongodb://user:password@${MYDB_SERVICE_HOST}:27017/sampledb \
    HOME=/tmp \
    PORT=3000 \
    ROOT_URL=http://localhost:3000 \
    Accounts_AvatarStorePath=/app/uploads \
    Accounts_UseDNSDomainCheck=false

EXPOSE 3000

CMD ["sh", "-c", "./run.sh"]





