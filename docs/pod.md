# pod

Kubectl-style workflow over [podman pods](https://docs.podman.io/en/latest/markdown/podman-pod.1.html) — groups of containers sharing a network namespace, useful for running a dev stack (app + db + cache).

```bash
pod new dev -p 8080:80                  # create pod, publish ports (args pass to podman)
pod run dev docker.io/library/nginx:stable   # add a container (auto-named dev-nginx)
pod run dev docker.io/library/postgres:18
pod ps                                 # list pods
pod logs dev nginx -f                   # follow logs (fzf pickers when names omitted)
pod sh dev                              # shell into a container
pod stop dev && pod rm dev              # teardown
```

See the official docs for more: [podman run](https://docs.podman.io/en/latest/markdown/podman-run.1.html), [podman pod create](https://docs.podman.io/en/latest/markdown/podman-pod-create.1.html).
