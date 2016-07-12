#!/bin/sh
export MONGO_URL="mongodb://user:password@${MYDB_SERVICE_HOST}:27017/sampledb"
export HOME=/tmp
export PORT=3000
export ROOT_URL=http://localhost:3000
export Accounts_AvatarStorePath=/app/uploads
export Accounts_UseDNSDomainCheck=false
node main.js



