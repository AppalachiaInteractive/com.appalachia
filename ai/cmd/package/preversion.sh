version=$npm_package_version

git fetch -p
git pull --tags

"${0%/*}"/../../ai.sh docs changelog
"${0%/*}"/../../ai.sh docs releaselog

git add .