cat /proc/uptime | split column " " | get column1 | $in.0 | into int | math round | $in * 1sec | $"Uptime: ($in)"
