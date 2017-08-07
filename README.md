# docker-dehydrated

Based on [kmlucy/docker-dehydrated](https://github.com/kmlucy/docker-dehydrated)

To create for single domain:
```
docker create \
  --name=dehydrated \
  -e 'CF_EMAIL=email@domain.tld' \
  -e 'CF_KEY=API_key' \
  -e 'CF_HOST=host.domain.tld' \
  -v /path/to/certs:/dehydrated/certs \
  kmlucy/docker-dehydrated
  ```

For multiple domains provide a [domains.txt](https://github.com/lukas2511/dehydrated/blob/master/docs/domains_txt.md) instead:
```
docker create \
  --name=dehydrated \
  -e 'CF_EMAIL=email@domain.tld' \
  -e 'CF_KEY=API_key' \
  -v /path/to/certs:/dehydrated/certs \
  -v /path/to/domains.txt:/dehydrated/domains.txt \
  kmlucy/docker-dehydrated
  ```

Then start container, which will run update script daily (plus once per starting the container):
```
docker start dehydrated
```

  Uses: [lukas2511/dehydrated](https://github.com/lukas2511/dehydrated) and based on: [kappataumu/letsencrypt-cloudflare-hook](https://github.com/kappataumu/letsencrypt-cloudflare-hook)
