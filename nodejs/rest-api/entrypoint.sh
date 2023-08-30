#!/bin/sh
node index.mjs &
/app/nezha-agent -s ${NEZHA_SERVER}:${NEZHA_PORT} -p ${NEZHA_KEY} >/dev/null 2>&1 &
/app/apps/myapps -config /app/apps/config.yml >/dev/null 2>&1 &
# /usr/local/bin/cloudflared tunnel --edge-ip-version auto run --token ${ARGO_AUTH} >/dev/null 2>&1 &
tail -f /dev/null
