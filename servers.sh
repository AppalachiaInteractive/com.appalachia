
cd "${0%/*}"

for dir in .servers/*/; do
    val=${dir::-1}
    dirname=${dir:9:-1}
    script=$val/$dirname".sh"
    echo 'dir:' $dir
    echo 'val:'  $val
    echo 'dirname:'  $dirname
    echo 'script:'  $script
    $script &    
done

sleep 5

NPM_USER="admin"
NPM_PASS="Ty!72*@PBcFG"
NPM_EMAIL="admin@appalachiainteractive.com"
NPM_REGISTRY="http://localhost:4873"
export NPM_USER
export NPM_PASS
export NPM_EMAIL
export NPM_REGISTRY
npm-cli-login