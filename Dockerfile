FROM python:alpine
LABEL maintainer="indrek@ardel.eu"

RUN apk add --update curl openssl bash git && \
    cd / && \
    git clone https://github.com/lukas2511/dehydrated && \
    cd dehydrated && \
    mkdir hooks && \
    git clone https://github.com/kappataumu/letsencrypt-cloudflare-hook hooks/cloudflare && \
    pip install -r hooks/cloudflare/requirements.txt && \
    apk del git && \
    rm -rf /var/cache/apk/* /tmp/* /var/tmp/ && \
    echo "#!/bin/bash" > /etc/periodic/daily/dehydrated && \
    echo "/dehydrated/dehydrated --register --accept-terms >> /dev/stdout" >> /etc/periodic/daily/dehydrated && \
    echo "/dehydrated/dehydrated -c -d \$CF_HOST -t dns-01 -k 'hooks/cloudflare/hook.py' >> /dev/stdout" >> /etc/periodic/daily/dehydrated && \
    chmod +x /etc/periodic/daily/dehydrated

CMD crond -l 2 -f

VOLUME /dehydrated/certs
