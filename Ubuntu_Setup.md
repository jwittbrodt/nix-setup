
## Initialize Home-Manager

1. `sudo apt install curl git age`
2. Install nix following the official instructions, enable flakes and nix-command
3. Clone this repo
4. Generate an age key for deploying the sops secrets `age-keygen -o ~/.age/key.txt`
   - Add the displayed public key to the `keys:` section in `.sops.yaml` (will need to setup manual git user/email)
   - ON A MACHINE WITH SOPS WORKING: in `.sops.yaml` add the key reference to the required `key-groups` and run `sops updatekeys secrets/secrets.yaml`
5. `nix run home-manager/master -- switch --flake .`
6. `sudo apt remove --autoremove curl git age`, since we now have the nix managed versions of those

## Shell setup

1. Add `$HOME/.nix-profile/bin/zsh` to `/etc/shells`
2. `chsh -s $HOME/.nix-profile/bin/zsh`
3. Relog to check that it works

## Apparmor
For apps that need `userns` (all electron/chromium/firefox based things) create appropriate profiles in `/etc/apparmor.d` to workaround [this issue](https://github.com/NixOS/nixpkgs/issues/121694)

## Remove Snap

1. `snap list` to get all installed snaps
2. `snap remove --purge` each of them except `snapd`
3. `sudo apt remove --autoremove --purge snapd`
4. `sudo apt-mark hold snapd` to prevent it from being reinstalled
5. remove leftover directories found by `sudo find / -type d -name snap`

## Remove Gnome

1. `sudo apt-mark manual pipewire-pulse pipewire` -> xdg-desktop-portal implementations (which are done via HM) need pipewire and its pulse api
2. FROM A TTY: `sudo apt remove --autoremove --purge ubuntu-desktop-minimal gnome-shell gdm3 xdg-desktop-portal`
3. Reboot, should end up in tty1 login, which will autostart sway according to the setup
