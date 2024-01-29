

```sh
nix-shell -p git
sudo nixos-rebuild switch --flake .#valus
```

## Docker login to GH store

From https://stackoverflow.com/a/73558624

- `gpg --generate-key`
- `pass init <generated gpg-id public key>`

Generate a Personal Access Token with `read:packages` permissions

- `echo "$PAT" | docker login ghcr.io -u aurecchia --password-stdin`
