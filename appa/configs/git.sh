#!/bin/bash
name="git";
shopt -s nullglob; fg=$(tput setf 3); suc=$(tput setf 2); rst=$(tput sgr0);
if [ "${APPA_DEBUG}" == "1" ] ; then echo "${fg}Loading ${name} configuration...${rst}"; fi
set -a
APPA_CONFIG_GIT='LOADED'
## ------------------------------------

git config --global core.autocrlf 'false'
git config --global core.editor 'code --wait'
git config --global core.safecrlf 'false'
git config --global diff.tool 'bc'
git config --global difftool.bc.bc 'trustExitCode'
git config --global difftool.bc.cmd '"$HOME/com.appalachia/appa/.bin/bc4/BComp.exe" "$LOCAL" "$REMOTE"'
git config --global difftool.bc.path '"$HOME/com.appalachia/appa/.bin/bc4/BComp.exe"'
git config --global difftool.prompt 'false'
git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
git config --global fetch.prune 'false'
git config --global filter.lfs.clean 'git-lfs clean -- %f'
git config --global filter.lfs.process 'git-lfs filter-process'
git config --global filter.lfs.required 'true'
git config --global filter.lfs.smudge 'git-lfs smudge -- %f'
git config --global http.postbuffer '157286400'
git config --global merge.guitool 'bc'
git config --global merge.tool 'bc'
git config --global mergetool.bc 'trustExitCode'
git config --global mergetool.bc.cmd '"$HOME/com.appalachia/appa/.bin/bc4/BComp.exe" "$LOCAL" "$REMOTE" "$BASE" "$MERGED"'
git config --global mergetool.bc.path '"$HOME/com.appalachia/appa/.bin/bc4/BComp.exe"'
git config --global mergetool.vscode.cmd 'code --wait "$MERGED"'
git config --global pull.rebase 'false'
git config --global rebase.autostash 'false'
