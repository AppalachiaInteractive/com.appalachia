#!/bin/bash
source "$APPA_FUNCTIONS_HOME/cmd_start.sh"

echo "Attempting to publish..."

bump="$1"
shift
if [[ "$bump" == "patch" || "$bump" == "minor" || "$bump" == "major" || "$bump" == "prepatch" || "$bump" == "preminor" || "$bump" == "premajor" || "$bump" == "prerelease" ]] ; then
    npm version $bump
    
    if [ $? -ne 0 ] ; then exit $?; fi;

    package_version=$(cat package.json \
    | grep version \
    | head -1 \
    | awk -F: '{ print $2 }' \
    | sed 's/[",]//g' \
    | tr -d '[[:space:]]')

    if [ -d .dist ] ; then
        rm -rf .dist
    fi   
    if [ -d dist ] ; then
        rm -rf dist
    fi

    output_folder='dist'

    if [ -d "$output_folder" ] ; then
        rm -f "$output_folder/*"
        rmdir "$output_folder"
    fi

    if [ $? -ne 0 ] ; then exit $?; fi;

    mkdir "$output_folder"
    
    if [ $? -ne 0 ] ; then exit $?; fi;

    cd "$output_folder"

    npm pack ..

    if [ $? -ne 0 ] ; then exit $?; fi;

    cd ..

    package=`ls "$output_folder" | head -n 1`
    package_path="./$output_folder/$package"

    echo "Publishing..."

    npm publish "$package_path" --registry "http://localhost:4873"
    
    if [ $? -ne 0 ] ; then exit $?; fi;
    
    #use release notes from a file
    echo "Sending to github as release..."

    gh release create v$package_version "$package_path" -F RELEASELOG.md
    
    if [ $? -ne 0 ] ; then exit $?; fi;

    echo "Destroying distribution tarballs.."
    
    rm -rf "$output_folder"

    echo 'Publishing complete!'

else
    echo "Choose [patch, minor, major, prepatch, preminor, premajor, prerelease]"
    exit 1
fi
