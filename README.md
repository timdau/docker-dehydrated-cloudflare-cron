# dehydrated-cloudflare-cron

Runs [lukas2511/dehydrated](https://github.com/lukas2511/dehydrated) with [kappataumu/letsencrypt-cloudflare-hook](https://github.com/kappataumu/letsencrypt-cloudflare-hook) as a cron job to acquire and update letsencrypt certificates using dns-01 challenge via CloudFlare.

For using with single domain:
```
docker create \
  --name=dehydrated \
  -e 'CF_EMAIL=email@domain.tld' \
  -e 'CF_KEY=API_key' \
  -e 'CF_HOST=host.domain.tld' \
  -v /path/to/certs:/dehydrated/certs \
  ingram/dehydrated-cloudflare-cron
```

For use with multiple domains, provide a [domains.txt](https://github.com/lukas2511/dehydrated/blob/master/docs/domains_txt.md) instead, `CF_HOST` environment variable has no effect if `domains.txt` can be found:
```
docker create \
  --name=dehydrated \
  -e 'CF_EMAIL=email@domain.tld' \
  -e 'CF_KEY=API_key' \
  -v /path/to/domains.txt:/dehydrated/domains.txt:ro \
  -v /path/to/certs:/dehydrated/certs \
  ingram/dehydrated-cloudflare-cron
```

Then start container, which will run update script once at start and once daily after that:
```
docker start dehydrated
```

Based on [kmlucy/docker-dehydrated](https://github.com/kmlucy/docker-dehydrated)
