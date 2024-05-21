# wrax

```
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠉⠉⠉⠉⠙⠓⠢⢤⣀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠑⡄⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡄⠀⠀⠀⠀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⠀⠀⠀⠀⠀
⠀⠀⠀⠀⣾⡇⢠⡠⢤⣤⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀
⠀⠀⠀⡀⣿⡇⢿⣃⠀⠀⠈⠙⠒⠢⠤⠄⠄⠒⠒⠚⠃⠀⠀⣀⠄⢸⠀⠀⠀⠀
⠀⠀⢠⠀⣿⠇⠄⠙⠓⠲⣤⣀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣼⠏⠁⠀⠀⢧⠀⠀⠀
⠀⠀⢸⡷⠻⡗⠀⠀⣀⣠⣤⣤⣽⣿⣿⣿⣿⣿⣶⣶⣦⣤⣄⡀⠀⠀⢀⡇⠀⠀
⠀⠀⠨⠂⠶⣷⣿⣿⣿⣿⣿⣿⣿⣿⢹⣿⡟⢻⣿⣿⣿⣿⣿⣿⣿⣦⢀⡇⠀⠀
⠀⠠⣴⠀⣼⣿⣿⣿⣿⣿⡡⢿⣿⠇⣾⡟⡀⠸⣿⡹⣿⡏⠛⣿⣿⣿⡆⢧⠀⠀      `wrax` is a simple file wrapper
⠀⠠⠇⣼⣿⣿⣿⣿⢿⣿⡿⠿⣋⣾⠟⠁⢣⣷⡈⢿⣌⠳⣴⡿⢃⣿⣿⡌⢣⠀       which enables ssh superpowers
⠀⠂⢠⣿⣿⣿⣷⡟⠶⠶⠖⠚⠋⠉⠀⠀⠘⠛⠃⠀⠉⠓⠒⠒⣫⣿⣿⣧⠀⢳
⠀⢠⣾⣿⣿⣿⢿⣿⣷⣶⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢹⣿⠟⠋⣿⣟⣷⠀⠈
⠀⣾⢻⠛⣿⣿⣆⠙⢄⠘⣿⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣹⣿⠷⢡⣿⠋⠉⠀⠀
⠂⠿⣿⣶⣿⣿⣿⣄⠀⠙⢼⣷⡀⠀⠀⡆⠀⠈⡆⠀⢠⢻⠁⢠⣻⡿⠁⠀⠀⠀
⠤⠀⠀⠹⢿⣿⣿⣿⣧⣄⠀⢹⣷⡄⣀⣵⣶⡶⠷⠶⣴⡟⡰⢫⣿⡇⠀⠀⠀⠄
⠈⢀⣤⣤⣼⣿⣿⣿⣿⣿⡄⠈⣿⣷⣿⠋⠁⠀⠀⠀⠀⢻⡁⣸⣿⡁⠀⠀⠀⠀
⣿⣯⡀⠀⠉⠛⠿⢿⣿⣿⣿⡄⢹⣿⣿⣀⠀⠀⣀⣤⣀⠘⣿⣿⠟⠀⠀⠀⠀⠀
⣿⣿⣆⣀⡀⠀⡰⣿⡈⣿⣿⣿⣼⣿⣿⣷⣾⡿⠿⠿⣿⣷⣿⣷⠀⠀⣴⣿⣿⣿
⠉⢾⣿⣛⣭⡍⡿⢁⡇⣿⣿⣿⣿⣿⣿⣿⣿⡟⡁⢉⣻⣿⣿⡏⠀⠀⠉⠉⢉⣿
⠀⠈⢽⣿⡽⠖⢀⣿⡧⢻⣿⣿⣿⣿⣿⣿⣿⣃⡀⠀⣈⣿⣿⡇⠀⠀⠀⠀⣾⡟
```

## About

`wrax` is a simple file wrapper, converting a single file to a string that can be consumed by `stdin`. The author's primary use case is to pair it with `ssh` to create a KISS remote automation/management tool. For example:

```sh
for host in master1 worker1 worker2; do
  wrcmd examples/autoupdate.sh | wrsudo | ssh -J juser@jumphost user@${host}
done
```

Will run the idempotent script `examples/autoupdate.sh` as root on the hosts: `master1` `worker1` `worker2`, which are only accessable through the `jumphost`.

## Installation

`install.sh` will install `wrcmd`, `wrcp` & `wrsudo` to `BINDIR`, by default ~/bin, if you would like to install it elsewhere, set `BINDIR` to your desired path.

```sh
curl -sfL https://raw.githubusercontent.com/dxlr8r/wrax/main/install.sh | BINDIR="$HOME/bin" sh -
```

If BINDIR is located in a directory in which you lack write access, run as `sudo`.

```sh
curl -sfL https://raw.githubusercontent.com/dxlr8r/wrax/main/install.sh | BINDIR=/usr/local/bin sudo sh -
```

## Commands

### wrcmd

```sh
wrcmd file
```

Description: converts `file` to a string/heredoc, and executing the string using the binary supplied in the file's shebang.

### wrcp

**Only recommended to transfer smaller files (~1MB or less).**

```sh
wrcp file dest
```

Description: converts `file` to a string/heredoc, and copies it to dest.

### wrsudo

```sh
wrsudo
```

Description: wraps `stdin` in a sudo heredoc.
