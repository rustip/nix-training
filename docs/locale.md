# Locale Setup

Use `en_US.UTF-8` for English text and US date, number, and currency formats or as you prefer.

1. Open `nix/host/configuration.nix` in your editor.
2. Replace the existing `i18n.defaultLocale` and `i18n.extraLocaleSettings` assignments with:

   ```nix
   i18n.defaultLocale = "en_US.UTF-8";

   i18n.extraLocaleSettings = {
     LC_ADDRESS = "en_US.UTF-8";
     LC_IDENTIFICATION = "en_US.UTF-8";
     LC_MEASUREMENT = "en_US.UTF-8";
     LC_MONETARY = "en_US.UTF-8";
     LC_NAME = "en_US.UTF-8";
     LC_NUMERIC = "en_US.UTF-8";
     LC_PAPER = "en_US.UTF-8";
     LC_TELEPHONE = "en_US.UTF-8";
     LC_TIME = "en_US.UTF-8";
   };
   ```

   If these values are already set, no edit is needed. The time zone is configured separately; keep `time.timeZone = "Asia/Kolkata";` if that is your time zone.

3. From the repository directory, apply the configuration:

   ```bash
   sudo nixos-rebuild switch --flake path:.#
   ```

4. Reboot, then open a terminal and check:

   ```bash
   locale
   ```

   `LANG` and the locale categories should show `en_US.UTF-8`. An empty `LC_ALL` is normal.

Before switching to this repository's flake setup, edit `/etc/nixos/configuration.nix` instead (for example, with `sudoedit`) and apply with `sudo nixos-rebuild switch` without the flake argument.
