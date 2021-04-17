```
 ________   ________   ________   ________   ___        ________   ________   ___  ___   ___   ________
|\   __  \ |\   __  \ |\   __  \ |\   __  \ |\  \      |\   __  \ |\   ____\ |\  \|\  \ |\  \ |\   __  \
\ \  \|\  \\ \  \|\  \\ \  \|\  \\ \  \|\  \\ \  \     \ \  \|\  \\ \  \___| \ \  \\\  \\ \  \\ \  \|\  \
 \ \   __  \\ \   ____\\ \   ____\\ \   __  \\ \  \     \ \   __  \\ \  \     \ \   __  \\ \  \\ \   __  \
  \ \  \ \  \\ \  \___| \ \  \___| \ \  \ \  \\ \  \____ \ \  \ \  \\ \  \____ \ \  \ \  \\ \  \\ \  \ \  \
   \ \__\ \__\\ \__\     \ \__\     \ \__\ \__\\ \_______\\ \__\ \__\\ \_______\\ \__\ \__\\ \__\\ \__\ \__\
    \|__|\|__|_\|__|   ___\|__|_   __\|__|\|__|_\|_______|_\|__|\|__|_\|_______|_\|__|\|__|_\|__|_\|__|\|__|  _______
    |\  \ |\   ___  \ |\___   ___\|\  ___ \  |\   __  \ |\   __  \ |\   ____\|\___   ___\|\  \ |\  \    /  /||\  ___ \
    \ \  \\ \  \\ \  \\|___ \  \_|\ \   __/| \ \  \|\  \\ \  \|\  \\ \  \___|\|___ \  \_|\ \  \\ \  \  /  / /\ \   __/|
     \ \  \\ \  \\ \  \    \ \  \  \ \  \_|/__\ \   _  _\\ \   __  \\ \  \        \ \  \  \ \  \\ \  \/  / /  \ \  \_|/__
      \ \  \\ \  \\ \  \    \ \  \  \ \  \_|\ \\ \  \\  \|\ \  \ \  \\ \  \____    \ \  \  \ \  \\ \    / /    \ \  \_|\ \
       \ \__\\ \__\\ \__\    \ \__\  \ \_______\\ \__\\ _\ \ \__\ \__\\ \_______\   \ \__\  \ \__\\ \__/ /      \ \_______\
        \|__| \|__| \|__|     \|__|   \|_______| \|__|\|__| \|__|\|__| \|_______|    \|__|   \|__| \|__|/        \|_______|

```
## Appalachia Interactive
### com.appalachia development environment

Add the `ai` folder to the PATH, and then run `ai.sh`.  From there, you'll see the possible commands and can begin to understand the tool.

At its core, the menu below is built dynamically, based on scripts populated within the `ai/cmd` directory.  Without much modification of `ai.sh` (maybe changing the header ;) ), you can set up your own simple scripting environment that gives you easy access to commands/subcommands without having to build executables or maintain a master menu.  Arguments are forwarded to commands as you would expect.

```
$ ai.sh

>  ai.sh init
>  ai.sh pip
>  ai.sh repo-publish
>  ai.sh repo-setup
>  ai.sh testcmd
>  ai.sh login
>  ai.sh login github
>  ai.sh login npm
>  ai.sh servers
>  ai.sh servers verdaccio
```
```
$ ai.sh login github

github.com
  ✓ Logged in to github.com as ChristopherSchubert (C:\Users\Chris\.config\gh/hosts.yml)
  ✓ Git operations for github.com configured to use https protocol.
  ✓ Token: *******************

```

For the above to work, there is a `login` directory added to the `cmd` directory.  This creates a `command family`.  Then any shell scripts placed within that `login` directory become subcommands.  