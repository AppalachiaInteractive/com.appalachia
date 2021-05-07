```
 ______   ______  ______  ______   __       ______   ______   __  __   __   ______
/\  __ \ /\  == \/\  == \/\  __ \ /\ \     /\  __ \ /\  ___\ /\ \_\ \ /\ \ /\  __ \
\ \  __ \\ \  _-/\ \  _-/\ \  __ \\ \ \____\ \  __ \\ \ \____\ \  __ \\ \ \\ \  __ \
 \ \_\ \_\\ \_\   \ \_\   \ \_\ \_\\ \_____\\ \_\ \_\\ \_____\\ \_\ \_\\ \_\\ \_\ \_\
  \/_/\/_/ \/_/    \/_/    \/_/\/_/ \/_____/ \/_/\/_/ \/_____/ \/_/\/_/ \/_/ \/_/\/_/
    __   __   __   ______  ______   ______   ______   ______   ______  __   __   __ ______
   /\ \ /\ "-.\ \ /\__  _\/\  ___\ /\  == \ /\  __ \ /\  ___\ /\__  _\/\ \ /\ \ / //\  ___\
   \ \ \\ \ \-.  \\/_/\ \/\ \  __\ \ \  __< \ \  __ \\ \ \____\/_/\ \/\ \ \\ \ \'/ \ \  __\
    \ \_\\ \_\\"\_\  \ \_\ \ \_____\\ \_\ \_\\ \_\ \_\\ \_____\  \ \_\ \ \_\\ \__|  \ \_____\
     \/_/ \/_/ \/_/   \/_/  \/_____/ \/_/ /_/ \/_/\/_/ \/_____/   \/_/  \/_/ \/_/    \/_____/
```
## Appalachia Interactive
### com.appalachia development environment

Add the `appa` folder to the PATH, and then run `appa`.  From there, you'll see the possible commands and can begin to understand the tool.

At its core, the menu below is built dynamically, based on scripts populated within the `appa/cmd` directory.  Without much modification of `appa` (maybe changing the header ;) ), you can set up your own simple scripting environment that gives you easy access to commands/subcommands without having to build executables or maintain a master menu.  Arguments are forwarded to commands as you would expect.

```
$ appa

>  appa init
>  appa pip
>  appa repo-publish
>  appa repo-setup
>  appa testcmd
>  appa login
>  appa login github
>  appa login npm
>  appa servers
>  appa servers verdaccio
```
```
$ appa login github

github.com
  ✓ Logged in to github.com as ChristopherSchubert (C:\Users\Chris\.config\gh/hosts.yml)
  ✓ Git operations for github.com configured to use https protocol.
  ✓ Token: *******************

```

For the above to work, there is a `login` directory added to the `cmd` directory.  This creates a `command family`.  Then any shell scripts placed within that `login` directory become subcommands.  

## Legal and Licensing
For legal and licensing information please see [LEGAL.md](./LEGAL.md).
