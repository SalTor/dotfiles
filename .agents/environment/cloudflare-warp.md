# Local edge-runtime dev doesn't traverse Cloudflare WARP / Zero Trust

Local edge and worker dev runtimes — MiniOxygen, workerd, wrangler, i.e. Cloudflare Workers and Shopify Hydrogen dev — use their own network and TLS stack. They do not go through Cloudflare WARP / Zero Trust on the host machine.

A server-side `fetch` from the dev worker to a host reachable only via WARP or a Cloudflare tunnel (an internal `*.sandbox.*` host, say) fails with an opaque `internal error; reference = …` and no HTTP response, even though `curl` from the shell succeeds — curl rides WARP.

Tell: the host's TLS cert is issued by a `Cloudflare Gateway CA`, meaning WARP is doing TLS inspection.

Fix: disable WARP, or point the worker at a `localhost` or publicly-reachable host. It is not a code or auth bug.
