echo 'Setting up repository...'
cd "${0%/*}"

base="$(basename "$PWD")"

echo $base
rm README.md
echo "# $base" >> README.md
git init
git add README.md
git commit -m "first commit"
git branch -M main
git remote add origin https://github.com/AppalachiaInteractive/$base.git
git add .
git commit -m "initializing organization repository"
git push -u origin main

echo 'Repository setup complete...'