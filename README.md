# Homebrew tap for Yagi

[Yagi](https://github.com/johnschult/yagi) shares an HDHomeRun tuner with the Plex, Jellyfin and Emby of your family and friends.

```sh
brew install johnschult/yagi/yagi
brew services start yagi        # keeps it running, and starts it again after a restart
```

Then open the one-time setup link in its log, `$(brew --prefix)/var/log/yagi.log` (or `http://localhost:9244/` on that machine), to become the admin. Its settings file is `$(brew --prefix)/var/yagi/yagi.json`.

Update with `brew upgrade yagi`. It works on macOS and Linux (Homebrew on Linux), on Intel and ARM; on Linux, where `brew services` needs systemd, the [install script](https://github.com/johnschult/yagi#quick-start) can also set up a service.

Homebrew installs the archive the release built (it doesn't build anything, so Node and Go aren't needed) and checks it against the checksum in the formula. Each release is also [signed](https://github.com/johnschult/yagi/blob/main/docs/security.md#verifying-a-download).

## About this repository

`Formula/yagi.rb` is written by Yagi's release workflow, from [`packaging/homebrew/yagi.rb`](https://github.com/johnschult/yagi/blob/main/packaging/homebrew/yagi.rb), each time a release is made. Don't edit it here: the next release overwrites it. Change the template in the Yagi repository instead. A change to the formula here is installed and tested on Linux and macOS (see `.github/workflows/tests.yml`).
