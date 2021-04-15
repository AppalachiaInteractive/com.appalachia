# Appalachia Interactive
## com.appalachia development environment

Add the `.ai` folder to the PATH, and then run `ai.sh`.  From there, you'll see the possible commands and can begin to understand the tool.

At its core, the menu below is built dynamically, based on scripts populated within the `.ai/cmd` directory.  Without much modification of `ai.sh` (maybe changing the header ;) ), you can set up your own simple scripting environment that gives you easy access to commands/subcommands without having to build executables or maintain a master menu.  Arguments are forwarded to commands as you would expect.

```
> ai.sh
________________________________________________________________________________
|     _     ____   ____    _     _         _     ____  _   _  ___     _        |
|    / \   |  _ \ |  _ \  / \   | |       / \   / ___|| | | ||_ _|   / \       |
|   / _ \  | |_) || |_) |/ _ \  | |      / _ \ | |    | |_| | | |   / _ \      |
|  / ___ \ |  __/ |  __// ___ \ | |___  / ___ \| |___ |  _  | | |  / ___ \     |
| /_/   \_\|_|    |_|  /_/   \_\|_____|/_/   \_\\____||_| |_||___|/_/   \_\    |
|  ___  _   _  _____  _____  ____      _     ____  _____  ___ __     __ _____  |
| |_ _|| \ | ||_   _|| ____||  _ \    / \   / ___||_   _||_ _|\ \   / /| ____| |
|  | | |  \| |  | |  |  _|  | |_) |  / _ \ | |      | |   | |  \ \ / / |  _|   |
|  | | | |\  |  | |  | |___ |  _ <  / ___ \| |___   | |   | |   \ V /  | |___  |
| |___||_| \_|  |_|  |_____||_| \_\/_/   \_\\____|  |_|  |___|   \_/   |_____| |
|______________________________________________________________________________|

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
