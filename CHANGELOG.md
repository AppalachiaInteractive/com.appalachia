```
[process_commands]
[process_commands]: [5 args] | $@: [print Changes 3D-ASCII --horizontal-layout fitted]
[get_commands]
[get_commands] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/init.sh
[get_commands] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/testcmd.sh
[get_command_families]
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/docs
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/header
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/login
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/package
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/print
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/repo
[get_command_families] [RETURN] /c/Users/Chris/com.appalachia/ai/cmd/servers
[process_commands]: [SHIFT] [4 args] | $@: [Changes 3D-ASCII --horizontal-layout fitted]
[process_commands] [COMMAND] /c/Users/Chris/com.appalachia/ai/cmd/init.sh
[clean_command]
[clean_command] [RETURN] init
[process_commands] [COMMAND] /c/Users/Chris/com.appalachia/ai/cmd/testcmd.sh
[clean_command]
[clean_command] [RETURN] testcmd
[process_commands] [FAMILY] /c/Users/Chris/com.appalachia/ai/cmd/docs
[clean_command]
[clean_command] [RETURN] docs
[process_commands] [FAMILY] /c/Users/Chris/com.appalachia/ai/cmd/header
[clean_command]
[clean_command] [RETURN] header
[process_commands] [FAMILY] /c/Users/Chris/com.appalachia/ai/cmd/login
[clean_command]
[clean_command] [RETURN] login
[process_commands] [FAMILY] /c/Users/Chris/com.appalachia/ai/cmd/package
[clean_command]
[clean_command] [RETURN] package
[process_commands] [FAMILY] /c/Users/Chris/com.appalachia/ai/cmd/print
[clean_command]
[clean_command] [RETURN] print
[process_commands]: [PATH] [ $# -gt 0 ] ai/cmd/do/do.sh exists
 ________   ___  ___   ________   ________    ________   _______    ________      
|\   ____\ |\  \|\  \ |\   __  \ |\   ___  \ |\   ____\ |\  ___ \  |\   ____\     
\ \  \___| \ \  \\\  \\ \  \|\  \\ \  \\ \  \\ \  \___| \ \   __/| \ \  \___|_    
 \ \  \     \ \   __  \\ \   __  \\ \  \\ \  \\ \  \  ___\ \  \_|/__\ \_____  \   
  \ \  \____ \ \  \ \  \\ \  \ \  \\ \  \\ \  \\ \  \|\  \\ \  \_|\ \\|____|\  \  
   \ \_______\\ \__\ \__\\ \__\ \__\\ \__\\ \__\\ \_______\\ \_______\ ____\_\  \ 
    \|_______| \|__|\|__| \|__|\|__| \|__| \|__| \|_______| \|_______||\_________\
                                                                      \|_________|
                                                                                  
```
## Unreleased
| Hash | Date | Author | Changes |
|------|------|--------|---------|
| b1325ff | 2021-04-17 | Chris Schubert | Fixing line breaks in changelog generation |
| 54bad4e | 2021-04-17 | Chris Schubert | Redesigning command structure and updating `header` command to `print` |
| ada5ac6 | 2021-04-17 | Chris Schubert | Fixing shell execution setup for npm, explicitly using bash to allow process substitution. |
| 598d510 | 2021-04-16 | Chris Schubert | Changes to command structure and licensing, header printing working |
| ef1961e | 2021-04-15 | Chris Schubert | Automatically creating github repo for new projects |
| 815d6db | 2021-04-15 | Chris Schubert | Fully integrating npm publish to ai.sh |
| 1f4e1eb | 2021-04-15 | Chris Schubert | Specifying license as GPU Affero v3 |
| b8f6046 | 2021-04-15 | Chris Schubert | Adding example invocation |
| dfe818f | 2021-04-15 | Chris Schubert | Improving documentation a bit on the purpose of the repo. |
| dcedbae | 2021-04-15 | Chris Schubert | Redesign of scripting environment |
| b4ccd7e | 2021-04-14 | Chris Schubert | Adding unity license choice. |
| f2a6718 | 2021-04-14 | Chris Schubert | Templating work |
| 4a3df0d | 2021-04-14 | Chris Schubert | Unity Package publishing working fully. |
| bc9c269 | 2021-04-13 | Chris Schubert | Updating default folder shell script |
| d4a5cd7 | 2021-04-13 | Chris Schubert | Updating structure and ignores |
| e1813b6 | 2021-04-13 | Chris Schubert | updating server execution |
| 6fa6a13 | 2021-04-13 | Chris Schubert | Initial setup of dev environment |
