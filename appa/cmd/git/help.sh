#!/bin/bash
# shellcheck source=./../functions/cmd_start.sh
source "${APPA_FUNCTIONS_HOME}/cmd_start.sh"

echo

seperator(){    
    subtle '--------------------------------------';
}

statement(){
    highlight1 "> ${1}";
    shift
    highlight2 " ${1}";
    shift
    highlight4 " ${1}";
    shift
    EXPRE='  |  '
    EXPOST=''

    while [ $# -gt 0 ]; do
        subtle "${EXPRE}${1}${EXPOST}";
        shift
    done
    
    seperator
}

statement 'git clone' \
          'used to recreate a remote repository on your local machine.' \
          '[USUALLY SAFE TO RUN] - Use when you want to download a new repo.' \
          'git clone https://github.com/AppalachiaInteractive/com.appalachia.git'

statement 'git status' \
          'used to show you what has changed on your copy of the repo, relative to the remote.' \
          '[ALWAYS SAFE TO RUN]' \
          'git status     # downloads metadata about recent changes from the remote repository.' \
          'git fetch -p  # will also "prune" (delete) local branches that were deleted from the remote'

statement 'git fetch' \
          'used to get files from the remote repository to the local repository but not into the working directory.  If you are running <git status> and it seems out of date, you may need to "fetch" updated metadata.' \
          '[ALWAYS SAFE TO RUN]' \
          'git fetch     # downloads metadata about recent changes from the remote repository.' \
          'git fetch -p  # CAREFUL: -p or "prune" will delete local branches that do not exist on the remote.'

statement 'git checkout' \
          'used to change your working directory to a different branch/version of the repo.' \
          '[USUALLY SAFE TO RUN] - Use when you want to work on a different version of the repo.' \
          'git checkout -b branch_A      # creates a new local branch named "branch_A".  Only you can see this until you push to the remote.' \
          'git checkout branch_B         # checks out your local "branch_B" branch' \
          'git checkout origin/branch_C  # downloads and checks out the remote "branch_C" branch' \
          
statement 'git pull' \
          'used to get files from the remote repository directly into the working directory. It is equivalent to a git fetch and a git merge .' \
          '[CONSIDER BEFORE RUNNING] - Only run when you have saved your work, and are ready to deal with potential merge conflicts.'
          
statement 'git add' \
          'used to add a file that is in the working directory to the staging area.' \
          '[USUALLY SAFE TO RUN] - But you should only use when you want to share your changes to the remote.' \
          'git add Assets/MyFiles/MyFile.txt                # add a specific file' \
          'git add "Assets/My Files With Spaces/MyFile.txt" # add a specific file' \
          'git add Assets                                   # add files in the Assets folder' \
          'git add .                                        # add all files in the repository' 
          
statement 'git reset' \
          'used to unstage files that you wish to "un-add".  Does not delete the files, just removes them from the upcoming commit.' \
          '[CONSIDER BEFORE RUNNING] - Reset is useful and safe if you do not use the --hard modifier. With the --hard modifier, be careful because you can lose work that has not been committed yet.' \
          'git reset Assets/MyFiles/MyFile.txt # unstage a specific file' \
          'git reset .                         # unstages all files from this commit' \
          'git reset --hard           # DANGER # "hard wipe" - reverts all changes that are not commited' 
          
statement 'git commit' \
          'used to add all files that are staged to the local repository.' \
          '[CONSIDER BEFORE RUNNING] - Only run when you are sure your work is completed.' \
          'git commit -m "This is what I did!"    # commits with the specified message'

statement 'git push' \
          'used to add all committed files in the local repository to the remote repository. So in the remote repository, all files and changes will be visible to anyone with access to the remote repository.' \
          '[CONSIDER BEFORE RUNNING] - This will share your work remotely, and is annoying to undo.'

statement 'git merge' \
          'used to get the files from the local repository into the working directory.' \
          '[CONSIDER BEFORE RUNNING] - Merges leave your branch in an unusable state until you complete them, so merge only when you have time.' \
          'Ask for help :)'
