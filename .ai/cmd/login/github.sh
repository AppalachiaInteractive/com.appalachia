gh auth status

if [ $? -ne 0 ]; then
    gh auth login
fi
