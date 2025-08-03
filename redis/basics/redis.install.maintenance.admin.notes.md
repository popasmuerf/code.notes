#Redis installation and admin notes




## MacOS M1

### Installed via Brew 

==> Pouring redis--7.2.5.arm64_sonoma.bottle.tar.gz
==> Caveats
To start redis now and restart at login:
  brew services start redis
Or, if you don't want/need a background service you can just run:
  /opt/homebrew/opt/redis/bin/redis-server /opt/homebrew/etc/redis.conf
==> Summary
🍺  /opt/homebrew/Cellar/redis/7.2.5: 15 files, 2.4MB
==> Running `brew cleanup redis`...
Disable this behaviour by setting HOMEBREW_NO_INSTALL_CLEANUP.
Hide these hints with HOMEBREW_NO_ENV_HINTS (see `man brew`).
mikeyb@Michaels-MacBook-Pro redis % brew doctor
Please note that these warnings are just used to help the Homebrew maintainers
with debugging if you file an issue. If everything you use Homebrew for is
working fine: please don't worry or file an issue; just ignore this. Than