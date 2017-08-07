FROM python:alpine
LABEL maintainer="indrek@ardel.eu"

RUN apk add --update curl openssl bash git cron && \
    cd / && \
    git clone https://github.com/lukas2511/dehydrated && \
    cd dehydrated && \
    mkdir hooks && \
    git clone https://github.com/kappataumu/letsencrypt-cloudflare-hook hooks/cloudflare && \
    pip install -r hooks/cloudflare/requirements.txt && \
    apk del git && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/ && \
    touch /var/log/cron.log && \
    echo "* * * * * root /dehydrated/cron.sh >> /var/log/cron.log 2>&1" > /etc/cron.d/dehydrated-daily && \
    chmod 0644 /etc/cron.d/dehydrated-daily && \
    echo "#!/bin/bash" > cron.sh && \
    echo "/dehydrated/dehydrated --register --accept-terms" >> cron.sh && \
    echo "/dehydrated/dehydrated -c -d \$CF_HOST -t dns-01 -k 'hooks/cloudflare/hook.py'" >> cron.sh

CMD cron && tail -f /var/log/cron.log

VOLUME /dehydrated/certs
