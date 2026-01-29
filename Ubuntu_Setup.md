
## Initialize Home-Manager

1. `apt-get install curl git age`
2. Install nix following the official instructions, enable flakes and nix-command
3. Clone this repo
4. Generate an age key for deploying the sops secrets `age-keygen -o ~/.age/key.txt`
   - Add the displayed public key to the `keys:` section in `.sops.yaml` (will need to setup manual git user/email)
   - ON A MACHINE WITH SOPS WORKING: in `.sops.yaml` add the key reference to the required `key-groups` and run `sops updatekeys secrets/secrets.yaml`
5. `nix run home-manager/master -- switch --flake .`
6. `apt-get remove --autoremove curl git age`, since we now have the nix managed versions of those

## Shell setup

1. Add `$HOME/.nix-profile/bin/zsh` to `/etc/shells`
2. `chsh -s $HOME/.nix-profile/bin/zsh`
3. Relog to check that it works

## Apparmor
For apps that need userns (all electron/chromium/firefox based things) create appropriate profiles in `/etc/apparmor.d` to workaround [this issue](https://github.com/NixOS/nixpkgs/issues/121694)
