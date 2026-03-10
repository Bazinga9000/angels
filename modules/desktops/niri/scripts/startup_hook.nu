# Set the location using IP API
curl http://ip-api.com/json?fields=country,city,region -m 1 | from json | noctalia-shell ipc call location set $"($in.city), ($in.region), ($in.country)"