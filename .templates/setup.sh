cd "${0%/*}"

echo 'Setting up repository...'
python ./setup.py
if [ $? -eq 0 ]
then
    rm setup.py
    rm -- "$0"
    echo 'Repository setup complete...'
else
    echo 'Issue setting up repository...'
fi