# Set the location using IP API
curl http://ip-api.com/json?fields=city,region | from json | noctalia-shell ipc call location set $"($in.city), ($in.region)"
