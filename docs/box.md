# box

Creates Ubuntu 26.04 [distrobox](https://distrobox.it/) containers with an init system, a per-box home at `~/.boxes/<name>`, its own hostname, and a clean `PATH` on enter.

```bash
box create mydev    # create (ubuntu:26.04, init, ~/.boxes/mydev) and enter it
box enter mydev     # enter again (fzf picker if name omitted)
box list            # list boxes
box rm mydev        # remove box (fzf picker if name omitted)
```

Inside a box you get your host user, files, and flatpak/GUI app access — see the [distrobox docs](https://distrobox.it/) for details. Packages installed inside (`apt install ...`) persist in that box's home/container.

## box-setup

Provisions a box from the host: adds extra apt sources, installs apps from the newest `.deb` in a repo's Packages index (e.g. Claude Desktop), installs local `.deb` files (staged through `/tmp` to avoid apt sandbox notices), and installs extra apt packages. Configure what it does in the arrays at the top of `scripts/box-setup`.

```bash
box-setup dev                                        # apply configured setup to box 'dev'
box-setup dev ~/Downloads/chatgpt_amd64.deb          # also install a local .deb
box-setup                                            # pick box with fzf
```

Running it again is safe; every step is idempotent.
